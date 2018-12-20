Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C1C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1A62186A
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gCBe3G9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbeLTRhI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:37:08 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:52454 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLTRhI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 12:37:08 -0500
Received: by mail-it1-f174.google.com with SMTP id g76so3177645itg.2
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZA9Fi67cs0K4625PwGqe3l2X2/yszPPV36PLDFMHLpU=;
        b=gCBe3G9WlcH8kKJziBDz4V9//7M0upNAUt1TINldxplSU7ZLzC+dl549FPGj6dg7Ek
         UFTVakuRSVDKX3w4dQsYOesCAtvI2iPwbxtXXAiaP8BF1HLl7530C3EcehYhI48/lYZH
         5CMVeXkxDC7BhLuy38NVYiD+ShNfnT0ttlOSCNJFLjc11TZgXfDRCzzUW67L0cTTHd+z
         /loqifJ0QQ3Co0VsKcr25DjFI7l8mxiTULUEI2UInEbYM3hyNfPS/8eFHXQ5kZSuvb9j
         NVrauFmtoxoM2Ozto/aKl4MCEcB0YJmU+hzG55JD0WLaXEhXuR8Ki3tZSyA96PYk5Mn1
         Aklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZA9Fi67cs0K4625PwGqe3l2X2/yszPPV36PLDFMHLpU=;
        b=LGvdACOJSBiFzs0uyTy9umu4ti2MaIDc/VKFX4SjecWZ7iryi8otAI9zQ66vswKOTs
         IbI+eiRP18m75L0DFDUpi4RKIBYeR1/KsQ/l4Cmyk9LoiW5j+CzuqS7EGoU4Pq8S6AEp
         nNps4Whaznc8ox+1cjwX2t5g4yrHpJVDO9lNyPTw0mQkxXwvsgh9xQILGNrrcqYUQzje
         ERG6IcrMc2GBUzAYybvJrY7mK72MzHRn0WCTiNgX6dEBep2qQrVPXe6e3S4lNxwUVVdu
         7lrVg2mOddx3U5ho/76fSvRqOSYQTi8tcLNo04e+qmVmRYpMJvCZFHJDoQNmFsuxrRVn
         YfLw==
X-Gm-Message-State: AA+aEWZk1LzSK7NsKwh+Fza4Bv57N6Br+zjTuSO+1CDhKiq702qGa/vN
        kb97QvL9dGl5xkSMmiB3OU4T1g==
X-Google-Smtp-Source: AFSGD/WPtEWeK0pNz8CqbT8dp7eUX2I5N5g5DzL+1UeLp7jueXUpoKTG1EoTn0koNVRSjg9KNhSpAQ==
X-Received: by 2002:a24:c105:: with SMTP id e5mr9911948itg.87.1545327427220;
        Thu, 20 Dec 2018 09:37:07 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o2sm89334iop.76.2018.12.20.09.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:37:06 -0800 (PST)
Subject: Re: [PATCHSET v2] Fix kyber hang
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@osandov.com
References: <20181220160149.4042-1-axboe@kernel.dk>
 <20181220165638.GB27758@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87b7cc80-88cf-4836-4776-96d6208d500a@kernel.dk>
Date:   Thu, 20 Dec 2018 10:37:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220165638.GB27758@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 9:56 AM, Ming Lei wrote:
> On Thu, Dec 20, 2018 at 09:01:47AM -0700, Jens Axboe wrote:
>> Since the wrong kyber patch was included in the first one, here's a
>> v2 with just that one line corrected.
>>
>> First one adds the necessary sbitmap helpers for users to be able to
>> do add_wait_queue() and list_del(wait_entry) type operations, and
>> still work with the optimized wakeup checking.
>>
>> Second one converts kyber to use it, fixing a hang with domain tokens.
> 
> With the two patches, can't reproduce the io hang issue any more when
> kyber is used.
> 
> Tested-by: Ming Lei <ming.lei@redhat.com>

Awesome, thanks for reporting and testing the patches!

-- 
Jens Axboe

