Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>
Subject: Re: I/O hangs after resuming from suspend-to-ram
Date: Mon, 28 Aug 2017 15:10:35 +0200
Message-ID: <3567128.t9myNOm9ia@merkaba>
In-Reply-To: <20170828125822.GA19670@ming.t460p>
References: <3926917.BCSovyVWdL@natalenko.name> <4174287.OjL0pO8MRx@natalenko.name> <20170828125822.GA19670@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Ming Lei - 28.08.17, 20:58:
> On Sun, Aug 27, 2017 at 09:43:52AM +0200, Oleksandr Natalenko wrote:
> > Hi.
> >=20
> > Here is disk setup for QEMU VM:
> >=20
> > =3D=3D=3D
> > [root@archmq ~]# smartctl -i /dev/sda
> > =E2=80=A6
> > Device Model:     QEMU HARDDISK
> > Serial Number:    QM00001
> > Firmware Version: 2.5+
> > User Capacity:    4,294,967,296 bytes [4.29 GB]
> > Sector Size:      512 bytes logical/physical
> > Device is:        Not in smartctl database [for details use: -P showall]
> > ATA Version is:   ATA/ATAPI-7, ATA/ATAPI-5 published, ANSI NCITS 340-20=
00
> > Local Time is:    Sun Aug 27 09:31:54 2017 CEST
> > SMART support is: Available - device has SMART capability.
> > SMART support is: Enabled
> >=20
> > [root@archmq ~]# lsblk
> > NAME                MAJ:MIN RM  SIZE RO TYPE   MOUNTPOINT
> > sda                   8:0    0    4G  0 disk
> > `-sda1                8:1    0    4G  0 part
> >=20
> >   `-md0               9:0    0    4G  0 raid10
> >  =20
> >     `-system        253:0    0    4G  0 crypt
> >    =20
> >       |-system-boot 253:1    0  512M  0 lvm    /boot
> >       |-system-swap 253:2    0  512M  0 lvm    [SWAP]
> >      =20
> >       `-system-root 253:3    0    3G  0 lvm    /
> >=20
> > sdb                   8:16   0    4G  0 disk
> > `-sdb1                8:17   0    4G  0 part
> >=20
> >   `-md0               9:0    0    4G  0 raid10
> >  =20
> >     `-system        253:0    0    4G  0 crypt
> >    =20
> >       |-system-boot 253:1    0  512M  0 lvm    /boot
> >       |-system-swap 253:2    0  512M  0 lvm    [SWAP]
> >      =20
> >       `-system-root 253:3    0    3G  0 lvm    /
> >=20
> > sr0                  11:0    1 1024M  0 rom
> >=20
> > [root@archmq ~]# mdadm --misc --detail /dev/md0
> >=20
> > /dev/md0:
> >         Version : 1.2
> >  =20
> >   Creation Time : Sat Jul 29 16:37:05 2017
> >  =20
> >      Raid Level : raid10
> >      Array Size : 4191232 (4.00 GiB 4.29 GB)
> >  =20
> >   Used Dev Size : 4191232 (4.00 GiB 4.29 GB)
> >  =20
> >    Raid Devices : 2
> >  =20
> >   Total Devices : 2
> >  =20
> >     Persistence : Superblock is persistent
> >    =20
> >     Update Time : Sun Aug 27 09:30:33 2017
> >    =20
> >           State : clean
> > =20
> >  Active Devices : 2
> >=20
> > Working Devices : 2
> >=20
> >  Failed Devices : 0
> > =20
> >   Spare Devices : 0
> >  =20
> >          Layout : far=3D2
> >     =20
> >      Chunk Size : 512K
> >     =20
> >            Name : archiso:0
> >            UUID : 43f4be59:c8d2fa0a:a94acdff:1c7f2f4e
> >         =20
> >          Events : 485
> >    =20
> >     Number   Major   Minor   RaidDevice State
> >    =20
> >        0       8        1        0      active sync   /dev/sda1
> >        1       8       17        1      active sync   /dev/sdb1
> >=20
> > =3D=3D=3D
> >=20
> > In words: 2 virtual disks, RAID10 setup with far-2 layout, LUKS on it,
> > then
> > LVM, then ext4 for boot, swap and btrfs for /.
> >=20
> > I couldn't reproduce the issue with single disk without RAID.
>=20
> Could you verify if the following patch fixes your issue?

Could this also apply to non MD RAID systems? I am using BTRFS RAID
1 with two SSDs. So far with CFQ it runs stable.

Thanks,
Martin

> From 9fa53d708ebc1d5b87e62e542dc54272529da244 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Mon, 28 Aug 2017 19:59:08 +0800
> Subject: [PATCH] blk-mq: align to legacy path for implementing
> blk_execute_rq
>=20
> In legacy path, when one request is run via blk_execute_rq(),
> it is added to q->queue_head directly, and I/O scheduler's
> queue is bypassed because either merging or sorting isn't
> needed.
>=20
> When SCSI device is put into quiece state, such as during
> system suspend, we need to add the request of RQF_PM into
> head of the queue.
>=20
> This patch fixes I/O hang after system resume.
>=20
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c     |  2 +-
>  block/blk-exec.c     |  2 +-
>  block/blk-flush.c    |  2 +-
>  block/blk-mq-sched.c | 58
> ++++++++++++++++++++++++++++++++++++++++++++++++++++ block/blk-mq-sched.h=
 |
>  2 ++
>  5 files changed, 63 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index dbecbf4a64e0..fb75bc646ebc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2330,7 +2330,7 @@ blk_status_t blk_insert_cloned_request(struct
> request_queue *q, struct request * if (q->mq_ops) {
>  		if (blk_queue_io_stat(q))
>  			blk_account_io_start(rq, true);
> -		blk_mq_sched_insert_request(rq, false, true, false, false);
> +		blk_mq_sched_insert_request_bypass(rq, false, true, false, false);
>  		return BLK_STS_OK;
>  	}
>=20
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index 5c0f3dc446dc..4565aa6bb624 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -61,7 +61,7 @@ void blk_execute_rq_nowait(struct request_queue *q, str=
uct
> gendisk *bd_disk, * be reused after dying flag is set
>  	 */
>  	if (q->mq_ops) {
> -		blk_mq_sched_insert_request(rq, at_head, true, false, false);
> +		blk_mq_sched_insert_request_bypass(rq, at_head, true, false, false);
>  		return;
>  	}
>=20
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index ed5fe322abba..51e89e5c525a 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -463,7 +463,7 @@ void blk_insert_flush(struct request *rq)
>  	if ((policy & REQ_FSEQ_DATA) &&
>  	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
>  		if (q->mq_ops)
> -			blk_mq_sched_insert_request(rq, false, true, false, false);
> +			blk_mq_sched_insert_request_bypass(rq, false, true, false, false);
>  		else
>  			list_add_tail(&rq->queuelist, &q->queue_head);
>  		return;
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 4ab69435708c..eeeea026fb47 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -354,6 +354,64 @@ static void blk_mq_sched_insert_flush(struct
> blk_mq_hw_ctx *hctx, blk_mq_add_to_requeue_list(rq, false, true);
>  }
>=20
> +static void blk_mq_flush_hctx(struct blk_mq_hw_ctx *hctx,
> +			      struct elevator_queue *e,
> +			      const bool has_sched_dispatch,
> +			      struct list_head *rqs)
> +{
> +	LIST_HEAD(list);
> +
> +	if (!has_sched_dispatch)
> +		blk_mq_flush_busy_ctxs(hctx, &list);
> +	else {
> +		while (true) {
> +			struct request *rq;
> +
> +			rq =3D e->type->ops.mq.dispatch_request(hctx);
> +			if (!rq)
> +				break;
> +			list_add_tail(&rq->queuelist, &list);
> +		}
> +	}
> +
> +	list_splice_tail(&list, rqs);
> +}
> +
> +void blk_mq_sched_insert_request_bypass(struct request *rq, bool at_head,
> +					bool run_queue, bool async,
> +					bool can_block)
> +{
> +	struct request_queue *q =3D rq->q;
> +	struct elevator_queue *e =3D q->elevator;
> +	struct blk_mq_ctx *ctx =3D rq->mq_ctx;
> +	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, ctx->cpu);
> +	LIST_HEAD(list);
> +	const bool has_sched_dispatch =3D e && e->type->ops.mq.dispatch_request;
> +
> +	if (rq->tag =3D=3D -1 && op_is_flush(rq->cmd_flags)) {
> +		blk_mq_sched_insert_flush(hctx, rq, can_block);
> +		return;
> +	}
> +
> +	if (at_head)
> +		list_add_tail(&rq->queuelist, &list);
> +	else {
> +		blk_mq_flush_hctx(hctx, e, has_sched_dispatch, &list);
> +		list_add_tail(&rq->queuelist, &list);
> +		run_queue =3D true;
> +	}
> +
> +	spin_lock(&hctx->lock);
> +	if (at_head)
> +		list_splice(&list, &hctx->dispatch);
> +	else
> +		list_splice_tail(&list, &hctx->dispatch);
> +	spin_unlock(&hctx->lock);
> +
> +	if (run_queue)
> +		blk_mq_run_hw_queue(hctx, async);
> +}
> +
>  void blk_mq_sched_insert_request(struct request *rq, bool at_head,
>  				 bool run_queue, bool async, bool can_block)
>  {
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 9267d0b7c197..4d01697a627f 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -18,6 +18,8 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
>=20
>  void blk_mq_sched_insert_request(struct request *rq, bool at_head,
>  				 bool run_queue, bool async, bool can_block);
> +void blk_mq_sched_insert_request_bypass(struct request *rq, bool at_head,
> +					bool run_queue, bool async, bool can_block);
>  void blk_mq_sched_insert_requests(struct request_queue *q,
>  				  struct blk_mq_ctx *ctx,
>  				  struct list_head *list, bool run_queue_async);


=2D-=20
Martin
