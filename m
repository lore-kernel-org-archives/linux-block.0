Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC9C001DE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 00:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjG0AdL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0AdJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 20:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4362135
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 17:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A107F61CEC
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 00:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D36BC43391;
        Thu, 27 Jul 2023 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690417987;
        bh=yCOE6LTTCJKyCVo9y/MNCIoBnB0rf6bqR6Hld4vw7io=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U8nqIOtWvQQBkIn4M1OJevW2Mx+TVR9M7v/Yz67WK2NnNl6u8WnuINZtbrvLxmYAK
         T0tRlUJvw+fFWTEQZml32b9/xuhlN8+sjKePwr7ZjD7loeWHtY8LSG/g79/6BGKHkX
         AHnyDjI8eClDNXNNrHuhaoaHN7hP4a3ensj93PfFkGko3uN3M/Pj0EDpl3QTmVBmJD
         rxbgnVK9FV8WZIGnnXac6rEhowFlYSN2TKilUCQXlbDRsVjz5HATGZBuKm0GrJ5ZBd
         KruslxTqbi7NnVZKMIEt5MZi2whzR7OPYT0pu6X44hf/SlTeIW+BSxmfq9THf6nqQb
         KI0IYtvLaMvPA==
Message-ID: <c4e4b310-c6c6-e7e7-b5e3-ff44dc63097f@kernel.org>
Date:   Thu, 27 Jul 2023 09:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 5/7] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-6-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726193440.1655149-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 04:34, Bart Van Assche wrote:
> If zoned writes (REQ_OP_WRITE) for a sequential write required zone have
> a starting LBA that differs from the write pointer, e.g. because zoned
> writes have been reordered, then the storage device will respond with an
> UNALIGNED WRITE COMMAND error. Send commands that failed with an
> unaligned write error to the SCSI error handler. Let the SCSI error
> handler sort SCSI commands per LBA before resubmitting these.

This last sentence reads as if the retry is done for all cases. That is not
true. It is done only and only if zone write locking is disabled, that is for
requests with REQ_NO_ZONE_WRITE_LOCK and a request queue with
QUEUE_FLAG_NO_ZONE_WRITE_LOCK set.

> If zone write locking is disabled, increase the number of retries for
> write commands sent to a sequential zone to the maximum number of
> outstanding commands because in the worst case the number of times
> reordered zoned writes have to be retried is (number of outstanding
> writes per sequential zone) - 1.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_error.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/scsi_lib.c   |  1 +
>  drivers/scsi/sd.c         |  2 ++
>  include/scsi/scsi.h       |  1 +
>  4 files changed, 42 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index c67cdcdc3ba8..9dc354a24d4b 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -27,6 +27,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/delay.h>
>  #include <linux/jiffies.h>
> +#include <linux/list_sort.h>
>  
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_cmnd.h>
> @@ -698,6 +699,17 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
>  		fallthrough;
>  
>  	case ILLEGAL_REQUEST:
> +		/*
> +		 * Unaligned write command. This indicates that zoned writes
> +		 * have been received by the device in the wrong order. If zone
> +		 * write locking is disabled, retry after all pending commands
> +		 * have completed.
> +		 */
> +		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
> +		    blk_no_zone_write_lock(scsi_cmd_to_rq(scmd)) &&
> +		    !scsi_noretry_cmd(scmd) && scsi_cmd_retry_allowed(scmd))
> +			return NEEDS_DELAYED_RETRY;
> +
>  		if (sshdr.asc == 0x20 || /* Invalid command operation code */
>  		    sshdr.asc == 0x21 || /* Logical block address out of range */
>  		    sshdr.asc == 0x22 || /* Invalid function */
> @@ -2223,6 +2235,25 @@ void scsi_eh_flush_done_q(struct list_head *done_q)
>  }
>  EXPORT_SYMBOL(scsi_eh_flush_done_q);
>  
> +/*
> + * Returns a negative value if @_a has a lower LBA than @_b, zero if
> + * both have the same LBA and a positive value otherwise.
> + */
> +static int scsi_cmp_lba(void *priv, const struct list_head *_a,
> +			const struct list_head *_b)
> +{
> +	struct scsi_cmnd *a = list_entry(_a, typeof(*a), eh_entry);
> +	struct scsi_cmnd *b = list_entry(_b, typeof(*b), eh_entry);
> +	const sector_t pos_a = blk_rq_pos(scsi_cmd_to_rq(a));
> +	const sector_t pos_b = blk_rq_pos(scsi_cmd_to_rq(b));
> +
> +	if (pos_a < pos_b)
> +		return -1;
> +	if (pos_a > pos_b)
> +		return 1;
> +	return 0;
> +}
> +
>  /**
>   * scsi_unjam_host - Attempt to fix a host which has a cmd that failed.
>   * @shost:	Host to unjam.
> @@ -2258,6 +2289,13 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
>  
>  	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
>  
> +	/*
> +	 * Sort pending SCSI commands in LBA order. This is important if one of
> +	 * the SCSI devices associated with @shost is a zoned block device for
> +	 * which zone write locking is disabled.
> +	 */
> +	list_sort(NULL, &eh_work_q, scsi_cmp_lba);
> +
>  	if (!scsi_eh_get_sense(&eh_work_q, &eh_done_q))
>  		scsi_eh_ready_devs(shost, &eh_work_q, &eh_done_q);
>  
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 59176946ab56..69da8aee13df 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1443,6 +1443,7 @@ static void scsi_complete(struct request *rq)
>  	case ADD_TO_MLQUEUE:
>  		scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
>  		break;
> +	case NEEDS_DELAYED_RETRY:
>  	default:
>  		scsi_eh_scmd_add(cmd);
>  		break;
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 68b12afa0721..7b5877323245 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1235,6 +1235,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  	cmd->transfersize = sdp->sector_size;
>  	cmd->underflow = nr_blocks << 9;
>  	cmd->allowed = sdkp->max_retries;
> +	if (blk_no_zone_write_lock(rq) && blk_rq_is_seq_zoned_write(rq))
> +		cmd->allowed += rq->q->nr_requests;

Why += ? Shouldn't this be "=" ?

That said, reading and commenting on your patches gave me a better
understanding of how this works. With that, I am now thinking that
QUEUE_FLAG_NO_ZONE_WRITE_LOCK may be the only thing needed.
My thinking:
1) For well behaved applications correctly issuing writes sequentially per zone
from the write pointer, we will not get any performance benefits for device
with QUEUE_FLAG_NO_ZONE_WRITE_LOCK. But we could if REQ_NO_ZONE_WRITE_LOCK was set.
2) For buggy applications that fail to write zones sequentially, they already
today get an error. That will remain true even for devices with
QUEUE_FLAG_NO_ZONE_WRITE_LOCK and even if we set REQ_NO_ZONE_WRITE_LOCK. The
only difference from today will be that the error return to the application
will be delayed by all the retries, but an error will still be returned,
always, even in the case of an application completely forgetting to issue one
IO (i.e. the application submitted a write stream with a hole in it). There
will be no deadlock given that the retry is within the scsi layer only, not
back to the block layer (which could create deadlocks preventing forward progress).
3) For in-kernel users (f2fs, btrfs, zonefs, dm-zoned), we know writes happen
sequentially, even when stacked on top of zone compliant DMs (dm-crypt,
dm-linear). They all could set REQ_NO_ZONE_WRITE_LOCK for devices with
QUEUE_FLAG_NO_ZONE_WRITE_LOCK and get the same performance boost as you see for
f2fs.

From all this, and given that for (3) REQ_NO_ZONE_WRITE_LOCK is set
unconditionally, it now seems to me that this request flag is useless...
Thoughts ?

>  	cmd->sdb.length = nr_blocks * sdp->sector_size;
>  
>  	SCSI_LOG_HLQUEUE(1,
> diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
> index ec093594ba53..6600db046227 100644
> --- a/include/scsi/scsi.h
> +++ b/include/scsi/scsi.h
> @@ -93,6 +93,7 @@ static inline int scsi_status_is_check_condition(int status)
>   * Internal return values.
>   */
>  enum scsi_disposition {
> +	NEEDS_DELAYED_RETRY	= 0x2000,
>  	NEEDS_RETRY		= 0x2001,
>  	SUCCESS			= 0x2002,
>  	FAILED			= 0x2003,

-- 
Damien Le Moal
Western Digital Research

