Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7468361DDD
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677912; cv=none; b=LrxBxfXop6EPlJzo/fRFx1u04f+8ilxokV0eAoQz/mAFdZPYXapTb2r4FzPKMrBYJGletsNgyWHM2bKT94OPUbHupDWaYMDkeRE+8RjWKMZlbK0SVMi/0cgqY0HDadsZTyjb27ttlkohjJyaHQ2OU4ACfymSkjhoNKIAbh4WShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677912; c=relaxed/simple;
	bh=VozKVFSNS/gs8NcxxeuKasgV5xRpmuKE3f5a5NANObc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN1+/6/ob21c1NPgKrnbknIFWZQ5PZUSr+28vpfgyPFsG6sq5PZRmSv/n0t5q2nT0RAXgA/LTTXouxdvemut/FmmFUkGSW+eNhDrJx+skK3RkgzA0/DizgvmMQZuUgmzkI4yfkTr76Cyu8utlHmUtP12zrC8aYkVF/jvnapR1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Q+yEQpBZ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Q+yEQpBZ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d1872504cbso136744a34.0
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775677910; x=1776282710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXmjLbQMnBqeQgGLuSxxqcM7IYKVin1hxCkiOdMcuyM=;
        b=Q+yEQpBZ/+AVOkNJvgio7qjowFdyPiWV4hMS5fyGz4B58/DfEvZLTw5yP5uP0L2tS6
         8tKm1C8nOqwTgYCvUOYLXCPoPtUtYOeApb4+uA80YecH4z2Pm/rHYpm9bTbvzwCHXXHp
         YxA0kA4MNr/rA6UrWeAVKo1ONz2sxZDDDT58MTzao8Mk4q1zFx9z6UtHGoF1+Yu4oUq/
         90mJxQbctxtZv8W5hSI9kPSGJg/Sde3fZTWw7XZdTNh3bjFzrV0sYur0uhUVy7T8z46G
         pODNiJ4wXd8W3SZxqm8MnEAIBaqOwNobxhAGg30VWbEDMZlACaJAOfoTzMYg/R9l9UHS
         LCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677910; x=1776282710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXmjLbQMnBqeQgGLuSxxqcM7IYKVin1hxCkiOdMcuyM=;
        b=VNV3rMMrP7c7j+YIWXqnVapJfvCdVccy8x6hH0gCK4PdYzAS1VpZ1ASFYSQlVXETs3
         6uPak6giYlFfPlodMCwb1e9vvLw6KwOvNn7ASrTvncqBHbi6U91HAjUH4GBqKaLGm7Hz
         MqwqHNdEPh83uoYGTRVvUvoMEXckxOMUOla2FDsfkmNLgUIyfi8UbuOfBlvnnzZEzosP
         bbU8IqHswR89zSJaz746huLhR1gRgmAMhtOz0oTwredzimWgT/8yDkOsjHy2skLZB3NC
         wU+m2a2scFcqbZTRiA0ufi3lwawtnTJVwPSKU/Zsn8dQOT0cop/BCoMl5R7a1B3c6qkF
         veoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwlgHEjJY6BTiUmTE3pqckDOq+aRi5DyJHVKe1Ey1CPLJA6UygEXB0Ji16ysahHfN3S23nCR4CBLxjiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJF2b1NDUiLTWrBZxIIVGazwlQhZOIfCiliIPNWLDzD7f383gH
	/7SU7cu/I3B2On+3Aew1f/6o0+rTwLF5j/yxHpMPjtF/GuU1OyjOoXHtS1gBgf6k+w8=
X-Gm-Gg: AeBDievarvZyVVP1mpgYAHxLASV2Ika+vSlO06q9Bd/OCq2AMikVbgB40/z+seaSShH
	kPGti7xBOXwBDLS3EFBET7n8ksPhHRTM9J4Ppkwr47mYy8pfZ8hNB+4JHER56tWK3nXFbnm10Od
	euD9qPOh0qeNwTASDc7DdSHEJFqHDoq3fLxoF4fYyw2ySMxFfER+0d9sgsxcLZp9//9eIVgXH99
	Tk3nBYn/vZ5hXh4SXdl6JyM8JljgfyJlosOQzX6nZzOQ2glpRpXrEnJjQQS1VGi8a2glHop+EmM
	Gs5mttntW/rltneGR9wwsfENPYPTU6c5GZXM6HIb87UAztwP+hG9iLp3LYmPVo1T6nWkhMUKjVk
	vhZY1YLtiEui07GRaepVXJDodr3XBjPTcKLCXMGYFljfz+LbWmRGAvDzGoKZel9ldun5H7DL9gV
	Pf0ecPthMIiVfX2d1yrUHFqebHrDSZPU3+lcIeCzZqhGwgPsKOWnRxHmHwc4Yq1QxRUh7Lv6hn8
	Gd4WuB7
X-Received: by 2002:a05:6830:4c97:b0:7db:bdd6:635a with SMTP id 46e09a7af769-7dc17728eeamr330070a34.9.1775677909639;
        Wed, 08 Apr 2026 12:51:49 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbfc1cb79esm3395778a34.15.2026.04.08.12.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:51:49 -0700 (PDT)
Message-ID: <699933c1-c150-4e10-a5fc-6f128260d0c1@kernel.dk>
Date: Wed, 8 Apr 2026 13:51:48 -0600
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
 <c4453f4e-c1a2-4f5a-b278-76b63d5dc4a3@kernel.dk>
 <01e6c582-fbab-40ec-97ac-02675e6a08ed@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <01e6c582-fbab-40ec-97ac-02675e6a08ed@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/26 12:48 PM, Tal Zussman wrote:
> On 3/25/26 4:14 PM, Jens Axboe wrote:
>> On 3/25/26 12:43 PM, Tal Zussman wrote:
>>> +static void bio_complete_work_fn(struct work_struct *w)
>>> +{
>>> +	struct bio_complete_batch *batch;
>>> +	struct bio_list list;
>>> +
>>> +again:
>>> +	local_lock_irq(&bio_complete_batch.lock);
>>> +	batch = this_cpu_ptr(&bio_complete_batch);
>>> +	list = batch->list;
>>> +	bio_list_init(&batch->list);
>>> +	local_unlock_irq(&bio_complete_batch.lock);
>>> +
>>> +	while (!bio_list_empty(&list)) {
>>> +		struct bio *bio = bio_list_pop(&list);
>>> +		bio->bi_end_io(bio);
>>> +	}
>>> +
>>> +	local_lock_irq(&bio_complete_batch.lock);
>>> +	batch = this_cpu_ptr(&bio_complete_batch);
>>> +	if (!bio_list_empty(&batch->list)) {
>>> +		local_unlock_irq(&bio_complete_batch.lock);
>>> +
>>> +		if (!need_resched())
>>> +			goto again;
>>> +
>>> +		schedule_work_on(smp_processor_id(), &batch->work);
>>> +		return;
>>> +	}
>>> +	local_unlock_irq(&bio_complete_batch.lock);
>>> +}
>>
>> bool looped = false;
>>
>> do {
>> 	if (looped && need_resched()) {
>>      		schedule_work_on(smp_processor_id(), &batch->work);
>> 		break;
>> 	}
>>
>> 	local_lock_irq(&bio_complete_batch.lock);
>> 	batch = this_cpu_ptr(&bio_complete_batch);
>> 	list = batch->list;
>> 	bio_list_init(&batch->list);
>> 	local_unlock_irq(&bio_complete_batch.lock);
>>
>> 	if (bio_list_empty(&list))
>> 		break;
>>
>> 	do {
>> 		struct bio *bio = bio_list_pop(&list);
>> 		bio->bi_end_io(bio);
>> 	} while (!bio_list_empty(&list));
>> 	looped = true;
>> } while (1);
>>
>> would be a lot easier to read, and avoid needing the list manipulation
>> included twice.
> 
> Yep, that looks cleaner. Although do we really need the looped variable?
> Can't we just move the need_resched() check right before the while (1)?

If you do that, then you'd also want to check if the list is empty. You
don't want to schedule_work() for a potentially empty list. Either way,
you need some check.

>>> +static void bio_queue_completion(struct bio *bio)
>>> +{
>>> +	struct bio_complete_batch *batch;
>>> +	unsigned long flags;
>>> +
>>> +	local_lock_irqsave(&bio_complete_batch.lock, flags);
>>> +	batch = this_cpu_ptr(&bio_complete_batch);
>>> +	bio_list_add(&batch->list, bio);
>>> +	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
>>> +
>>> +	schedule_work_on(smp_processor_id(), &batch->work);
>>> +}
>>
>> Maybe do something ala:
>>
>> static void bio_queue_completion(struct bio *bio)
>> {
>> 	struct bio_complete_batch *batch;
>> 	unsigned long flags;
>> 	bool was_empty;
>>
>> 	local_lock_irqsave(&bio_complete_batch.lock, flags);
>> 	batch = this_cpu_ptr(&bio_complete_batch);
>> 	was_empty = bio_list_empty(&batch->list);
>> 	bio_list_add(&batch->list, bio);
>> 	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
>>
>> 	if (was_empty)
>> 		schedule_work_on(smp_processor_id(), &batch->work);
>> }
> 
> Makes sense, will do!
> 
>> Outside of these mostly nits, I like this approach. It avoids my main
>> worry with this, which was contention on the list locks. And on the
>> io_uring side, we'll never hit the !in_task() path anyway, as the
>> completions are run from the task always. The bio flag makes sense for
>> this.
> 
> Thanks! I'm going to give Dave's llist suggestion a shot on top of
> this as it seems like it'll simplify this nicely. Looks like that'll
> involve turning bio::bi_next into a union with a struct llist_node.

Since these lists can get long, I'd keep an eye on llist reversal
overhead there...

-- 
Jens Axboe
