Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18643C001DE
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 09:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjHBJRD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjHBJQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 05:16:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C04207
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 02:16:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E53951F8AB;
        Wed,  2 Aug 2023 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690967761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5X4dgE7g48XijBy8A/yvUuqWW/cklJ2ATXTHmDaTLE=;
        b=MMv6yRX3sWyDTOVUM94YEvWC0VlwWd8LwMDhd/14OYhayU1sbF9GxvNvVmGLx82efgo6uK
        a8LEw5mzTEWDMsU8SdD9WaFWqcJZdtWhqa33/FxypLtOC73fDYD/uk5GWUBnQJNwW6r6QA
        1GXnuoznuEWwKdbh47uNavAAoteKsl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690967761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5X4dgE7g48XijBy8A/yvUuqWW/cklJ2ATXTHmDaTLE=;
        b=tSi8bOChG3Q0KxM+6ZoV8Hm0oM0d7FPSiKfuP8ahnAul7p5BuBJKd8aywjHBKGCtOuUETH
        OCJyEatekT19C8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCDC713909;
        Wed,  2 Aug 2023 09:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8G2EMdEeymTzXQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Aug 2023 09:16:01 +0000
Message-ID: <501de5ca-3510-00b7-bf15-0c778323da3d@suse.de>
Date:   Wed, 2 Aug 2023 11:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] scsi: core: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230731221458.437440-1-bvanassche@acm.org>
 <20230731221458.437440-4-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731221458.437440-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/23 00:14, Bart Van Assche wrote:
> If zoned writes (REQ_OP_WRITE) for a sequential write required zone have
> a starting LBA that differs from the write pointer, e.g. because zoned
> writes have been reordered, then the storage device will respond with an
> UNALIGNED WRITE COMMAND error. Send commands that failed with an
> unaligned write error to the SCSI error handler if zone write locking is
> disabled. Let the SCSI error handler sort SCSI commands per LBA before
> resubmitting these.
> 
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
>   drivers/scsi/scsi_error.c | 37 +++++++++++++++++++++++++++++++++++++
>   drivers/scsi/scsi_lib.c   |  1 +
>   drivers/scsi/sd.c         |  3 +++
>   include/scsi/scsi.h       |  1 +
>   4 files changed, 42 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index c67cdcdc3ba8..24a4e49215af 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -27,6 +27,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/delay.h>
>   #include <linux/jiffies.h>
> +#include <linux/list_sort.h>
>   
>   #include <scsi/scsi.h>
>   #include <scsi/scsi_cmnd.h>
> @@ -698,6 +699,16 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
>   		fallthrough;
>   
>   	case ILLEGAL_REQUEST:
> +		/*
> +		 * Unaligned write command. This indicates that zoned writes
> +		 * have been received by the device in the wrong order. If zone
> +		 * write locking is disabled, retry after all pending commands
> +		 * have completed.
> +		 */
> +		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
> +		    blk_queue_no_zone_write_lock(scsi_cmd_to_rq(scmd)->q))
> +			return NEEDS_DELAYED_RETRY;
> +
>   		if (sshdr.asc == 0x20 || /* Invalid command operation code */
>   		    sshdr.asc == 0x21 || /* Logical block address out of range */
>   		    sshdr.asc == 0x22 || /* Invalid function */
> @@ -2186,6 +2197,25 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
>   }
>   EXPORT_SYMBOL_GPL(scsi_eh_ready_devs);
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
>   /**
>    * scsi_eh_flush_done_q - finish processed commands or retry them.
>    * @done_q:	list_head of processed commands.
> @@ -2194,6 +2224,13 @@ void scsi_eh_flush_done_q(struct list_head *done_q)
>   {
>   	struct scsi_cmnd *scmd, *next;
>   
> +	/*
> +	 * Sort pending SCSI commands in LBA order. This is important if one of
> +	 * the SCSI devices associated with @shost is a zoned block device for
> +	 * which zone write locking is disabled.
> +	 */
> +	list_sort(NULL, done_q, scsi_cmp_lba);
> +
>   	list_for_each_entry_safe(scmd, next, done_q, eh_entry) {
>   		list_del_init(&scmd->eh_entry);
>   		if (scsi_device_online(scmd->device) &&
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 59176946ab56..69da8aee13df 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1443,6 +1443,7 @@ static void scsi_complete(struct request *rq)
>   	case ADD_TO_MLQUEUE:
>   		scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
>   		break;
> +	case NEEDS_DELAYED_RETRY:
>   	default:
>   		scsi_eh_scmd_add(cmd);
>   		break;
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 68b12afa0721..27b9ebe05b90 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1235,6 +1235,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   	cmd->transfersize = sdp->sector_size;
>   	cmd->underflow = nr_blocks << 9;
>   	cmd->allowed = sdkp->max_retries;
> +	if (blk_queue_no_zone_write_lock(rq->q) &&
> +	    blk_rq_is_seq_zoned_write(rq))
> +		cmd->allowed += rq->q->nr_requests;
>   	cmd->sdb.length = nr_blocks * sdp->sector_size;
>   
>   	SCSI_LOG_HLQUEUE(1,
> diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
> index ec093594ba53..6600db046227 100644
> --- a/include/scsi/scsi.h
> +++ b/include/scsi/scsi.h
> @@ -93,6 +93,7 @@ static inline int scsi_status_is_check_condition(int status)
>    * Internal return values.
>    */
>   enum scsi_disposition {
> +	NEEDS_DELAYED_RETRY	= 0x2000,
>   	NEEDS_RETRY		= 0x2001,
>   	SUCCESS			= 0x2002,
>   	FAILED			= 0x2003,
What happens for a 'real' unaligned write, ie a command whose starting 
LBA is before the write pointer? Wouldn't we incur additional retries?
Do we terminate at all?

Cheers,

Hannes

