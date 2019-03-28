Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA50C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 02:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35837206C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 02:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfC1ChD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfC1ChD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 22:37:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1E553688B;
        Thu, 28 Mar 2019 02:37:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60FCF608A4;
        Thu, 28 Mar 2019 02:36:55 +0000 (UTC)
Date:   Thu, 28 Mar 2019 10:36:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] loop: Better discard support for block devices
Message-ID: <20190328023650.GD19708@ming.t460p>
References: <20190327222841.38650-1-evgreen@chromium.org>
 <20190327222841.38650-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327222841.38650-3-evgreen@chromium.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 28 Mar 2019 02:37:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 03:28:41PM -0700, Evan Green wrote:
> If the backing device for a loop device is a block device,
> then mirror the discard properties of the underlying block
> device into the loop device. This new change only applies to
> loop devices backed directly by a block device, not loop
> devices backed by regular files.
> 
> While in there, differentiate between REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES, which are different for block devices,
> but which the loop device had just been lumping together, since
> they're largely the same for files.
> 
> This change fixes blktest block/003, and removes an extraneous
> error print in block/013 when testing on a loop device backed
> by a block device that does not support discard.

I saw such issue many times, I believe it needs the fix.

> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> Changes in v3:
>  - Updated commit description
> 
> Changes in v2: None
> 
>  drivers/block/loop.c | 61 +++++++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bbf21ebeccd3..e1edd004298a 100644
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
> +
>  	case REQ_OP_WRITE:
>  		if (lo->transfer)
>  			return lo_write_transfer(lo, rq, pos);
> @@ -854,6 +854,25 @@ static void loop_config_discard(struct loop_device *lo)
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
>  	struct request_queue *q = lo->lo_queue;
> +	struct request_queue *backingq;
> +
> +	/*
> +	 * If the backing device is a block device, mirror its discard
> +	 * capabilities.
> +	 */
> +	if (S_ISBLK(inode->i_mode)) {
> +		backingq = bdev_get_queue(inode->i_bdev);
> +		blk_queue_max_discard_sectors(q,
> +			backingq->limits.max_discard_sectors);
> +
> +		blk_queue_max_write_zeroes_sectors(q,
> +			backingq->limits.max_write_zeroes_sectors);
> +
> +		q->limits.discard_granularity =
> +			backingq->limits.discard_granularity;
> +
> +		q->limits.discard_alignment =
> +			backingq->limits.discard_alignment;

Loop usually doesn't mirror backing queue's limits, and I believe
it isn't necessary for this case too, just wondering why the
following simple setting can't work?

	if (S_ISBLK(inode->i_mode)) {
		backingq = bdev_get_queue(inode->i_bdev);

		q->limits.discard_alignment = 0;
		if (!blk_queue_discard(backingq)) {
			q->limits.discard_granularity = 0;
			blk_queue_max_discard_sectors(q, 0);
			blk_queue_max_write_zeroes_sectors(q, 0);
			blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
		} else {
			q->limits.discard_granularity = inode->i_sb->s_blocksize;
			blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
			blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
			blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
		}
	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
		...
	}

I remembered you mentioned the above code doesn't work in some of your
tests, but never explain the reason. However, it is supposed to work
given bio splitting does handle/respect the discard limits. Or is there
bug in bio splitting on discard IO?

Thanks,
Ming
