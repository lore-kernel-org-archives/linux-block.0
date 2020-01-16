Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ACFC33CB1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 16:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3BE2077C
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 16:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iZ2TkGbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAPQWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:22:20 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:32826 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPQWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 11:22:20 -0500
Received: by mail-il1-f195.google.com with SMTP id v15so18702921iln.0
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2020 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xtcVgdeEJ2UwrvDuDEEnV3rTW9ps6rdw5ehbLNlrYek=;
        b=iZ2TkGbR399pneTpcDu0Uqzmijo1HbDa0Pc/IJHraHwrc4HTpxl+D/zEJVR8H0y0fR
         I9QT8gHkj2q7vY3Bnv2NZMivoWyK1rAwoJhQrzgDqITPLxAGobsfxjIHMXVsfCJyutgg
         K/jQwpSLpsm5hfxcn68WsP/Z+L4uErDCwutZW56hYL0siVkC+yFV0hwKAI/l1AVLbzmJ
         nXZ6L+HsnNKC6/i0CoC6fwLTnqeXP4vnFBkVhYghcnoTXg/3qu0xY6RwzCNIYqrKKaky
         3XcRdHi07Bbsmz6SuomzVu8fBtkr5qxHUOyOHek/QwdcNARNXRdnhmwxdkznaDK/cPtl
         /BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtcVgdeEJ2UwrvDuDEEnV3rTW9ps6rdw5ehbLNlrYek=;
        b=LJ/C7pblcbvULaUKPDmdKmLRhFHUguQ0IxnCz9DPG/cMc3hN2EQnNlAemPD12x5I5R
         oc9unYUmG/ZPg3W1tjjt6NKr2bkUnSyyUwUYNvCUFnuyPbkbZvl8fZM9O2LHCnOzobbV
         b+8eLqs8rznkM+ZqYjN0BBuPpLuuJ6ak/lQbflG5iq9d4HPYiW33gknMCxf6KhjuBrZZ
         49yIxtKeFBl83C+JIt3JYhrCixFCJq1tqw0H8fCqb2EFaT6rctE2DWCnPv/MSp6JK6N0
         iWVHP8RF0oxfbZshlCEamnO99vK8XwRLAYr+s/19CsLTSUcJSb9CvRHrRxgD1SZ8vYP2
         m5/w==
X-Gm-Message-State: APjAAAWWfzB2S6c1RobVGiTmUAiR6Whf52nVRgE91sz1f9/miLQUCsxR
        Fbpvt6ZCukeFCDV9z9rUUK7Uz16ILKs=
X-Google-Smtp-Source: APXvYqxWOY3IH7XlaIjaX9Z9/WTjFMPb5/1gfMassiSOncTF60XTdajrG0E5ZLKcoJxblcArlEJ+Vg==
X-Received: by 2002:a92:1a0a:: with SMTP id a10mr4313670ila.295.1579191739229;
        Thu, 16 Jan 2020 08:22:19 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f5sm4022999ioj.18.2020.01.16.08.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:22:18 -0800 (PST)
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
From:   Jens Axboe <axboe@kernel.dk>
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
 <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
Message-ID: <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
Date:   Thu, 16 Jan 2020 09:22:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/20 9:42 PM, Jens Axboe wrote:
> On 1/15/20 9:34 PM, Jens Axboe wrote:
>> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>>> so acquire ctx->uring_lock beforehand similar to other instances of
>>> calling io_issue_sqe().
>>
>> Is the below not enough?
> 
> This should be better, we have two that set ->in_async, and only one
> doesn't hold the mutex.
> 
> If this works for you, can you resend patch 2 with that? Also add a:
> 
> Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")
> 
> to it as well. Thanks!

I tested and queued this up:

https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.5&id=11ba820bf163e224bf5dd44e545a66a44a5b1d7a

Please let me know if this works, it sits on top of the ->result patch you
sent in.

-- 
Jens Axboe

