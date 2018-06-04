Return-Path: <neilb@suse.com>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@gmail.com>
Date: Tue, 05 Jun 2018 07:16:51 +1000
Cc: linux-block <linux-block@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
In-Reply-To: <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk> <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com> <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
cc: Shaohua Li <shli@kernel.org>
Message-ID: <87efhmp7zw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04 2018, Jens Axboe wrote:

> On 6/4/18 9:51 AM, Linus Torvalds wrote:
>> On Sun, Jun 3, 2018 at 5:42 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>  drivers/md/md.c                                 |  61 +--
>>>  drivers/md/md.h                                 |   4 +-
>>=20
>> So I've pulled this, but I get a new warning:
>>=20
>>   drivers/md/md.c: In function =E2=80=98mddev_put=E2=80=99:
>>   drivers/md/md.c:543:1: warning: the frame size of 2112 bytes is
>> larger than 2048 bytes [-Wframe-larger-than=3D]
>>=20
>> which seems to be due to commit afeee514ce7f ("md: convert to
>> bioset_init()/mempool_init()").
>>=20
>> As of that commit, mddev_put() now allocates *two* "struct bio_set"
>> structures on the stack, and those really aren't small. Yes, part of
>> it is that I do my test-builds with all that debug stuff, but those
>> structures have several embedded mempool_t members, and they really
>> are pretty sizable.
>>=20
>> And I _really_ do not think it's acceptable to have that kind of stack
>> usage in there. I'm not sure you can trigger mddev_put() in the IO
>> paths, but even without that I don't think it's acceptable.
>>=20
>> Also, the code simply looks like complete and utter garbage. It does
>>=20
>>                 bs =3D mddev->bio_set;
>>                 sync_bs =3D mddev->sync_set;
>>=20
>> to _copy_ those structures, and then does bioset_exit() on them. WTF?
>>=20
>> Why the hell doesn't it just do biset_exit() on the originals instead,
>> before freeing the mddev?
>>=20
>> I've pulled this, but this needs to be fixed. That is just broken
>> garbage right now. No way in hell is it acceptable to waste 2kB of
>> stack space on something idiotic like this.
>
> Works is already underway to get this fixed up. I agree that the
> excessive stack usage isn't great, but the code in that function
> is pretty miserable, as you say. That's not new with the patch,
> the conversion just carried that forward.
>
> CC'ing Neil to get his input on how best to clean that up, I'd
> be much more comfortable with that logic improved rather than
> just catering to the stack usage issue. Also include Arnd, as
> he had a test patch for it.

Cc:ing Shaohua as well, as he is the current maintainer, and authored
=20=20
  Commit: 7184ef8bab0c ("MD: fix sleep in atomic")

which seems most relevant.
The justification given in that patch is that bioset_free() will take a
mutex.
This must have been in destory_workqueue() when destroying
bs->rescue_workqueue.
md biosets don't have a work queue (BIOSET_NEED_RESCUER isn't set),
so these calls will no longer take a mutex.  So this commit
can now be reverted.  I think that will clean up this code suitably.

I really should get back to BIOSET_NEED_RESCUER and see if I can discard
it completely.
Kent - the only remaining user is bcache, and the main reason I haven't
removed it is that I cannot follow the code (or at least, I couldn't
last time I tried).  Are you able to see if it is still needed?

Thanks,
NeilBrown

>
> --=20
> Jens Axboe

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsVrEMACgkQOeye3VZi
gbm8HxAAkmbP3cOvoWUll1daGq0hKObfo9fiYce4VwjQfw4N+GoiezMMbnzNP444
jZbHFu+albrf2OHLPHph6PezzeTiNdRmBh2M35tuJVm0NVFBVHlNVdIrhvphGh64
Q5RJbjDzv4oYyn6OlOupRCwoQ00r3HehjUXZ5mbuVS8J7I/o2mJUkkBbr5WPXvFK
Af/HXFN0+uC9swixuq+Lizvid5Ko9xuozpZiyHO+HrS3uYlO/iY0qX13mI0GlITR
bDJelpzKxHYEyDYJ2vdo4qcy28XU5hUe3VFHlMgPYMXZnRPrmyRo1Ee2m/Xn1dHd
LRWI1DfdQ09URcMxY8AgT0aFSBdePrkZc2jkiY58RP0es0PRdvbYZJblE/hcJ0Ll
gEoULLk/1n8Lkl0qq+E/p/RMEDmQ/Y13E5YlLO7B96g1Prqc8cegKsgwEJSr9T3l
faUr+bEMqt5+ndtAIupt2u68PXB1mCjFnaW5hhyKwsYAP/2eXsNYaNow9X8qpUb3
eueFEcELuWNdl2DNFtGoBYmVYzWvyOutfbjTnQFcuCMp6Xcuk4v5ufHaUnuyEyHY
d4hTXk48RYdMPs8I/APwEWsSi4wF7ysJDbqyLnhwbfYBfxMBTa45H3I1CVCqvaY2
H+p+T42ZMOwNBkGA7JBZ8GsPoZ9z1RwzE0+6TEFSS2Z/CPoiMC8=
=XLnb
-----END PGP SIGNATURE-----
--=-=-=--
