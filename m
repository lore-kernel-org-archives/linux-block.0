Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B379C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 01:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451F620759
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 01:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HRGIKLBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgG1BvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG1BvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 21:51:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F4C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 18:51:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so9088410plr.8
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 18:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9bjxitCtFHZdGGQj9EyRRYimxiJZ+W4ufp+SOIp69y4=;
        b=HRGIKLBJvuN7ye9foSLvkE1UJFKxk2DkwyBuwH5xdChA5o0a6gjQZZG+GyS1qicdHn
         rjN4Q+7ZyE9boM5fm1ekWApZXC8vHjyHQyrp6aXyF7RQ/ZqMwkmqXZ5Epn5FlO7/SUqI
         eMuC/3BONQ1n02U6OjvXAAY54lSKjxNZjMold2UWn8R3t0sahhwzM5EEpzp8uS3dKrq+
         wHgY0b+Mgd2AygqjZSbuAJnR+tdxnESfOjJa4aXabDTHE9TkIB7vv3NDx89Kd4yna17r
         69Ijhg+/+RL0vszB6V+ZXbDmxI/YZfKpo3R2Q5mknTP1S6+1Mx0Vs8w38HPC88+K8PXd
         qpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bjxitCtFHZdGGQj9EyRRYimxiJZ+W4ufp+SOIp69y4=;
        b=mALFO/cjiBOKo5N58zXufCByXwmZiGOByY3NOYuhKEa0jNqfk18lS8b/7OBe+Lz+VT
         2zN/tC9hhuBfcuehcB8r6pvRCx+r0nXFGaxfn4C2MgCscVIPzxbqNLSazzVZCufuE36U
         MMlkNDvQXHfKEt0WncqgYgOdDBOgtn0ScuJdfYZT/DGdivGfC4gchaqmswitrbZxftTk
         u+pvLvEMAYL1RwLpqtHiRH4ql6wnJZjr0LcmrWLEy+Qu1mlV5oXTd3SWOB9eTwtvQOJz
         z8HtBM2jXHytbjxtu4+s2xU/BTgZz8KPuZECHJ8qx/0Zih//9kcQ5Jnal/NhboPBw4sw
         StPw==
X-Gm-Message-State: AOAM530cTD/iM+GytZgaROlKgAsKdkJwPPgHBxnQMloYRZg4c/DNxECW
        xmveEhXPEHaNMz3tV8VCUMZAzQ==
X-Google-Smtp-Source: ABdhPJxOCrD6HZPvqed+snQ0vbyzB4sdQRlakyKKEIn61uHYFCyCDQgk72GEC0pbwcWdJtGFzFoI3A==
X-Received: by 2002:a17:902:ead2:: with SMTP id p18mr4992656pld.339.1595901079009;
        Mon, 27 Jul 2020 18:51:19 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 127sm16616364pgf.5.2020.07.27.18.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 18:51:18 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
Date:   Mon, 27 Jul 2020 19:51:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728014038.GA1305646@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 7:40 PM, Ming Lei wrote:
> On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
>> drivers that have shared tagsets may need to quiesce potentially a lot
>> of request queues that all share a single tagset (e.g. nvme). Add an interface
>> to quiesce all the queues on a given tagset. This interface is useful because
>> it can speedup the quiesce by doing it in parallel.
>>
>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
>> in parallel such that all of them wait for the same rcu elapsed period with
>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
>> sufficient.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/blk-mq.h |  4 +++
>>  2 files changed, 70 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index abcf590f6238..c37e37354330 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>>  }
>>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>>  
>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	blk_mq_quiesce_queue_nowait(q);
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>> +		if (!hctx->rcu_sync)
>> +			continue;
> 
> This approach of quiesce/unquiesce tagset is good abstraction.
> 
> Just one more thing, please allocate a rcu_sync array because hctx is
> supposed to not store scratch stuff.

I'd be all for not stuffing this in the hctx, but how would that work?
The only thing I can think of that would work reliably is batching the
queue+wait into units of N. We could potentially have many thousands of
queues, and it could get iffy (and/or unreliable) in terms of allocation
size. Looks like rcu_synchronize is 48-bytes on my local install, and it
doesn't take a lot of devices at current CPU counts to make an alloc
covering all of it huge. Let's say 64 threads, and 32 devices, then
we're already at 64*32*48 bytes which is an order 5 allocation. Not
friendly, and not going to be reliable when you need it. And if we start
batching in reasonable counts, then we're _almost_ back to doing a queue
or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
the time for single page allocations.

-- 
Jens Axboe

