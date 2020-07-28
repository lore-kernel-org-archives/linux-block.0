Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B80C433DF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 02:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5842075A
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 02:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="szhHWiOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgG1Cc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgG1Cc5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 22:32:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23E3C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 19:32:57 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so3255249pfh.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 19:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AVCeCjsYNWy7yl3GQCLxoee2T6ANS9Vfnp2KykIh8cQ=;
        b=szhHWiOgGtsx4vdB4DKVPYRKDYn1yU1hybwnEbEkP2PjrplQIlqcowH3iWjb+OB52M
         yzGio2fjOMxTRZdhehvYxELDzvS2MppjV5yx8qkJ18GNRXu2Eopo0iUXNvM87n91k+VD
         H9JvBXr3EYSN1ezP4YzmFsE95nKEGbuiFdF/VZHSjd0esj0zMFf42ewbomXT29o8K8Xe
         QtdLSueaEVTchj+wCG1gvePHXB2GeeolaVEuPrtxYmtUEM//X2g2ecPHfSdy67SbfHB7
         2d2jI2djr40bO72tI53rkpSakNvCQnJb0Czymeii4D1FIscCg192OTZcaTrzUN4R2RdK
         dzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVCeCjsYNWy7yl3GQCLxoee2T6ANS9Vfnp2KykIh8cQ=;
        b=XJr0CKopHa/YsoodqgT47ayxeh3/eW4uo7ytcBT+wmhyr9T8R+nTLtNlUaNGNDMBqB
         WfPdp7q/7qoyDS/k+i23JXI7id0cMONO9LuHVNuWuYCJZaMmBI/l7GFXpPM5RvQ+LiGu
         TYaN4W28qJ+BU+28OCN8qSsFjelM8L1CRbkqBwWQrUfoZN5NObDj9NlE1rdzcUUNEwZ2
         5eEBiPB6tXOc7erbFQ59aAtkhCPOQqYH9D+dx20znEanBByv2UACxUiKjyYlFmE+yB/t
         AdoCy3ZBkAcDK8/5+edANd+Ga7XE0hoRxRy9JQdpI7BkHG39LFB3RPq7yFkfD2XZGC94
         zGzQ==
X-Gm-Message-State: AOAM5337q2fqWeN1sPbG7+z9WLXLJD1cVyM95iP3pGSkEeotQdNH+aKZ
        vmVA2Nf8ZpmXY3eNvcESomvBKDPY7N8=
X-Google-Smtp-Source: ABdhPJxSL/OBvT/OhzUgrZYGrGqElFmK/68S+zHc1nk2kq1VNE3fBo3+Mg76J8t0xRxFp6FDXSfI5Q==
X-Received: by 2002:a63:eb55:: with SMTP id b21mr22459743pgk.433.1595903577177;
        Mon, 27 Jul 2020 19:32:57 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b128sm15989210pfg.114.2020.07.27.19.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 19:32:56 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
 <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
 <20200728021744.GB1305646@T590>
 <5fce2096-2ed2-b396-76a7-5fb8ea97a389@kernel.dk>
 <20200728022802.GC1305646@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <baede23a-94c1-1494-bcca-964e1396f253@kernel.dk>
Date:   Mon, 27 Jul 2020 20:32:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728022802.GC1305646@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 8:28 PM, Ming Lei wrote:
> On Mon, Jul 27, 2020 at 08:23:15PM -0600, Jens Axboe wrote:
>> On 7/27/20 8:17 PM, Ming Lei wrote:
>>> On Mon, Jul 27, 2020 at 07:51:16PM -0600, Jens Axboe wrote:
>>>> On 7/27/20 7:40 PM, Ming Lei wrote:
>>>>> On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
>>>>>> drivers that have shared tagsets may need to quiesce potentially a lot
>>>>>> of request queues that all share a single tagset (e.g. nvme). Add an interface
>>>>>> to quiesce all the queues on a given tagset. This interface is useful because
>>>>>> it can speedup the quiesce by doing it in parallel.
>>>>>>
>>>>>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
>>>>>> in parallel such that all of them wait for the same rcu elapsed period with
>>>>>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
>>>>>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
>>>>>> sufficient.
>>>>>>
>>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>>> ---
>>>>>>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>  include/linux/blk-mq.h |  4 +++
>>>>>>  2 files changed, 70 insertions(+)
>>>>>>
>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>>> index abcf590f6238..c37e37354330 100644
>>>>>> --- a/block/blk-mq.c
>>>>>> +++ b/block/blk-mq.c
>>>>>> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>>>>>>  
>>>>>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>>>>>> +{
>>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>>> +	unsigned int i;
>>>>>> +
>>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>>> +
>>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>>>>>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>>>>>> +		if (!hctx->rcu_sync)
>>>>>> +			continue;
>>>>>
>>>>> This approach of quiesce/unquiesce tagset is good abstraction.
>>>>>
>>>>> Just one more thing, please allocate a rcu_sync array because hctx is
>>>>> supposed to not store scratch stuff.
>>>>
>>>> I'd be all for not stuffing this in the hctx, but how would that work?
>>>> The only thing I can think of that would work reliably is batching the
>>>> queue+wait into units of N. We could potentially have many thousands of
>>>> queues, and it could get iffy (and/or unreliable) in terms of allocation
>>>> size. Looks like rcu_synchronize is 48-bytes on my local install, and it
>>>> doesn't take a lot of devices at current CPU counts to make an alloc
>>>> covering all of it huge. Let's say 64 threads, and 32 devices, then
>>>> we're already at 64*32*48 bytes which is an order 5 allocation. Not
>>>> friendly, and not going to be reliable when you need it. And if we start
>>>> batching in reasonable counts, then we're _almost_ back to doing a queue
>>>> or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
>>>> the time for single page allocations.
>>>
>>> We can convert to order 0 allocation by one extra indirect array. 
>>
>> I guess that could work, and would just be one extra alloc + free if we
>> still retain the batch. That'd take it to 16 devices (at 32 CPUs) per
>> round, potentially way less of course if we have more CPUs. So still
>> somewhat limiting, rather than do all at once.
> 
> With the approach in blk_mq_alloc_rqs(), each allocated page can be
> added to one list, so the indirect array can be saved. Then it is
> possible to allocate for any size queues/devices since every
> allocation is just for single page in case that it is needed, even no
> pre-calculation is required.

As long as we watch the complexity, don't think we need to go overboard
here in the risk of adding issues for the failure path. But yes, we
could use the same trick I did in blk_mq_alloc_rqs() and just alloc
pages as we go.

-- 
Jens Axboe

