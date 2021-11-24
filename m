Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D8AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 15:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhKXPcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhKXPcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 10:32:46 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9486C061574
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:29:36 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w4so2818234ilv.12
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rrhZzQDUHJIQTmg6CJB/zIDIB4fKU/4VePYDTiFCM24=;
        b=6WOXuf8vNnnqTemrJS2e1qVKDzZmmXev0ma1C2pBEm+jg0jPl6b15OWnUO1ab2yj36
         DXKTL/PnmbsYLVskeeBh40H4yCuyJVO0Pamap/2nXVp5c3zd6sj9sTnH9dBfF+7Pov84
         P87h5+hj9Nsq+ezTzdhFKvnEVdid6xKJsq7SV93Qk2m17LEuQARmtlqltILgutMOECVO
         T3Xki3WOspQFeFQQ5EPHei6cWKiPEZpsZnpX9a6RznzMXpw5D5w8XaaS9Wb26n1Bv4ZE
         F+rn2Q1Svoy5OGkN67lAxVl0eCvhNmtIqZ8BESe6QQOzqRL4ytltNuZ9aCas1P/6Qnbk
         mXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrhZzQDUHJIQTmg6CJB/zIDIB4fKU/4VePYDTiFCM24=;
        b=4bv/VLHm2CwuL9zmPhI05m9O1hRucGX2eNgalLLhyOztvJI3d+9ykfxF0p0QH3qlmB
         O7A6j7nmgWwJq1Z7gYeJolwT5kopIx6acYpVgNz8FKIqhK9v5m8SFTvNdC6mSO2U4AWH
         enI6JzBjhVtnZP2XuebFXk4erWsfKv6elkHsYuZprAQQbp/MFR5qmroUoiILfTfAnXMz
         HQzaHMTSJ6W08DsogK1giwhACBOml6UKh+pMvuQYvwB65JYx08cTPJfBSD2LE4r76U90
         Ak9BjflfR5669VI2ve5ngRfKmnqbjRSzBSNwHNq8haR8mWHPccq+Vf2pmsPnTTnunDsv
         uu/A==
X-Gm-Message-State: AOAM532kE5XUq4/+PBoHdNVbG//otXTcfSqOT2f2AKy5VnOIhIGtG19K
        RrraY5HtA33aVcQxvdbpdv3HOg==
X-Google-Smtp-Source: ABdhPJxkFlRHVM9OlG5+7rg2MTm6jqHUnus79+leW0HqbkVM2xmauoaaLAA8qDQM/tnLPYDBhnnYOw==
X-Received: by 2002:a05:6e02:1707:: with SMTP id u7mr14508546ill.210.1637767776368;
        Wed, 24 Nov 2021 07:29:36 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x10sm71366ilv.72.2021.11.24.07.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 07:29:36 -0800 (PST)
Subject: Re: [PATCH 1/2] block: only allocate poll_stats if there's a user of
 them
To:     Pankaj Raghav <pankydev8@gmail.com>
Cc:     linux-block@vger.kernel.org, p.raghav@samsung.com
References: <20211123191518.413917-1-axboe@kernel.dk>
 <20211123191518.413917-2-axboe@kernel.dk>
 <20211124125236.s7h7e2tunjxt3r3j@quentin>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5589736-54d8-541a-9a28-00deab848a84@kernel.dk>
Date:   Wed, 24 Nov 2021 08:29:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211124125236.s7h7e2tunjxt3r3j@quentin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/21 5:52 AM, Pankaj Raghav wrote:
> Hi Jens,
> 
> On Tue, Nov 23, 2021 at 12:15:18PM -0700, Jens Axboe wrote:
>> +bool blk_stats_alloc_enable(struct request_queue *q)
>> +{
>> +	struct blk_rq_stat *poll_stat;
>> +
>> +	poll_stat = kcalloc(BLK_MQ_POLL_STATS_BKTS, sizeof(*poll_stat),
>> +				GFP_ATOMIC);
>> +	if (!poll_stat)
>> +		return false;
>> +
>> +	if (cmpxchg(&q->poll_stat, poll_stat, NULL) != poll_stat) {
> Isn't the logic inverted here? As we already check for non-NULL
> q->poll_stat at the caller side, shouldn't it be:
> 
> if (cmpxchg(&q->poll_stat, NULL, poll_stat) != NULL) {

Yes, I did fix that one up right after sending this out, here's the
patch:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.17/block&id=987567fece249eabb14406e4e52f427e679d8461

-- 
Jens Axboe

