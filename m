Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35FC3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 01:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3197E233A0
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 01:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O1hRyMJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfHVBdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:33:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35586 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfHVBdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 21:33:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so2718545pfd.2
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7BOLFnYihrpQRqYXnNCtcQbPkLyOpzQDsrvAArnF1TM=;
        b=O1hRyMJl+ZzV2m4GG2LoBd93tgF+lqzcm1paFEtJONnvDNt/y75zJp3KpX1o/0a9wR
         ooE0LpewEH2EfygLzaOD7dWPEQdfpQBlLlTRY6k8qMz+My+RDu/88zfvZnU0pNj34jBf
         hqIJm2qiS17sOeahhe4zLiapycJUDqPzFqYT+aabEn1RAnqDcrN6K5BDI/tWXYC/9ODp
         8HlWWprlz/nw3cITb5WA4dKhwfByn8Y01EvsEUiLpT33l098U3ZYrD0bhD9z8NUFQDxb
         cNrNJq6u1rLTNya9t5ml0QPBuObRT+1AihtCouEXv75AJZsFtbu1RdNSa+ybNzCmcac2
         l5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BOLFnYihrpQRqYXnNCtcQbPkLyOpzQDsrvAArnF1TM=;
        b=YHexJYRdtZprHHMiRdiQDqxjRF/TVWdJtHQ0WsFGQIOq26GbGgSHO+CE3Xg+6GxHlr
         RrSx34N4yE9pYkrVxZWJXA7Gu2liyrcxEOu5/u8vhl7sqtz4qfvjUbALQNoE7PIMqI80
         JiM6aumUIRI5ZwF44n3AUR/MtMF6T/6FjDHnVSorMhzDfwaSYxhN5ZqfG3lGBAAS3uHS
         7mEiKBvkZx3+XCT4oupjaS1TNRXLfiAyDV8Ntn774oIaEcjMktqV/BWIsOwR9RQAAyzB
         jZXOWcUeGB0vxG1smGJX+o+8l7qd06KeIR5pD+sIyayuoIhoCvoEYfb7M5pRdXR1C6Jt
         6vAw==
X-Gm-Message-State: APjAAAUDQA7FYTtv0ZgU5ILAJKtku0J9WttHscfopxcCYqsUB0IM1cc6
        UU4DmfvHk9NQOxqyxj1mfGQ/ME2st1SIAQ==
X-Google-Smtp-Source: APXvYqxDt8T2j8QNXaVzUz2v3AILdQ1aAtm+ZJBpnZt3VWqZn4tf5TaEe3yR0U6SHpB6cZaihEDAYQ==
X-Received: by 2002:a62:c584:: with SMTP id j126mr38866622pfg.21.1566437624034;
        Wed, 21 Aug 2019 18:33:44 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id u3sm1075379pjn.5.2019.08.21.18.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 18:33:43 -0700 (PDT)
Subject: Re: soft lockup with io_uring
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2f87ee3f-d61f-e572-08f5-96a8ef8843b0@grimberg.me>
 <0ac352c8-851c-9976-118b-afb5839d6746@kernel.dk>
 <e14439c4-b59a-2aa0-6cf1-1ef54e70b14b@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04e8824f-15f8-eee3-4d9d-8d3fb021fd40@kernel.dk>
Date:   Wed, 21 Aug 2019 19:33:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e14439c4-b59a-2aa0-6cf1-1ef54e70b14b@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 7:18 PM, Sagi Grimberg wrote:
> 
>>> Hey,
>>>
>>> Just ran io-uring-bench on my VM to /dev/nullb0 and got the following
>>> soft lockup [1], the reproducer is as simple as:
>>>
>>> modprobe null_blk
>>> tools/io_uring/io_uring-bench /dev/nullb0
>>>
>>> It looks like io_iopoll_getevents() can hog the cpu, however I don't
>>> yet really know what is preventing it from quickly exceeding min and
>>> punting back...
>>>
>>> Adding this makes the problem go away:
>>> --
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 8b9dbf3b2298..aba03eee5c81 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -779,6 +779,7 @@ static int io_iopoll_getevents(struct io_ring_ctx
>>> *ctx, unsigned int *nr_events,
>>>                             return ret;
>>>                     if (!min || *nr_events >= min)
>>>                             return 0;
>>> +               cond_resched();
>>>             }
>>>
>>>             return 1;
>>> --
>>>
>>> But I do not know if this is the correct way to fix this, or what
>>> exactly is the issue, but thought I send it out given its so
>>> easy to reproduce.
>>
>> I wonder what your .config is, can you attach it?
> 
> Attached.
> 
>>
>> Also, please try my for-linus branch, it's got a few tweaks for how
>> we handle polling (and when we back off). Doesn't affect the inner
>> loop, so might not change anything for you.
> 
> This is your for-linus branch (or at least the one when I sent you
> the nvme pull request this week).
> 
> The head commit on fs/io_uring.c:
> 2fc7323f1c4b io_uring: fix potential hang with polled IO
> 
> I'm only missing:
> a3a0e43fd770 io_uring: don't enter poll loop if we have CQEs pending
> 
> But that does not indicate that it addresses such an issue.
> 
> I can still give it a shot if you think it can be resolved...
> 
>> If not, might be better to have a need_resched() terminator in there,
>> like we have in the outer loop.
> 
> I can easily modify that, would like to understand what is preventing
> the stop condition from happening though...

I'm guessing because we need to free that same CPU to process the
softirq that's actually completing them. null_blk is a bit special in
that regard. The key in your case is that you have voluntary preempt
set, so it'll never get to do that unless we yield on our own.

Can you try this?

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e7a43a354d91..c6a722996d8a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -778,7 +778,7 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 static int io_iopoll_getevents(struct io_ring_ctx *ctx, unsigned int *nr_events,
 				long min)
 {
-	while (!list_empty(&ctx->poll_list)) {
+	while (!list_empty(&ctx->poll_list) && !need_resched()) {
 		int ret;
 
 		ret = io_do_iopoll(ctx, nr_events, min);

-- 
Jens Axboe

