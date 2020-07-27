Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92D7C433E3
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FA420792
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 20:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UusocTr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgG0Uhv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgG0Uhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 16:37:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA5C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 13:37:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s189so10581416pgc.13
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BoMGSFrK6JuNKJj0yzQkT5G/Ydi9HB5iMMp3B/Ar/NU=;
        b=UusocTr6Wn5ya8x5g7nFGEyJc8UZUmDNAQgB4983QxdSzLkqYvlSLtF2vuYsjVUBuF
         YeCgKhKyqgnSJor+vuG2KxcGmaJ502UTwJK0KF0mycK94hP+HQMYA8e2suKl2DJj0hCs
         tkIP0bkQapW8XcBilA9KV8IBiZ6nbKwyltEefHGBx3KH6aQOkM72342mcVy9aosHAv07
         BBGvWLv6cLA2dwMV72X6L6PlOuDbdQ3OC4VAFwgLLYzb9Ajneu/+Tr2XkuTJkXxI+6hJ
         okuUT1br2bAM9KD2ATd90v/FLIyT1TUwa7on7pSArJfS1OJtzxpD0Uo/h32x2/V5jdYm
         C3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BoMGSFrK6JuNKJj0yzQkT5G/Ydi9HB5iMMp3B/Ar/NU=;
        b=riCtY1ebdsXlw5GMNRtkykAJLGI1ZjmWESTfKCOnmAhZaZZDKaibpqnbMxuPtYt/ta
         rgbQN6QQFUZVP3ElQ4LLuO89FeXqdME5hh5v/1LJyyW5kJuhmUl8K22/QFI8OsQb9ujK
         gWEDamxMH5OgUSHWONCMBoX4LCUE3+jsettA0N845792GgUAhIes7ShcctZ3l/U1h2l0
         7dbfSXR+iCE/lKPUXOdvQ+mwnCv0vCjNG/XOuzBIJj/h6z/hlgARTgLRU1QWw9BcZd79
         QYnIQ4tb+VT64GvNfZXfzcWm6XPgyhmrN4paqfRq1Rgwvpsn0X5XBwt2dPAvu7FbJzDK
         Apxg==
X-Gm-Message-State: AOAM531xJGpqkPo3tgK3LPdyEd89SsNmHOxkVRyd9khuT+PWc8rR3Mq+
        usCHWtBvLOMwgJcXD9p2EfMJZw==
X-Google-Smtp-Source: ABdhPJxmez7ADoFSJNVMEcnyiur5YEx6PVUnQDGsz7qtvYp8baQZcPhTa5spOpDdvjAqtsiRJBGt1Q==
X-Received: by 2002:a63:495c:: with SMTP id y28mr21606643pgk.30.1595882270081;
        Mon, 27 Jul 2020 13:37:50 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s22sm15056230pgv.43.2020.07.27.13.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:37:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
Date:   Mon, 27 Jul 2020 14:37:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 12:36 PM, Sagi Grimberg wrote:
> 
>>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>>> +{
>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>> +	unsigned int i;
>>>>> +
>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>> +
>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>>> +				wakeme_after_rcu);
>>>>> +		else
>>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>>> +				wakeme_after_rcu);
>>>>> +	}
>>>>
>>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>>> synchronize_rcu() is OK for all hctx during waiting.
>>>
>>> That's true, but I want a single interface for both. v2 had exactly
>>> that, but I decided that this approach is better.
>>
>> Not sure one new interface is needed, and one simple way is to:
>>
>> 1) call blk_mq_quiesce_queue_nowait() for each request queue
>>
>> 2) wait in driver specific way
>>
>> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
>> then you may add per-tagset APIs for the waiting.
> 
> Because it puts assumptions on how quiesce works, which is something
> I'd like to avoid because I think its cleaner, what do others think?
> Jens? Christoph?

I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
call that.

-- 
Jens Axboe

