Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21506C56201
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A375420790
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IZ1C3kIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbgJ2AkT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbgJ2AkT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 20:40:19 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17054C0613CF
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 17:40:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k27so1507964oij.11
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 17:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6JSP+gknecdQIb43HL25pDbZr81hZ8KDnNrBmTGdQyQ=;
        b=IZ1C3kIaYcK/G2ClwunxqGHsFv2IHhnNyr3/1dNAioeOVs7VevEtVOQCDqZHuBK5QN
         ubeC8+K+5JYRFnK0bmP2I1Uo8RsUKENUEmcSIixhppbebvpY8iCTaUDs++CbJaJUZBgu
         byT/X0NQ24miKZlInT/MCffbrOMl4VR2ITW6vf7srIfVd2uh8YHCeTjcAc9iu/u5aT4S
         MoMvbJOWYhJEMCmVQnY22EEACVRtqY2yP9mELPJbkjw8J5nboE+tJIuhH7FbwwAJWHE3
         TyOAt6jZ0LLPKJiFGaDVnOHPMPfQXAwcfj80dy9D9q5tL6Q31tWe96FfozpRAJMj/BDl
         mObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6JSP+gknecdQIb43HL25pDbZr81hZ8KDnNrBmTGdQyQ=;
        b=fu6gjPVL9S1wRnWmc/C35klzAyeYzJUOsqvRqx8pbEXu7EBpT1sDS28xphddh1Ly0U
         sEK1ylQVY3zyER79vSUsqGGGnSaEtMKSMeJ6o3zZ6stlOzqp9FrKBd1CjG9BLlB9S+3T
         a5CRRsAFqjtuySY5Z0OVUbfvU47hwBXDXlt+yw6hPqKmSajYbrxEqaOwdIVwymMhsIOl
         8n1GkuzO53EOJscQQofnaq8+7sDoPi3U2/qAxcdH/k1tNSJNKRZLkcMHu3esnWuYzJAp
         jSmAXTm9CRhAApROn03oPYYf6jX4vGL44Ta+zollfVNg6xmx5wXHRd8x1bA5QTUjN7fL
         qr7g==
X-Gm-Message-State: AOAM533T6g4ZuNKASmm4bjGiG9wNi7ww5mcIJJS0s7qCBIPAfPg0nLQ+
        8k+7lg2wsopF01H8eWVaa6f0zoTHcEbZmA==
X-Google-Smtp-Source: ABdhPJyZSVd+JZaAYxUeIMvPGFoUD0i3wI32yHTc5e5c7SW3PYC40SS0vy9uNw2huBZNAxs4EV6Z3A==
X-Received: by 2002:a17:90b:3842:: with SMTP id nl2mr4612274pjb.202.1603852862019;
        Tue, 27 Oct 2020 19:41:02 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f4sm3205726pjs.8.2020.10.27.19.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 19:41:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] null_blk: synchronization fix for zoned device
To:     Kanchan Joshi <joshi.k@samsung.com>, Damien.LeMoal@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, javier.gonz@samsung.com
References: <20200928095549.184510-1-joshi.k@samsung.com>
 <CGME20200928095914epcas5p1beae8d5a201c35b598fde8288532d58d@epcas5p1.samsung.com>
 <20200928095549.184510-2-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c948100e-7e01-5f30-721a-7ed8c820a3b8@kernel.dk>
Date:   Tue, 27 Oct 2020 20:40:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928095549.184510-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/20 3:55 AM, Kanchan Joshi wrote:
> Parallel write,read,zone-mgmt operations accessing/altering zone state
> and write-pointer may get into race. Avoid the situation by using a new
> spinlock for zoned device.
> Concurrent zone-appends (on a zone) returning same write-pointer issue
> is also avoided using this lock.

Applied, thanks.

-- 
Jens Axboe

