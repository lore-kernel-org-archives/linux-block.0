Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E4DCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF4222C1
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E6fDekNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505623AbfJYQVp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:21:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35318 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505611AbfJYQVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:21:44 -0400
Received: by mail-io1-f66.google.com with SMTP id h9so3107303ioh.2
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UFlDIxxWEiQKjD97bCpDrofaOxgXD9c/cbkklhTNG5I=;
        b=E6fDekNsn+2S+2VigEqdWLAFsCUi68ijury0+BA9OY6vYrxKraMV0rgbWjLhsEJciW
         HCkuY8UrtM6u3iJXCSS+KJ12c/0T1c4k25U9zjvA5AmzBEnULtsnGe169bS35Sgv6rlI
         lYwr2mktC5XDYjxeB/wNmKUnC80Qa1SMhjB0Zg7SYeoDtoXzJfz/NQcyl52oHhiNlJIi
         xOSvCv6rkJ2KEmgdmBo4SG9aWNtcNbvMOpfYYS3NKC8YjQVE1ntCFgjRWQqXBashrY2I
         bbR0LOIPCBPHIg4mnpjhe1qiHoJYfIXRh+9ZlHUSN/08sekvU6BxZcD1q8Dk5tPeNFYb
         UGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UFlDIxxWEiQKjD97bCpDrofaOxgXD9c/cbkklhTNG5I=;
        b=XAsdPQhl3rUNfpmIrO+WTCt5G1K0INpu5UCQA3JV29Jh/qgUPzRjwPaGS/vFIvXmFU
         fHiXxjqk+7p4KAUig/dOZ0fes5dFBPxQiL4j1/KoLJP1JtdbqARbX6ZRxfKurhLayOWl
         +qGY6Ic4S7lEa+7WJCRnZg6p9YyYseR6TjxBN6Z4opr0uq3/6BSV416Ol9sGRrSWuQPt
         dLiNvvKNh59lg5Zd1TSWidJrXiCXBxvRSqs17p4djWTkUTasft5JAxi/aL4TxRjhDxvn
         wUL/uvKDgUEe3y2eDZKexKb6Lz9VhfFtTO8f5hyw2hOlbaa79DDgwj7yK9qI9QQR3qaz
         yioQ==
X-Gm-Message-State: APjAAAV684zvETB5IjJMYmPocx5/v3odwQ/cexnOyuQ9SpiJdbMKryRG
        /dTw9Iu6rPemkQS1dUlYbwSajQ==
X-Google-Smtp-Source: APXvYqz10MltTtSqSx4QROMbXjbQ7wypm+omuOXqs4neLjwMMnJQNN/i42cvbTVsNOM5q7zix/Mk8w==
X-Received: by 2002:a05:6602:2428:: with SMTP id g8mr4399690iob.246.1572020503873;
        Fri, 25 Oct 2019 09:21:43 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h18sm319303iog.52.2019.10.25.09.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:21:42 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <dfd21591-5187-0a8b-cc55-cfe5d57dd471@kernel.dk>
Message-ID: <1e2c5f16-dd06-d184-ce5b-3f3d4f76eec2@kernel.dk>
Date:   Fri, 25 Oct 2019 10:21:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dfd21591-5187-0a8b-cc55-cfe5d57dd471@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 10:09 AM, Jens Axboe wrote:
> On 10/25/19 10:03 AM, Jens Axboe wrote:
>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>> I found 2 problems with __io_sequence_defer().
>>>
>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>>> it can be maliciously changed.
>>>
>>> see sent liburing test (test/defer *_hung()), which left an unkillable
>>> process for me
>>
>> OK, how about the below. I'll split this in two, as it's really two
>> separate fixes.
> 
> Patch 1:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=9a9a21d9cf65cb621cce4052a4527868a80009ad
> 
> and patch 2:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=ed348662f74c4f63537b3c188585e39cdea22713
> 
> Let me know what you think, and if/when I can add your reviewed/test-by
> to them.

Updated patch 2 as per the other discussion, here it is:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=b6c2c446c0fca0318dec904821bd11f52d2445d3


-- 
Jens Axboe

