Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CB32D439
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710941; cv=none; b=aNCGWXgqWQ2C4lWCoqHAG/68d7gvTZPQZ6vEqFIDMBZdz4vP99l3FJ/lKmw8SmRMKLDob5jDtPcJx62E3Ujp7FrA0gxfLzFoPuRwWYV+bjyBG0MIkWz4MSetMXRfCMyTNpawItak5Ov4ScJ1xIS/6p+eNByBTb1glH8KXaz8UlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710941; c=relaxed/simple;
	bh=6YOiDJGD/xN647oeFLRihMwreWGKsEw4MO9xcq+Juho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG+nxOEz8rUtd9bzzBC1h/4M8MMfBO2AKss5Hfl9F3+YUY9fK3FtypuwcGrAeXM7UJIV5z3EQ/4G5v96qQ8t42xZMlhmMLxkP94ol4C+y+FTvKLoxg9DB5zeSqjvRI52eVB/apbxH5MdvDBA1Xg6RuY7tJN1xI65w2+rm54AMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWL7fmRr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWL7fmRr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae77516so11474805e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 06:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767710938; x=1768315738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxkFIY8qM1qxfl1HL58V0glbGXXY0jztZigsQiwZ12I=;
        b=FWL7fmRrwjfKdAIe5oYslIrym+s5QmaLtQljTsUvqDW6DstBKJo7NxqsGtwEDoyZLY
         le32rSrvbLBRQY0YITEeawJ7UleFQk4qVmft0egOTsrYuzS6zdyy/Ujwe9GU0UWoZ9Sy
         2p2R/nid6IQIDSXM9md4pNepC4RDU1vYmCv3qS4CUJztiLnlm7kXHB7R3XAvswB5cKB5
         KnCIg0II64VHrKezapXxSktOVmmdt6MmQTfVU9CKFlLaHTi9r20VbIvUrBwGV5cJ08Jg
         yLJzvsulBo5wsH83yILR/fZmRSeDySBGLOWn7w4JrnyPZl2mYNe40tuGrZXPIcAblhUK
         tJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767710938; x=1768315738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxkFIY8qM1qxfl1HL58V0glbGXXY0jztZigsQiwZ12I=;
        b=N/ZQ9yQMPWvcT9j3cUPz6kW9KBD2Nto7GHpIWoRLwPdoE4B82HuXokXhutW0u1kFqA
         2qL4cIRiwGBkGFd+deFMZLaUMTGuzsf/fLkf2sZwN/6baiMkoHEBS+cJyzVnChqMGq0n
         Hxqvf8WjNFBmw87fVu/aGF2LScsp6ov4z36EtiHLu5IwAmFfQ6vOmkZeZn0/NGiaatiM
         r+PObqcv9Uh5n9s0r8VX2kHSZAM12ZXjvCvXwiODGcbPj3ROm5YtrFlkC1/fqIGPsWgN
         hU1SIFQs7St0CU0RvlinJ3JwHpJpmrpQtAsr2GNOtilt2IDYUgx7yKBxQCNWqr0KhKxh
         D2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCURhd3MNJmGRBrwdaGY4Wlrwml8SAyOlfPbJOVmlujS91tyrIXH4kL9fcErJzSTKW+tcmgohz5nc3iDtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzau5VmAnT79Sx9ofVZxd1H2U+UTePy+SL0u0MxtJxoBxv0beAe
	uimJ/lKEfiUG/1wEbE7RiwPwQeF6TUOf5x5mV1E2AMtLbY4TlVBN2MPz
X-Gm-Gg: AY/fxX4N54uRbZGNjqn8u5q5hdslAJ5WhAiZ4jOp4yGBk9iEmsq72sxcSXgoP06AdnX
	SWsfxf24c2rbEp5OWzV+wv3mTMFixI0f7/7jDP/zQLyAfgH8lj5DCNNebbkNZCGtofXLgUukfra
	T95WzIaqiMOzuWzMcrwXNrVDYGnESDYUJvNCp0a8Qde6j2jlkx4gcW/8EQJjLrj0wDtT7CMl+Ud
	irXN/5o39aR46xEa8aGxTvZD5qIKR14GL4VMq+nZNQOz8MGQaOlg/1ReJpWNM1vROnq0rGMmnKU
	enJ2IMhMcV+4cMVpPHKIe9Af29+pMeCghJhvMMHcvBDY9FZPY3WRwZ+5+318qs/QVuNsXx9EfZ/
	u6x4skCu0cNWEKDllvJhnM9S23GGCgRffM9/XVdQpRS2xe3aDmBua6p8eRXaO74mdSpB8ZoWe4P
	24S+roJc8rqQqrcEcIlf+U7liIBM4eIH8errpMP5tD1K0k
X-Google-Smtp-Source: AGHT+IEj73RVY8eYlp2o73JgkLW4iMwOBRsV69LLVN84xy5evsMlhdmdNOmgoJ0bEI5q3eY0MF7NJw==
X-Received: by 2002:a05:600c:8b05:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-47d7f0a806bmr32999185e9.33.1767710937649;
        Tue, 06 Jan 2026 06:48:57 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:ca09:7000:33fc:5cce:3767:6b22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7fb3a912sm19743095e9.4.2026.01.06.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:48:56 -0800 (PST)
From: Ionut Nechita <djiony2011@gmail.com>
X-Google-Original-From: Ionut Nechita <ionut.nechita@windriver.com>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.lei@redhat.com,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when called from interrupt context
Date: Tue,  6 Jan 2026 16:40:21 +0200
Message-ID: <20260106144023.381884-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <6eb6abcf-26aa-473d-843e-428ae0f38203@acm.org>
References: <6eb6abcf-26aa-473d-843e-428ae0f38203@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bart,

Thank you for the thorough and insightful review. You've identified several critical issues with my submission that I need to address.

> 6.6.71 is pretty far away from Jens' for-next branch. Please use Jens'
> for-next branch for testing kernel patches intended for the upstream kernel.

You're absolutely right. I was testing on the stable Debian kernel (6.6.71-rt) which was where the issue was originally reported. I will now fetch and test on Jens' for-next branch and ensure the issue reproduces there before resubmitting.

> Where in the above call stack is the code that disables interrupts?

This was poorly worded on my part, and I apologize for the confusion. The issue is NOT "interrupt context" in the hardirq sense.

What's actually happening:
- **Context:** kworker thread (async SCSI device scan)
- **State:** Running with preemption disabled (atomic context, not hardirq)
- **Path:** Queue destruction during device probe error cleanup
- **Trigger:** On PREEMPT_RT, in_interrupt() returns true when preemption is disabled, even in process context

The WARN_ON in blk_mq_run_hw_queue() at line 2291 is:
  WARN_ON_ONCE(!async && in_interrupt());

On PREEMPT_RT, this check fires because:
1. blk_freeze_queue_start() calls blk_mq_run_hw_queues(q, false) ← async=false
2. This eventually calls blk_mq_run_hw_queue() with async=false
3. in_interrupt() returns true (because preempt_count indicates atomic state)
4. WARN_ON triggers

So it's not "interrupt context" - it's atomic context (preemption disabled) being detected by in_interrupt() on RT kernel.

> How is the above call stack related to the reported problem? The above
> call stack is about request queue allocation while the reported problem
> happens during request queue destruction.

You're absolutely correct, and I apologize for the confusion. I mistakenly included two different call stacks in my commit message:

1. **"scheduling while atomic" during blk_mq_realloc_hw_ctxs** - This was from queue allocation and is a DIFFERENT issue. It should NOT have been included.

2. **WARN_ON during blk_queue_start_drain** - This is the ACTUAL issue that my patch addresses (queue destruction path).

I will revise the commit message to remove the unrelated allocation stack trace and focus solely on the queue destruction path.

> I apologize for the confusion in my commit message. Should I:
> 1. Revise the commit message to accurately describe the blk_queue_start_drain() path?
> 2. Add details about the PREEMPT_RT context causing the atomic state?
>
> The answer to both questions is yes.

Understood. I will prepare v3->v5 with the following corrections:

1. **Test on Jens' for-next branch** - Fetch, reproduce, and validate the fix on the upstream development tree

2. **Accurate context description** - Replace "IRQ thread context" with "kworker context with preemption disabled (atomic context on RT)"

3. **Single, clear call stack** - Remove the confusing allocation stack trace, focus only on the destruction path:
   ```
   scsi_alloc_sdev (error path)
   → __scsi_remove_device
   → blk_mq_destroy_queue
   → blk_queue_start_drain
   → blk_freeze_queue_start
   → blk_mq_run_hw_queues(q, false)  ← Problem: async=false
   ```

4. **Explain PREEMPT_RT specifics** - Clearly describe why in_interrupt() returns true in atomic context on RT kernel, and how changing to async=true avoids the problem

5. **Accurate problem statement** - This is about avoiding synchronous queue runs in atomic context on RT, not about MSI-X IRQ thread contention (that was a misunderstanding on my part)

I'll respond again once I've validated on for-next and have a corrected v3->v5 ready.

Thank you again for the detailed feedback.

Best regards,
Ionut
--
2.52.0
