Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF09C46477
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C0820449
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rLvl6Cbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfFMQ3L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:29:11 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:35189 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbfFMIf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 04:35:27 -0400
Received: by mail-yw1-f43.google.com with SMTP id k128so8009952ywf.2
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E9Et9thIQKwcveyw5OArkt0ti7mIXwVLr/kLmzsdkuc=;
        b=rLvl6CbghlvG5MM7cpZKY4fnpuglneY+OyeiqcA2h9T2AQtB+ZCMA40qcUvl7QTklO
         0NO28FsKG+40kR+1rP/XWJhwcu7aX26UZvpMdkVKLoqqAzSPELOwczCyV87u9JYvmGC3
         Jzj4SsIXRym1WOEQySid/FsapUXbUht0R1G0bIwwu8xj8Svzn9IGuCSCgK5QsEpFuTCg
         fmQ8trV0NUouYl1H74oUBrxIube2J4gT0/tTMvhiW2/5VCzmnH5sjfuY7W+Ky0RITtbh
         PQJa15mSUAW0nzucBMJCFGtAfIO3D9uHPITb6G0cd/CXdJKSxfgvE/V2JnsWinQhFGIa
         Vi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9Et9thIQKwcveyw5OArkt0ti7mIXwVLr/kLmzsdkuc=;
        b=osRd2PMDrt9rUin1P5iec0mxx0OZq6Yo8738vhN1hQD1SuPuvwp+XN/3vpswYnDzaz
         qU0ANDWNb6VvVysOdxTZhp3xg1BmimNhLP7VCq7bgozAGKx2bH4rCOWuRYTMhnLjQBwQ
         ovoVYaVLJ8fVMNsYhsTDzPRose36yss2tmYdKgaWLYPXR2AA8U7rPz7+AINg4XxkjxuR
         JOv1T2vGADq2vs9gHz41yvdzf0ImFteio57zjzLnVO3K0ZjjeWnbQ5VOyO83nxllI5Xr
         nc/KSIrxeJbHon2Xhi3K/+yiwo0pZo/NxCOZ8RWht5p37sMFeDR22LJy4sq6h+Qeg6YO
         YA/w==
X-Gm-Message-State: APjAAAUJ4ht5I/zsIG2QxUEHa2OzLVK5G6mCnqkJgUtTXIaD4AsMaqLr
        Sjv4FO0/2ToWfhDG8slNctSXUsQJMP8hVg==
X-Google-Smtp-Source: APXvYqzKWYWZyYFEavhU0na+Eo++Q4WovsklPO+JjUhQ0ZLs+VXPJFQJCpYJAas0I4IpJB7Lb+j1hg==
X-Received: by 2002:a81:b2c3:: with SMTP id q186mr677722ywh.379.1560414926189;
        Thu, 13 Jun 2019 01:35:26 -0700 (PDT)
Received: from ?IPv6:2600:380:9e2c:9b66:893e:4845:326b:1174? ([2600:380:9e2c:9b66:893e:4845:326b:1174])
        by smtp.gmail.com with ESMTPSA id s8sm886073ywl.58.2019.06.13.01.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:35:25 -0700 (PDT)
Subject: Re: io_uring: buf_index and registered buffers
To:     Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <99E68FD7-430D-4D58-920F-8705D823A4F6@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4510f6eb-9165-f239-7770-65b1596a7e18@kernel.dk>
Date:   Thu, 13 Jun 2019 02:35:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <99E68FD7-430D-4D58-920F-8705D823A4F6@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/11/19 9:11 AM, Stephen  Bates wrote:
> Hi Jens and Team
> 
> While experimenting with io_uring and liburing I seem to have hit an
> issue with registered buffers. I can't see a way that either
> io_uring_register() or liburing can return the buffer indicies
> associated with registered buffers. In addition, there is no way to

Why would it need to return them? The indices are the index into the
array you passed in for registration.

> set sqe.buf_index via liburing right now when submitting an IO (it is
> memset to 0 in liburing.h). The end result is that io_uring IO start
> to fail when we do them from a set of registered buffers.

liburing is missing a lot of helpers right now, I'll happily take
patches to bring it closer to full feature parity.

> I'd be happy to work on a patch for this but could do with confirmation that this a problem and some guidance on a good approach to fixing this in both the system call and the user-space library.
> 
> BTW while liburing tests the creation of multiple registered buffers
> it never issues IO against them so that would be a hole I'd like to
> fill too.

Fio uses them, as does t/io_uring from fio. I've done lots of testing
with registered buffers, all the performance numbers done were with that
enabled (unless otherwise noted).

But yes, a test case is always a great idea!

-- 
Jens Axboe

