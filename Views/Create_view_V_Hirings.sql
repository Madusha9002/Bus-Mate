create or Alter view V_Hirings AS
	select h.RecordRef,h.HireID, h.VehicleId, h.Rate, h.WithDriver, h.WithoutDriver, h.IsAvailable,h.[Location], v.UserId, v.Brand,
		v.Model, v.WithAC, v.NoOfSeats, v.OtherOption, o.first_name, o.Email,o.mobile_phone, o.mobile_phone2,h.Status
		from Hiring h,Vehical v,UDB.dbo.user_profile o
		where h.VehicleId = v.VehicleId and v.UserId = o.user_id;
	