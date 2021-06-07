Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA5C47082
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 10:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAE561090
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 10:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFGKHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jun 2021 06:07:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56256 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFGKHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jun 2021 06:07:44 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5564821A82;
        Mon,  7 Jun 2021 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623060353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCUgVnd4rWL5dLkzFcY7UgSM/LxqZ20XsX3i91iV+Gg=;
        b=O8yT6lQExYQzgxakdBaHq1BxuGZs6MdrHY+lk61h1HwJEEhbsW/qgEMISzTUKeLUxW3TDP
        rQQTFDGSFdD0mo8C8o7ENDHAGU+OVRqiGTqevht0w3AxN1Dwl/SCckBaFNCGLNe0lWSDd1
        W+2eACYWnz0eG4+VZJztkQsQUNPpn5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623060353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCUgVnd4rWL5dLkzFcY7UgSM/LxqZ20XsX3i91iV+Gg=;
        b=rz0J05SxJukfzoL0VWcvHwPMqKus8mRQYrHkwFvChgGzyXpZ5e8MVrw6wJWbesZys6qua+
        C/fM+rFpCUpLHpBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 171E6118DD;
        Mon,  7 Jun 2021 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623060353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCUgVnd4rWL5dLkzFcY7UgSM/LxqZ20XsX3i91iV+Gg=;
        b=O8yT6lQExYQzgxakdBaHq1BxuGZs6MdrHY+lk61h1HwJEEhbsW/qgEMISzTUKeLUxW3TDP
        rQQTFDGSFdD0mo8C8o7ENDHAGU+OVRqiGTqevht0w3AxN1Dwl/SCckBaFNCGLNe0lWSDd1
        W+2eACYWnz0eG4+VZJztkQsQUNPpn5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623060353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCUgVnd4rWL5dLkzFcY7UgSM/LxqZ20XsX3i91iV+Gg=;
        b=rz0J05SxJukfzoL0VWcvHwPMqKus8mRQYrHkwFvChgGzyXpZ5e8MVrw6wJWbesZys6qua+
        C/fM+rFpCUpLHpBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id K5HsBIHvvWC1KAAALh3uQQ
        (envelope-from <hare@suse.de>); Mon, 07 Jun 2021 10:05:53 +0000
Subject: Re: [PATCH v2] block: Do not pull requests from the scheduler when we
 cannot dispatch them
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>
References: <20210603104721.6309-1-jack@suse.cz>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <42e2e0f1-acf4-a5eb-2c3e-cb20706430a4@suse.de>
Date:   Mon, 7 Jun 2021 12:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210603104721.6309-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/21 12:47 PM, Jan Kara wrote:
> Provided the device driver does not implement dispatch budget accounting
> (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
> requests from the IO scheduler as long as it is willing to give out any.
> That defeats scheduling heuristics inside the scheduler by creating
> false impression that the device can take more IO when it in fact
> cannot.
> 
> For example with BFQ IO scheduler on top of virtio-blk device setting
> blkio cgroup weight has barely any impact on observed throughput of
> async IO because __blk_mq_do_dispatch_sched() always sucks out all the
> IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
> when that is all dispatched, it will give out IO of lower weight cgroups
> as well. And then we have to wait for all this IO to be dispatched to
> the disk (which means lot of it actually has to complete) before the
> IO scheduler is queried again for dispatching more requests. This
> completely destroys any service differentiation.
> 
> So grab request tag for a request pulled out of the IO scheduler already
> in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
> cannot get it because we are unlikely to be able to dispatch it. That
> way only single request is going to wait in the dispatch list for some
> tag to free.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-mq-sched.c | 12 +++++++++++-
>  block/blk-mq.c       |  2 +-
>  block/blk-mq.h       |  2 ++
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> Jens, can you please merge the patch? Thanks!
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 996a4b2f73aa..714e678f516a 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -168,9 +168,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		 * in blk_mq_dispatch_rq_list().
>  		 */
>  		list_add_tail(&rq->queuelist, &rq_list);
> +		count++;
>  		if (rq->mq_hctx != hctx)
>  			multi_hctxs = true;
> -	} while (++count < max_dispatch);
> +
> +		/*
> +		 * If we cannot get tag for the request, stop dequeueing
> +		 * requests from the IO scheduler. We are unlikely to be able
> +		 * to submit them anyway and it creates false impression for
> +		 * scheduling heuristics that the device can take more IO.
> +		 */
> +		if (!blk_mq_get_driver_tag(rq))
> +			break;
> +	} while (count < max_dispatch);
>  
>  	if (!count) {
>  		if (run_queue)

Doesn't this lead to a double accounting of the allocated tags?
From what I can see we don't really check if the tag is already
allocated in blk_mq_get_driver_tag() ...

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
