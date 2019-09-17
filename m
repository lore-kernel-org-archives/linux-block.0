Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE2BC4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 23:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C88A21897
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 23:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q5eZNtj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfIQXZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:25:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35708 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIQXZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 19:25:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so2206808plp.2
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 16:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ygaAzaNkL2xKzH63XMB1rgQXO5dSuYuP4GvHDpGQIsQ=;
        b=q5eZNtj1lvSpT5MvUQP9D4wpuPBUa9FuQuelDbc8R37cr93NF0P/2oh+EPKHvMHjYB
         OIiB3aLicnLGazROYkuSrmKbc/TSjU3G8vkpDaRnGk7hlN5jGkIgm+Uf//IPoNAR5JBt
         ZWa5ElDU8DFojrdht8W1IDPuIksYmQLqYg1I/GFzDMa/Rh8zHfLB44sxZBUPNuGzLeGB
         +Wa1sCl+Cjzqgf/q8zlbt9toBum1/yCaiuk4USithTTknpuEVdxowdjGa8H0wvxNy+kw
         vyKIMMBjNbQ4teD9KHowaIe3ztvHh4zhx8Od6CCw186c8P/vWoTTfVCFQ8hz5ud1e0CM
         nPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ygaAzaNkL2xKzH63XMB1rgQXO5dSuYuP4GvHDpGQIsQ=;
        b=QS87EsctAWqDq8AfzEPTAI2t+PzolFYWbjlJZAsWSYSltrFL8ddy1EymSPP24eRiT2
         lqI1al5Hcf5dUAFcRaWvC9xGr4WEF+7tOlwc9mOtFlFF/KlZPQ88Ib1NZ4aDxoGU4yjB
         /FzOdUYRb91QRa8sHJl85a2b/4nRZg4xxgAbwN8uWBkRFzRr6+7hhL+lshAfwXkvv5IY
         zCQ0tips9UoB8UwZ+pY7rABjefVU/firNmWnneWKoJGXhseO9xEh9NPeqCP4AvoRV92M
         jwUJtv/gI9r6U9HV93eXIbyJQ30E3RNH4iPU/0V1X4btZb7kRwUmME2+2voxsq4dZaKy
         RH4w==
X-Gm-Message-State: APjAAAVxBnn9x4FTk1SXhgUvs1ebuqHjMYrq51jRiemqV16crA78+euI
        Jj9h1ZnxMt8CmCt3rIXz4X+Aw9xHlB3NKQ==
X-Google-Smtp-Source: APXvYqzGDSzih4xJb/SW4upH/peMt8oFgX/IURfeu1GmYNaQfZeAqtxwqnRwfJ19xc1jp2pOFKERdQ==
X-Received: by 2002:a17:902:b208:: with SMTP id t8mr1218312plr.262.1568762703956;
        Tue, 17 Sep 2019 16:25:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h14sm3879722pfo.15.2019.09.17.16.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 16:25:03 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] blk-mq: Avoid memory reclaim when allocating
To:     Xiubo Li <xiubli@redhat.com>, josef@toxicpanda.com
Cc:     mchristi@redhat.com, hch@infradead.org, linux-block@vger.kernel.org
References: <20190917120910.24842-1-xiubli@redhat.com>
 <426aa779-1011-5a75-bb73-ae573c229806@kernel.dk>
 <eaa4fb45-3a62-839e-bdcf-5219fe1c8211@redhat.com>
 <e7e0ed6a-be80-241c-3841-4eaaba6a9bf9@kernel.dk>
 <960dd93e-3e3f-b0f4-5be5-1f77639a1614@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <380792f3-cc15-2dc2-e138-124976508978@kernel.dk>
Date:   Tue, 17 Sep 2019 17:25:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <960dd93e-3e3f-b0f4-5be5-1f77639a1614@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 5:19 PM, Xiubo Li wrote:
> On 2019/9/18 7:11, Jens Axboe wrote:
>> On 9/17/19 4:54 PM, Xiubo Li wrote:
>>> On 2019/9/17 22:13, Jens Axboe wrote:
>>>> On 9/17/19 6:09 AM, xiubli@redhat.com wrote:
>>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>>
>>>>> Changed in V2:
>>>>> - Addressed the comment from Ming Lei, thanks.
>>>>>
>>>>> Changed in V3:
>>>>> - Switch to memalloc_noio_save/restore from Christoph's comment, thanks.
>>>> This now seems to be a mix of both approaches, which I don't think makes
>>>> sense at all. I think we should just stick to the gfp_t being passed in,
>>>> and defining the standard mask for init time blk-mq memory allocations.
>>>>
>>> Hmm, I might missed or misunderstand from the last thread. In this
>>> thread with the save/store, the GFP_KERNEL is using instead. Maybe
>>> save/store pair is not a exactly correct place or occasion to use here
>>> as @Bart mentioned.
>> Just make them all gfp based please, and skip the memalloc() stuff.
> 
> Yeah, isn't the v2 thread needed here ?

It might be, I didn't look super closely at v2. I'll take a look.

-- 
Jens Axboe

