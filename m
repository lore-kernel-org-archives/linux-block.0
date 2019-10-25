Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46990CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE6C21929
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F+4Nk17K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395403AbfJYPcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:32:19 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43266 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395398AbfJYPcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 11:32:18 -0400
Received: by mail-io1-f42.google.com with SMTP id c11so2858669iom.10
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9SGhr83kGhgMvdo0bnTpUhl94AG5c9MOBhWi01H1Iug=;
        b=F+4Nk17KdT82i8j5y2iA+2wDLHVgdDsF5PCZ/vdSJhuRCz/ZUX5ixCLqiW5gGmqg3g
         R0uKgNv2nFd+eMtDoadUcSBjm+CVzqchlyKso1bTnpiw17lLOQyjFYX6t6hksl7y1hKM
         5pYyDOvRvcT4X26/pq6edwCh0UNQCCra+SqmY+yQym61QWEhAgWsLpM6heetTlv/cKk9
         KrPpP/p9XSyn5XGJv7K6edxVuqD7kQKx41BgouHmk43pRrcsLAJX7Ey6IYcDgbxYeRk1
         cHNZ8NWFDcNzxIDLZWuPRpka0bm8YilvouWZo3gQJTSimbN1tl6Jfjp4FN/guAtnEcuy
         RdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9SGhr83kGhgMvdo0bnTpUhl94AG5c9MOBhWi01H1Iug=;
        b=JEIcTRdShgZwVY1TX1xKDfgJJs81V3Ct9A7nCYllYRsPUOr/dMsbc749hRrv+3Ymwv
         gqnly6FXF1//DMK4cXh3cZ6Zz8Sdt8/B/OIeOUqRHtZ5vT4mwUmYlmsDjeXEFsIjQCpX
         zsjJ8MCZqdeqnDqkhHyqDwL86EcxfzyB4atu7dc/YcP0dnzXOeZoZPs9SJTLzyLv9ui0
         ufXIdfcNvmTz9xFL6acBu0Nk/waUV8QagVh54bGsN8uDl9GHPg+QbF/hliGp958yePE6
         NO+wppWdleXF345RgEpe48nxClMKYr4WC5IY3q2l5eO5KPUyaeGrclfsJALqsPnAZiDi
         QpRA==
X-Gm-Message-State: APjAAAWWkGHvN7uK3obCTJHZak8kk/1sNHcDVDUYFVXFTIeFk53+2a/0
        /bYK+pEuTBJenKymzO4pCtmydg==
X-Google-Smtp-Source: APXvYqwWN4xdDosFK6XsmDmPL6Ua8uL4QwxiANjl9J1p/mLV6gwtbsWK7zVFaY9idQhPOH1IpRi3yw==
X-Received: by 2002:a6b:e615:: with SMTP id g21mr4239446ioh.56.1572017536570;
        Fri, 25 Oct 2019 08:32:16 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s90sm392468ill.40.2019.10.25.08.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:32:15 -0700 (PDT)
Subject: Re: [BUG][RFC] Miscalculated inflight counter in io_uring
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bfecc5ba-274b-b2f7-52dc-8ac6e0fab352@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <539958bc-7010-c6dc-7647-b6632b37569c@kernel.dk>
Date:   Fri, 25 Oct 2019 09:32:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bfecc5ba-274b-b2f7-52dc-8ac6e0fab352@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 3:48 AM, Pavel Begunkov wrote:
> In case of IORING_SETUP_SQPOLL | IORING_SETUP_IOPOLL:
> 
> @inflight count returned by io_submit_sqes() is the number of entries
> picked up from a sqring including already completed/failed. And
> completed but not failed requests will be placed into @poll_list.
> 
> Then io_sq_thread() tries to poll @inflight events, even though failed
> won't appear in @poll_list. Thus, it will think that there are always
> something to poll (i.e. @inflight > 0)
> 
> There are several issues with this:
> 1. io_sq_thread won't ever sleep
> 2. io_sq_thread() may be left running and actively polling even after
> user process is destroyed
> 3. the same goes for mm_struct with all vmas of the user process
> TL;DR;
> awhile @inflight > 0, io_sq_thread won't put @cur_mm, so locking
> recycling of vmas used for rings' mapping, which hold refcount of
> io_uring's struct file. Thus, io_uring_release() won't be called, as
> well as kthread_{park,stop}(). That's all in case when the user process
> haven't unmapped rings.
> 
> 
> I'm not sure how to fix it better:
> 1. try to put failed into poll_list (grabbing mutex).
> 
> 2. test for zero-inflight case with comparing sq and cq. something like
> ```
> if (nr_polled == 0) {
> 	lock(comp_lock);
> 	if (cached_cq_head == cached_sq_tail)
> 		inflight = 0;
> 	unlock(comp_lock);
> }
> ```
> But that's adds extra spinlock locking in fast-path. And that's unsafe
> to use non-cached heads/tails, as it could be maliciously changed by
> userspace.
> 
> 3. Do some counting of failed (probably needs atomic or synchronisation)
> 
> 4. something else?

Can we just look at the completion count? Ala:

prev_tail = ctx->cached_cq_tail;
inflight += io_submit_sqes(ctx, to_submit, cur_mm != NULL,      
                                             mm_fault);
if (prev_tail != ctx->cached_cq_tail)
	inflight -= (ctx->cached_cq_tail - prev_tail);

or something like that.

-- 
Jens Axboe

