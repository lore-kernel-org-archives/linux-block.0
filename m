Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B433C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9C0218FD
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 19:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pBlTGqlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbeLTTQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:16:30 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:54770 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbeLTTQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 14:16:30 -0500
Received: by mail-it1-f172.google.com with SMTP id i145so3618394ita.4
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o3owhA37u8GwAoYak14feQ6RKXS/8ulXf7ce1q22BEA=;
        b=pBlTGqlvpdSErzsbWlL1zzJd/fSgpfqi9gEtko5B8Q2aGfhbeJfxCmvj8Jw7UQ9sHl
         EHPq3ycULjt7xVjGVFrsQhQIL5m04ah2Fb+86HvdBRRGt5cpKF1aqNLE4ToDe22kPEGK
         dgyHS/mtJG6LXXtYe8REAJZ3efRAcTDlTcUjjiESRI9okS6GUulELY0lZ1mkf8ylGgQ2
         XbQ/QGhsGCjNZxp8y24800UA01WstT6Jzmylr5EH23UGsJxr9Gidd9J2ZqFeB98op04B
         3tKnrQ44htpoeDdmcaIkHqgs1Zzv4z/B2vyChvrZ6f/tf/D5hFqvftdsm6qHL1dQzIwh
         bfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3owhA37u8GwAoYak14feQ6RKXS/8ulXf7ce1q22BEA=;
        b=lZdWn/alXg7bwTujVkX+eC3MONYSg8JSH1jry4mFEShNsmUMZ5cqOrNmVTglovDYuc
         DWKYgAWm7S3/63E7y38/wSc/rJ7Ldm8JVn/ncYPrqwTApxj6Et2DSkXevkAC19C+sP9X
         1oEx+KPsBPPAj8wBc9yF4VIWBnanFNZxZbMOvu0mLZ1/Tm9Mt7Q81knLLUqIrkgC1wRX
         qTsNqGjgLIuG3O8IL4SaUNr8jcls2Jz+uoJLa32+Zs+BaFCkamEeuH9vtxunvEuLhADY
         aO7gnEPnN5K56/dgJzq8gT+gVmwOOihxUp5NvtqsIumJKcAS8RmN2O4/VpzBoj+Dtd+J
         jgkw==
X-Gm-Message-State: AA+aEWYiSnhTcYAaflJCX+DMQagg4AIgggcJPU4xAYtLK+a3RbiVcvj2
        C+pPbHTNtApzkNGyh4wlDUM0Xj4e+03Qiw==
X-Google-Smtp-Source: AFSGD/WEsPixLrw6XjTCgPFGGOdy+PmBBweN3f4+PYGv28AXR2ulQBH/oAFB+5AjdHvyta75be9GfA==
X-Received: by 2002:a24:41aa:: with SMTP id b42mr10159674itd.148.1545333389263;
        Thu, 20 Dec 2018 11:16:29 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm11207925ioc.87.2018.12.20.11.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:16:28 -0800 (PST)
Subject: Re: [PATCHSET v2] Fix kyber hang
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
References: <20181220160149.4042-1-axboe@kernel.dk>
 <20181220191510.GD11852@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c6da816-f4d9-cb35-2dd4-76110e1f4bc1@kernel.dk>
Date:   Thu, 20 Dec 2018 12:16:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220191510.GD11852@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 12:15 PM, Omar Sandoval wrote:
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
> Lame, I should've caught this on the original patch. For the series:

Yeah, somewhat puzzled that it wasn't...

> Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks!

-- 
Jens Axboe

