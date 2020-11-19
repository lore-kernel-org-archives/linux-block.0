Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4164FC56201
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D275A2468B
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 17:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VGMYR7GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgKSRUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 12:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgKSRUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 12:20:05 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03CFC0613CF
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 09:20:03 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id z14so6009580ilp.11
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Cuh0RTTSFAlmIPVhGB92scgG2gp7uIXGl6U8eaIkwws=;
        b=VGMYR7GIyigGqFMlURJN1OniF74reh1UdQXfBzrlKlnYeM+WRXlnHYCvAek+XLZl+j
         fnMW4SKO1FBIJPHj2Yi6SohZxhvFabSdCp+cz9YCH2FNIeSNV62dzclA+evfaJH2QBOs
         Or3W4G6dSf6MJ1czMoPcLasp5lrGvUJu9RH+cPxkDlBy4F/tLGo6R8vg1bhpk8h1xlPH
         IvcvRDOyW/1XkjXvhwz6Jdg17E9LYTylvdyqaf7yXdmNocIbZLtvoDsXU01T+/2RfZkY
         6xDKT6SF2aNEgX7rlD69MPQQakerXRxeaE3nPaaZ/WCkz12FdpPJxXHzisFXq1ATjZy+
         LFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cuh0RTTSFAlmIPVhGB92scgG2gp7uIXGl6U8eaIkwws=;
        b=rjT3NOdXq5sZRff9Z1yjeuRg5pewAxUreeWg+VVD3Q+7wpgwAtr0QQBl86lSrVFBY1
         iMjQzvVWFbE3t2UvuYqJK1mRLYK9qfXYFCHIgsIfuaSYiyC1ms4Nv75m8fS/2p9V2Jy1
         4PsrqkdwqSFdNLW05rEix2AwnNPRU0K9k//oMhFKGH69BHNIJfEdhdi1qeOpQbtlZHIO
         b2Mf5O3n1C6H3sLvCJx+mmh/sI1lkcXxGHioNJX1iUkbxjUVF1p+FEUftZQcG5nmRthw
         2+GO/GT/lDiPM2QN00L6Jm4I776jKRPfkBhNQBAG66LFeJhfw5cTmLIwUYJWQ+rFbXzM
         lzUg==
X-Gm-Message-State: AOAM533VrDCKkR4LObXNgqOnHJoKnEyaY9SSpsVm6f7iPLsFSGH2AW3k
        I3GzkGtnsA+vy7bcIVrmbwGrjg==
X-Google-Smtp-Source: ABdhPJxqW+pxzeKvGrbOkUbneyIPxMDLzPVQq32823a3f0cted9sUHxsKt6LdBhk+atDCT70aCQa4g==
X-Received: by 2002:a92:d143:: with SMTP id t3mr2340629ilg.35.1605806403250;
        Thu, 19 Nov 2020 09:20:03 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x5sm237863ilc.15.2020.11.19.09.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:20:02 -0800 (PST)
Subject: Re: [PATCH 0/2] optimise iov_iter
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <cover.1605799583.git.asml.silence@gmail.com>
 <2b50322d-821f-469e-6f57-072b54e25ef4@kernel.dk>
 <629cabf2-3a23-9d95-dd88-281ef4d49ddd@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72a1df1a-810b-5bf1-39bd-b702188a875b@kernel.dk>
Date:   Thu, 19 Nov 2020 10:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <629cabf2-3a23-9d95-dd88-281ef4d49ddd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/20 10:14 AM, Pavel Begunkov wrote:
> On 19/11/2020 16:46, Jens Axboe wrote:
>> On 11/19/20 8:29 AM, Pavel Begunkov wrote:
>>> The first patch optimises iov_iter_npages() for the bvec case, and the
>>> second helps code generation to kill unreachable code.
>>>
>>> Pavel Begunkov (2):
>>>   iov_iter: optimise iov_iter_npages for bvec
>>>   iov_iter: optimise iter type checking
>>>
>>>  include/linux/uio.h | 10 +++++-----
>>>  lib/iov_iter.c      | 10 +++++-----
>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> Nice! Tested this and confirmed both the better code generation,
>> and reduction in overhead in iov_iter_npages().
> 
> Thanks! Did you find t-put/etc. boost with your setup?

Yeah, for this kind of test, if we shave 1% off the stack overhead,
that directly yields an increase in peak IOPS. My numbers were close
to yours, dropped about 1% of system overhead.

-- 
Jens Axboe

