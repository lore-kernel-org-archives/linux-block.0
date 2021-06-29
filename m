Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AFAC11F66
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 12:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF2061C94
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 12:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhF2Mlp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:41:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhF2Mlo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 08:41:44 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B429226C5;
        Tue, 29 Jun 2021 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624970356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
        b=uyx75GqJK8gG+KLCTA2elm8fsSaPos9nVI0HNHwr8uhE88kPoeynppMTXU+2nZFccHkzYz
        ciyfylmnSU9dQCVBk+HDkuS10GaqNGgOnSuv8ree67i4imSJYQzwi9TE3s/Z5ymM7ecGQg
        vON/vpG+dstXkBU8CN5vv4SkEH9lO6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624970356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
        b=MU69S6cXYp84mfJOzW4rWymAsY5ZrSD9xUiY7Af8LixR6kkoZketxEjUs3uwi4FcqJtQF4
        MHH+FPwe4eDthHCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B4F1F11906;
        Tue, 29 Jun 2021 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624970356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
        b=uyx75GqJK8gG+KLCTA2elm8fsSaPos9nVI0HNHwr8uhE88kPoeynppMTXU+2nZFccHkzYz
        ciyfylmnSU9dQCVBk+HDkuS10GaqNGgOnSuv8ree67i4imSJYQzwi9TE3s/Z5ymM7ecGQg
        vON/vpG+dstXkBU8CN5vv4SkEH9lO6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624970356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
        b=MU69S6cXYp84mfJOzW4rWymAsY5ZrSD9xUiY7Af8LixR6kkoZketxEjUs3uwi4FcqJtQF4
        MHH+FPwe4eDthHCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 4tdjKnMU22D8TAAALh3uQQ
        (envelope-from <hare@suse.de>); Tue, 29 Jun 2021 12:39:15 +0000
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1a14a397-6244-928e-5aaa-85c2ccbe0e40@suse.de>
Date:   Tue, 29 Jun 2021 14:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210629074951.1981284-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/21 9:49 AM, Ming Lei wrote:
> hctx is deactivated when all CPU in hctx->cpumask become offline by
> draining all requests originated from this hctx and moving new
> allocation to active hctx. This way is for avoiding inflight IO when
> the managed irq is shutdown.
> 
> Some drivers(nvme fc, rdma, tcp, loop) doesn't use managed irq, so
> they needn't to deactivate hctx. Also, they are the only user of
> blk_mq_alloc_request_hctx() which is used for connecting io queue.
> And their requirement is that the connect request can be submitted
> via one specified hctx on which all CPU in its hctx->cpumask may have
> become offline.
> 

How can you submit a connect request for a hctx on which all CPUs are 
offline? That hctx will be unusable as it'll never be able to receive 
interrupts ...

> Address the requirement for nvme fc/rdma/loop, so the reported kernel
> panic on the following line in blk_mq_alloc_request_hctx() can be fixed.
> 
> 	data.ctx = __blk_mq_get_ctx(q, cpu)
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Wen Xiong <wenxiong@us.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c         | 6 +++++-
>   include/linux/blk-mq.h | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index df5dc3b756f5..74632f50d969 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	data.hctx = q->queue_hw_ctx[hctx_idx];
>   	if (!blk_mq_hw_queue_mapped(data.hctx))
>   		goto out_queue_exit;
> -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> +	cpu = cpumask_first(data.hctx->cpumask);
>   	data.ctx = __blk_mq_get_ctx(q, cpu);

I don't get it.
Doesn't this allow us to allocate a request on a dead cpu, ie the very 
thing we try to prevent?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
