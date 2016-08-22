Return-Path: <Damien.LeMoal@hgst.com>
Subject: Re: [PATCH v2 2/4] On Discard either do Reset WP or Write Same
To: Shaun Tancheff <shaun@tancheff.com>, <linux-block@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20160822043116.21168-1-shaun@tancheff.com>
 <20160822043116.21168-3-shaun@tancheff.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "James E . J
 . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman
	<josh.bingaman@seagate.com>, Dan Williams <dan.j.williams@intel.com>, Sagi
 Grimberg <sagig@mellanox.com>, Mike Christie <mchristi@redhat.com>, Toshi
 Kani <toshi.kani@hpe.com>, Ming Lei <ming.lei@canonical.com>, Shaun Tancheff
	<shaun.tancheff@seagate.com>
From: Damien Le Moal <damien.lemoal@hgst.com>
Message-ID: <53c2949f-f8b9-463f-2adf-faf4603429bb@hgst.com>
Date: Tue, 23 Aug 2016 08:57:15 +0900
MIME-Version: 1.0
In-Reply-To: <20160822043116.21168-3-shaun@tancheff.com>
Content-Type: text/plain; charset="windows-1252"
Return-Path: damien.lemoal@hgst.com
List-ID: <linux-block@vger.kernel.org>


Shaun,

On 8/22/16 13:31, Shaun Tancheff wrote:
[...]
> -int sd_zbc_setup_discard(struct scsi_disk *sdkp, struct request *rq,
> -			 sector_t sector, unsigned int num_sectors)
> +int sd_zbc_setup_discard(struct scsi_cmnd *cmd)
>  {
> -	struct blk_zone *zone;
> +	struct request *rq =3D cmd->request;
> +	struct scsi_device *sdp =3D cmd->device;
> +	struct scsi_disk *sdkp =3D scsi_disk(rq->rq_disk);
> +	sector_t sector =3D blk_rq_pos(rq);
> +	unsigned int nr_sectors =3D blk_rq_sectors(rq);
>  	int ret =3D BLKPREP_OK;
> +	struct blk_zone *zone;
>  	unsigned long flags;
> +	u32 wp_offset;
> +	bool use_write_same =3D false;
>  =

>  	zone =3D blk_lookup_zone(rq->q, sector);
> -	if (!zone)
> +	if (!zone) {
> +		/* Test for a runt zone before giving up */
> +		if (sdp->type !=3D TYPE_ZBC) {
> +			struct request_queue *q =3D rq->q;
> +			struct rb_node *node;
> +
> +			node =3D rb_last(&q->zones);
> +			if (node)
> +				zone =3D rb_entry(node, struct blk_zone, node);
> +			if (zone) {
> +				spin_lock_irqsave(&zone->lock, flags);
> +				if ((zone->start + zone->len) <=3D sector)
> +					goto out;
> +				spin_unlock_irqrestore(&zone->lock, flags);
> +				zone =3D NULL;
> +			}
> +		}
>  		return BLKPREP_KILL;
> +	}

I do not understand the point of this code here to test for the runt
zone. As long as sector is within the device maximum capacity (in 512B
unit), blk_lookup_zone will return the pointer to the zone structure
containing that sector (the RB-tree does not have any constraint
regarding zone size). The only case where NULL would be returned is if
discard is issued super early right after the disk is probed and before
the zone refresh work has completed. We can certainly protect against
that by delaying the discard.


>  =

>  	spin_lock_irqsave(&zone->lock, flags);
> -
>  	if (zone->state =3D=3D BLK_ZONE_UNKNOWN ||
>  	    zone->state =3D=3D BLK_ZONE_BUSY) {
>  		sd_zbc_debug_ratelimit(sdkp,
> -				       "Discarding zone %zu state %x, deferring\n",
> +				       "Discarding zone %zx state %x, deferring\n",

Sector values are usually displayed in decimal. Why use Hex here ? At
least "0x" would be needed to avoid confusion I think.

>  				       zone->start, zone->state);
>  		ret =3D BLKPREP_DEFER;
>  		goto out;
> @@ -406,46 +428,80 @@ int sd_zbc_setup_discard(struct scsi_disk *sdkp, st=
ruct request *rq,
>  	if (zone->state =3D=3D BLK_ZONE_OFFLINE) {
>  		/* let the drive fail the command */
>  		sd_zbc_debug_ratelimit(sdkp,
> -				       "Discarding offline zone %zu\n",
> +				       "Discarding offline zone %zx\n",
>  				       zone->start);
>  		goto out;
>  	}
> -
> -	if (!blk_zone_is_smr(zone)) {
> +	if (blk_zone_is_cmr(zone)) {
> +		use_write_same =3D true;
>  		sd_zbc_debug_ratelimit(sdkp,
> -				       "Discarding %s zone %zu\n",
> -				       blk_zone_is_cmr(zone) ? "CMR" : "unknown",
> +				       "Discarding CMR zone %zx\n",
>  				       zone->start);
> -		ret =3D BLKPREP_DONE;
>  		goto out;
>  	}

Some 10TB host managed disks out there have 1% conventional zone space,
that is 100GB of capacity. When issuing a "reset all", doing a write
same in these zones will take forever... If the user really wants zeroes
in those zones, let it issue a zeroout.

I think that it would a better choice to simply not report
discard_zeroes_data as true and do nothing for conventional zones reset.

> -	if (blk_zone_is_empty(zone)) {
> -		sd_zbc_debug_ratelimit(sdkp,
> -				       "Discarding empty zone %zu\n",
> -				       zone->start);
> -		ret =3D BLKPREP_DONE;
> +	if (zone->start !=3D sector || zone->len < nr_sectors) {
> +		sd_printk(KERN_ERR, sdkp,
> +			  "Misaligned RESET WP %zx/%x on zone %zx/%zx\n",
> +			  sector, nr_sectors, zone->start, zone->len);
> +		ret =3D BLKPREP_KILL;
>  		goto out;
>  	}
> -
> -	if (zone->start !=3D sector ||
> -	    zone->len < num_sectors) {
> +	/* Protect against Reset WP when more data had been written to the
> +	 * zone than is being discarded.
> +	 */
> +	wp_offset =3D zone->wp - zone->start;
> +	if (wp_offset > nr_sectors) {
>  		sd_printk(KERN_ERR, sdkp,
> -			  "Misaligned RESET WP, start %zu/%zu "
> -			  "len %zu/%u\n",
> -			  zone->start, sector, zone->len, num_sectors);
> +			  "Will Corrupt RESET WP %zx/%x/%x on zone %zx/%zx/%zx\n",
> +			  sector, wp_offset, nr_sectors,
> +			  zone->start, zone->wp, zone->len);
>  		ret =3D BLKPREP_KILL;
>  		goto out;
>  	}
> -
> -	/*
> -	 * Opportunistic setting, will be fixed up with
> -	 * zone update if RESET WRITE POINTER fails.
> -	 */
> -	zone->wp =3D zone->start;
> +	if (blk_zone_is_empty(zone)) {
> +		sd_zbc_debug_ratelimit(sdkp,
> +				       "Discarding empty zone %zx [WP: %zx]\n",
> +				       zone->start, zone->wp);
> +		ret =3D BLKPREP_DONE;
> +		goto out;
> +	}
>  =

>  out:
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  =

> +	if (ret !=3D BLKPREP_OK)
> +		goto done;
> +	/*
> +	 * blk_zone cache uses block layer sector units
> +	 * but commands use device units
> +	 */
> +	sector >>=3D ilog2(sdp->sector_size) - 9;
> +	nr_sectors >>=3D ilog2(sdp->sector_size) - 9;
> +
> +	if (use_write_same) {
> +		cmd->cmd_len =3D 16;
> +		cmd->cmnd[0] =3D WRITE_SAME_16;
> +		cmd->cmnd[1] =3D 0; /* UNMAP (not set) */
> +		put_unaligned_be64(sector, &cmd->cmnd[2]);
> +		put_unaligned_be32(nr_sectors, &cmd->cmnd[10]);
> +		cmd->transfersize =3D sdp->sector_size;
> +		rq->timeout =3D SD_WRITE_SAME_TIMEOUT;
> +	} else {
> +		cmd->cmd_len =3D 16;
> +		cmd->cmnd[0] =3D ZBC_OUT;
> +		cmd->cmnd[1] =3D ZO_RESET_WRITE_POINTER;
> +		put_unaligned_be64(sector, &cmd->cmnd[2]);
> +		/* Reset Write Pointer doesn't have a payload */
> +		cmd->transfersize =3D 0;
> +		cmd->sc_data_direction =3D DMA_NONE;
> +		/*
> +		 * Opportunistic setting, will be fixed up with
> +		 * zone update if RESET WRITE POINTER fails.
> +		 */
> +		zone->wp =3D zone->start;
> +	}
> +
> +done:
>  	return ret;
>  }
>  =

> @@ -468,6 +524,9 @@ int sd_zbc_setup_read_write(struct scsi_disk *sdkp, s=
truct request *rq,
>  =

>  	spin_lock_irqsave(&zone->lock, flags);
>  =

> +	if (blk_zone_is_cmr(zone))
> +		goto out;
> +
>  	if (zone->state =3D=3D BLK_ZONE_UNKNOWN ||
>  	    zone->state =3D=3D BLK_ZONE_BUSY) {
>  		sd_zbc_debug_ratelimit(sdkp,
> @@ -476,16 +535,6 @@ int sd_zbc_setup_read_write(struct scsi_disk *sdkp, =
struct request *rq,
>  		ret =3D BLKPREP_DEFER;
>  		goto out;
>  	}
> -	if (zone->state =3D=3D BLK_ZONE_OFFLINE) {
> -		/* let the drive fail the command */
> -		sd_zbc_debug_ratelimit(sdkp,
> -				       "zone %zu offline\n",
> -				       zone->start);
> -		goto out;
> -	}
> -
> -	if (blk_zone_is_cmr(zone))
> -		goto out;
>  =

>  	if (blk_zone_is_seq_pref(zone)) {
>  		if (op_is_write(req_op(rq))) {
> @@ -514,6 +563,14 @@ int sd_zbc_setup_read_write(struct scsi_disk *sdkp, =
struct request *rq,
>  		goto out;
>  	}
>  =

> +	if (zone->state =3D=3D BLK_ZONE_OFFLINE) {
> +		/* let the drive fail the command */
> +		sd_zbc_debug_ratelimit(sdkp,
> +				       "zone %zu offline\n",
> +				       zone->start);
> +		goto out;
> +	}
> +
>  	if (op_is_write(req_op(rq))) {
>  		if (zone->state =3D=3D BLK_ZONE_READONLY)
>  			goto out;
> =


-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital brand
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa, =

Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
