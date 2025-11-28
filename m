Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F6261B70
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346783; cv=none; b=ctZmHjG4j5e42ZGul6EqH80SB6GLewU63+StVKYFysYY0FNbSrwQe75nlucFpoUnKmVje2yEovr2FYoJljI6sA+6XhIbDQG6XIURAsnLT/BMyEHvUfhKsc0umdykWJTqG1nQK0p6Ha+C4e2yIxNntyzePXmXffZcjcbnxGqmgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346783; c=relaxed/simple;
	bh=4/AJwti87gmU/M6ZkuqGNMG1wOirRvZR8Gc//GujTTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1fFgFHJ3fYd8qyr0eKKuAUiNMODNMNxBwAp6altgA6KTAxlWyKPXcey75C1gdCCiRvEdSeD+7mCW4nLewJNx4dP+RZu2e8pXHdGVilj+x6Wg7kJDBk8rfufgrnUlmwEa7izyONfI5h90JUzKt1VmrznUri9QuSx3f8jR5Bwo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1BISdZ0S; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1BISdZ0S"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43346da8817so10938345ab.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764346780; x=1764951580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfxU3Y6gwC6vWtxbzwQf2ciJ/Yx0VfMiyPttpa5vkEo=;
        b=1BISdZ0SGTCCvXt7A+i0C8gOYl5Tvr8JnizSyHqgsjyMJUTKwfeMKOrVq580Bd+DM0
         I3JyJ0jR7Ug4LME6vFji1r3Zgfb5xvTwhjAHPd1u8YRHX1y6PWw/e7dqhWlwOwTE9m1z
         Y1k6HGOnPmzjxaDfxnup3IxD9slEt1fiLO7EMECaSgdTmEJMrJ98jncfL5wf9MpWnAOA
         nH/mZou8S7hSXd8edIGtvYjfo7vB+XclfsV+ou0T8P3pHYd6HPJf3oY8BWcVSfGLyyR1
         nsbVpcgtKzm+87ok6CA/FKqQCKKll+8lDoNJpRz3t7WZ6qW8zyzE51ytdz/ok1Ni5SOz
         4QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346780; x=1764951580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfxU3Y6gwC6vWtxbzwQf2ciJ/Yx0VfMiyPttpa5vkEo=;
        b=DV/CS2OWiuBjLuoV4HpNFdXGDN751YzIeyOkDmG9FLXz8RAxeJATuDUvquCG8q0L1q
         LOblFqYty3O8jTjhg4FzDxiOif0mL+8fR0y/r+zIi3pDOHPfQJ5FrO6gkEJ0HTL9qUmG
         GrOf4U7Agq1eHTfDmn8KGjU4WB1W5gT6Hw6tPyYtL2j+EaatGyk/BKgKrlKNJ8wa7Za3
         QOq7YpsGZuFl6TVTy1qMcI8o41thgXBFPA2mTbVL6ju0uiEiU8LuY5F8Gy/OHJGK0E9k
         TVvAbhkdY10iSH5UiDKmIQ7nFGoF7WtQWwJx67Ax37G+f/2gyoEAC43Y2TV3/BEdoHba
         DK/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBNLILHreOKmIPKgjhF5Y3iqfwWiJXp7IbjGRxxc2Gu2IGjEpolst+AviY6Uo3E7WQ2844F0y9GEE5+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzLVilqcd84+jaDoeRMsUAYw3m29LDQoiM9fTsZ0fPrb1OceR
	tvexRNsy6WXbz4WzkRhavqesYMCEJwT7TMH2cs8i2Y07AM7DyI8t257V5uKOrz7Ml54=
X-Gm-Gg: ASbGncu/O+oM6PRLVGfuAkxrWzgRXdNkflJFaoOyx6FlTvTMsM9KGTw9PsOYqZot+yz
	cOGaBQY+tXywRbv/tSVEKbaDz1F/2ssJCNgb7izWhc6XG7PTEV5DDiipncneCFaVqrZbVoOnRYJ
	ghukdG3/JOoSMFO31qrRbh6gJqdGHio1sIYinhXyYAlFCRo+zd3sWVCMCNYvbSrcCQFvvI9u3Rm
	l8hhgQCH4mHJ8m1uuib4mLiXBDX5DzeWZfhFd2+LSciaob7hXj3Y1PU5pi4eeQdtQWPGbqIbRpf
	lHV1BTxj9RvJtpLdb+pN43PTp16z5+vkaGzIRTUEWfCywAvj4B78G+hi2OY94bT7kSa7o72fFXT
	nKYCfs9OpFy1MPS/cvJx40xmV4qGA8JWBv/ZlCm0ZrEqQ9XK77qHPxxPxbDxhE6jUA/jkoK3r7N
	OljmlTTJLT
X-Google-Smtp-Source: AGHT+IGF3VmRFWUBOCSmF5Wv63nwTe8CnZte3b2nU2MUrW5CXqqLhyZ6U2OhVIddYRDSNo8rMyje8A==
X-Received: by 2002:a92:607:0:b0:433:7d0b:b377 with SMTP id e9e14a558f8ab-435aa8db717mr196412295ab.15.1764346779975;
        Fri, 28 Nov 2025 08:19:39 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc79c5d3sm2300111173.54.2025.11.28.08.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 08:19:39 -0800 (PST)
Message-ID: <f60b4e02-7950-4fb4-908e-802a9a90ed54@kernel.dk>
Date: Fri, 28 Nov 2025 09:19:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/27] ublk: add UBLK_F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>,
 Stefani Seibold <stefani@seibold.net>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <aSmOu6b2mG-N0aE7@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aSmOu6b2mG-N0aE7@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 4:59 AM, Ming Lei wrote:
> On Fri, Nov 21, 2025 at 09:58:22AM +0800, Ming Lei wrote:
>> Hello,
>>
>> This patchset adds UBLK_F_BATCH_IO feature for communicating between kernel and ublk
>> server in batching way:
>>
>> - Per-queue vs Per-I/O: Commands operate on queues rather than individual I/Os
>>
>> - Batch processing: Multiple I/Os are handled in single operation
>>
>> - Multishot commands: Use io_uring multishot for reducing submission overhead
>>
>> - Flexible task assignment: Any task can handle any I/O (no per-I/O daemons)
>>
>> - Better load balancing: Tasks can adjust their workload dynamically
>>
>> - help for future optimizations:
>> 	- blk-mq batch tags free
>>   	- support io-poll
>> 	- per-task batch for avoiding per-io lock
>> 	- fetch command priority
>>
>> - simplify command cancel process with per-queue lock
>>
>> selftest are provided.
>>
>>
>> Performance test result(IOPS) on V3:
>>
>> - page copy
>>
>> tools/testing/selftests/ublk//kublk add -t null -q 16 [-b]
>>
>> - zero copy(--auto_zc)
>> tools/testing/selftests/ublk//kublk add -t null -q 16 --auto_zc [-b]
>>
>> - IO test
>> taskset -c 0-31 fio/t/io_uring -p0 -n $JOBS -r 30 /dev/ublkb0
>>
>> 1) 16 jobs IO
>> - page copy:  			37.77M vs. 42.40M(BATCH_IO), +12%
>> - zero copy(--auto_zc): 42.83M vs. 44.43M(BATCH_IO), +3.7%
>>
>>
>> 2) single job IO
>> - page copy:  			2.54M vs. 2.6M(BATCH_IO),   +2.3%
>> - zero copy(--auto_zc): 3.13M vs. 3.35M(BATCH_IO),  +7%
>>
>>
>> V4:
>> 	- fix handling in case of running out of mshot buffer, request has to
>> 	  be un-prepared for zero copy
>> 	- don't expose unused tag to userspace
>> 	- replace fixed buffer with plain user buffer for
>> 	  UBLK_U_IO_PREP_IO_CMDS and UBLK_U_IO_COMMIT_IO_CMDS
>> 	- replace iov iterator with plain copy_from_user() for
>> 	  ublk_walk_cmd_buf(), code is simplified with performance improvement
>> 	- don't touch sqe->len for UBLK_U_IO_PREP_IO_CMDS and
>> 	  UBLK_U_IO_COMMIT_IO_CMDS(Caleb Sander Mateos)
>> 	- use READ_ONCE() for access sqe->addr (Caleb Sander Mateos)
>> 	- all kinds of patch style fix(Caleb Sander Mateos)
>> 	- inline __kfifo_alloc() (Caleb Sander Mateos)
> 
> Hi Caleb Sander Mateos and Jens,
> 
> Caleb have reviewed patch 1 ~ patch 8, and driver patch 9 ~ patch 18 are not
> reviewed yet.
> 
> I'd want to hear your idea for how to move on. So far, looks there are
> several ways:
> 
> 1) merge patch 1 ~ patch 6 to v6.19 first, which can be prep patches for BATCH_IO
> 
> 2) delay the whole patchset to v6.20 cycle
> 
> 3) merge the whole patchset to v6.19
> 
> I am fine with either one, which one do you prefer to?
> 
> BTW, V4 pass all builtin function and stress tests, and there is just one small bug
> fix not posted yet, which can be a follow-up. The new feature takes standalone
> code path, so regression risk is pretty small.

I'm fine taking the whole thing for 6.19. Caleb let me know if you
disagree. I'll queue 1..6 for now, then can follow up later today with
the rest as needed.

-- 
Jens Axboe
