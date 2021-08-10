Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3BC4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E7A60F11
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhHJCzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhHJCzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 22:55:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBA3C0613D3
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 19:55:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so2175642pji.5
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwIzHxLKfJ1Z3y+RWFS0rmWRsd8dHq583SjkmpXiIrU=;
        b=tlsooozbybGptNcVHCZDISbfqnJ2rMZfqhrc1/cJszVpXx5PnGEUsU8ShMHEVAWzBW
         kezruyelWHWZp9ls8n3okRvc3ZHXxuM52gsYBgQqPcqXvErmNknl4bFepCSP27gXdDF9
         sCO+/mFrf0D3a8rpz2Ta67T7qbJUwIvGCVfYxkV1Ou1jhZL32/1Ge6wJ0hsgHb8lr2mL
         +LWttyWzqc71yEWbMLkehAqSqu2R8vqx52NSRST0mHFS/jt7qdYgF0V01u/w7t4DCPlz
         YMQ/4ucqupB7U1B6tr8/h8feIsEjf7OxRFQ9Tgch6r7naWJq1dk30iMknlp4qHtcgJZM
         vmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwIzHxLKfJ1Z3y+RWFS0rmWRsd8dHq583SjkmpXiIrU=;
        b=G6AMUb7GE/atV2+1NeNe8JpQjMmVMjQ4aXkjxaOKyaajQQNOcb0LXeCM7l8I8LvJMB
         DQSU40bP7U875yeE5Aw7KKvJ3lHZSLQkcHdD6oRqSgUkrQxwHdvbDfroVhl7FnrZN3iN
         GBHS6gAbbnCOceHIcH116ZjqSY4lvrFFksaS9F7Yj+hhL3dTrDWPj/VwsbSEqVKsYFpM
         zmQC+CX6/eAFmtq9yZoTjcRdEl8K+4DUpznuUaXLXAd5zLuUdUdQbt02LfDsn6vm2GDM
         l2Kq6mXKfKZYwAcXV048QHDUrbpMQ3zN+nqfNMsf+ucfbi7duRxZi5ydSWEUmBY+tBsg
         Xqvw==
X-Gm-Message-State: AOAM5334+dJuXfyUdeCYs5yBsN1XMtHMp/Q+LvXCrSb0EucmmQh393cr
        f1u3GcUg91Nal2Uz0uJxMvSXhLi6cjjH9Fia
X-Google-Smtp-Source: ABdhPJzD0wFwdX8lFZi/QYjob22NbLdSh8CT+Y/Qlh8lpeaN9/VXSVY27HMWFRiJ90AjUV59i2FQpw==
X-Received: by 2002:a05:6a00:1c59:b029:3bb:8d49:c2a2 with SMTP id s25-20020a056a001c59b02903bb8d49c2a2mr26406963pfw.77.1628564119065;
        Mon, 09 Aug 2021 19:55:19 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d10sm2523032pfd.49.2021.08.09.19.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 19:55:18 -0700 (PDT)
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20210729034226.1591070-1-ming.lei@redhat.com>
 <YQtcZHgE1cTl+KVz@T590> <a60094bf-c5b7-9b26-43b6-11188409edf1@kernel.dk>
 <YRHoxGKjD9JHjiXh@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eabcef59-64a1-6e6e-adbd-5924fabf9810@kernel.dk>
Date:   Mon, 9 Aug 2021 20:55:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRHoxGKjD9JHjiXh@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/21 8:47 PM, Ming Lei wrote:
> On Mon, Aug 09, 2021 at 02:36:25PM -0600, Jens Axboe wrote:
>> On 8/4/21 9:35 PM, Ming Lei wrote:
>>> On Thu, Jul 29, 2021 at 11:42:26AM +0800, Ming Lei wrote:
>>>> When merging one bio to request, if they are discard IO and the queue
>>>> supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
>>>> because both block core and related drivers(nvme, virtio-blk) doesn't
>>>> handle mixed discard io merge(traditional IO merge together with
>>>> discard merge) well.
>>>>
>>>> Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
>>>> so both blk-mq and drivers just need to handle multi-range discard.
>>>>
>>>> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>
>>> Hello Jens and Guys,
>>>
>>> Ping...
>>
>> Since this isn't a new regression this release and since this kind
>> of change always makes me a bit nervous, any objections to queueing
>> it up for 5.15 with the stable/fixes tags?
> 
> Fine, will post a new version with fixes tag.

Sorry if I wasn't clear, I mean are you fine with queueing this for
5.15? I already did add the fixes tag.

-- 
Jens Axboe

