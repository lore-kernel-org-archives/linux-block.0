Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Thiago
 Jung Bauermann <bauerman@linux.vnet.ibm.com>, Lekshmi Pillai
	<lekshmicpillai@in.ibm.com>, Tejun Heo <tj@kernel.org>, NeilBrown
	<neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 04/13] block: Move bdi_unregister() to del_gendisk()
Date: Tue, 21 Feb 2017 19:53:29 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0AC71A@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-5-jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 02/21/2017 09:55 AM, Jan Kara wrote:=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 47104f6a398b..9a901dcfdd5c 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -580,8 +580,6 @@ void blk_cleanup_queue(struct request_queue *q)=0A=
>  		q->queue_lock =3D &q->__queue_lock;=0A=
>  	spin_unlock_irq(lock);=0A=
>  =0A=
> -	bdi_unregister(q->backing_dev_info);=0A=
> -=0A=
>  	/* @q is and will stay empty, shutdown and put */=0A=
>  	blk_put_queue(q);=0A=
>  }=0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index f6c4d4400759..68c613edb93a 100644=0A=
> --- a/block/genhd.c=0A=
> +++ b/block/genhd.c=0A=
> @@ -660,6 +660,13 @@ void del_gendisk(struct gendisk *disk)=0A=
>  	disk->flags &=3D ~GENHD_FL_UP;=0A=
>  =0A=
>  	sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");=0A=
> +	/*=0A=
> +	 * Unregister bdi before releasing device numbers (as they can get=0A=
> +	 * reused and we'd get clashes in sysfs) but after bdev inodes are=0A=
> +	 * unhashed and thus will be soon destroyed as bdev inode's reference=
=0A=
> +	 * to wb_writeback can block bdi_unregister().=0A=
> +	 */=0A=
> +	bdi_unregister(disk->queue->backing_dev_info);=0A=
>  	blk_unregister_queue(disk);=0A=
>  	blk_unregister_region(disk_devt(disk), disk->minors);=0A=
=0A=
This change looks suspicious to me. There are drivers that create a=0A=
block layer queue but neither call device_add_disk() nor del_gendisk(),=0A=
e.g. drivers/scsi/st.c. Although bdi_init() will be called for the=0A=
queues created by these drivers, this patch will cause the=0A=
bdi_unregister() call to be skipped for these drivers.=0A=
=0A=
Bart.=0A=
=0A=
