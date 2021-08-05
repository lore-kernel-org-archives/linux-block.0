Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC87C4320A
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD54261168
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhHERts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbhHERtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 13:49:47 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E72C061765
        for <linux-block@vger.kernel.org>; Thu,  5 Aug 2021 10:49:32 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so1525912ooq.13
        for <linux-block@vger.kernel.org>; Thu, 05 Aug 2021 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kkiaRg7roULA4rPWTzyKUAotq3+PaXnsdiPOMH2IJRk=;
        b=OkJfdu3xYIZ3l8Cdpu435rPmlDaiYqZcSiETAMiNXO43rVbnolFM4A4oO2+SN3W14x
         C4I0zLmkb2QE07H2+cbWaaGwVyGL0IBHMytdKN/A/edp/pLWfyFI/ZUaRc4xwB1h/VtN
         9RlNy7/iAIByh4P2eGMroSe1Z4z5LWHHUA3++LSG7iv6/C2freg/wBK1Jya96dWsuNCd
         wBHEgVZdRXlAylUH4z9Fscg8xxOAwG+SK81D7NqvtT5CveXO0fKwwuXtgpx6cqywFVOi
         lhVMy7x99TauWDrq358bIs1ADYoPuhadTy6UnGgpHGimoF4vyEBxGQm7gAWisw7Ffqly
         wZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kkiaRg7roULA4rPWTzyKUAotq3+PaXnsdiPOMH2IJRk=;
        b=adedKV8dLxngq6j8ac7UN/2+MtM6JZZnbwDiYyGLutq1tXz6gf8Tfr0aldnFacq3y0
         4kyh6jbTkkR2448s6bhDe/gbipOZqcjiWTmofdBuidlZue8+7OE+NysAbOoIL6dc0s2C
         mPFaJrKCziGZctfSh+3wNpyQ0RcrJ7YDMnPZc/wARReXFYQbAPAg44OpC0q2Iha24Fyq
         RjXwU7AW0YwvaaF86H0OIKYsKUMmKAKbDJdRnwbTjGJ/kQPTW8WJ47lVurXHQvml00Kd
         JSZ93yo5/FXam8aETyDXIC4bKwzZ53p1CUeMgnvHcUvERcY76qMEyxQnBL0NCqFhY1bZ
         CulQ==
X-Gm-Message-State: AOAM530H9Hek6LTZqxWZcX4lS2UV3i2yF+VcQByfiub+9BDlvBU/EfUn
        4V20p++XnWwE7GprFRxEjFp/kNANeBOCHUdP
X-Google-Smtp-Source: ABdhPJxQdki8yvJX1U95w1cJrMwxV1x+iNefnRHC3YF6rqv8+GajkVBEGcdQOmYgzCF9MY0XZXnalA==
X-Received: by 2002:a4a:6507:: with SMTP id y7mr1602072ooc.38.1628185771402;
        Thu, 05 Aug 2021 10:49:31 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u6sm1159251oiw.36.2021.08.05.10.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:49:31 -0700 (PDT)
Subject: Re: [PATCH] block/partitions/ldm.c: Fix a kernel-doc warning
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210805173447.3249906-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <efc3abed-09be-293d-9c8d-2f6c1f18f0aa@kernel.dk>
Date:   Thu, 5 Aug 2021 11:49:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805173447.3249906-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/21 11:34 AM, Bart Van Assche wrote:
> Fix the following kernel-doc warning that appears when building with W=1:
> 
> block/partitions/ldm.c:31: warning: expecting prototype for ldm().
> Prototype was for ldm_debug() instead

Applied, thanks.

-- 
Jens Axboe

