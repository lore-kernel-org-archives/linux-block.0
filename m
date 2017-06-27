Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <74679E1A-1CDF-45CF-99A0-A4BB057540A3@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5013611D-24F5-4DF9-9F09-E13AB58ABC49";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 00/20] LightNVM: pblk patches for 4.13
Date: Tue, 27 Jun 2017 10:00:52 +0200
In-Reply-To: <20170626222920.GA9175@kernel.dk>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
 <20170626222920.GA9175@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_5013611D-24F5-4DF9-9F09-E13AB58ABC49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Jun 2017, at 00.29, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On Mon, Jun 26 2017, Javier Gonz=C3=A1lez wrote:
>> Hi Matias,
>>=20
>> Here you have the pblk patchset for this window.
>>=20
>> Apart from small fixes for LightNVM core and pblk, there are three
>> relevant changes:
>>=20
>> - Metadata for each line is no longer issued on a separate workqueue,
>>   but instead, all I/Os are scheduled on the write thread. This =
allows
>>   to have more control over LUN collisions. The result is that we can
>>   use the full bandwidth of the device for user data. In the 4.12 =
pblk,
>>   we use ~25% of the bandwidth for metadata.
>>=20
>> - The rate-limiter and GC have been tuned to keep the GC writer busy.
>>   Also, capacity per line is guaranteed for GC I/O as we reach
>>   capacity.
>>=20
>> - We have now a FTL state machine. This allows to fail gracefully to
>>   user space in case of irrecoverable errors. This state machine will
>>   be the base for the pblk's FTL log.
>>=20
>> The patches apply into your for-4.13/core. You can also find them in:
>=20
> Nope, they do not. Patch #7 fails, because it's not on top of the
> bio_set changes that went in a week or two ago. I hand applied that =
one,
> didn't find issues with the rest.
>=20
> But please remember to ensure that it applies on top of the current
> branch.

Thanks Jens. Won't happen again.

Javier


--Apple-Mail=_5013611D-24F5-4DF9-9F09-E13AB58ABC49
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZUhC0AAoJEGMfBTt1mRjKwxkQAITA2E7hwnAX0DqfFcZb5fX7
vzYgAEiXfCsDC4MaVouJ/8cb39boxri5WCPseqs8sbZC29doOB1cyq/YWmwh5NBt
HSHUURD66bmPA5J56/BxSOTFQxpBWLpfAYXHS7f2G9Ifj8m8pDQDku43s5aPhy/3
kcbIGA7zOSlNBgHeGFSRi1tW1v0KxRrn7U0K25emwTRo6PKRa6h62bdFl0QYJt+k
mZx5WV4vOCYhsAPUoZH0kuXRtVSz0jEq2XbcvWyMsvfuWCh8h21ndpXga+YDkces
AVEbkDSg6fkKh/q9aUM1IqJ+b7qznkV6ZZufcFtqrO5tRn/JKs590/LSl4jiEVcb
4bJeI2emJyxjNhQGOQoKTGvxqrqDWuJ4b2htFIZ/heY8+weC7eueDeJe8l64Lal4
ujjKlrc+/vEWp7z7GpRJRBpNO0tOBIPjdBJILrR3UOfOhPDxMGTiPxJH0mC8rfOB
pmvHRrrqTywKepdONJYpkGnCsnFYNYB3LM7nhx5GApSMCbmYfXQ7NBxF8MAdLbwY
x42aOVKVCyQCyhD4uX05sxkju6IGDdHk8ItZ68FlBIOvjmTD3YQ9poTHprJN4qlv
Cu50PqnYOPv/E2sORQ5dk0IIIrdmFhB+uTDh4Dr2ezhvR88Ny2H2po0eWYQ9AhQt
wOe+elWSJ5rvs2iLTosn
=s/s0
-----END PGP SIGNATURE-----

--Apple-Mail=_5013611D-24F5-4DF9-9F09-E13AB58ABC49--
