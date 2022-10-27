Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A013AFA373D
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 23:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiJ0XzX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 19:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiJ0XzV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 19:55:21 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9610348CA9
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 16:55:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h2so3301607pgp.4
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 16:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57Ulewj9d98RBZz2AYPNwPFe+XAi6bXTa5vtei3dQvo=;
        b=6RMNxacpVaXW2EDu9wkQ3UwiCmby+a3pXw/7jP+sQ319y15sUcGC0fs01IBk7enkGk
         YIFFEHr3V73p5MgMLECtJvFm4Soyf4Bsd6Vu5I5UcNLr3Q1vUiYGC1bJ8QDHHfdhnW1t
         g//NqSteZjVxqud9tUlxc08hDaUXwcs/Qpu46t5fP5lGDlDCU+nNSVw0dhgUtFDAln4g
         A28tTJHdslfRWDK9my4Bm52DUj9LGnh0ZeLsOlXY8Ykv4WU6WMOyPsYoNocOu9oVnEwY
         igM1zQtOc53K4wMZlo/whfRLzL7csXFqeO2ak/4tIA4sJaNtCjXFecT+RI+P0Pa1YQxY
         sGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57Ulewj9d98RBZz2AYPNwPFe+XAi6bXTa5vtei3dQvo=;
        b=JyUYSTi8suhGuZz2Fl1Mm6nCgreV9fDB0A52q2/X/02iCh/+FkUFJY3pTqTvdjfLku
         Gv6ObZ/8TNKPQ90szf5Dtk41mj1tUX6E1z+wcHUfict0h2JBAJRJRwH341gNuSbkcgNZ
         Ulym8BghlyCtdPjtD/hgNNEt+2IO9o6Bz66/7RiC5scBmVeewG2GHqq7454fIOnQ6zH1
         n9qo3u7F0mJWlvwGE5vmOBiBk3SM2Yfs9eP1Vw8tYoaXtFBd8O+cUp07T6NwEOO2pd24
         59QmEMXoF4b5Jh4a4P2ylR+neebfe6roAgH54rEyhHxPrNl2wvwOyjst9xAwUwaxQ7yn
         B5Nw==
X-Gm-Message-State: ACrzQf1sNnEv4SOG4vmpJxmmsSJZtZ/gxjhCT+K5AFPXhmb8eZ7aGXzr
        NopifwuIP9imNMXA4FCvPW/AOjPTfQab4ABt
X-Google-Smtp-Source: AMsMyM7MwzXJxLxAhXWfPK4B2sxVr6j3vKoW+mSUKg686GOODgG/qji9Xwu7FaxACAbjFdynO+kg/Q==
X-Received: by 2002:a05:6a00:218d:b0:569:84e0:19e5 with SMTP id h13-20020a056a00218d00b0056984e019e5mr39877777pfi.11.1666914919053;
        Thu, 27 Oct 2022 16:55:19 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a818500b0020d9ac33fbbsm1513919pjn.17.2022.10.27.16.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 16:55:18 -0700 (PDT)
Message-ID: <13b597a1-b955-ba52-aa1b-174d789a5d7b@kernel.dk>
Date:   Thu, 27 Oct 2022 17:55:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH for-6.1 0/2] iopoll bio pcpu cache fix
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
References: <cover.1666886282.git.asml.silence@gmail.com>
 <983a4fda-5e42-3a26-81f6-65e8cd343f8e@kernel.dk>
In-Reply-To: <983a4fda-5e42-3a26-81f6-65e8cd343f8e@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 5:27 PM, Jens Axboe wrote:
> On 10/27/22 4:14 PM, Pavel Begunkov wrote:
>> There are ways to deprive bioset mempool of requests using pcpu caches
>> and never return them back, which breaks forward progress guarantees bioset
>> tried to provide. Fix it.
>>
>> Pavel Begunkov (2):
>>   mempool: introduce mempool_is_saturated
>>   bio: don't rob bios from starving bioset
>>
>>  block/bio.c             | 2 ++
>>  include/linux/mempool.h | 5 +++++
>>  2 files changed, 7 insertions(+)
>>
> 
> This isn't really a concern for 6.1 and earlier, because the caching is
> just for polled IO. Polled IO will not be grabbing any of the reserved
> inflight units on the mempool side, which is what guarantees the forward
> progress.
> 
> It'll be a concern for the 6.2 irq based general caching, so it would
> need to be handled there. So perhaps this can be a pre-series for a
> reposting of that patchset.

Just a followup, since we had some out-of-band discussion. This is
a potential concern on the bio side, though not on the request side.
But this approach is racy, we'll figure something else out.

-- 
Jens Axboe


