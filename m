Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6971CC001DE
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 09:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjHBJbV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjHBJbU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 05:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987FD127
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 02:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DD76618BF
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 09:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABACAC433C7;
        Wed,  2 Aug 2023 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690968677;
        bh=3xvlaRrzxLLDqaHOzjDUDcxmUKwNd3J3WYrR+1i0294=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f32NryoKaeC5pAOrjLPTne+/LRFq39BHQBXsMrLtcb4IuVOpu1vw2/xvTUZR0/FSK
         SgKmuFJr/Xyt8wySGG0Wc8XLzvkLxjjZxq0QmbIezEZDgdZcsdnw2E9NFVjwVR4lQY
         kqRcfh1+Z7fz+NCFZPTuEEvQ/Qz46IWt887j3rszCxiy0VltxNEQBvV8PDVGIADyFd
         smuSrM1lMROUlgnUXbcfSl6paus64UGtV9vP+l8NrjwdaB/zwGP6Hn45Cl9hq+c8Ui
         U9QIOByktJULmwBqV0baiTC1hgviU5yDvhzsQ/bEGZf5LNLLJgJ/tyH2wl4zB46pcb
         e88pmVnz9k+1w==
Message-ID: <f0022a48-621a-edf4-1d6b-c99c7064d8d8@kernel.org>
Date:   Wed, 2 Aug 2023 18:31:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/7] scsi: core: Retry unaligned zoned writes
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230731221458.437440-1-bvanassche@acm.org>
 <20230731221458.437440-4-bvanassche@acm.org>
 <501de5ca-3510-00b7-bf15-0c778323da3d@suse.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <501de5ca-3510-00b7-bf15-0c778323da3d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/23 18:16, Hannes Reinecke wrote:
> On 8/1/23 00:14, Bart Van Assche wrote:
>> If zoned writes (REQ_OP_WRITE) for a sequential write required zone have
>> a starting LBA that differs from the write pointer, e.g. because zoned
>> writes have been reordered, then the storage device will respond with an
>> UNALIGNED WRITE COMMAND error. Send commands that failed with an
>> unaligned write error to the SCSI error handler if zone write locking is
>> disabled. Let the SCSI error handler sort SCSI commands per LBA before
>> resubmitting these.
>>
>> If zone write locking is disabled, increase the number of retries for
>> write commands sent to a sequential zone to the maximum number of
>> outstanding commands because in the worst case the number of times
>> reordered zoned writes have to be retried is (number of outstanding
>> writes per sequential zone) - 1.
>>
>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/scsi/scsi_error.c | 37 +++++++++++++++++++++++++++++++++++++
>>   drivers/scsi/scsi_lib.c   |  1 +
>>   drivers/scsi/sd.c         |  3 +++
>>   include/scsi/scsi.h       |  1 +
>>   4 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
>> index c67cdcdc3ba8..24a4e49215af 100644
>> --- a/drivers/scsi/scsi_error.c
>> +++ b/drivers/scsi/scsi_error.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/blkdev.h>
>>   #include <linux/delay.h>
>>   #include <linux/jiffies.h>
>> +#include <linux/list_sort.h>
>>   
>>   #include <scsi/scsi.h>
>>   #include <scsi/scsi_cmnd.h>
>> @@ -698,6 +699,16 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
>>   		fallthrough;
>>   
>>   	case ILLEGAL_REQUEST:
>> +		/*
>> +		 * Unaligned write command. This indicates that zoned writes
>> +		 * have been received by the device in the wrong order. If zone
>> +		 * write locking is disabled, retry after all pending commands
>> +		 * have completed.
>> +		 */
>> +		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
>> +		    blk_queue_no_zone_write_lock(scsi_cmd_to_rq(scmd)->q))
>> +			return NEEDS_DELAYED_RETRY;
>> +
>>   		if (sshdr.asc == 0x20 || /* Invalid command operation code */
>>   		    sshdr.asc == 0x21 || /* Logical block address out of range */
>>   		    sshdr.asc == 0x22 || /* Invalid function */
>> @@ -2186,6 +2197,25 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
>>   }
>>   EXPORT_SYMBOL_GPL(scsi_eh_ready_devs);
>>   
>> +/*
>> + * Returns a negative value if @_a has a lower LBA than @_b, zero if
>> + * both have the same LBA and a positive value otherwise.
>> + */
>> +static int scsi_cmp_lba(void *priv, const struct list_head *_a,
>> +			const struct list_head *_b)
>> +{
>> +	struct scsi_cmnd *a = list_entry(_a, typeof(*a), eh_entry);
>> +	struct scsi_cmnd *b = list_entry(_b, typeof(*b), eh_entry);
>> +	const sector_t pos_a = blk_rq_pos(scsi_cmd_to_rq(a));
>> +	const sector_t pos_b = blk_rq_pos(scsi_cmd_to_rq(b));
>> +
>> +	if (pos_a < pos_b)
>> +		return -1;
>> +	if (pos_a > pos_b)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>>   /**
>>    * scsi_eh_flush_done_q - finish processed commands or retry them.
>>    * @done_q:	list_head of processed commands.
>> @@ -2194,6 +2224,13 @@ void scsi_eh_flush_done_q(struct list_head *done_q)
>>   {
>>   	struct scsi_cmnd *scmd, *next;
>>   
>> +	/*
>> +	 * Sort pending SCSI commands in LBA order. This is important if one of
>> +	 * the SCSI devices associated with @shost is a zoned block device for
>> +	 * which zone write locking is disabled.
>> +	 */
>> +	list_sort(NULL, done_q, scsi_cmp_lba);
>> +
>>   	list_for_each_entry_safe(scmd, next, done_q, eh_entry) {
>>   		list_del_init(&scmd->eh_entry);
>>   		if (scsi_device_online(scmd->device) &&
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 59176946ab56..69da8aee13df 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1443,6 +1443,7 @@ static void scsi_complete(struct request *rq)
>>   	case ADD_TO_MLQUEUE:
>>   		scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
>>   		break;
>> +	case NEEDS_DELAYED_RETRY:
>>   	default:
>>   		scsi_eh_scmd_add(cmd);
>>   		break;
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index 68b12afa0721..27b9ebe05b90 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -1235,6 +1235,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>   	cmd->transfersize = sdp->sector_size;
>>   	cmd->underflow = nr_blocks << 9;
>>   	cmd->allowed = sdkp->max_retries;
>> +	if (blk_queue_no_zone_write_lock(rq->q) &&
>> +	    blk_rq_is_seq_zoned_write(rq))
>> +		cmd->allowed += rq->q->nr_requests;
>>   	cmd->sdb.length = nr_blocks * sdp->sector_size;
>>   
>>   	SCSI_LOG_HLQUEUE(1,
>> diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
>> index ec093594ba53..6600db046227 100644
>> --- a/include/scsi/scsi.h
>> +++ b/include/scsi/scsi.h
>> @@ -93,6 +93,7 @@ static inline int scsi_status_is_check_condition(int status)
>>    * Internal return values.
>>    */
>>   enum scsi_disposition {
>> +	NEEDS_DELAYED_RETRY	= 0x2000,
>>   	NEEDS_RETRY		= 0x2001,
>>   	SUCCESS			= 0x2002,
>>   	FAILED			= 0x2003,
> What happens for a 'real' unaligned write, ie a command whose starting 
> LBA is before the write pointer? Wouldn't we incur additional retries?
> Do we terminate at all?

The buggy user issuing writes out of order will either eventually see the error
or get lucky and have its unaligned write reordered and succeeding.

> 
> Cheers,
> 
> Hannes
> 

-- 
Damien Le Moal
Western Digital Research

