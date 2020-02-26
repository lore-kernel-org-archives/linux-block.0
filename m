Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83415C4BA13
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A3B24680
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 14:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgBZO5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:57:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51038 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgBZO5X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 09:57:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so3431877wmb.0;
        Wed, 26 Feb 2020 06:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y5oMwPaakQ4byqYR1EE4YZx03bbdPGVSudGIZV+dLHM=;
        b=AXdSfiie2R/zADL+0qvNISUUG3duokeIBD9ti/vnrXJ9irbc/MJPCYXHElNdrZJu5H
         fPqznG6AmufCRREtVGDR97KQSE8v9srVAkc6m9KXPGJZvdl0DeHRMlkR02Io/f0pkNUh
         YXKRfvzRCwg2f/XvuwOy9kyRPmc9G5tIrK5ifC0cy1AfiHjp2MdRbsowSnl3LIjVCEG9
         yC8iWTfnTKTnH3zhnxzmfHoEVqGZQsXy6u6NJiFuFx+UCEZxol8sOuXddpv757cuHJt5
         J20A9E0PbDrOJYIwz+Zts0vCdZ+ewAWMCCNdKcGm3fglKDQIm7JeiERlxOf279r0sUMj
         tCXg==
X-Gm-Message-State: APjAAAXb9WAZkM9rUjqUaJTCVBvBLan5aPOe5V9ZXYvi1AjeV8xprtw0
        h1W5YuoZJvKeJ7RZk9Pv1h8J0ZFk
X-Google-Smtp-Source: APXvYqxAWVOsfJSDJcv6jgKy3HH0ktDpSqXxVRDr6s2OCKwHiZCKf0AegpwxqMLGRTtMvv7qgnzRGg==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr5984028wmc.103.1582729041485;
        Wed, 26 Feb 2020 06:57:21 -0800 (PST)
Received: from [10.10.2.174] (winnie.ispras.ru. [83.149.199.91])
        by smtp.gmail.com with ESMTPSA id w1sm3240417wmc.11.2020.02.26.06.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 06:57:20 -0800 (PST)
Reply-To: efremov@linux.com
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200224212352.8640-1-w@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
Date:   Wed, 26 Feb 2020 17:57:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/25/20 12:23 AM, Willy Tarreau wrote:
> As indicated in commit 2e90ca6 ("floppy: check FDC index for errors
> before assigning it") there are some surprising effects in the floppy
> driver due to some macros referencing global or local variables while
> at first glance being inoffensive.
> 
> This patchset aims at removing these macros and replacing all of their
> occurrences by the equivalent code. Most of the work was done under
> Coccinelle's assistance, and it was verified that the resulting binary
> code is exactly the same as the original one.
> 
> The aim is not to make the driver prettier, as Linus mentioned it's
> already not pretty. It only aims at making potential bugs more visible,
> given almost all latest changes to this driver were fixes for out-of-
> bounds and similar bugs.
> 
> As a side effect, some lines got longer, causing checkpatch to complain
> a bit, but I preferred to let it complain as I didn't want to break them
> apart as I'm already seeing the trap of going too far here.
> 
> The patches are broken by macro (or sets of macros when relevant) so
> that each of them remains reviewable.
> 
> I can possibly go a bit further in the cleanup but I haven't used
> floppies for a few years now and am not interested in doing too much
> on this driver by lack of use cases.

For patches 1-10.
[x] eye checked the changes
[x] bloat-o-meter and .s diff show no real changes
[x] tested that kernel builds after every patch
[x] floppy targeted fuzzing with kasan+ubsan reveals no *new* issues
    (required mainly to test the previous patch)

If Linus has no objections (regarding his review) I would prefer to
accept 1-10 patches rather to resend them again. They seems complete
to me as the first step.

I've placed the patches here:
https://github.com/evdenis/linux-floppy/commits/floppy-next

Thanks,
Denis
