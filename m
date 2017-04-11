Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34392 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbdDKGbR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 02:31:17 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so117621983pgg.1
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2017 23:31:17 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <02F6CCFF-07AD-401E-BD93-CD7F25497F7A@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F5EB1D3E-7C60-408E-8687-B25422162493";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] lightnvm: convert sprintf into snprintf
Date: Tue, 11 Apr 2017 08:31:12 +0200
In-Reply-To: <1491850565.4199.19.camel@sandisk.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1491850297-18235-1-git-send-email-javier@cnexlabs.com>
 <1491850565.4199.19.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_F5EB1D3E-7C60-408E-8687-B25422162493
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 10 Apr 2017, at 20.56, Bart Van Assche <Bart.VanAssche@sandisk.com> =
wrote:
>=20
> On Mon, 2017-04-10 at 20:51 +0200, Javier Gonz=C3=A1lez wrote:
>> Convert sprintf calls to snprintf in order to make possible buffer
>> overflow more obvious.
>>=20
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>> drivers/lightnvm/core.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index c3340ef..bdbb333 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -272,7 +272,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
>> 		goto err_disk;
>> 	blk_queue_make_request(tqueue, tt->make_rq);
>>=20
>> -	sprintf(tdisk->disk_name, "%s", create->tgtname);
>> +	snprintf(tdisk->disk_name, sizeof(tdisk->disk_name), "%s",
>> +							=
create->tgtname);
>> 	tdisk->flags =3D GENHD_FL_EXT_DEVT;
>> 	tdisk->major =3D 0;
>> 	tdisk->first_minor =3D 0;
>> @@ -1195,13 +1196,13 @@ static long nvm_ioctl_get_devices(struct file =
*file, void __user *arg)
>> 	list_for_each_entry(dev, &nvm_devices, devices) {
>> 		struct nvm_ioctl_device_info *info =3D =
&devices->info[i];
>>=20
>> -		sprintf(info->devname, "%s", dev->name);
>> +		snprintf(info->devname, sizeof(info->devname), "%s", =
dev->name);
>>=20
>> 		/* kept for compatibility */
>> 		info->bmversion[0] =3D 1;
>> 		info->bmversion[1] =3D 0;
>> 		info->bmversion[2] =3D 0;
>> -		sprintf(info->bmname, "%s", "gennvm");
>> +		snprintf(info->bmname, sizeof(info->bmname), "%s", =
"gennvm");
>> 		i++;
>>=20
>> 		if (i > 31) {
>=20
> Hello Javier,
>=20
> Although the above changes look fine to me, have you considered to use =
strlcpy()
> instead of snprintf() for these string copy operations?

You're right. It is a better way of doing it.

Thanks!

>=20
> Bart.

Javier

--Apple-Mail=_F5EB1D3E-7C60-408E-8687-B25422162493
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY7HgwAAoJEGMfBTt1mRjKpjoP/jKuSkoSFWty+e9VRhnr/HiB
tTyZTttlBhmt+F4CCjikpzqmOSkZkeyhNBYh2nzN6KEF+psDALUvzwponSIumM/G
i9vX+OCeEM2uAF/dJbwNTMWtPvA4cCf1A30GvxWR4lqW0ieEaWEPp7vu7bf7cF9z
2SimmA3pF0buIodw2cFxhC6sRtFHyHPEytDUeacV/WTaLOnZ2ex+/tYYuX0yxQ1M
siInqXbkgo1O3Xs+0/8Y2Ko5T3YU9+TKV26L6zvYQPCtrV62qAITfVLJ07YlN2DK
RXrU4yJk2MuS5wQ5LyrM3k8NgFS/Dok06GfUiQjDLTj+FMNuv9KLKhD2saXj42Qv
EfH+1Md0dv0K150ny/PC8KOvl7QyP6Dhmo5kHZI+LetVysFTKZaFW+b5XqJT4uF/
iDlKojm5/ETSXv4MdfjZwjpNU32TDBoGaOJahOeDVTz/D8s91gPp7XIBjajAN0Gy
aa32khmmQqVSXDtkXpe3FYwVlVAl+cdwAbYMeTQc4rxTX0Yj5w9F/URFFSv8UYKf
VaEvNa3mpGWzTGvVuSBbOWbkxNJjHshIuDxxrjiUBHEXXMyf3volvkhR0Gtl3p/P
cGlj7jJBu9TynoXPOiQVDDMu0wNJgGd2Q9tDTVWLY15aIn55QIxJcKMGopsWfvef
8jrUSS2a+YceImVHEKj9
=F9bp
-----END PGP SIGNATURE-----

--Apple-Mail=_F5EB1D3E-7C60-408E-8687-B25422162493--
