Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9832C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 08:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGZIyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjGZIx5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 04:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171FE7DBA
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 01:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE89B61865
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 08:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC2EC433C8;
        Wed, 26 Jul 2023 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690361237;
        bh=AXWDWSSo3OCIvBxgqZ86OHHptKE2bVDEYLp5473mFGM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K8WU2UcZPwIWIOmekqvJCns4bKBz6oK1NpqWxFLYNFduW2CqlbgseA6bH3Oy7/ye3
         THoi1zr/OIqJ/Iqnj8RDPFGwF4P9W8fV9yQjfJ/XnzQGwb+mU+2LR7OrigXjpZGz+c
         CeMXmU8q41Wqqb2v39PUXwBBNgMWIrHuYdPQYRLgPPe7uXzyYGD/lyzp0vRfRw5K6G
         Oc06BDaaFgQC7aX8J69QCVKkp/sRCRupiAm4ULIvd6TiJlsuPUqCeAXUhZfAoZcAMs
         I7fDx97WJEFl3t/uD0ryDfymnNlMhcCvWONzkhWyd743xEwcwViYcYhEvIVQZyXJRq
         RqE70DvTA9KCA==
Message-ID: <e9cfd243-4b2d-a2f5-2d34-b0012470117a@kernel.org>
Date:   Wed, 26 Jul 2023 17:47:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/6] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726005742.303865-1-bvanassche@acm.org>
 <20230726005742.303865-5-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726005742.303865-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 09:57, Bart Van Assche wrote:
> From ZBC-2: "The device server terminates with CHECK CONDITION status, with
> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
> same command, that specifies: a) the starting LBA in a sequential write
> required zone set to a value that is not equal to the write pointer for
> that sequential write required zone; or b) an ending LBA that is not equal
> to the last logical block within a physical block (see SBC-5)."
> 
> Send commands that failed with an unaligned write error to the SCSI error
> handler. Let the SCSI error handler sort SCSI commands per LBA before
> resubmitting these.
> 
> Increase the number of retries for write commands sent to a sequential
> zone to the maximum number of outstanding commands.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_error.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/scsi/scsi_lib.c   |  1 +
>  drivers/scsi/sd.c         |  3 +++
>  include/scsi/scsi.h       |  1 +
>  4 files changed, 42 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index c67cdcdc3ba8..2b9aec05dc36 100644
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
> +		    blk_queue_no_zone_write_lock(sdev->request_queue) &&
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

The argument priv is unused.

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
> @@ -2258,6 +2289,12 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
>  
>  	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
>  
> +	/*
> +	 * Sort pending SCSI commands in LBA order. This is important if zone
> +	 * write locking is disabled for a zoned SCSI device.
> +	 */
> +	list_sort(NULL, &eh_work_q, scsi_cmp_lba);

Should we do this only for zoned devices ?

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
> index 68b12afa0721..27b9ebe05b90 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1235,6 +1235,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  	cmd->transfersize = sdp->sector_size;
>  	cmd->underflow = nr_blocks << 9;
>  	cmd->allowed = sdkp->max_retries;
> +	if (blk_queue_no_zone_write_lock(rq->q) &&
> +	    blk_rq_is_seq_zoned_write(rq))
> +		cmd->allowed += rq->q->nr_requests;

Aouch... that could be a lot...

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

