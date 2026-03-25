Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765A36E487
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469696; cv=none; b=s78vG2acmeexREOr9yvuB7YkrMsjhO//opMkFlcqiXosaXO2WxEsyXGKhhPNJHQIXT08HaE9rFg5eVO6fsht2avMFgIiPV7HEXFWjhvuXBsDuSGvqqyvkzFzj1KcA4z16cZKDECmM7o+rO1KEq7GtXwauArYQH+fgfhk4TyAtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469696; c=relaxed/simple;
	bh=TUGGsTUoaa7OmlTYcOqxOvlR6dQCgDcIlIzZN2FX1Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIjK/3QOsHQ7WG9RDdr8HzCDBNjFziTNWqaCYc7bhepF0VNn0RCfNpsxmDtwOkyhttnR5carCMSQycfA0JnMuW+aSqSQbIAq0+StjkwYnsAmQ4Hy5d6f0616LUs0uqOZXAisOUkNtaMbTxCYa7+pILKDYSmOg2X03zwi/P0Yq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BdLSkuLb; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BdLSkuLb"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40946982a78so119892fac.2
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774469693; x=1775074493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PlzBqe1IIMZnSLJe3Nt9W0mLjdauDVoWC1E+bHzQXs=;
        b=BdLSkuLbkvjvqo4SHXcM9hOSCpAQMP1s6LNcsPqujNgtRq77JmMpYUWmgXnm7UQim7
         OD40cvf+fJrO0J9FQyo+MUyncnrhVCXddAkvF7AceTQz8cqeghEu+HxonccduuJ4LRrV
         H9brCnPfzhJ8nRZ+OeOvsLegk8k3JwsaxW3WyJLhR0/mK2xIIqOvX7ZGUu227FxQkwRL
         lxc37GLfYG7StePtmm9rTSGHVlUEcX9WhaTCEmeLzS5hP0camnKeO+SmORIXb7s4WNBJ
         J7YR291hbfHCT1s2zoPH2lztTIGzFmt6noVFf7LZMzjfOdV3KwuepTrRKoUo7oLYZUz8
         JhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469693; x=1775074493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PlzBqe1IIMZnSLJe3Nt9W0mLjdauDVoWC1E+bHzQXs=;
        b=IFGFSwmuVPt0xcz8U7eILE62Vj9qUZ8GIMLqnuLkknGGSKiSlZI0z/22wCLXeSMZjU
         iFgNB+/uM56gLhOQMYFxASfjnSDs5evDRpo71pA/egW3ytV7+Il3X2JZTLAVp7PkTzdh
         dBBlwy/SWHhmGpacFPPM7IARmOcgt3o/+zMw/I5wujmO96AEZzBrNHHjgAY0b3uWBeP2
         QTl7qoVJ7r8FS5MP6p4Hq2oCwQif69GuzGbIr5wlCydVOSosJIbLE578BnxVn1iN7ZRE
         GnBamE2otKgCQi1c2JcAa0ekOLas/fcivupgXuapoNxx4lG9rN1ECc8A3BiJMxGqiary
         G3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUnyQd0iv9OEq4yxWj9oIqlS6bnx5zIGnN1GkP5umhKIL9rK5Q22us7hebQbMAOrHFV4V+mJztScum9Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTH2hDU4sU/YfsxdgZgN3EchlhQGtT0Jh+ObguoxmDwQ5I9NV8
	sWypsd+1iDuO2klaA3V60Eizo5rdWXFwLQmpKFxpvYcx+1Kcukq4R5UpVpqxsC012Y0=
X-Gm-Gg: ATEYQzzT/XszNPOx6jN7j+OWoAqsG2c7G4BJVD0bPpPiJPUVDOmQmS36ZzYTna+SQKS
	aAU9zr4fzjwZrrb1eAdIZF8tIYriSN/abJuL+cN08zyZdmqiaKG8v4u+TueyBQgaQQzAkeGDexk
	uZMtGzfvktmbqCFE3qBQlLT8Pfz7ZntI7Ymk2+3Z0pEWpEQ3Jp5MFYRZPT6r+Zwh/hL0hmneTE0
	sDf6L/2gC9XqPeyF/rYUO/51aXjYqc3KvsjYLbkLAMwa3WzrV6JaUy9dVdlvJQY6rdj+qZGwqem
	PyFCZsLgIfZh/y+Di9RBuYEYXGg5JZTX1Mm8YV4SNhvreWgfLJAnxZX951N3rrTw8+PvntDKBmt
	IhqjbcaBBRq5VDSbPlLZFO92N/mULGJ2hOuJwls4qQv65p5XJqPQNbJvwpEyoGDF+ayDbUFQxTv
	0DSlEI5PqoQ8WJYoE+6pWW4Cikrp2KYKkixamdwtQjMc1uGRAMWzM0sR02cfpnr6x44o9K5vo/1
	LNWU+Yu
X-Received: by 2002:a4a:edcd:0:b0:67b:be84:e085 with SMTP id 006d021491bc7-67dff50ad22mr2303872eaf.27.1774469693263;
        Wed, 25 Mar 2026 13:14:53 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab1b9e3sm535628eaf.12.2026.03.25.13.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 13:14:52 -0700 (PDT)
Message-ID: <c4453f4e-c1a2-4f5a-b278-76b63d5dc4a3@kernel.dk>
Date: Wed, 25 Mar 2026 14:14:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Tal Zussman <tz2294@columbia.edu>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 12:43 PM, Tal Zussman wrote:
> diff --git a/block/bio.c b/block/bio.c
> index 8203bb7455a9..69ee0d93041f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -18,6 +18,7 @@
>  #include <linux/highmem.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/xarray.h>
> +#include <linux/local_lock.h>
>  
>  #include <trace/events/block.h>
>  #include "blk.h"
> @@ -1714,6 +1715,60 @@ void bio_check_pages_dirty(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
>  
> +struct bio_complete_batch {
> +	local_lock_t lock;
> +	struct bio_list list;
> +	struct work_struct work;
> +};
> +
> +static DEFINE_PER_CPU(struct bio_complete_batch, bio_complete_batch) = {
> +	.lock = INIT_LOCAL_LOCK(lock),
> +};
> +
> +static void bio_complete_work_fn(struct work_struct *w)
> +{
> +	struct bio_complete_batch *batch;
> +	struct bio_list list;
> +
> +again:
> +	local_lock_irq(&bio_complete_batch.lock);
> +	batch = this_cpu_ptr(&bio_complete_batch);
> +	list = batch->list;
> +	bio_list_init(&batch->list);
> +	local_unlock_irq(&bio_complete_batch.lock);
> +
> +	while (!bio_list_empty(&list)) {
> +		struct bio *bio = bio_list_pop(&list);
> +		bio->bi_end_io(bio);
> +	}
> +
> +	local_lock_irq(&bio_complete_batch.lock);
> +	batch = this_cpu_ptr(&bio_complete_batch);
> +	if (!bio_list_empty(&batch->list)) {
> +		local_unlock_irq(&bio_complete_batch.lock);
> +
> +		if (!need_resched())
> +			goto again;
> +
> +		schedule_work_on(smp_processor_id(), &batch->work);
> +		return;
> +	}
> +	local_unlock_irq(&bio_complete_batch.lock);
> +}

bool looped = false;

do {
	if (looped && need_resched()) {
    		schedule_work_on(smp_processor_id(), &batch->work);
		break;
	}

	local_lock_irq(&bio_complete_batch.lock);
	batch = this_cpu_ptr(&bio_complete_batch);
	list = batch->list;
	bio_list_init(&batch->list);
	local_unlock_irq(&bio_complete_batch.lock);

	if (bio_list_empty(&list))
		break;

	do {
		struct bio *bio = bio_list_pop(&list);
		bio->bi_end_io(bio);
	} while (!bio_list_empty(&list));
	looped = true;
} while (1);

would be a lot easier to read, and avoid needing the list manipulation
included twice.

> +static void bio_queue_completion(struct bio *bio)
> +{
> +	struct bio_complete_batch *batch;
> +	unsigned long flags;
> +
> +	local_lock_irqsave(&bio_complete_batch.lock, flags);
> +	batch = this_cpu_ptr(&bio_complete_batch);
> +	bio_list_add(&batch->list, bio);
> +	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
> +
> +	schedule_work_on(smp_processor_id(), &batch->work);
> +}

Maybe do something ala:

static void bio_queue_completion(struct bio *bio)
{
	struct bio_complete_batch *batch;
	unsigned long flags;
	bool was_empty;

	local_lock_irqsave(&bio_complete_batch.lock, flags);
	batch = this_cpu_ptr(&bio_complete_batch);
	was_empty = bio_list_empty(&batch->list);
	bio_list_add(&batch->list, bio);
	local_unlock_irqrestore(&bio_complete_batch.lock, flags);

	if (was_empty)
		schedule_work_on(smp_processor_id(), &batch->work);
}

Outside of these mostly nits, I like this approach. It avoids my main
worry with this, which was contention on the list locks. And on the
io_uring side, we'll never hit the !in_task() path anyway, as the
completions are run from the task always. The bio flag makes sense for
this.

-- 
Jens Axboe
