Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C783C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2CB206C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fpBc0bGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfC2OWf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:22:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39263 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfC2OWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:22:35 -0400
Received: by mail-it1-f194.google.com with SMTP id 139so4103498ita.4
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SOANC2vEzDaTyZQT2DfDGjTsWATCeRLViQe7HD4K+QE=;
        b=fpBc0bGfaF+vIaQ3dZ9Hx3YxH88s5NfPvpxjNs0hk6UQQv8oOl1pjWMYqMYlW4srbb
         loJPLp2WBAzjgAR3YCz0/qoMuqkpVwesZ9OuzO25sOuX67m2pjcrsd+S7CuzV1O6vOtc
         RxCRmLKXAtp1l92+DVe5WgblwzYRnoo59NkaSSVv1ZJLmW8HR/SXqS287PblSu/8Xp42
         vTfYjIac0f1wwtGdxPlCZyhWlYKHykm6VYRDr6nktC/xvZaTcBK0FcWgQUowUJxCx//q
         UOMn3o7fHkFPPVykk8aWl+Kvn/IxwHUu4NXAb4srkyzBy4ZQbDIl0b0B/WygXdKhXnHN
         fM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SOANC2vEzDaTyZQT2DfDGjTsWATCeRLViQe7HD4K+QE=;
        b=k5fJw8i6NTHXaYmOsV5jl38QUnxOuPen9SUurn7oAzExF4GSNUJEF8OfafNlHaqx/n
         0/veB4urx/Nhs9pplugj84dcqExmwz+aYVXhN6HwGxLM3YxgDtcVq75Lu1BcG4QQvm2w
         5mVZno+dlVgKgZ5QnI5CuwJOfBQ5hL+QtGP8U1OqugsgYcanK1tlmgMrMHSehGBP8bPU
         CMefDydsm3x6uSRsrcXlszhkamPV8UIT9PZuB3i0VjF1Nq4PMCpxMGh0HkJxSbz8kPHC
         dCofnYDDQr75197sVosY3gemqTzEM3CUmOfTiYXVgua7XVCicW9h0fnjEB0F6QO4/GkF
         25ug==
X-Gm-Message-State: APjAAAW9EcqDLaW1BEMakwVp+4BUa1W6GlaUB+9lJgs4IrJ7WcKBLpng
        RBgSElgRRLumy1eA7ZYJLWz9YUbEsSeJuw==
X-Google-Smtp-Source: APXvYqwZK7ODdwuLSHpQyLOR2bKFCdFOmtsu0sVv+lApjlA5vzSEtUzv7G3UlrUHfv8ZxNH7TLqjGg==
X-Received: by 2002:a24:1d0:: with SMTP id 199mr4084918itk.41.1553869353116;
        Fri, 29 Mar 2019 07:22:33 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e27sm912145ioc.14.2019.03.29.07.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:22:32 -0700 (PDT)
Subject: Re: [PATCH V3 00/10] block: enable multi-page bvec for passthrough IO
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190329070803.10958-1-ming.lei@redhat.com>
 <ca3a4d22-ec5a-4300-3ff2-08e0c02ed3dd@kernel.dk>
Message-ID: <782d69e3-d0f9-14ae-a57e-68d146be2f8f@kernel.dk>
Date:   Fri, 29 Mar 2019 08:22:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ca3a4d22-ec5a-4300-3ff2-08e0c02ed3dd@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 8:20 AM, Jens Axboe wrote:
> On 3/29/19 1:07 AM, Ming Lei wrote:
>> Hi,
>>
>> Now the whole IO stack is capable of handling multi-page bvec, and it has
>> been enabled in the normal FS IO path. However, it isn't done for
>> passthrough IO.
>>
>> Without enabling multi-bvec for passthough IO, we won't go ahead for
>> optimizing related IO paths, such as bvec merging, bio_add_pc_page
>> simplification.
>>
>> This patch enables multi-page bvec for passthrough IO. Turns out
>> bio_add_pc_page() is simpliefied a lot, especially the physical segment
>> number of passthrough bio is always same with bio.bi_vcnt. Also the
>> bvec merging inside bio is killed.
>>
>> blktests(block/029) is added for covering passthough IO path, and this
>> patchset does pass the new block/029 test.
>>
>> V3:
>> 	- fix build warning on patch 1 and 7, only the two patches are
>> 	  changed
> 
> Please just send me an incremental fix for those two patches, v2 has
> been in my tree for a while now. I can rebase it since I haven't pushed
> out, but doing so incrementally is a lot more convenient than replacing
> the entire series.

Actually, I can just replace those two, that's easy enough. Done.

-- 
Jens Axboe

