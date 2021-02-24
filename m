Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B408C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B6464E6C
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhBXQMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhBXP4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 10:56:12 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909AC061788
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 07:55:11 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id c10so2115659ilo.8
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WNLTnpurdEVGQyELRj8Mcnx3jCoSc8XZQ/4PoKsDj2M=;
        b=At+NJtkiSvXd1pGP9JAzS2/T2CxfS7TZNVAQCy/sv9dqTOvnHmvLen1K03AZgq2r04
         mrVxM8FqcAOyxB9xfC9u3ncx32XLkA2slIRsupF6PPBspv+XxiKnXYiPxYSjN1gR9Asz
         PN8Jwadq2czLAQ/ZzpdJUVmCs1iRTlITZmeuokO2oxoo7zqP8RGsOtzMmmEXiMl/B0t+
         x02RGr2ZIXm3K6r6GAhr1/+XxVuKNr5sz6ScyFfPmRinosRsRefynA1orB4r3hMnBQ6h
         VIIMLm2cbcETnyVLiY7RlctTUTA7vvOwQoNeTf/+2fMrue/ZFrpkANVe7wgctMS8YozR
         Jv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNLTnpurdEVGQyELRj8Mcnx3jCoSc8XZQ/4PoKsDj2M=;
        b=c9G4kwbeXSXswe1SRGUX1Tg8Jx8Hgasrf65raDrG/1Dt3xIk3CfLPH++mG3iNIVfFN
         dRk3qpVO9K/xKccpNF+FFa5YeJstvagZ4WYkeLDUgj0R0ijiK5R7/9Pjfxl/oii5xj2W
         dh7lNfnqseNSLYObgHMPZtro5nT2dlw7cb2dI0eIiw9fqAzKd2Q6oc+c/Q8DRXeaJEoZ
         iu1qcsCu3xxsWNgJRV0FKP4j0KKbbw0h7qeFYD8d5Dt/+ig+8YSWf0pI8kys66FJveK5
         EEgZTe8FdW0mQRYMT5+pyHu5mnmAZpNRWXKYvoHOZobhAf8FEHfzygRql9F0sHirVZ/H
         jPAw==
X-Gm-Message-State: AOAM533ImVy49juF8HbpxNHD8bytbm/SwfYfDWGjHO0D69dMiGT9+hy0
        GDFVURbItdnxYYvrBY4hbKH153t6m5MYjlDB
X-Google-Smtp-Source: ABdhPJz+iO6GyvOIjaJhHOlrkyx8JcM8vBFssFNxDEx2eBM4DOWYKf+qOYI3z7gdwmZiRdqVJa6yJg==
X-Received: by 2002:a05:6e02:20c4:: with SMTP id 4mr24508346ilq.221.1614182110725;
        Wed, 24 Feb 2021 07:55:10 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t7sm1760439ilj.62.2021.02.24.07.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 07:55:09 -0800 (PST)
Subject: Re: bio_kmalloc related fixes for 5.12
To:     Christoph Hellwig <hch@lst.de>
Cc:     Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
References: <20210224072407.46363-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1b68f27-e6ae-77c4-99c0-ab20ac99c11b@kernel.dk>
Date:   Wed, 24 Feb 2021 08:55:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210224072407.46363-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/21 12:24 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> a few fixes for 5.12 below.

Applied, thanks.

-- 
Jens Axboe

