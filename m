Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4895C7618B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7925C227B7
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 13:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y4uhVeOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbfGWNfq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:35:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43771 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389991AbfGWNfp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 09:35:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so19440583pgv.10
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U/rIdHk59Y26MP5OXK9CvV9HfQIDnItcRiOtBbdSbMQ=;
        b=y4uhVeOBrDTO/fWLGANwFQ5WbdfHqk0C3/9TA4Xqj6oaoxU4upVOcL3Jwc7pOKVpNQ
         jvwpqpGDcfUB/YN5IEPy7WIeXpG//IQCBQCmGghrtYY/EuKSvIevTqGPJtakh0LoO/Tk
         wtaS6ABQOdbx4zCVCvVSpwo4dVKDS2vLDYJq1GOf5e8qDIZy1OLZjP8iZ8+juoa3nbTO
         Ry+rreTVmTnPNGUOdX7PKSil7d1tIGK/Y0WImVn9y2OgmzbzZk9P9Ms0Z8ZkVVA6MXhi
         fgVWNl4lfjsR8SD40LuLvlZ8TXLj7jTpoYttudPDPha42ZNstoa0gF6lXXi6ULka99pT
         ylxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/rIdHk59Y26MP5OXK9CvV9HfQIDnItcRiOtBbdSbMQ=;
        b=N/EjMZJ6iBbAuj783nEnJOB8tj8y2Bp0zIKW63/m89E2oO/uyk2OcW3VP5KKsPQf6y
         GXLRwan5AUKs2ZMrDoUlLyezao+dIAD56Ov5x23GrqusNISU9OCdzYxsKjq36hbHVHQS
         /1t9XDFZa/C1Y68ifFVCswMLzdiTQQuCKh51d1T+BCUaAh6FYYq13UpfNEKA2MVvCwyD
         5fylLxRqezV+BkRht9D3WcoguP6g7goGx0CI/20TVkH92325WytwYbWPYdEgLQNQiJud
         DAf1jCIc6jQ8CWfSWAGbG7wM7zGf09F/O1lkeY3+gzu1SIVkUBKDdDe8rZ66DsuBL20D
         4++w==
X-Gm-Message-State: APjAAAWh+q4BzWixy5L7oOQ+k7fe7xPSPSXL4SCuPHhV8v3fQqpx8ixA
        q7bFn0j5CqYDj5+VOPhSW44=
X-Google-Smtp-Source: APXvYqyZXqUqAa7v+mXbcPVtleQm/zArV5YEyo8rLa6bVPAOCH2Ab1hiVN80dUJspZkEVeaO9Om9wg==
X-Received: by 2002:a65:654f:: with SMTP id a15mr74534244pgw.73.1563888945184;
        Tue, 23 Jul 2019 06:35:45 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id bo20sm32429908pjb.23.2019.07.23.06.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:35:44 -0700 (PDT)
Subject: Re: [PATCH] [v2] drbd: dynamically allocate shash descriptor
To:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     Roland Kammerer <roland.kammerer@linbit.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190722122647.351002-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2675f963-6d67-7802-4f8a-eab423688419@kernel.dk>
Date:   Tue, 23 Jul 2019 07:35:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722122647.351002-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/19 6:26 AM, Arnd Bergmann wrote:
> Building with clang and KASAN, we get a warning about an overly large
> stack frame on 32-bit architectures:
> 
> drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
>        [-Werror,-Wframe-larger-than=]
> 
> We already allocate other data dynamically in this function, so
> just do the same for the shash descriptor, which makes up most of
> this memory.

Applied, thanks.

-- 
Jens Axboe

