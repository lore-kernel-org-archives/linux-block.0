Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513444D5BF
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048070; cv=none; b=NDPt1EfLoRMBCI+IR+GrS6igiZBOGwWVxUARilMOBPqNTYZmH4OJPQPqY6pUXtOIn6AeTmAdNMnG8cwHzvgmBqM4JpWMkgJCQyGEeRVS/g12EuJ2npPcpKkUwt1KpWIz5GLAENCjLpprzAuUUkXhcStWZsTh8XZxg6LIVU+HyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048070; c=relaxed/simple;
	bh=hc1Po8Epl8QLTSAnFW/VHh4gDdNobReMgl7lYoAphcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y7udSTl+0kvqNZBbR7wgRveBXbqkdJav/ZehgjCO6MNS/cDPG1LALStAjno0hP2QraNOleynOt7VLz/Q0Cg4UBLqGuU7IZ+iFd1L3hrJ0t6qluP565D6bF6Wt95SeB8ByjEwANMAyRA0aQdeNL3HseIFKkx7DMkzMIEnE4tvu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SSzHRNVx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SSzHRNVx"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cf9e543562so399868a12.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 14:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706048068; x=1706652868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJBxxt3ypRyes1+Emb3kOT9WWT6BEwzwvnfoqAHrT8Y=;
        b=SSzHRNVxbFslrD1rBDQN4Wtk28RjaTovNUPYekqkzuR5rM/OuKGecKol6aH48Ss/8R
         2gCxvCOQFh4zEoee1yonDuP6Ai0NUDV716nCJ25BGRNaNRm+2RIT2zoJYyoqi5BFBC2z
         ic9OaKkb6lztS23WX23Nmk+ITyQTnRc45PsJ2XKEFmJUuPEobMyIGkmgofKP4IK927Zc
         QYHzxkb5hZ+EFvzaUEWYZ30pyUuSoGUiSEHQ8fI/9FbNg0MMqHGQpQpt7bR4DYOpmhAt
         szAk0yz2EHTwGnKHdnRMRiMZx7Nmt8Xv0JQ9G3KLhqZrHkJaFh3xScHD4nIHYKzGS6hk
         WvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706048068; x=1706652868;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJBxxt3ypRyes1+Emb3kOT9WWT6BEwzwvnfoqAHrT8Y=;
        b=MAVGxfJAGM197EGeoH0iL2GaI4dge2OjKBrgUzbUcGV+pUIEtmugmeq5qa4nJtWZ8h
         8euqpCJMq3hgkfJJx+UW9L3rxaFGitWhrwocDuHx83eV56TG6fl3HCM9cc4FdNta9Vcp
         l34VjJ8o9nGRDWmC1Ifub7TaK1op8Yb7QrBL0uKAw3jMtWmbg2DuP1JRZpEuosQjEY9v
         JpWKRzEwzbhYJRRWnR62tV2JigOoyt16Zu1QHfpHzKGiaE5uQlnQQzGYVTi1V3sX1yy4
         a1kW18NCIUUEBvPiYGET3upXjT4VH/CTUsYadMnNfDnglsTUsVjlLKovXRPMYucW5JW9
         5iRg==
X-Gm-Message-State: AOJu0YyAIc3xeq3X7vxBpdy+7rAaXjCLvbYQxQCntZA21VAQlifIWshT
	rrytyxB4U07CJHErocGiigZ6qE6Z+HQJkTkvK4LEoHnS+EX1lBMnjlWQMH8KkiNroqlRUfEUBqw
	Ex3s=
X-Google-Smtp-Source: AGHT+IFAKF2CvyfN7pgUKTMTism7+OWMVmCNk4YkSxp7sMuQPGtlFrtxs+fv+koE6RM8+bdt75CE6A==
X-Received: by 2002:a17:902:6547:b0:1d4:e308:cb0d with SMTP id d7-20020a170902654700b001d4e308cb0dmr646555pln.5.1706048068583;
        Tue, 23 Jan 2024 14:14:28 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z4-20020a170903018400b001d755bde001sm3619823plg.258.2024.01.23.14.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 14:14:27 -0800 (PST)
Message-ID: <c67b93f8-22c2-4ecd-b5e7-d7830c2f6aac@kernel.dk>
Date: Tue, 23 Jan 2024 15:14:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v3] mq-deadline and BFQ scalability improvements
Content-Language: en-US
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <2313676.ElGaqSPkdT@natalenko.name>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2313676.ElGaqSPkdT@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 1:03 PM, Oleksandr Natalenko wrote:
> Hello.
> 
> On ?ter? 23. ledna 2024 18:34:12 CET Jens Axboe wrote:
>> Hi,
>>
>> It's no secret that mq-deadline doesn't scale very well - it was
>> originally done as a proof-of-concept conversion from deadline, when the
>> blk-mq multiqueue layer was written. In the single queue world, the
>> queue lock protected the IO scheduler as well, and mq-deadline simply
>> adopted an internal dd->lock to fill the place of that.
>>
>> While mq-deadline works under blk-mq and doesn't suffer any scaling on
>> that side, as soon as request insertion or dispatch is done, we're
>> hitting the per-queue dd->lock quite intensely. On a basic test box
>> with 16 cores / 32 threads, running a number of IO intensive threads
>> on either null_blk (single hw queue) or nvme0n1 (many hw queues) shows
>> this quite easily:
>>
>> The test case looks like this:
>>
>> fio --bs=512 --group_reporting=1 --gtod_reduce=1 --invalidate=1 \
>> 	--ioengine=io_uring --norandommap --runtime=60 --rw=randread \
>> 	--thread --time_based=1 --buffered=0 --fixedbufs=1 --numjobs=32 \
>> 	--iodepth=4 --iodepth_batch_submit=4 --iodepth_batch_complete=4 \
>> 	--name=scaletest --filename=/dev/$DEV
>>
>> and is being run on a desktop 7950X box.
>>
>> which is 32 threads each doing 4 IOs, for a total queue depth of 128.
>>
>> Results before the patches:
>>
>> Device		IOPS	sys	contention	diff
>> ====================================================
>> null_blk	879K	89%	93.6%
>> nvme0n1		901K	86%	94.5%
>>
>> which looks pretty miserable, most of the time is spent contending on
>> the queue lock.
>>
>> This RFC patchset attempts to address that by:
>>
>> 1) Serializing dispatch of requests. If we fail dispatching, rely on
>>    the next completion to dispatch the next one. This could potentially
>>    reduce the overall depth achieved on the device side, however even
>>    for the heavily contended test I'm running here, no observable
>>    change is seen. This is patch 2.
>>
>> 2) Serialize request insertion, using internal per-cpu lists to
>>    temporarily store requests until insertion can proceed. This is
>>    patch 3.
>>
>> 3) Skip expensive merges if the queue is already contended. Reasonings
>>    provided in that patch, patch 4.
>>
>> With that in place, the same test case now does:
>>
>> Device		IOPS	sys	contention	diff
>> ====================================================
>> null_blk	2867K	11.1%	~6.0%		+226%
>> nvme0n1		3162K	 9.9%	~5.0%		+250%
>>
>> and while that doesn't completely eliminate the lock contention, it's
>> oodles better than what it was before. The throughput increase shows
>> that nicely, with more than a 200% improvement for both cases.
>>
>> Since the above is very high IOPS testing to show the scalability
>> limitations, I also ran this on a more normal drive on a Dell R7525 test
>> box. It doesn't change the performance there (around 66K IOPS), but
>> it does reduce the system time required to do the IO from 12.6% to
>> 10.7%, or about 20% less time spent in the kernel.
>>
>>  block/mq-deadline.c | 178 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 161 insertions(+), 17 deletions(-)
>>
>> Since v2:
>> 	- Update mq-deadline insertion locking optimization patch to
>> 	  use Bart's variant instead. This also drops the per-cpu
>> 	  buckets and hence resolves the need to potentially make
>> 	  the number of buckets dependent on the host.
>> 	- Use locking bitops
>> 	- Add similar series for BFQ, with good results as well
>> 	- Rebase on 6.8-rc1
>>
>>
>>
> 
> I'm running this for a couple of days with no issues, hence for the series:
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

That's great to know, thanks for testing!

-- 
Jens Axboe

