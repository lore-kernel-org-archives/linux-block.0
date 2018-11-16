Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEBCC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301F52145D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 09:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301F52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeKPUE5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:04:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:38246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbeKPUE5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 15:04:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52DEAAF11;
        Fri, 16 Nov 2018 09:53:21 +0000 (UTC)
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
To:     Keith Busch <keith.busch@intel.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-3-keith.busch@intel.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <05c4ea6a-9beb-063c-a91c-aca5826cc5b5@suse.de>
Date:   Fri, 16 Nov 2018 10:53:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115175820.13391-3-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/18 6:58 PM, Keith Busch wrote:
> The scsi timeout error handling had been directly updating the block
> layer's request state to prevent a error handling and a natural completion
> from completing the same request twice. Fix this layering violation
> by having scsi control the fate of its commands with scsi owned flags
> rather than use blk-mq's.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>   drivers/scsi/scsi_error.c | 22 +++++++++++-----------
>   drivers/scsi/scsi_lib.c   |  6 +++++-
>   include/scsi/scsi_cmnd.h  |  5 ++++-
>   3 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index dd338a8cd275..e92e088f636f 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -297,19 +297,19 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
>   
>   	if (rtn == BLK_EH_DONE) {
>   		/*
> -		 * For blk-mq, we must set the request state to complete now
> -		 * before sending the request to the scsi error handler. This
> -		 * will prevent a use-after-free in the event the LLD manages
> -		 * to complete the request before the error handler finishes
> -		 * processing this timed out request.
> +		 * Set the command to complete first in order to prevent a real
> +		 * completion from releasing the command while error handling
> +		 * is using it. If the command was already completed, then the
> +		 * lower level driver beat the timeout handler, and it is safe
> +		 * to return without escalating error recovery.
>   		 *
> -		 * If the request was already completed, then the LLD beat the
> -		 * time out handler from transferring the request to the scsi
> -		 * error handler. In that case we can return immediately as no
> -		 * further action is required.
> +		 * If timeout handling lost the race to a real completion, the
> +		 * block layer may ignore that due to a fake timeout injection,
> +		 * so return RESET_TIMER to allow error handling another shot
> +		 * at this command.
>   		 */
> -		if (!blk_mq_mark_complete(req))
> -			return rtn;
> +		if (test_and_set_bit(__SCMD_COMPLETE, &scmd->flags))
> +			return BLK_EH_RESET_TIMER;
>   		if (scsi_abort_command(scmd) != SUCCESS) {
>   			set_host_byte(scmd, DID_TIME_OUT);
>   			scsi_eh_scmd_add(scmd);
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 5d83a162d03b..c1d5e4e36125 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
>   
>   static void scsi_mq_done(struct scsi_cmnd *cmd)
>   {
> +	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
> +		return;
>   	trace_scsi_dispatch_cmd_done(cmd);
> -	blk_mq_complete_request(cmd->request);
> +	if (unlikely(!blk_mq_complete_request(cmd->request)))
> +		clear_bit(__SCMD_COMPLETE, &cmd->flags);
>   }
>   
>   static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
> @@ -1701,6 +1704,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			goto out_dec_host_busy;
>   		req->rq_flags |= RQF_DONTPREP;
>   	} else {
> +		cmd->flags &= ~SCMD_COMPLETE;
>   		blk_mq_start_request(req);
>   	}
>   
Why do you use a normal assignment here (and not a clear_bit() as in the 
above hunk)?

And shouldn't you add a barrier here to broadcast the state change to 
other cores?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
