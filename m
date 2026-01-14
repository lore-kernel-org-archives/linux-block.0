Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565330EF7F
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402740; cv=none; b=UQPKZgeQDsUmdGqIG6/tLekXqwlYvjuk+ZjGVnvCnrBOMk4Tr3J3FApOI3kXF5fcVezCJgzUXtM9bTjP84Ci0D6QJrvJoIsnuWXKAyp0s5Tss6Jaww9F02kWebtWQsGMJA2XNnOYo8qezM9plI5DJR/MnZF2h6+6/dpzxkcW3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402740; c=relaxed/simple;
	bh=ofdD7ioS/rsv4BnSxHf7n6U7Sg1L9SvaG8SWp//WoL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cu4iq+sKSPM4qP3zbLinjJHR6MwX0qKCXbQrSl357DJstdy5hYjnUYR7MHZmwJ6u4sLwFfZOTSFh8Wo+bWP5ZTw/uxP+VN0lk03849oPGP3EThuyvaGXs2TCZAFoyraaLasbyw8WWzO+ZjD5TYs59D/h/gjRJ/whDWIvFCk5Upk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YPDYxBV7; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YPDYxBV7"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40413188553so395508fac.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 06:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768402737; x=1769007537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rARcp9rAVxHTIyrwYXLTvRA34uRYUAawx/kEq8nC+XI=;
        b=YPDYxBV73/zkm5NI2WPsWSiT9ESFseSHFWmOMRHPlQnJMTcks/amsAX3cDsz7vULta
         cVNP5Y9PC+dMwylz0gzAK8mmBu3+hWzz8MhgSc5EDganlHFijDGe8zrnDS3Pd3672Jo4
         nuUnisZwZ+X8481OqvlzCYVrXyxdF3d367W/hrUSLv7ky1/FARKXfad3v2k//zR3A2hK
         owo2+PksyYFCOiK+h9k+XX3xRm7TmEexSBhZHS4T9U+WHfispgEiHWNtMdijIg0eCaSj
         hEsQFo0pE1853UlalBT1D6YGxZSgAOyZswElIQMmelK+BHGbrVkPpGujwlxa9XF1gxWI
         oIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402737; x=1769007537;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rARcp9rAVxHTIyrwYXLTvRA34uRYUAawx/kEq8nC+XI=;
        b=pSj4scewGyKcAqQAsBcr9HH9KE/LBhNgnWpsJvsqOdf0AiGM11IMCt587B+GY22uof
         UqfsswdlGtULKXZ0EMJ+kFng/EYCq61SXOIwBeIBuazzVLjbOlGx6EN+cNgAjxVK0kAh
         WVIqzDw/4bBbhBw50IhBGxR5IA1ZkTSMdOoHK5POKL7LHaBezN+8FR0UrfkQG8Yh8bAl
         w7U/UXkqWPfra94V3dz+7bnNybfY7lhCuPjWTuFe5s9irJZcK910dJlbB8kUslEN9WLl
         Iseys04krotIb/v25jkl2iC9GJHifSUajt2i1Jib1y08leJdYI7kPVKz0aQYJWq4tRG5
         dDyw==
X-Forwarded-Encrypted: i=1; AJvYcCXb8R8cJM1rOK8DizBcNBVcCvTX4tf4DMPQB2toMukdLubw/UHIRX4AY+aQN5NQ/i14LyTbtdPSNvQ5fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZH7+JgvdL/oKXH7Hus8rCqE0Ks4b4XGxt4B3j/lsKnuxTkhBQ
	ZS1henHJv9kp0O5lm0yC53amTcspoTO1phnIi+f8jl9JTm6dUrkvatT5QKWIE6R/knw=
X-Gm-Gg: AY/fxX6O2wcSzUd9YFh0+Qm1mTT7065tt66JVFWuo905VZht9ux8iQNY9pZpD1uMaRd
	MDXP98EHWJiidi94rhcAgLI4qrY6jwEjSR7O1gayEpLNymRwewWZQs3QFBWsPhjWtDiPXm9QaGn
	GyyZCXQqybCInovuUr9z8C3+yEH6vdVmk4GPLqDtw3TwE9zZm/yAixuVngBvnG4CuYEVgUGHetn
	NQqRqGbCJt0NstBd17q9AuruYBde7MRety85A0Akz8Abn4mdvLvnZQnZa+sW3g2fglRvF5oIprv
	v+UVBu2SxLVLv98iwjfRqf4urRdu9u8YTlUsPOM1nz3jHZQY4Ro73+zSHVShVKZiYCfAU+hrMGo
	0L9aAqtJpyYuApO7qROr4VQls3C1rpx5jgOUC7gjDh8RuvHkARzEs2+zSlpBLDwW5iVyFVEOk50
	c7SUeCFCY=
X-Received: by 2002:a05:6870:c0c3:b0:3f6:207d:1b74 with SMTP id 586e51a60fabf-40407013081mr2049833fac.25.1768402737047;
        Wed, 14 Jan 2026 06:58:57 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa507220csm16682142fac.11.2026.01.14.06.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 06:58:56 -0800 (PST)
Message-ID: <9ae067ba-d0b6-49ac-9e96-01d23348261f@kernel.dk>
Date: Wed, 14 Jan 2026 07:58:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: fengnanchang@gmail.com, linux-block <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
 <aWekEgznso6zkgdI@fedora> <78ff994b-26e8-4b35-a83f-15bb61865e87@kernel.dk>
Content-Language: en-US
In-Reply-To: <78ff994b-26e8-4b35-a83f-15bb61865e87@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 7:43 AM, Jens Axboe wrote:
> On 1/14/26 7:11 AM, Ming Lei wrote:
>> On Wed, Jan 14, 2026 at 01:58:03PM +0800, Yi Zhang wrote:
>>> On Thu, Jan 8, 2026 at 2:39?PM Yi Zhang <yi.zhang@redhat.com> wrote:
>>>>
>>>> On Thu, Jan 8, 2026 at 12:48?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 1/7/26 9:39 AM, Yi Zhang wrote:
>>>>>> Hi
>>>>>> The following issue[2] was triggered by blktests nvme/059 and it's
>>>>>
>>>>> nvme/049 presumably?
>>>>>
>>>> Yes.
>>>>
>>>>>> 100% reproduced with commit[1]. Please help check it and let me know
>>>>>> if you need any info/test for it.
>>>>>> Seems it's one regression, I will try to test with the latest
>>>>>> linux-block/for-next and also bisect it tomorrow.
>>>>>
>>>>> Doesn't reproduce for me on the current tree, but nothing since:
>>>>>
>>>>>> commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
>>>>>> Merge: 29cefd61e0c6 fcf463b92a08
>>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>>> Date:   Tue Jan 6 05:48:07 2026 -0700
>>>>>>
>>>>>>     Merge branch 'for-7.0/blk-pvec' into for-next
>>>>>
>>>>> should have impacted that. So please do bisect.
>>>>
>>>> Hi Jens
>>>> The issue seems was introduced from below commit.
>>>> and the issue cannot be reproduced after reverting this commit.
>>>
>>> The issue still can be reproduced on the latest linux-block/for-next
>>
>> Hi Yi,
>>
>> Can you try the following patch?
>>
>>
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index a9c097dacad6..7b0e62b8322b 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -425,14 +425,23 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>>  	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
>>  
>>  	/*
>> -	 * IOPOLL could potentially complete this request directly, but
>> -	 * if multiple rings are polling on the same queue, then it's possible
>> -	 * for one ring to find completions for another ring. Punting the
>> -	 * completion via task_work will always direct it to the right
>> -	 * location, rather than potentially complete requests for ringA
>> -	 * under iopoll invocations from ringB.
>> +	 * For IOPOLL, complete the request inline. The request's io_kiocb
>> +	 * uses a union for io_task_work and iopoll_node, so scheduling
>> +	 * task_work would corrupt the iopoll_list while the request is
>> +	 * still on it. io_uring_cmd_done() handles IOPOLL by setting
>> +	 * iopoll_completed rather than scheduling task_work.
>> +	 *
>> +	 * For non-IOPOLL, complete via task_work to ensure we run in the
>> +	 * submitter's context and handling multiple rings is safe.
>>  	 */
>> -	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
>> +	if (blk_rq_is_poll(req)) {
>> +		if (pdu->bio)
>> +			blk_rq_unmap_user(pdu->bio);
>> +		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
>> +	} else {
>> +		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
>> +	}
>> +
>>  	return RQ_END_IO_FREE;
>>  }
>>  
> 
> Ah yes that should fix it, the task_work addition will conflict with
> the list addition. Don't think it's safe though, which is why I made
> them all use task_work previously. Let me fix it in the IOPOLL patch
> instead.

This should be better:

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index dd084a55bed8..1fa8d829cbac 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -719,13 +719,10 @@ struct io_kiocb {
 	atomic_t			refs;
 	bool				cancel_seq_set;
 
-	/*
-	 * IOPOLL doesn't use task_work, so use the ->iopoll_node list
-	 * entry to manage pending iopoll requests.
-	 */
 	union {
 		struct io_task_work	io_task_work;
-		struct list_head	iopoll_node;
+		/* For IOPOLL setup queues, with hybrid polling */
+		u64                     iopoll_start;
 	};
 
 	union {
@@ -734,8 +731,8 @@ struct io_kiocb {
 		 * poll
 		 */
 		struct hlist_node	hash_node;
-		/* For IOPOLL setup queues, with hybrid polling */
-		u64                     iopoll_start;
+		/* IOPOLL completion handling */
+		struct list_head	iopoll_node;
 		/* for private io_kiocb freeing */
 		struct rcu_head		rcu_head;
 	};

-- 
Jens Axboe
