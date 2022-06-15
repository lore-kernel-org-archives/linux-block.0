Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF779C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 21:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbiFOV3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348255AbiFOV3O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 17:29:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09459562C8
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:29:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t2so11476939pld.4
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ldmBi8APWWuyNzxGvJAEFdPJdaAowmPS/Vlf+myf3zs=;
        b=dbWi6Vk2bqjrc8vUfNT3gf9Tpobn1o5c5p5I4GS9d4Mo14fwwZzLC+2+IWr2LZoh4R
         JCz1axMB5dx3FhR4jwYUZfYX55Vqkr/bSTHw15BVz1mjo7CQSUB8REEJR1n5vq2Zt5Kk
         W4p6cW2tAH0xKOU9xBtnajmRUgCd1F35bYbTybTnuV15olWhFStIe5sN/WvZq/1od5rW
         cE9FrRIQMGIvOWbvj8/UmqvUdF2s/XjpyiRt8m1IbSHCL6tr0vU/4l5W/oq9E56OOIDK
         dh80OCMd1rh/nZQi/kg+6j/SsaVcm7EaxcF9jejMqTbj/wPVkPyBxsJfIY9dUAsMV0V+
         ia+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ldmBi8APWWuyNzxGvJAEFdPJdaAowmPS/Vlf+myf3zs=;
        b=olyTvk+uxgNYfXKiam8BNIOj2sMO9Hs/ngq42Fu5Pr5wWHzPQ5BcLBTbAkYCidJS/W
         0oNIJs1Z5bSmzcGvUnwnOHbdfE1PrvI65lx0mhQIheFkbbBThAcEkz4ttlQjz5X7VL5c
         7rJ8XmIT/tV1Eaw+g3Zihzp2/CWLHID5S5ERov4xRMzPV+1uLV4Hsxgwh8QyMtpklYTx
         35Z/Z8uSu+LWj14zfe1XNIrV2XOeg2ZMwt12h0XZdpYqn4bMaKlZPuJMaZ8kL6dE8H66
         BrXQqU5UQu6b1TAkFiMEjfDm7bUK08yP3HqZNgqxtyrZcc+Cb9IXSjkEyVTSBCbGwUCI
         xXlw==
X-Gm-Message-State: AJIora/PnsAKDL5U3imQpK9zU35xpoc2fPCo1+lpy9/KohXECRwukgOS
        TKDJpT2PF86LOjLxPm04hAg+hAG0vd1hgg==
X-Google-Smtp-Source: AGRyM1uXsTN49BEmlVW1t5M3nREGbQLY+LBgVpXTGMXryhzFXN8kwF9RnSzuYvtVDxunHnDnrQq6pw==
X-Received: by 2002:a17:903:2451:b0:167:8179:62a8 with SMTP id l17-20020a170903245100b00167817962a8mr1483402pls.148.1655328553467;
        Wed, 15 Jun 2022 14:29:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ef27092aasm80082plo.190.2022.06.15.14.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 14:29:13 -0700 (PDT)
Message-ID: <c6a9a981-815e-58c2-1f8a-e60e119de88a@kernel.dk>
Date:   Wed, 15 Jun 2022 15:29:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] block: Improve blk_mq_get_sq_hctx()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20220615210136.1032199-1-bvanassche@acm.org>
 <20220615210136.1032199-4-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220615210136.1032199-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 3:01 PM, Bart Van Assche wrote:
> Since the introduction of blk_mq_get_hctx_type() the operation type in
> the second argument of blk_mq_get_hctx_type() matters. Make sure that
> blk_mq_get_sq_hctx() selects a hardware queue of type HCTX_TYPE_DEFAULT
> instead of a hardware queue of type HCTX_TYPE_READ.

You ignored my comment here. A good changelog explains WHY a change is
made, not what the change does. For that, I can just read the change.

So please change the commit message to say WHY it's important. Or if
it's not, make it clear that it is a cosmetic thing.

-- 
Jens Axboe

