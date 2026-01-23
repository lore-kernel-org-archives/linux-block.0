Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3532AAB7
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139232; cv=none; b=nQeEqlOxPcihu3h6nenmeMdO/Kq56yUklMAwsVTobt3in9KV2gAySnD16W7bpJzXehLkJ4+iAjXMuHtpNyY1b6n0iBtp7/zjv0CACUko0TFhY/sG7gVqOjTt0mnDkuQMfEedgiCh2blkWDa232PHTTEIv6+JXKDwatXJQCZ2IjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139232; c=relaxed/simple;
	bh=nQdfCDYJvcfIsPj6+hijnJsydGoPIuhyEkPoqerOMf0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TjX0lqCDWkwGd/m1af8dchR5WFzSb1LqE91GZ7sucf3U9yChK460MUBDZdA+fefc0EiG+pYPPBUU/8Etxx45FbuQrBbzSV98S2U9z84nffWCSwioVvXPcXNxiztMYVrZp8FERvAA8j76eNMz5yElioq1GrHFQJMSOMNFrqV3CVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H4+RQ+H4; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H4+RQ+H4"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7cfd10887d5so663979a34.1
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769139220; x=1769744020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRCKO43zBGo/syu1JZDnlgocs+7/bLyPqadUsvvtKZs=;
        b=H4+RQ+H4V/jFpzERy6rodc927rgHUG0umdnOniiP5+5P7L6VKL/t6tDGgLqkNZAR53
         njbggxOf+2prf4BUZD7Uk3Xj+X4AcoJ7TGGKOWXsIPG4Hb4PbyI3L55066eMdahzbT6r
         FaSyrdEh/vfPUT0TFs3j1ywq7INIY1yKVSGec8opT1d4Kvqk8YALT0toI8/uxY9tKGds
         WKcpgCHCFKIc1GCHANsPUcaTp3PDF4K7162OfzWgBNxbUphUqmeR2ZVx2pSdEmPP88Hn
         v4sdS/HzdpCzjOr5LyiPgFRUxUi7DOsMEyOBJK9rZNS1QGOSnUnLhE7KTstdX3hqz+T9
         lMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769139220; x=1769744020;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRCKO43zBGo/syu1JZDnlgocs+7/bLyPqadUsvvtKZs=;
        b=IXygIGelUw/bshl+VB/etz1xCqsCy432YzzLNgeVoZLBJMQXYM/ffGo3myaqKNW6rR
         CX1H/cmlzHzPKlWzbuIK8g9Yc6cqg6RD6PU6sEytJEHRpYAnX+g7eQpEJFAhYcbHAQKb
         QbA10qO+4kJGHNqcFjCuNjq0BkdLLLqTst2hCc+6eJ7bKTUcVOtDNILZgmaLZBDBmQVb
         +Bw4WzoaQwQmX7uCr1m8/P2wCxy5xsTBJdBg7cnVkvKm/Q95KECQtAhIfY0WpPY1eYNi
         dHOj8puvNWYIYjvhdZZJ+LLaOI8XX52bx28sVcoPgnc6cb3T9IO+Q55en3a4Wye6UV/S
         Dpww==
X-Gm-Message-State: AOJu0YyefCvxaQxw9WLayykPzajAsmzVMTqDWir/vDBGu4P4IEy2t6Br
	ePeQdQUTTiHGBsYJaAa/pzPqny2Xr6XQVbgW5nCeHzpAkT7/o54Usy8obI21kKjGS2NkftYLayZ
	9HwZW7Kc=
X-Gm-Gg: AZuq6aL01QbdzeWPFpGY2ma5hX2Q8OyCU+lCfS14AKS5wV54pCVvTI3yuNQWZDCn0gv
	JRBHvW7AsoDrBjSHq+gaGMGQw9e5hH1ZzII9sN4P2WXxf1CquaS6xTz4pq6g4LM6QfmZs0mAiKQ
	RVrKqOxa64NLsim86o6ozX9MQzisrDemysWyLC5Jd6HeDJvAOemUJv255ZsCRS5yk2a7sJf/AFn
	ZSaslCXk7rhHeXWig9KvvIAI+vaaVSemuOn5XKsu7c5Wm75/8I/yIbvwGQn4MEV+CDXkeHgSY7t
	O8Ztc7mY4tgSR8LetMVl0x4calQYywNwMnJplsUW2i+tQv04iS+NEpRR2nhnZYiQHmkafgi3vHp
	mGSKfIvriE2N050ty079uCpmzXyEOhsKRrSH/K9NaE7fD8G8wEByGOCqcxI70RklKgNi3oU8EBk
	mHRKBi/nZu3P1eFroi/sBrNtELX39WYvckI0eXK1L1wUTuDWR5qrMmM6zZkre6W8aWOxzEQw==
X-Received: by 2002:a05:6830:2a92:b0:7cf:d744:4e2 with SMTP id 46e09a7af769-7d15a64d160mr903565a34.35.1769139220208;
        Thu, 22 Jan 2026 19:33:40 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b3d3d00sm961775a34.24.2026.01.22.19.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 19:33:39 -0800 (PST)
Message-ID: <716ab266-d2fe-45ff-8ec5-10c4d9a1ebcc@kernel.dk>
Date: Thu, 22 Jan 2026 20:33:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V6 14/24] ublk: fix batch I/O recovery -ENODEV error
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
 <20260116141859.719929-15-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20260116141859.719929-15-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Claude says:

ublk: fix batch I/O recovery -ENODEV error

This commit changes the recovery flow to track per-queue readiness and
clear ubq->canceling when individual queues become ready, rather than
waiting for all queues. This fixes UBLK_U_IO_FETCH_IO_CMDS failing with
-ENODEV during batch I/O recovery.

> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e6e746cd369e..346596c1e319 100644

[ ... ]

> @@ -2791,37 +2797,52 @@ static void ublk_stop_dev(struct ublk_device *ub)
>  	ublk_cancel_dev(ub);
>  }
>
> -/* reset ublk io_uring queue & io flags */
> -static void ublk_reset_io_flags(struct ublk_device *ub)
> +/* reset per-queue io flags */
> +static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
>  {
> -	int i, j;
> +	int j;
>
> -	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> -
> -		/* UBLK_IO_FLAG_CANCELED can be cleared now */
> -		spin_lock(&ubq->cancel_lock);
> -		for (j = 0; j < ubq->q_depth; j++)
> -			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
> -		spin_unlock(&ubq->cancel_lock);
> -		ubq->fail_io = false;
> -	}
> -	mutex_lock(&ub->cancel_mutex);
> -	ublk_set_canceling(ub, false);
> -	mutex_unlock(&ub->cancel_mutex);
> +	/* UBLK_IO_FLAG_CANCELED can be cleared now */
> +	spin_lock(&ubq->cancel_lock);
> +	for (j = 0; j < ubq->q_depth; j++)
> +		ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
> +	spin_unlock(&ubq->cancel_lock);
> +	ubq->fail_io = false;
> +	ubq->canceling = false;
                         ^^^^

The comment on ublk_set_canceling() says "Do not set these flags directly"
and requires cancel_mutex to be held. Is it intentional to set
ubq->canceling directly here without the mutex? The old code used
ublk_set_canceling() with proper locking.

[ ... ]

> @@ -3411,7 +3432,14 @@ static int ublk_batch_unprep_io(struct ublk_queue *ubq,
>  {
>  	struct ublk_io *io = &ubq->ios[elem->tag];
>
> -	data->ub->nr_io_ready--;
> +	/*
> +	 * If queue was ready before this decrement, it won't be anymore,
> +	 * so we need to decrement the queue ready count too.
> +	 */
> +	if (ublk_queue_ready(ubq))
> +		data->ub->nr_queue_ready--;
> +	ubq->nr_io_ready--;
> +
>  	ublk_io_lock(io);
>  	io->flags = 0;
>  	ublk_io_unlock(io);

When ublk_batch_unprep_io() is used for rollback after a batch prep
failure, the counters are correctly decremented, but if the queue
became ready during prep (triggering ublk_queue_reset_io_flags() which
set ubq->canceling = false), the canceling flag is not restored.

Consider this scenario during recovery:
1. Batch prep command with tags 0,1,2,3 (valid) and tag 5 (invalid)
2. Tags 0-3 prep succeeds, queue becomes ready, canceling set to false
3. Tag 5 validation fails (tag >= q_depth)
4. Rollback via ublk_batch_revert_prep_cmd() calls ublk_batch_unprep_io()

After rollback: nr_io_ready=0, nr_queue_ready=0, but canceling=false.

With canceling incorrectly false, new requests in __ublk_queue_rq_common()
would not be aborted and could reach ublk_queue_cmd() which accesses
ubq->ios[tag].cmd - but the IO slots were cleared by rollback.

Should ublk_batch_unprep_io() restore ubq->canceling = true when the
queue transitions from ready to not-ready?

-- 
Jens Axboe

