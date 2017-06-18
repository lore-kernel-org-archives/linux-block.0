Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 19 Jun 2017 07:36:33 +1000
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] block: assorted cleanup for bio splitting and cloning.
In-Reply-To: <20170618184143.GA10920@kernel.dk>
References: <149776047907.23258.8058071140236879834.stgit@noble> <20170618184143.GA10920@kernel.dk>
Message-ID: <87poe13rmm.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18 2017, Jens Axboe wrote:

> On Sun, Jun 18 2017, NeilBrown wrote:
>> This is a resend of my series of patches working
>> towards removing the bioset work queues.
>>=20
>> This set is based on for-4.13/block.
>>=20
>> It incorporates the revised versions of all the patches that were
>> resent following feedback on the last set.
>>=20
>> It also includes a minor grammatic improvement to a comment, and
>> simple changes to compensate for a couple of changes to the block tree
>> since the last posting.
>>=20
>> I hope to eventually get rid of the new BIOSET_NEED_RESCUER flag,
>> but that needs work in dm and probably bcache first.
>
> Thanks Neil, applied.

Thanks a lot Jens.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAllG8mMACgkQOeye3VZi
gblISw//UFQg1nu+tquc1lAkcPmtFZqvTWRTa1/pgfE3UIinKwQiZJsubYv7nI9T
RvfK1dEcWbK6EyH+bfkmB98WvIk+p0jns2kK/LU3yWPBbm4oFQ1X3mTmxKahVvQB
RChLRC6QwaV/29qrYiz6+bWf54h0Ij4hLAKP7RBQRSfU2SZGhmcriMRyRIBAayFS
hpqm0r5uaDku+XgFbl64ytFbaTYzw/RD24LjAyu9SjgSMKpa+xtBHyWE/ozazTtJ
s/GpCRjewCGXoV2iFauC5yykbshhbLhg374AVBteRstJkuypCSGPt7puISnwyuDG
H1DCn1AVPmBtVVw8v8HK/a6QMoKWxV7+dLS3T7OCJyOUKqtbUWn4YvFB2zFsScdy
9aO6R+X0+jRuZpQwlBNkimBPRVUR0hcPwxDQAdxOhzvnn6wap0cKhTLBdFx+61P4
/gL/l/i9yjCGKVRSFnH3HH/FVKCDlXgoNccGQPXrjAnwQkp6d/AFX3u9XTj+Wk+G
ZmU7L9GiFAAIVHyz7te71IC1lLAx6BAnCPA0ReipY1Xu1dvmMbWZLox6ulY3UT0S
uMhk91NbBS/CKdyRn1r8vO7QqB0govuPdd2ZlU8HfHRUSwDa8qLIERacozQ7dGPF
vqvQtBrnUqdqoypN/0VOa2dzAYdhLlu6rRSz8y5tNOsj1SILKms=
=3Uj2
-----END PGP SIGNATURE-----
--=-=-=--
