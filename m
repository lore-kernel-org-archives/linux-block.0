Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 11 May 2017 10:58:11 +1000
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>, Javier Gonzalez <jg@lightnvm.io>
Subject: Re: [PATCH 00/13] block: assorted cleanup for bio splitting and cloning.
In-Reply-To: <149369628671.5146.4865312503373040039.stgit@noble>
References: <149369628671.5146.4865312503373040039.stgit@noble>
Message-ID: <877f1omcpo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 02 2017, NeilBrown wrote:

> This is a revision of my series of patches working
> towards removing the bioset work queues.

Hi Jens,
 could I get some feed-back about your thoughts on this series?
 Will you apply it?  When?  Do I need to resend anything?
 Would you like a git-pull request?  If so, what should I base it on?
 There is a minor conflict with drivers/block/zram/zram_drv.c
 as it dropped the call to blk_queue_split() recently, but otherwise it
 still applies.

Thanks,
NeilBrown


>
> This set is based on Linus' tree as for today (2nd May) plus
> the for-linus branch from Shaohua's md/raid tree.
>
> This series adds a fix for the new lightnvm/pblk-read code
> and discards bioset_create_nobvec() in favor of a flag arg to
> bioset_create().  There are also minor fixes and a little
> code clean-up.
>
> I hope to eventually get rid of the new BIOSET_NEED_RESCUER flag,
> but that needs work ing dm and probably bcache first.
>
> Thanks,
> NeilBrown
>
>
> ---
>
> NeilBrown (13):
>       blk: remove bio_set arg from blk_queue_split()
>       blk: replace bioset_create_nobvec() with a flags arg to bioset_crea=
te()
>       blk: make the bioset rescue_workqueue optional.
>       blk: use non-rescuing bioset for q->bio_split.
>       block: Improvements to bounce-buffer handling
>       rbd: use bio_clone_fast() instead of bio_clone()
>       drbd: use bio_clone_fast() instead of bio_clone()
>       pktcdvd: use bio_clone_fast() instead of bio_clone()
>       lightnvm/pblk-read: use bio_clone_fast()
>       xen-blkfront: remove bio splitting.
>       bcache: use kmalloc to allocate bio in bch_data_verify()
>       block: remove bio_clone() and all references.
>       block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()
>
>
>  Documentation/block/biodoc.txt      |    2 -
>  block/bio.c                         |   72 ++++++++++++++++-------------=
------
>  block/blk-core.c                    |    4 +-
>  block/blk-merge.c                   |   31 ++-------------
>  block/blk-mq.c                      |    2 -
>  block/bounce.c                      |   32 +++++++++++++---
>  drivers/block/drbd/drbd_int.h       |    3 +
>  drivers/block/drbd/drbd_main.c      |   11 +++++
>  drivers/block/drbd/drbd_req.c       |    2 -
>  drivers/block/drbd/drbd_req.h       |    2 -
>  drivers/block/pktcdvd.c             |   14 +++++--
>  drivers/block/ps3vram.c             |    2 -
>  drivers/block/rbd.c                 |   16 +++++++-
>  drivers/block/rsxx/dev.c            |    2 -
>  drivers/block/umem.c                |    2 -
>  drivers/block/xen-blkfront.c        |   54 +-------------------------
>  drivers/block/zram/zram_drv.c       |    2 -
>  drivers/lightnvm/pblk-init.c        |   16 ++++++--
>  drivers/lightnvm/pblk-read.c        |    2 -
>  drivers/lightnvm/pblk.h             |    1=20
>  drivers/lightnvm/rrpc.c             |    2 -
>  drivers/md/bcache/debug.c           |    2 -
>  drivers/md/bcache/super.c           |    6 ++-
>  drivers/md/dm-crypt.c               |    2 -
>  drivers/md/dm-io.c                  |    2 -
>  drivers/md/dm.c                     |    5 +-
>  drivers/md/md.c                     |    6 +--
>  drivers/md/raid1.c                  |    2 -
>  drivers/md/raid10.c                 |    2 -
>  drivers/md/raid5-cache.c            |    2 -
>  drivers/md/raid5-ppl.c              |    2 -
>  drivers/md/raid5.c                  |    2 -
>  drivers/s390/block/dcssblk.c        |    2 -
>  drivers/s390/block/xpram.c          |    2 -
>  drivers/target/target_core_iblock.c |    2 -
>  fs/block_dev.c                      |    2 -
>  fs/btrfs/extent_io.c                |    3 +
>  fs/xfs/xfs_super.c                  |    3 +
>  include/linux/bio.h                 |   12 ++----
>  include/linux/blkdev.h              |    3 -
>  40 files changed, 162 insertions(+), 174 deletions(-)
>
> --
> Signature

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkTtyMACgkQOeye3VZi
gbnoaA/7BAmdUU15Sq5y4GgR355UXM2kEtbO1KZ7eXv078rfaJ6tOyuqye0eOSZk
f8LY8eH9qQQX0UAVeMhfw5mzN5+gRNh/nOwtLIGLpw6teThMPNA5j6SBI6D2oGmF
N28qiFpknV+PmFkeYIH+RjwMEsdcvvQnGNeEGta3fAVkaotMh0q7Etf/BN3n7FCP
fIJsxlYI9MsURcNa1rMf7DCGQnlqP9V5rObHniNK3gNvOIMG8Kqmt6a/DfsiZ30r
Sf80AZJVpOlh1xqpy0I8WCyWG7aipbPnpPPViKwLBxC/GMmwNC8HM+Xo8CbCMcp9
E4LoO00tzrG0qVct2xaGdf2i8+WdeS378jhhggBzKI3lz05x1k6HjiAEfzSqB9Id
UoslQTgE9pOKbCHHvGZxBH6HZlp/uEz1YU2L7bAOcHaXqzBqq0kPiJcRK/qfAvPz
REoZpyQA+f2ekYWmqo3r310vcUz3sZ4rdjvF9O6ch6z1+pA5MF0I6U/yfnaRAP+z
ZvgFEe4spAdbydFsW30RLYJrEwJxdijT0lvcuP9QV43i007AGTgQ9rzbFogKAW/z
TyPmmYLnUCapLvvvvTJRzGVxYtA4nxdqZwqIENzN9dryOCrZASXI39JMU9CFNrqI
v/Lj/8dY85VCckBXe74OHzJYQUZKTTiwnPCgDMKGQ44snJtCpTs=
=MUt/
-----END PGP SIGNATURE-----
--=-=-=--
