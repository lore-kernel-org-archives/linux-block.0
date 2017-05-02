Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Date: Tue, 02 May 2017 13:33:53 +1000
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] blk: make the bioset rescue_workqueue optional.
In-Reply-To: <583a23d7-3d5f-e280-6ef4-a7fec84359e2@kernel.dk>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266672858.27388.11409778158413625707.stgit@noble> <20170421112458.GB12523@infradead.org> <87h91er2t6.fsf@notabene.neil.brown.name> <20170424151013.GA17867@infradead.org> <87tw55qigs.fsf@notabene.neil.brown.name> <583a23d7-3d5f-e280-6ef4-a7fec84359e2@kernel.dk>
Message-ID: <87h914q6e6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, May 01 2017, Jens Axboe wrote:

> On 04/30/2017 11:00 PM, NeilBrown wrote:
>> On Mon, Apr 24 2017, Christoph Hellwig wrote:
>>=20
>>> On Mon, Apr 24, 2017 at 11:51:01AM +1000, NeilBrown wrote:
>>>>
>>>> I was following the existing practice exemplified by
>>>> bioset_create_nobvec().
>>>
>>> Which is pretty ugly to start with..
>>=20
>> That is a matter of personal taste.
>> As such, it is up to the maintainer to change it if they want it
>> changed.
>>=20
>>>
>>>> By not changing the signature of the function, I can avoid touching
>>>> quite a few places where it is called.
>>>
>>> There are 13 callers of bioset_create and one caller of
>>> bioset_create_nobvec, and your series touches many of those.
>>>
>>> So just adding a flags argument to bioset_create and passing
>>> BIOSET_NEED_BVECS and BIOSET_NEED_RESUER flags to it doesn't seem
>>> to much of an effort, and it's going to create a much nicer and easier
>>> to extend interface.
>>=20
>> If someone else submitted a patch to discard bioset_create_nobvec in
>> favour of BIOSET_NEED_BVECS and got it accepted, then I would rebase my
>> series on that.  As it is, I'm basing my patches on the style currently
>> present in the tree.
>>=20
>> Of course, if Jens says he'll only take my patches if I change to style
>> to match your preference, I'll do that.
>
> I generally tend to prefer tree wide cleanups to improve our APIs, even
> if it does cause an extra bit of pain. Would you mind doing that as a
> prep patch?

OK, will do.

I have rebased and fixed up a couple of issues.  Will repost shortly.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkH/iEACgkQOeye3VZi
gbnh8w//VK9z1TY3zj/c0nGS6TmtmtIbh2iGGOcwRhyfRdFzgYtRmgcvKpP5thIx
5FvE2dejKgrnv0Do5AbYyyG42G7vIzHfbJY8y2yq8vC/JuO0wlRuVlTsQkqCIqy3
ZumKCjNemAU8ydgsLKprq0e7PeqofMtEhMM9Y0FTjCUvRLQjpw01Nw5gZbx/E8op
2BCb7HsB3RFNfwLk6qmnszj7TEtP8+l45D8WahKLLqrqEzb1yo2lRv3elZwT8if/
oeLrxQFGhhV28gExip5zc7arIRUTGz6jIYu2CiTehUQnl3wSAozfr2TIADPDDBBU
Oj7Fp13v7ivtgZhyphr7Ds4eZSxtnUhjFZL2Xt8AuG3wUcAAQAYDxJT2KJu4gpkV
EVEGqPnjPqxtaI/OzLx/Dfy5nUCERKl4WXgdkYLC2//FVVDOVhkMuJy0rJKWxARP
6L3+avNkrG2pr8PPWci/lbTg40CUEFzpD3QH4TJb+ec3WUMmp7gGbqLleCJRQNJA
JsBf+hYkYTNr5CAxUvjwavw70j1G2l/pSNgjyVG6vHmzPcq7tO1hC7+ZnsAvq0eZ
Y5rOG+Ia0u8N84GOXHZOwROGdpqNLCfIoEkPqXZw90Z0IiR9IPqeDPr5a7BU/8eV
knw1DBEdi6Yc74RAoXgNttqALsq/Fx5js6verOCOzObEwMTVikY=
=ss8X
-----END PGP SIGNATURE-----
--=-=-=--
