Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426CFC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABE861003
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUPQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhFUPQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 11:16:39 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390CCC061756
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 08:14:24 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i12so15558390ila.13
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tsu7eDLoNDm5bb4H1/D+NsnNSYlHRlAHX6coAFFVuSU=;
        b=b3rb82PI+YEMnnS8yKwnGUJgdkHs6/3GNq3DAKs5pZXqX8QdriURpK51KVxJR44OIZ
         8e6tMcFQcmRkXsoAev0FlaJeq7oH/oD9XANXfzQHeGZx5/JEugdJRdbXXWmSaFPa3XKR
         i6JhxDev9UFkkFIjXX6LDP3XNEmfGYFb7uzVvpyLmYv0qdWsVtcG6tXelkSuF0cqSjfi
         PF2/ogBjOE/cxrbf75kurnOeGx4uCIbwyT0yhbvl1FKZgvbbg81Z8SHlYViLLowzWP47
         BJujuJgD4nZZ5ZMm08m/zFTKE5J0tApHf1701TnmgkeE3DaQc9IwYo9k/N2J1r/RijFf
         eCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tsu7eDLoNDm5bb4H1/D+NsnNSYlHRlAHX6coAFFVuSU=;
        b=mTlatjiWJwjqOEPGhcmc2JA7qWrmYANjvZJdg9jLdKt6SCNh81iB7hIE8Pi0LM/D1U
         Ue7eCQMfl5n/JDEFKZYjxWUg1+Q4PF0eDtZ9Qj+vLE2KY9FX/lzAfKOGn7b+siRaR31z
         fMyzmWAmyty1jEGAqr/L4jT8PIYYg7NA6OZCK5u9gdWMTbEZ8u+7asywjqO8ingakN+P
         wZWYQDuOPKHb/1pl6vwcW8zbdZ05kZb2ncH2HZ+HJ0ZAdCaOMKhmL0wIIwLXe61SPkVb
         vP0PkDJMYMrWSKlfKCXWzASVn8WCqDxzRfuuRJivi3YvhVcphLMSr4bsCD+tp/OQc0KK
         l04w==
X-Gm-Message-State: AOAM533La0N/aQHeMhdTa4SxcEU2mB9fu2lUcggg8zAuWz5I2HdpnRZQ
        czlQW9ejinjllpobTTA6T5sIu1yhHkS2bA==
X-Google-Smtp-Source: ABdhPJy88YRDcaFe0BKVZvue6TrZNXIZRKsNZz7WrsfoSF8Nm601LTC2PBCAKfusaOb0pfhoBu6qTw==
X-Received: by 2002:a92:c5a9:: with SMTP id r9mr17872497ilt.56.1624288463256;
        Mon, 21 Jun 2021 08:14:23 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u14sm2807443iln.43.2021.06.21.08.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:14:22 -0700 (PDT)
Subject: Re: [PATCH 00/14] bcache patches for Linux v5.14
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20210615054921.101421-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb427b5f-8e55-bed2-1e3d-7382a092d4a0@kernel.dk>
Date:   Mon, 21 Jun 2021 09:14:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210615054921.101421-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/21 11:49 PM, Coly Li wrote:
> Hi Jens,
> 
> Here are the bcache patches for Linux v5.14.
> 
> The patches from Chao Yu and Ding Senjie are useful code cleanup. The
> rested patches for the NVDIMM support to bcache journaling.
> 
> For the series to support NVDIMM to bache journaling, all reported
> issue since last merge window are all fixed. And no more issue detected
> during our testing or by the kernel test robot. If there is any issue
> reported during they stay in linux-next, I, Jianpang and Qiaowei will
> response and fix immediately.
> 
> Please take them for Linux v5.14.

I'd really like the user api bits to have some wider review. Maybe
I'm missing something, but there's a lot of weird stuff in the uapi
header that includes things like pointers etc.

-- 
Jens Axboe

