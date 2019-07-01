Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A504C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 17:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103F82146F
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 17:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZD4vWDqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGARMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:12:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGARMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 13:12:21 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so30554014ioo.2
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RBO6ISTGE0h2dzkR+zya7y2lDF/DCB6FONDvEvwIwZk=;
        b=ZD4vWDqmN8sC4m9U0mKDls6w/BqgwuZFplHvVoqdGIe4oA04ntk/JAvqG0CygnRXF8
         bX97QdzxSp8NzXbEt1zs2gchFTpxDwR5jaRi4bjcIJrGLYcN4s2lD7PcPAhn8gijY9gZ
         5Mt1aT9RNK1ytWnlKWCdk7GAXhWOUZx0csdS+eaqyY6GHwjAM3HCKH0XqtYQ02nruJhU
         IAMKC7XXwiFKfIaWe0TdLZ+T9SEQLCRR/bIcmkUTgdq2mskXQWsWINntOzllofk5POTn
         tFHPDaE683vmUMk5Z3nICt7IoXVvTeOy5f0X0hHInlUFIOT95X6NoaVlz6M+BOUhhwRA
         wnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RBO6ISTGE0h2dzkR+zya7y2lDF/DCB6FONDvEvwIwZk=;
        b=GAXzC+XJrvwfWlOFELR3NhGCYQu4wtCNdgnNv6Ro3V8VCtzOlynz0I8VRfRhyjIC5Q
         xYjFQW4wlQDxVBYaQrpx8oo07YP8JKbwPfmfm52I+kzw0RdU02CsXaKyb/Jx4mvLAI4t
         u+Iu0/IV/iZh8GPeTOez8jfFlqarhgF5oAnTWAo9L3HOTRsb19QTQq4Cd8zJpM0x+YcC
         6QVkTTYcD7j7XSEeMCY7YCgkY6T21fq9rBNCXWjbryxuaUHNvqpa/rbRoI8sOtJ1UrR1
         QIY5jIqSXHZHiBn3qyc2dWGM8npl85xJTpaVLRy3UsDuPzwS/8vh2fvOYd8yEKxSvZTI
         fWPg==
X-Gm-Message-State: APjAAAUn0OIlTpSSBnnQpza33fe1gVtlef4cDJKhYeYZ9lusqMOJj81/
        HhfP7925Q/YDKcsk8be30GdQ3A==
X-Google-Smtp-Source: APXvYqx/zbfgU/smGmgDqBql6CCGIw46JMN6JlP0z9Gnibmz/Joi7z5QUmsbmrm6BSLrAvAUHiJCgw==
X-Received: by 2002:a5d:9c4d:: with SMTP id 13mr15731987iof.47.1562001140624;
        Mon, 01 Jul 2019 10:12:20 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t19sm10658440iog.41.2019.07.01.10.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 10:12:19 -0700 (PDT)
Subject: Re: [PATCH] tools/io_uring: Use <asm/barrier.h> instead of
 tools/io_uring/barrier.h
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190701154145.202722-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0dfd33f7-ebd5-22ed-4a17-49cf2b05113b@kernel.dk>
Date:   Mon, 1 Jul 2019 11:12:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701154145.202722-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 9:41 AM, Bart Van Assche wrote:
> This patch avoids that multiple definitions of barrier primitives occur in
> the tools directory. This patch does not change the behavior of the code on
> x86 since on x86 smp_rmb() and smp_wmb() are defined as follows in
> tools/arch/x86/include/asm/barrier.h:
> 
>   #define barrier() __asm__ __volatile__("": : :"memory")
>   #define smp_rmb() barrier()
>   #define smp_wmb() barrier()

The kernel bits are just synced from liburing, essentially. So I don't
think it makes a lot of sense to add this change on the kernel side,
though cleaning up the liburing side would be great (and could then
bubble to the kernel as well).

-- 
Jens Axboe

