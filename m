Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <69B7769C-B47B-4FB3-8B07-C92DD5DBBA5B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_572E262C-C243-49DA-BACE-49FFD27B5DEE";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 02/10] blk-mq: expose stream write stats through debugfs
Date: Tue, 13 Jun 2017 22:07:57 -0600
In-Reply-To: <1497412919-19400-3-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <1497412919-19400-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_572E262C-C243-49DA-BACE-49FFD27B5DEE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 10:01 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> Useful to verify that things are working the way they should.
> Reading the file will return number of kb written to each
> stream. Writing the file will reset the statistics. No care
> is taken to ensure that we don't race on updates.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> block/blk-core.c       |  5 +++++
> block/blk-mq-debugfs.c | 24 ++++++++++++++++++++++++
> include/linux/blkdev.h |  3 +++
> 3 files changed, 32 insertions(+)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a7421b772d0e..81051e24b5dd 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2057,6 +2057,11 @@ blk_qc_t generic_make_request(struct bio *bio)
> 	do {
> 		struct request_queue *q =3D =
bdev_get_queue(bio->bi_bdev);
>=20
> +		if (bio_stream(bio) < BLK_MAX_STREAM) {
> +			q->stream_writes[bio_stream(bio)] +=3D
> +						bio->bi_iter.bi_size >> =
9;
> +		}
> +
> 		if (likely(blk_queue_enter(q, false) =3D=3D 0)) {
> 			struct bio_list lower, same;
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 803aed4d7221..0a37c848961d 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -133,6 +133,29 @@ static void print_stat(struct seq_file *m, struct =
blk_rq_stat *stat)
> 	}
> }
>=20
> +static int queue_streams_show(void *data, struct seq_file *m)
> +{
> +	struct request_queue *q =3D data;
> +	int i;
> +
> +	for (i =3D 0; i < BLK_MAX_STREAM; i++)
> +		seq_printf(m, "stream%d: %llu\n", i, =
q->stream_writes[i]);
> +
> +	return 0;
> +}
> +
> +static ssize_t queue_streams_store(void *data, const char __user =
*buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct request_queue *q =3D data;
> +	int i;
> +
> +	for (i =3D 0; i < BLK_MAX_STREAM; i++)
> +		q->stream_writes[i] =3D 0;
> +
> +	return count;
> +}
> +
> static int queue_poll_stat_show(void *data, struct seq_file *m)
> {
> 	struct request_queue *q =3D data;
> @@ -656,6 +679,7 @@ const struct file_operations blk_mq_debugfs_fops =3D=
 {
> static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] =3D=
 {
> 	{"poll_stat", 0400, queue_poll_stat_show},
> 	{"state", 0600, queue_state_show, queue_state_write},
> +	{"streams", 0600, queue_streams_show, queue_streams_store},
> 	{},
> };
>=20
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ab92c4ea138b..88719c6f3edf 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -586,6 +586,9 @@ struct request_queue {
>=20
> 	size_t			cmd_size;
> 	void			*rq_alloc_data;
> +
> +#define BLK_MAX_STREAM	5
> +	u64			stream_writes[BLK_MAX_STREAM];
> };
>=20
> #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_572E262C-C243-49DA-BACE-49FFD27B5DEE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQLadpIg59Q01vtYRAl14AJ46Uq1r2oIf6Ax1V39JxCWC0jAvcQCg29+r
wRTXRcIbpnHT1wqehsVjrq4=
=2oIc
-----END PGP SIGNATURE-----

--Apple-Mail=_572E262C-C243-49DA-BACE-49FFD27B5DEE--
