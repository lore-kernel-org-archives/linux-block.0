Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8786BC432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E50B21655
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="niFXDHG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439052AbfIXIgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:36:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42221 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440635AbfIXIgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 04:36:46 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so2393865iod.9
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MW39ZIJPkLCSSALoFZZ0RMcoDQFhuN46oWAYAG3QDA4=;
        b=niFXDHG/G/ebTXEg6ep4fLeucIL38EfUODDxS1+dE9fXEM25WG3owJflzmajxBOkVg
         a3B8R48JV9XKSL6dRyhWW8BYq1m7DjvobGjP3aE3W8tCV3HQq1QoKS4XHzuR9U/Pp77E
         mG3V+Iohxpmo4NY+AkCpOGX6RJGc3VsusoKNm2olaRX8o2oQ7twyccfsY1bMO7HDFy4d
         PNXK1How3mI4eG/b38J9BxzljuLxu0jC/OmIkP3vavMPZ55hvx14WMdmlDpXmYY3Mgme
         RCScxLjihXDHizjySRac77zgAz/hfz9Zfsq97EQr6kz6I6qY1PVOLz2kmyTlfgVYfLzF
         ddhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MW39ZIJPkLCSSALoFZZ0RMcoDQFhuN46oWAYAG3QDA4=;
        b=iuZ3UZL1qZz/NNTuXtoX+7ENY7SGt+pIldzcvibtLja+fyDPU/BN0FP/JaCVLmV6NE
         mtWUIDBVdGwH8E581C8+DkeOC2xt1R+G9zrJ6l291wVgVdsfyF0T8y+TnJHXSUAMZekP
         dYSfmMXmItC2Q1bBoyiP7waVXfQJsVWr9ZPlEa4zzwppCbyIWN0nvGaKqYHmaB1OcjK+
         5uqNEiuqwTDBhKHdrE9WijMt1DJG+EUqsEAHxBo3pYihPaGrWPktl9hEWO36ghOttAjS
         S8HyVgwh0QAhkZ1NVvjqXE150SMC3kTXD+jUy1fuu/ndN5TR6Kucv7fIcUkpWkOhBlSm
         v7zQ==
X-Gm-Message-State: APjAAAWNuzOS8aQ81E8I9HxHs7qSuN+lj3Y8/P0aDqpePcxNQpxeeOyK
        b45lXnVglyQz2iMJarWI14uefw==
X-Google-Smtp-Source: APXvYqyYWoTKod2624IdPCpraBMYTtHYtDYtaYFlyxK/jdO8fmJBht8vCc4phhMZI2vrrdOKDxzokg==
X-Received: by 2002:a6b:8e92:: with SMTP id q140mr2275210iod.205.1569314204092;
        Tue, 24 Sep 2019 01:36:44 -0700 (PDT)
Received: from [172.19.131.113] ([8.46.75.9])
        by smtp.gmail.com with ESMTPSA id c4sm909144ioa.70.2019.09.24.01.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 01:36:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
Message-ID: <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
Date:   Tue, 24 Sep 2019 10:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 2:27 AM, Jens Axboe wrote:
> On 9/24/19 2:02 AM, Jens Axboe wrote:
>> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>>> structure with a count in it, on the stack. Got some flight time
>>>>> coming up later today, let me try and cook up a patch.
>>>>
>>>> Totally untested, and sent out 5 min before departure... But something
>>>> like this.
>>> Hmm, reminds me my first version. Basically that's the same thing but
>>> with macroses inlined. I wanted to make it reusable and self-contained,
>>> though.
>>>
>>> If you don't think it could be useful in other places, sure, we could do
>>> something like that. Is that so?
>>
>> I totally agree it could be useful in other places. Maybe formalized and
>> used with wake_up_nr() instead of adding a new primitive? Haven't looked
>> into that, I may be talking nonsense.
>>
>> In any case, I did get a chance to test it and it works for me. Here's
>> the "finished" version, slightly cleaned up and with a comment added
>> for good measure.
> 
> Notes:
> 
> This version gets the ordering right, you need exclusive waits to get
> fifo ordering on the waitqueue.
> 
> Both versions (yours and mine) suffer from the problem of potentially
> waking too many. I don't think this is a real issue, as generally we
> don't do threaded access to the io_urings. But if you had the following
> tasks wait on the cqring:
> 
> [min_events = 32], [min_events = 8], [min_events = 8]
> 
> and we reach the io_cqring_events() == threshold, we'll wake all three.
> I don't see a good solution to this, so I suspect we just live with
> until proven an issue. Both versions are much better than what we have
> now.

Forgot an issue around signal handling, version below adds the
right check for that too.

Curious what your test case was for this?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index ca7570aca430..3fbab5692f14 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2768,6 +2768,42 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 	return submit;
 }
 
+struct io_wait_queue {
+	struct wait_queue_entry wq;
+	struct io_ring_ctx *ctx;
+	struct task_struct *task;
+	unsigned to_wait;
+	unsigned nr_timeouts;
+};
+
+static inline bool io_should_wake(struct io_wait_queue *iowq)
+{
+	struct io_ring_ctx *ctx = iowq->ctx;
+
+	/*
+	 * Wake up if we have enough events, or if a timeout occured since we
+	 * started waiting. For timeouts, we always want to return to userspace,
+	 * regardless of event count.
+	 */
+	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
+			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
+}
+
+static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
+			    int wake_flags, void *key)
+{
+	struct io_wait_queue *iowq = container_of(curr, struct io_wait_queue,
+							wq);
+
+	if (io_should_wake(iowq)) {
+		list_del_init(&curr->entry);
+		wake_up_process(iowq->task);
+		return 1;
+	}
+
+	return -1;
+}
+
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
@@ -2775,8 +2811,16 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
+	struct io_wait_queue iowq = {
+		.wq = {
+			.func	= io_wake_function,
+			.entry	= LIST_HEAD_INIT(iowq.wq.entry),
+		},
+		.task		= current,
+		.ctx		= ctx,
+		.to_wait	= min_events,
+	};
 	struct io_rings *rings = ctx->rings;
-	unsigned nr_timeouts;
 	int ret;
 
 	if (io_cqring_events(rings) >= min_events)
@@ -2795,15 +2839,18 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	nr_timeouts = atomic_read(&ctx->cq_timeouts);
-	/*
-	 * Return if we have enough events, or if a timeout occured since
-	 * we started waiting. For timeouts, we always want to return to
-	 * userspace.
-	 */
-	ret = wait_event_interruptible(ctx->wait,
-				io_cqring_events(rings) >= min_events ||
-				atomic_read(&ctx->cq_timeouts) != nr_timeouts);
+	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
+	prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
+	do {
+		if (io_should_wake(&iowq))
+			break;
+		schedule();
+		if (signal_pending(current))
+			break;
+		set_current_state(TASK_INTERRUPTIBLE);
+	} while (1);
+	finish_wait(&ctx->wait, &iowq.wq);
+
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;

-- 
Jens Axboe

