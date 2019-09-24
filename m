Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7CBC432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26392146E
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSpg3aUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395106AbfIXLLh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:11:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54740 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395105AbfIXLLh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 07:11:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so1769255wmp.4;
        Tue, 24 Sep 2019 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5kyz+Vy8ZpFU8IYBPXklbJbx7c6ELiItFHhsEhOj8k=;
        b=NSpg3aUc/LcPbrv1alj9bsgKVXYWl6PblR19J2F4hxh49hQNdcnJtSA3spnKE+fm6g
         0Nw3N8LF8NtlAuJPz25YDva3XqUYbQlnsL5OwfFiN6UM8nczeWbhCmFznEgdXG71bPiL
         a5n1VI9Yd9c4LofCKf4Tg+b5FoXCbAjJ1QSEmJny93Ce75qD8rcmFpEkeXiLe9WPkX+m
         o6Q7gAVz2xX9mFpzcpYUqaYZ3OuF+bcpg+RFnMTZ5qQ+hL2LO3LX1RhYuAQ6rESsD/8x
         jKfYNvf8HowrVpSIrfZeihGTmYhCMwLoUq3puTClgKR/GSW9WXH9qnEN19K8GmO9UA57
         n54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V5kyz+Vy8ZpFU8IYBPXklbJbx7c6ELiItFHhsEhOj8k=;
        b=eor7ANYQKf24EjpRJmjhE0e3emGPibORCHIQ+V2twtSNMTuKvwUo8h5KbVb+cFLf9x
         JzO+qhYoUmRmY/xyKImFxzNRUGOCAeMGqD1uIEoLS6fd3e/KwbYjYx0tcmFUSLYiZc2W
         4r/lmXqbt1SY0LhGkG+lFP2Ol+shYmwxyA60lUzWjWtzVDZIFvDusg+UQMDGwsXW6ZV5
         jmpGCFKKstlsQPVlMQFK5VlVaTKi8qcsVeY+Dk9Q36rTLtB//vl7hQMNrTx9WHG74Fns
         d5BevHhzIDbUVhys7+p+d5MUNa7UPlkucC2mz/+Skl4wkYg4QEfD+l+y9ZjCMsgFeBtM
         LqbQ==
X-Gm-Message-State: APjAAAXUOUFhgCB0DnhHHd0Dq8q6BKZjzfSlabqCsmYRXfi1A63AdTHd
        RTJGBeiPnp/0jnXUG4yCktRbi7n0mUGB9g==
X-Google-Smtp-Source: APXvYqxNCmT8mlqnzJ5OuqXdCIEUVD4kP/xVsGdJQgS9VZc8GBomto3lmlGu+S7KgPVEoYnzS+lwig==
X-Received: by 2002:a1c:4846:: with SMTP id v67mr2222471wma.120.1569323493495;
        Tue, 24 Sep 2019 04:11:33 -0700 (PDT)
Received: from [192.168.1.75] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id w12sm2063086wrg.47.2019.09.24.04.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:11:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
Date:   Tue, 24 Sep 2019 14:11:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/09/2019 13:34, Jens Axboe wrote:
> On 9/24/19 4:13 AM, Jens Axboe wrote:
>> On 9/24/19 3:49 AM, Peter Zijlstra wrote:
>>> On Tue, Sep 24, 2019 at 10:36:28AM +0200, Jens Axboe wrote:
>>>
>>>> +struct io_wait_queue {
>>>> +	struct wait_queue_entry wq;
>>>> +	struct io_ring_ctx *ctx;
>>>> +	struct task_struct *task;
>>>
>>> wq.private is where the normal waitqueue stores the task pointer.
>>>
>>> (I'm going to rename that)
>>
>> If you do that, then we can just base the io_uring parts on that.
> 
> Just took a quick look at it, and ran into block/kyber-iosched.c that
> actually uses the private pointer for something that isn't a task
> struct...
> 

Let reuse autoremove_wake_function anyway. Changed a bit your patch:


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5c3f2bb81637..a77971290fdd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2690,6 +2690,38 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 	return submit;
 }
 
+struct io_wait_queue {
+	struct wait_queue_entry wq;
+	struct io_ring_ctx *ctx;
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
+	if (!io_should_wake(iowq))
+		return -1;
+
+	return autoremove_wake_function(curr, mode, wake_flags, key);
+}
+
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
@@ -2697,8 +2729,16 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
+	struct io_wait_queue iowq = {
+		.wq = {
+			.private = current,
+			.func	= io_wake_function,
+			.entry	= LIST_HEAD_INIT(iowq.wq.entry),
+		},
+		.ctx		= ctx,
+		.to_wait	= min_events,
+	};
 	struct io_rings *rings = ctx->rings;
-	unsigned nr_timeouts;
 	int ret;
 
 	if (io_cqring_events(rings) >= min_events)
@@ -2717,15 +2757,18 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
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
Yours sincerely,
Pavel Begunkov
