Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Javier =?utf-8?Q?Gonz=C3=A1lez?= <jg@lightnvm.io>
Date: Mon, 24 Apr 2017 12:32:04 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] blk: remove bio_set arg from blk_queue_split()
In-Reply-To: <F684F05A-679F-4704-A70E-7C1EE92B83E7@lightnvm.io>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266672835.27388.5719138070560521601.stgit@noble> <F684F05A-679F-4704-A70E-7C1EE92B83E7@lightnvm.io>
Message-ID: <87efwir0wr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 22 2017, Javier Gonz=C3=A1lez wrote:

>> On 20 Apr 2017, at 07.38, NeilBrown <neilb@suse.com> wrote:
>>=20
>> blk_queue_split() is always called with the last arg being q->bio_split,
>> where 'q' is the first arg.
>>=20
>> Also blk_queue_split() sometimes uses the passed-in 'bs' and sometimes u=
ses
>> q->bio_split.
>>=20
>> This is inconsistent and unnecessary.  Remove the last arg and always use
>> q->bio_split inside blk_queue_split()
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>> block/blk-core.c              |    2 +-
>> block/blk-merge.c             |    9 ++++-----
>> block/blk-mq.c                |    2 +-
>> drivers/block/drbd/drbd_req.c |    2 +-
>> drivers/block/pktcdvd.c       |    2 +-
>> drivers/block/ps3vram.c       |    2 +-
>> drivers/block/rsxx/dev.c      |    2 +-
>> drivers/block/umem.c          |    2 +-
>> drivers/block/zram/zram_drv.c |    2 +-
>> drivers/lightnvm/rrpc.c       |    2 +-
>> drivers/md/md.c               |    2 +-
>> drivers/s390/block/dcssblk.c  |    2 +-
>> drivers/s390/block/xpram.c    |    2 +-
>> include/linux/blkdev.h        |    3 +--
>> 14 files changed, 17 insertions(+), 19 deletions(-)
>>=20
>
> It most probably made it to Jens' tree after you made these changes, but
> in drivers/lightnvm/pblk-init.c we also use blk_queue_split() in a
> couple of places inside pblk_rw_io().

Ahh, yes - thanks.  That will need to same small change.

Jens, do you prefer a resend, or and update patch, or to just add this
change manually?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlj9Y6QACgkQOeye3VZi
gbk7cRAAmk6dBewV28tJFa3ov4+APE+XHElJVDbDMz2CL77990kTMsDGvAfLn5no
FjU2k/94p/45gYVb+avqUiwRWQoh6WQDZHt6b0hFPhhf75yWbwdYaGtrPHGlco5+
Wb6WEvqKtA4AvTbFOaq6Je3mw49TKAAyQ14k4GL+3Ac0BVLXfS0FMY89jEJ6jP3i
8Uh+VS48SWMWZWoZTLlheKrtLObf37AoHqbTwXVSbcGIzAF4UZpO9ViKZpm8bh79
ufQWYuWZlXsceyEQt1syoWROiLER1oaLrO9XSobPhzqH3gEppqhUZ/Klim87KaLR
e+gJZWR8pFi7LvKFWClKhpr/rcFToFlx815SMdz1yK44hlmzPmMj9xy6SAsxWg12
XI6IFqGrRQu/wVV5kvszJclpIp7ZSeDnJrKlmkMeuwtiGQPbXyLt5dl4s6/0lVl/
UcgTeALsc5fvxnLk2kHCyPdKgSBFDy5uXwJuoxqPlXryfPEeSDB61ZJ9ZbpA4JJz
eVrbizmowqBDFmPnmGYK/ZYAcv09RFTmZsM/LhmyrDCkTnQoX7Kmr6z0FJI6OyBZ
9NDg0JMBNHZQZ/R8itSGufgrMgL/xKXR+k+F5BUIbGA1qhJt8m+Rt/fkU4japAsT
8fPHCBJXGk7q7XXYqatOPRqylpxFnEL4xKGcTRm9QcnBIYLwZ+o=
=yXDS
-----END PGP SIGNATURE-----
--=-=-=--
