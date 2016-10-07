Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Francesco Dolcini <francesco@dolcini.it>
Date: Fri, 07 Oct 2016 13:09:11 +1100
Cc: Francesco Dolcini <francesco@dolcini.it>, axboe@kernel.dk, tj@kernel.org, hch@lst.de, axboe@fb.com, akpm@linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: blockdev kernel regression (bugzilla 173031)
In-Reply-To: <20161006075409.GA4059@dev1>
References: <20161004150350.GA27176@dev1> <8760p75zc6.fsf@notabene.neil.brown.name> <20161005111826.GA2430@dev1> <87k2dm3ueb.fsf@notabene.neil.brown.name> <20161006075409.GA4059@dev1>
Message-ID: <8760p452rc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06 2016, Francesco Dolcini wrote:

> On Thu, Oct 06, 2016 at 04:42:52PM +1100, NeilBrown wrote:
> cc
>> Maybe there is a race, but that seems unlikely.
>
> Consider that just hot removal while writing is not enough to=20
> reproduce systematically the bug.
>
> while true; do [ ! -f /media/usb/.not_mounted ] \
> 	&& dd if=3D/dev/zero of=3D/media/usb/aaa bs=3D1k \
> 	count=3D1 2>/dev/null && echo -n '*' ; done
>
> with lazy umount by mdev on USB flash drive removal
>
> reproduce the problem pretty always
>
>> The vfat issue is different, and is only a warning.
> Why you say is only a warning? Here the Oops with vfat on ARM/i.MX6:

I looked at:

x86 Oops information (with vfat):

in the bugzilla and didn't realized there was another one further down.
That first vfat on is just a warning.
>
>> > Regression is on commit 6cd18e7 ("block: destroy bdi before blockdev i=
s unregistered.")
>> >
>> > Commit: bdfe0cbd746a ("Revert "ext4: remove block_device_ejected") is =
already present on 4.1 stable I am currently working on (2a6f417 on 4.1 bra=
nch)
>> >
>> > I wonder if commit b02176f ("block: don't release bdi while request_qu=
eue has live references") is the correct fix for this also in kernel 4.1.
>>=20
>> Maybe.  It is worth a try.
>>=20
>> Below is a a backport to 4.1.33.  It compiles, but I haven't tested.
>> If it works for you, I can recommend it for -stable.
>
> I confirm that it works!

Thanks.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX9wPHAAoJEDnsnt1WYoG5IuYP/AuiWH0uuGzpXjnwtm5YcqrO
XOj+LzJfAnkmuKLJZRM6kR2KwBSeTIaV9JebzsL1ybrPOIxUPmszv3fAnA4v3sX9
swBr2+XR5MnEzfYI0bKju7nZ6kQGZWRRa2u8LzyBvl9/I5U6sGzlD4/yicgi1zWh
6AHBnwN0rn6HtbhQs2SSah3Ef2e+CJAlU/iKW1MCFYKskaCNlUY7IkiBOGMnVS48
jZPURL0Q6iG/kUB9YN/rhZG3eHUIKwT6AaOG1F0GA3I7WDWQ13f8kyo/WuwuSpV/
FD12xBh9ZAma2WJSnUVcJkBpXFJYXxs7otomLZwsvWdhZrgaLtvdjCVoCDRmvVBn
zKcQ7+aYjnvu9s30PS4NINuHyvGxCfcPTNfEwOxg09oMC/WjgXZEE3dM1Sc3v2Jl
vO59ZnBnDM0q+cKCOu5Ioef10sOksp1oGp+FV++MhQDBfQs4Yk9XpSVgEIrrOux4
KCqjyOestz654R2drVDjUgX2+7g/+77XoDe4F1KEAHzFWIUUg4rraxHOtqZejZM8
ElHMzipQNPuYZthvt+1kAgeWx1nfED4JAxkUX3X2khK/qivWpeL7Fa+BDYIbC++m
y2XXeGv5km1wRgnx4RdsHj7dIQxfETALiYyWDlpLhEDqjIocFW7vXW3BloPQs4Xt
eYtR+BJWKMQdlHl2nIPU
=PeJw
-----END PGP SIGNATURE-----
--=-=-=--
