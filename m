Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DECC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 03:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA8220842
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 03:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hh1F5iew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfCDDXi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:23:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38940 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDDXi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Mar 2019 22:23:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so1933559pfo.6
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 19:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/kRRQiennps3hw4O4VbWEZeQ6J0kPsAvSB4di1NgTSI=;
        b=hh1F5iewKYp1pqJ4GcqZ3nf8xth3fKUrveM5HKEJr4bTZwrUdbo6nLupbcD+ApgLL5
         9V8D6t+QxpZKdC/FDOPcLFWDyLhhxeFpk+kzxQbJZw4zCCw0oBt4paO5/BFndAsCs363
         TR3SfJgFqgkxNssSiklz+k2C79wpOgjJRART7aI3IZgprb8opkvQ8ZGschq6LZOrO5o1
         43GWfRxSZIDvsZNZhulS4yorTn7AjWsVYansWsc3pZkeHfDXmJg60YgNgEGi+FKa6BKJ
         Ixeq3GshM/58MrxgZ5AETSCte8ZkBOWz9dk+Ib92KxWVqz83gKG0CmDFaxVh6gATIaeY
         uVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/kRRQiennps3hw4O4VbWEZeQ6J0kPsAvSB4di1NgTSI=;
        b=j4BUK3iz/z3kHRspYNMw5ogUzWrzxqaL0oce8e5gJEy1IrIluhA/FHCKrWeO05vMrL
         EG+T1OPHbkJyyse2dq4wBzRZTz2K4n2Ydjcnv3DvfHSHYPHCNP51SYum3cKXMAZeURFw
         ZGy598/BUp6ybn+iCLZgpLnqnANiQrDBmt/2rEgx1ZNANX6GIPEoeXciDwO7MAlYa5PZ
         GpwAGr0Pq48d38KfNxC4ze9QH1VJbUsjFApy8USDE6s5yg5QVXfHSflexE0DeVcomma0
         y0AN+f1rxzXOU1m7Cg4LMp5VzqJ5oMsPYqZ9nQXFupFTJGfzH/CWCeQIEK133abJFDks
         ViGw==
X-Gm-Message-State: APjAAAVKF4bnhNqm0SejEnpFnive+MGX9oLjue7OPbXztA7dJtUsT+5T
        qzc6Z0G0WTi5Sxhhf9dnobD7mTdp0iGwmn54
X-Google-Smtp-Source: APXvYqybeubpzV+rqZyqFgZVFidVEdaeJ1G6lfmceggdac8SODLNGRj7lrrxW+TKUztC5b4/RZqYPA==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2mr18293702pls.65.1551669817064;
        Sun, 03 Mar 2019 19:23:37 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v6sm6865011pgb.2.2019.03.03.19.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 19:23:35 -0800 (PST)
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
References: <f15aeeb9-e602-27bc-f230-ce52e59f6bb2@kernel.dk>
 <CAHk-=wgf6WfxnskG06zRGN=+6u5xyRdAb2GP0mT7J6f5xk+3MA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d04fb7d-f3f8-cf5b-fe10-d6eb8a59f5cf@kernel.dk>
Date:   Sun, 3 Mar 2019 20:23:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgf6WfxnskG06zRGN=+6u5xyRdAb2GP0mT7J6f5xk+3MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/19 7:34 PM, Linus Torvalds wrote:
> On Sun, Mar 3, 2019 at 5:53 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This pull request adds support for a new IO interface, io_uring.
>> io_uring allows an application to communicate with the kernel through
>> two rings, the submission queue (SQ) and completion queue (CQ) ring.
>> This allows for very efficient handling of IOs, see the v5 posting for
>> some basic numbers:
> 
> Having just looked at the bugs in fs/aio.c and not finding a lot of
> users of *that*, and absolutely zero actual test-cases, I'm actually
> less than thrilled to see a new interface with the same behavior.
> 
> So I would want to see some test programs that actually use this.
> Perhaps as part of tools/testing/?

I think there's a few things to take into account here. Nothing
(basically) uses fs/aio.c. Obviously that's true for io_uring as well
right now, but the hope is that that is NOT going to be true going
forward as it works for any type of IO, instead of being just O_DIRECT.

That said, there are test programs. As mentioned in the pull, there's a
fio IO engine that uses it. In the fio repo, there's also a standalone
test program, t/io_uring.c.

Outside of that, the liburing repo mentioned does have some actual test
cases, in the test/ directory. Some are unit tests, some are just random
test cases.

So it's not like there are NO test cases. Not a huge amount, but most of
them have been organically grown as bugs have shown up.

Now that you know there are some, how do you want to proceed? I can
write some more unit like tests and migrate the ones I do have to
tools/testing/?

-- 
Jens Axboe

