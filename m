Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <BF51D239-D6C6-4B08-B53F-25E5710EEA17@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9461B7A7-8785-4B60-A00A-8ED6EC60D0D0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] lightnvm: create cmd before allocating request
Date: Thu, 4 May 2017 15:55:56 +0200
In-Reply-To: <20170504135345.GA9292@kernel.dk>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
 <20170504135345.GA9292@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_9461B7A7-8785-4B60-A00A-8ED6EC60D0D0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 May 2017, at 15.53, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On Wed, May 03 2017, Javier Gonz=C3=A1lez wrote:
>> Create nvme command before allocating a request using
>> nvme_alloc_request, which uses the command direction. Up until now, =
the
>> command has been zeroized, so all commands have been allocated as a
>> read operation.
>=20
> Applied 1-2. Javier, please use a cover letter when sending more than =
1
> patch at the time, makes it easier to reply to the series as a whole.
>=20


Thanks Jens. I will.

Javier


--Apple-Mail=_9461B7A7-8785-4B60-A00A-8ED6EC60D0D0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIbBAEBCgAGBQJZCzLtAAoJEGMfBTt1mRjKQPwP+PLd17PGLsPbsI4v1Ow+R1DN
iFYGKtOA9Od7VZU1vpzavMliT8EwNXKUUQ0FLKcQ5qwZYPRZmS/6MWu0hrkReKQV
WJ/f7V+LKF/2Q/ikaRifayXMMf/yxXxGll589PiBll4gp7+HkwbXxTDzdX8gWBEj
ryCq5b58s76mAnLhWXnb4zd1ppZXPiQKfDVljvvp9NtaMymfKpHYuth9609727E4
3x6cBvW7ZlLVBIJEsW35VSrgWXCnyApZkPQX6cAnlGTO4zOnTZFR1jEDRh+iZCkF
ggZrkX3Y5FWMhzNmaU3ANPdjSDdjfj3ZnyXHJ/1MpuGHqkE/TdVHhvWcuQ2lA6AZ
4+QnEVIeAxTHgDbftTWIKgxuP0wvY9QNssgXP1GnvSxBAs6iDYHsLzbuMYq7yGW1
g6aUjvyay3DPy6upqU0c3hQfETPh0e0pBMvSBRrpGuFl20FJzWIY1qME4Lt9ioV6
gEAIeI9bnFKilwvtAkqk4gwLVHjRvUjhA8nU0TWsg+xGPJGHigQ35/fztkYP2r8D
WebsxhveD3zieeWc3xwjkKrqAEqPbafTZIQYzyF8yNxsRMyUN2QHGvvmsTtW7Uhc
dZehayxL3FFn7ropyLx8O+dVlTaR3SepcPKehSh6WNgdTQey/xxfJ5M/5O95uWUa
V4g0KGkvPP3UTRBaFDQ=
=qBS9
-----END PGP SIGNATURE-----

--Apple-Mail=_9461B7A7-8785-4B60-A00A-8ED6EC60D0D0--
