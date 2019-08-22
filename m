Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF33C3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8CE206BA
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 00:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="csE+DoIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfHVAzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:55:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33187 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfHVAzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 20:55:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so2344793plb.0
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xsI4WbxizzqJOCpBaR8IMBY4PzPDkZ9jGIw4OXTlFVU=;
        b=csE+DoIeruuV00lLr59x9dyLe8dw845teqArlmE/Vav43TM8kZmvT50T3VhWV+GnUt
         D7cMxidvPWEzsCAzhCLzUuL7qNtJhFpqwCHvv5KQuSTAPEESacghODWV0kqCk97ga/JR
         yTywVTzmLTUFhy8pA+zAs0g5NcmyKuV68recQHAZcrh0Y2UZbEobfgcp/d/BNXBs6x3r
         Rv+oydJ79FKheApKC0RE6/kuquM9YFjnyRHfYOsjqPuOhhtsuvRklw5x3tNxurSzQGxg
         yA2NjR0yT3b8XZTMw3+m0fJduV8nDl9DSq54bgorOPXusIaCSScZ4jFaDIMS6QhSMUZm
         oYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xsI4WbxizzqJOCpBaR8IMBY4PzPDkZ9jGIw4OXTlFVU=;
        b=RKlzBJ8ErU8FDPZMGx8YLWj8/edvo+ZdWBXr3hvVxOXU49QeOPPOhbYsMjr22drS2S
         WACPbcfauP5evZ1GFp8JJrNsyxlhVwAjeIrCbrAN1hMrJoM/Bjzf+LJhA4SK9PAfhAWW
         4XBmhiTVKh2Vk8/2UximY71L6Mlg0jnz1bA2TIZTBXnBJtyMaZcGR04kX1phBS1p8CQ9
         4qOpNzckyUS1iZJY2zl/GScwLY11fkjaVxWAoFM+X7n4i39DD4RGMJuSXnOQDP8AH9GU
         0Xp+mLOPEb3c4dWJ8oS9IwQGxMOOmMdQbdMdnX9drpbyi2aRVvV8nPQpsda8cg6VrTgA
         +CRQ==
X-Gm-Message-State: APjAAAUggnRvp+u8QaOiSSqnPW1fDfcu3h2SmOSy/W63aY0rZ38QNgca
        mNbQhFh0S9zxo+n+HR4KL/ivCyfifN3r5A==
X-Google-Smtp-Source: APXvYqzVIIrdHbG77D8kAgKMjXAO6PI8F4iDYRGZ/nM9fFvjwqF0LREN5NvRgF80fIMwuHvdExW4Nw==
X-Received: by 2002:a17:902:e30f:: with SMTP id cg15mr37132567plb.46.1566435348521;
        Wed, 21 Aug 2019 17:55:48 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z24sm37338381pfr.51.2019.08.21.17.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 17:55:47 -0700 (PDT)
Subject: Re: soft lockup with io_uring
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2f87ee3f-d61f-e572-08f5-96a8ef8843b0@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ac352c8-851c-9976-118b-afb5839d6746@kernel.dk>
Date:   Wed, 21 Aug 2019 18:55:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f87ee3f-d61f-e572-08f5-96a8ef8843b0@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 4:48 PM, Sagi Grimberg wrote:
> Hey,
> 
> Just ran io-uring-bench on my VM to /dev/nullb0 and got the following
> soft lockup [1], the reproducer is as simple as:
> 
> modprobe null_blk
> tools/io_uring/io_uring-bench /dev/nullb0
> 
> It looks like io_iopoll_getevents() can hog the cpu, however I don't
> yet really know what is preventing it from quickly exceeding min and
> punting back...
> 
> Adding this makes the problem go away:
> --
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 8b9dbf3b2298..aba03eee5c81 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -779,6 +779,7 @@ static int io_iopoll_getevents(struct io_ring_ctx
> *ctx, unsigned int *nr_events,
>                           return ret;
>                   if (!min || *nr_events >= min)
>                           return 0;
> +               cond_resched();
>           }
> 
>           return 1;
> --
> 
> But I do not know if this is the correct way to fix this, or what
> exactly is the issue, but thought I send it out given its so
> easy to reproduce.

I wonder what your .config is, can you attach it?

Also, please try my for-linus branch, it's got a few tweaks for how
we handle polling (and when we back off). Doesn't affect the inner
loop, so might not change anything for you.

If not, might be better to have a need_resched() terminator in there,
like we have in the outer loop.

-- 
Jens Axboe

