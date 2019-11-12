Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C0C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 01:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E01B2196E
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 01:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeArrJ3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKLBhu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:37:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51262 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfKLBhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 20:37:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1JXM3007300;
        Tue, 12 Nov 2019 01:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=QC6ajmzxjxGIRABZgSAbAx8X+z6ZNnLd4wJEGFGBvBc=;
 b=NeArrJ3y/B5lKE+1d0xg/tEHU9uIT9V51uOsP7pbSqYbGCkLHK4YQgAf6VNLh/AosUeg
 Vj1Sfdy8NA2rCgW/BMqvLvm1PGvxeeuYc7PAbVvCPMqczY20jnfQGeympx9PZWxKt24Y
 WDfmRiu6QCWI6WzzRcfY6zCdtnAsQFbeFdmgGUZ4Cd2uzrY3CM4CWI4v+nSXiwZJVV2o
 WpHXIuY5G8w3aEubIBPu0J64uwOTrezEN0s10ovuksVy6J2lD+gu3SWtqMiP2gFmBn6u
 T4LsA17W/dct7zKofTuwGT8Abq3ffk5BjdAj9BR6WH4vSkLaPKvKKJz1tdY3JdMnNRRU LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w5mvthnt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:36:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1JHVk172390;
        Tue, 12 Nov 2019 01:36:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w6r8kcef5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:36:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAC1afPg007706;
        Tue, 12 Nov 2019 01:36:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Nov 2019 17:36:41 -0800
Date:   Mon, 11 Nov 2019 17:36:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] loop: Better discard support for block devices
Message-ID: <20191112013639.GE6235@magnolia>
References: <20191111185030.215451-1-evgreen@chromium.org>
 <20191111185030.215451-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111185030.215451-3-evgreen@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120009
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 11, 2019 at 10:50:30AM -0800, Evan Green wrote:
> If the backing device for a loop device is a block device,
> then mirror the "write zeroes" capabilities of the underlying
> block device into the loop device. Copy this capability into both
> max_write_zeroes_sectors and max_discard_sectors of the loop device.
> 
> The reason for this is that REQ_OP_DISCARD on a loop device translates
> into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> presents a consistent interface for loop devices (that discarded data
> is zeroed), regardless of the backing device type of the loop device.
> There should be no behavior change for loop devices backed by regular
> files.
> 
> While in there, differentiate between REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES, which are different for block devices,
> but which the loop device had just been lumping together, since
> they're largely the same for files.
> 
> This change fixes blktest block/003, and removes an extraneous
> error print in block/013 when testing on a loop device backed
> by a block device that does not support discard.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
> 
> Changes in v6: None
> Changes in v5:
> - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> 
> Changes in v4:
> - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> 
> Changes in v3:
> - Updated commit description
> 
> Changes in v2: None
> 
>  drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d749156a3d88..236f6deb0772 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
>  	return ret;
>  }
>  
> -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> +static int lo_discard(struct loop_device *lo, struct request *rq,
> +		int mode, loff_t pos)
>  {
> -	/*
> -	 * We use punch hole to reclaim the free space used by the
> -	 * image a.k.a. discard. However we do not support discard if
> -	 * encryption is enabled, because it may give an attacker
> -	 * useful information.
> -	 */
>  	struct file *file = lo->lo_backing_file;
> -	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> +	struct request_queue *q = lo->lo_queue;
>  	int ret;
>  
> -	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> +	if (!blk_queue_discard(q)) {
>  		ret = -EOPNOTSUPP;
>  		goto out;
>  	}
> @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  	case REQ_OP_FLUSH:
>  		return lo_req_flush(lo, rq);
>  	case REQ_OP_DISCARD:
> +		return lo_discard(lo, rq,
> +			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> +
>  	case REQ_OP_WRITE_ZEROES:
> -		return lo_discard(lo, rq, pos);
> +		return lo_discard(lo, rq,
> +			FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);

Yes, this more or less reimplements what's already in -next...

> +
>  	case REQ_OP_WRITE:
>  		if (lo->transfer)
>  			return lo_write_transfer(lo, rq, pos);
> @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
>  	struct request_queue *q = lo->lo_queue;
> +	struct request_queue *backingq;
> +
> +	/*
> +	 * If the backing device is a block device, mirror its zeroing
> +	 * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> +	 * by block devices to keep consistent behavior with file-backed loop
> +	 * devices.
> +	 */
> +	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> +		backingq = bdev_get_queue(inode->i_bdev);

What happens if the inode is from a filesystem that can have multiple
backing devices (like btrfs)?

> +		blk_queue_max_discard_sectors(q,
> +			backingq->limits.max_write_zeroes_sectors);
> +
> +		blk_queue_max_write_zeroes_sectors(q,
> +			backingq->limits.max_write_zeroes_sectors);

Also, seeing as filesystems tend to implement PUNCH_HOLE and ZERO_RANGE
on their own independent of the hardware capabilities of the underlying
device, it doesn't make much sense to forward the blockdev limits to the
loop device.

(Put another way, XFS's ZERO_RANGE implementation can zero hundreds of
gigabytes at a time even if the underlying device is a spinning rust.)

--D

>  
>  	/*
>  	 * We use punch hole to reclaim the free space used by the
> @@ -861,22 +876,24 @@ static void loop_config_discard(struct loop_device *lo)
>  	 * encryption is enabled, because it may give an attacker
>  	 * useful information.
>  	 */
> -	if ((!file->f_op->fallocate) ||
> -	    lo->lo_encrypt_key_size) {
> +	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
>  		q->limits.discard_granularity = 0;
>  		q->limits.discard_alignment = 0;
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
> -		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> -		return;
> -	}
>  
> -	q->limits.discard_granularity = inode->i_sb->s_blocksize;
> -	q->limits.discard_alignment = 0;
> +	} else {
> +		q->limits.discard_granularity = inode->i_sb->s_blocksize;
> +		q->limits.discard_alignment = 0;
> +
> +		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> +		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> +	}
>  
> -	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> -	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> -	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +	if (q->limits.max_write_zeroes_sectors)
> +		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>  }
>  
>  static void loop_unprepare_queue(struct loop_device *lo)
> -- 
> 2.21.0
> 
