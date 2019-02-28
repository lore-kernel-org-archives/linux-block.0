Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830FDC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A310218D3
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RYoItzJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfB1VGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:06:20 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:39520 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfB1VGU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:06:20 -0500
Received: by mail-io1-f52.google.com with SMTP id x3so17803518ior.6
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=As9MHN3S0CXB+/6llIFxzGeXsdXZhyb/nrwdfM4pyiI=;
        b=RYoItzJjL/azkC0fkDUJAc0VAP3GM+oZp97BPsslJ9Oi3tQjvYnPK5wU2BKbax5Yaq
         Ctq0N8SdVYsqRyvJh5hL2RHbjyxDPU3yslvqqqzdP/Vd8q9NXsQhu952mK5gok2YV2a3
         7tmEfq6fwiOMGVZgZZPzYDGpi9oA30C129mBP6BOZGW+2jL6yLWaO4I5DEFjeGX+RJe6
         ZweyEefJpj8rY4Z9/ACVUT3hnlgbb9ZtwVRk+48I4oS4qoIdFLom4IVAODBxBwVyGvrV
         0EIjpZ7wQBRsdmEWNgFdvtmZ+SdHAQgR5dQ7kqdok8DHuZZbSuQk3oLoOWfdJs/ZM9qp
         4gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=As9MHN3S0CXB+/6llIFxzGeXsdXZhyb/nrwdfM4pyiI=;
        b=U1tlrP9FfUpuIDSOFlSyCo8/Y2GvG7jfhaiUedTYQquKBU8NjLFgjq0zX1V2ZsDiBX
         WwzAYJv9uT7rxxYJPZjkBRUilje8FimBLJbgUypW6bXNpW6A6+W6emUQ2tmtmxQOW3rQ
         aIvQjwZcUPrImnmvmBu13v1cm3NVFM1eg7B8uz819zMxjR+ysYsnql3fRG3POfZsk2Fq
         /4GDlrSV2mDWkTJ1+o/09HNWVgyEYccsC882Wm0EL4uFs5afm78hF1U+d0Gmu/kGFyP/
         PIqb/ofdpnOvAyJ/w34QKuTPZhvjoqbqvyDrU5Io4UhvMBDCbqNLDj0DG9/VbnqxGmOS
         vdFQ==
X-Gm-Message-State: APjAAAXn/F9ZGgl1KfAjX3PrQiaT5j2+1Dt9HzZD3eRL0pOW1Z9wsJ9t
        i2thaHnQn9S19KQIyyoBnJ+qVw==
X-Google-Smtp-Source: APXvYqzz8JV5koe9viHkrUdzJzQ3o4l4ggZBWfVEjQgFOynP4R87t24/K+6HrsnQIIQoRZ9arKDHmQ==
X-Received: by 2002:a6b:fa11:: with SMTP id p17mr873993ioh.185.1551387979409;
        Thu, 28 Feb 2019 13:06:19 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u10sm3256209ita.24.2019.02.28.13.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:06:18 -0800 (PST)
Subject: Re: [PATCH -next] floppy: remove set but not used variable 'q'
To:     YueHaibing <yuehaibing@huawei.com>, Jiri Kosina <jikos@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190218084232.193878-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a230eac-bea4-c771-5126-03f711f3e8a6@kernel.dk>
Date:   Thu, 28 Feb 2019 14:06:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218084232.193878-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/18/19 1:42 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/block/floppy.c: In function 'request_done':
> drivers/block/floppy.c:2233:24: warning:
>  variable 'q' set but not used [-Wunused-but-set-variable]
> 
> It's never used and can be removed.

Applied, thanks.

-- 
Jens Axboe

