Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <8290144C-3C0E-4200-B5FF-A949BC3FD87B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_576774D0-3B29-4C44-8FD8-28B6367839A5";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 03/11] blk-mq: expose stream write stats through debugfs
Date: Tue, 13 Jun 2017 13:21:00 -0600
In-Reply-To: <1497374123-15286-4-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-4-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_576774D0-3B29-4C44-8FD8-28B6367839A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> Useful to verify that things are working the way they should.
> Reading the file will return number of kb written to each
> stream. Writing the file will reset the statistics. No care
> is taken to ensure that we don't race on updates.

This is one of the few places where there is an arbitrary limit on the
number of stream IDs, which is strange because it doesn't correspond to
any limit in a struct field or the physical hardware or external =
protocol...

Bumping the stream_writes[] stats array up to 16 wouldn't make any
significant difference to the size of struct request_queue.

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> block/blk-core.c       |  2 ++
> block/blk-mq-debugfs.c | 24 ++++++++++++++++++++++++
> include/linux/blkdev.h |  2 ++
> 3 files changed, 28 insertions(+)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a7421b772d0e..12e402e4e741 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2057,6 +2057,8 @@ blk_qc_t generic_make_request(struct bio *bio)
> 	do {
> 		struct request_queue *q =3D =
bdev_get_queue(bio->bi_bdev);
>=20
> +		q->stream_writes[bio_stream(bio)] +=3D =
bio->bi_iter.bi_size >> 9;

This should probably limit the value returned from bio_stream(), and put =
values
>=3D WRITE_LIFE_NR into an "overflow" bucket or similar?  At some point =
in the
future this could be made more flexible, based on the actual usage, but =
at
least the limitation on the implementation isn't something arbitrary =
like stats.

> 		if (likely(blk_queue_enter(q, false) =3D=3D 0)) {
> 			struct bio_list lower, same;
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 803aed4d7221..a0a480a0b373 100644
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
> +	for (i =3D 0; i < WRITE_LIFE_NR; i++)
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
> +	for (i =3D 0; i < WRITE_LIFE_NR; i++)
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
> index ab92c4ea138b..ab623deb20b2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -586,6 +586,8 @@ struct request_queue {
>=20
> 	size_t			cmd_size;
> 	void			*rq_alloc_data;
> +
> +	u64			stream_writes[WRITE_LIFE_NR];
> };
>=20
> #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_576774D0-3B29-4C44-8FD8-28B6367839A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQDscpIg59Q01vtYRAoxaAKDDOxgeCN34tJvfIt2EkrHllA1awwCg7ve0
nK8FiVEWMGrMxA4e88yAt70=
=71JG
-----END PGP SIGNATURE-----

--Apple-Mail=_576774D0-3B29-4C44-8FD8-28B6367839A5--
