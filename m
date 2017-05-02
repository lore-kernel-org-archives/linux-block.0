Return-Path: <javigon.napster@gmail.com>
Return-Path: <javigon.napster@gmail.com>
From: javigon <javigon.napster@gmail.com>
Message-Id: <63D46798-F6A7-4686-8577-CDE5F4B413D5@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5A83D2D9-6AAC-4BA2-B0CD-25A560004039";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/13] blk: remove bio_set arg from blk_queue_split()
Date: Tue, 2 May 2017 12:44:53 +0200
In-Reply-To: <149369654384.5146.13347645646156684946.stgit@noble>
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Ming Lei <tom.leiming@gmail.com>,
 linux-kernel@vger.kernel.org
To: NeilBrown <neilb@suse.com>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654384.5146.13347645646156684946.stgit@noble>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_5A83D2D9-6AAC-4BA2-B0CD-25A560004039
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 2 May 2017, at 05.42, NeilBrown <neilb@suse.com> wrote:
>=20
> blk_queue_split() is always called with the last arg being =
q->bio_split,
> where 'q' is the first arg.
>=20
> Also blk_queue_split() sometimes uses the passed-in 'bs' and sometimes =
uses
> q->bio_split.
>=20
> This is inconsistent and unnecessary.  Remove the last arg and always =
use
> q->bio_split inside blk_queue_split()
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Credit-to: Javier Gonz=C3=A1lez <jg@lightnvm.io> (Noticed that =
lightnvm was missed)
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> block/blk-core.c              |    2 +-
> block/blk-merge.c             |    9 ++++-----
> block/blk-mq.c                |    2 +-
> drivers/block/drbd/drbd_req.c |    2 +-
> drivers/block/pktcdvd.c       |    2 +-
> drivers/block/ps3vram.c       |    2 +-
> drivers/block/rsxx/dev.c      |    2 +-
> drivers/block/umem.c          |    2 +-
> drivers/block/zram/zram_drv.c |    2 +-
> drivers/lightnvm/pblk-init.c  |    4 ++--
> drivers/lightnvm/rrpc.c       |    2 +-
> drivers/md/md.c               |    2 +-
> drivers/s390/block/dcssblk.c  |    2 +-
> drivers/s390/block/xpram.c    |    2 +-
> include/linux/blkdev.h        |    3 +--
> 15 files changed, 19 insertions(+), 21 deletions(-)
>=20

> [..]

> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index ae8cd6d5af8b..b3fec8ec55b8 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -33,7 +33,7 @@ static int pblk_rw_io(struct request_queue *q, =
struct pblk *pblk,
> 	 * constraint. Writes can be of arbitrary size.
> 	 */
> 	if (bio_data_dir(bio) =3D=3D READ) {
> -		blk_queue_split(q, &bio, q->bio_split);
> +		blk_queue_split(q, &bio);
> 		ret =3D pblk_submit_read(pblk, bio);
> 		if (ret =3D=3D NVM_IO_DONE && bio_flagged(bio, =
BIO_CLONED))
> 			bio_put(bio);
> @@ -46,7 +46,7 @@ static int pblk_rw_io(struct request_queue *q, =
struct pblk *pblk,
> 	 * available for user I/O.
> 	 */
> 	if (unlikely(pblk_get_secs(bio) >=3D =
pblk_rl_sysfs_rate_show(&pblk->rl)))
> -		blk_queue_split(q, &bio, q->bio_split);
> +		blk_queue_split(q, &bio);
>=20
> 	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
> }
> diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
> index cf0e28a0ff61..8e241056b141 100644
> --- a/drivers/lightnvm/rrpc.c
> +++ b/drivers/lightnvm/rrpc.c
> @@ -994,7 +994,7 @@ static blk_qc_t rrpc_make_rq(struct request_queue =
*q, struct bio *bio)
> 	struct nvm_rq *rqd;
> 	int err;
>=20
> -	blk_queue_split(q, &bio, q->bio_split);
> +	blk_queue_split(q, &bio);
>=20
> 	if (bio_op(bio) =3D=3D REQ_OP_DISCARD) {
> 		rrpc_discard(rrpc, bio);
>=20

Hi Neil,

Thanks for adding the LightNVM changes. It works fine on our test setup.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
Tested-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_5A83D2D9-6AAC-4BA2-B0CD-25A560004039
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJZCGMlAAoJEGn/+wzNTX/af/oH/0vnEXHJEPY3eSFOBSo4CTHM
UhBUkCGMCshTjTlU8Bfjd9qyecxSpqD8xtRVlbLbtdSz7JLo5NA8DJ8BdV1DorpS
wwkMjPQb4TDhYt6cTsUQVv5vRzhjUjWXETv5Pfsss0ueu3G2vXeO4ALYDiJ0aN5q
oT1uxWDbRTpWVT9zXQ8hJQhqHbfcUYtmBn8/xQgJxa17e0D5IKY+W+zH8KghZSEc
/+ssV7tpm4PinDc9Cgvdkv/xF5rq/pvKiWEJiTqF9cMf9ir1nyoIxD9fbF4LNSgO
qvN6qXwqDMj5X1U5xcIrC8FCKc9X08DlMozkrfm4OJExLqcXaPnfpsRrigSu8vE=
=oOnk
-----END PGP SIGNATURE-----

--Apple-Mail=_5A83D2D9-6AAC-4BA2-B0CD-25A560004039--
