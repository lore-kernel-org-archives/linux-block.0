Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD34EB4C
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680225; cv=none; b=PaX2J1zG0u1XUkJyK/lw1huQbco79HyMImnsYep2RjHlzvqcEouAIGZYP5CTNNqIEnuwOO9WLxFzZ0Jzm71DyMbf4AVz/Gs64wdLULhIzsceao7u6+iKH20qHblTeuo/jVpfzBJ3Zh64BQu9ombjTgspvVRHzhr6SvZp5B274yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680225; c=relaxed/simple;
	bh=5egZooH6XED8XdfRAckc2doTEkMT0HASO+KVZwEjpJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjKR31dma9GyNNYP31aJOSGUYmgiuYdY0kTXMP51evoB1V+AloGQjrc5/10jiykfEob8bu9JP1tjMxUl1Ty6vHdZMrVb4MKArNg3+jV4q4XXCMcQTXg2nDrtav8+AKGC2GTbaxmMiZO+MuPtNsFPbjqzGmYkIfzJFzNw19dZ7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dcTnU9zS; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dcTnU9zS"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bee9f626caso13149839f.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705680221; x=1706285021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vm7CkYwt+nXmzpPNNrfAgm10W9UTxbtw6IhoDKUp8c=;
        b=dcTnU9zSbv0X1QhqTAfZq2EnA9j+yIDNsYwJgGGyPWS9TwN2isWKfwYW1D+LirCyUo
         VIRSZWzo7NGLuB4vm28Iy14C2tM6QkaplWjkSThqllLHf991vEC+ZQV1DAHHIT0S9L8c
         fFOX/mJiJg5FxMBuAfJcCw2i61jXovPIuuuK4piPbQnwH9QI5rtFHAsmeHzhaZSOdhMo
         j4rWV5SnZ7gtNNBN7SCMDO18SicLuEvh/Muf9UcdNzsZWXljJ0GuNS9wuBVfgq2p8nDq
         1i7nzjMQnc5yEO3OJEo09HTh41t4AaY1fPyj5lq+MvX6Kse+SnA0uB0esDsUPMYjZ5St
         5vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680221; x=1706285021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vm7CkYwt+nXmzpPNNrfAgm10W9UTxbtw6IhoDKUp8c=;
        b=dhzKf7x3JzNmIe0kYPK3yMMivPxvygunP8jHJPEmeIyfbevf8AoDy3gY0IkqJ2Nxv2
         Q82S9i/TZmdjyNpBnf/bs7KEKQqB0UcBZHscAJEJ7E6AkWoIwSMzYrdfCfBsXVCPnPxR
         0I4N+WUKQXZKBF3q+GMzfa4JDpapZ4dpha8GQGVDXGRkRWP5NvaNPI5GtdbGzzRPg+t4
         Id94wBcBmLCV22uqS5seRzU6D/9ezfk3dywJiPJvFLKDq5Mi1NGFoMk1l2PEnlCiRnv9
         +MhYLqF1AQSQrNHAz6DCRxuFS2JO6GNRfwx5SyS+QNmVtbM4t7am7MveLYAOk0R1Uetq
         6lDA==
X-Gm-Message-State: AOJu0YxIB/P6wOhzOVKqRYUyzdyKP1VSjKibGxr7/TjTz53x9u3FW9Et
	MU76JvfJTAwvDYr9ScMnurS6y60h/V0WDtcNdgI/aD2CmbF1cin8vy94Skrb00kmK/jW2L7Llsi
	zzy4=
X-Google-Smtp-Source: AGHT+IEEt9BSt3m74YasmtZUcXWj1+tdC9p/nuXjUy8WR8IOQvkcefLYlq4iewFqo6x4AjaQz+yREA==
X-Received: by 2002:a92:c549:0:b0:360:7937:6f7 with SMTP id a9-20020a92c549000000b00360793706f7mr50732ilj.3.1705680221301;
        Fri, 19 Jan 2024 08:03:41 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bc8-20020a056e02008800b0035fe37a9c09sm5645163ilb.20.2024.01.19.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:03:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org
Subject: [PATCHSET RFC v2 0/4] mq-deadline scalability improvements
Date: Fri, 19 Jan 2024 09:02:05 -0700
Message-ID: <20240119160338.1191281-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It's no secret that mq-deadline doesn't scale very well - it was
originally done as a proof-of-concept conversion from deadline, when the
blk-mq multiqueue layer was written. In the single queue world, the
queue lock protected the IO scheduler as well, and mq-deadline simply
adopted an internal dd->lock to fill the place of that.

While mq-deadline works under blk-mq and doesn't suffer any scaling on
that side, as soon as request insertion or dispatch is done, we're
hitting the per-queue dd->lock quite intensely. On a basic test box
with 16 cores / 32 threads, running a number of IO intensive threads
on either null_blk (single hw queue) or nvme0n1 (many hw queues) shows
this quite easily:

The test case looks like this:

fio --bs=512 --group_reporting=1 --gtod_reduce=1 --invalidate=1 \
	--ioengine=io_uring --norandommap --runtime=60 --rw=randread \
	--thread --time_based=1 --buffered=0 --fixedbufs=1 --numjobs=32 \
	--iodepth=4 --iodepth_batch_submit=4 --iodepth_batch_complete=4 \
	--name=scaletest --filename=/dev/$DEV

and is being run on a desktop 7950X box.

which is 32 threads each doing 4 IOs, for a total queue depth of 128.

Results before the patches:

Device		IOPS	sys	contention	diff
====================================================
null_blk	879K	89%	93.6%
nvme0n1		901K	86%	94.5%

which looks pretty miserable, most of the time is spent contending on
the queue lock.

This RFC patchset attempts to address that by:

1) Serializing dispatch of requests. If we fail dispatching, rely on
   the next completion to dispatch the next one. This could potentially
   reduce the overall depth achieved on the device side, however even
   for the heavily contended test I'm running here, no observable
   change is seen. This is patch 2.

2) Serialize request insertion, using internal per-cpu lists to
   temporarily store requests until insertion can proceed. This is
   patch 3.

3) Skip expensive merges if the queue is already contended. Reasonings
   provided in that patch, patch 4.

With that in place, the same test case now does:

Device		IOPS	sys	contention	diff
====================================================
null_blk	2311K	10.3%	21.1%		+257%
nvme0n1		2610K	11.0%	24.6%		+289%

and while that doesn't completely eliminate the lock contention, it's
oodles better than what it was before. The throughput increase shows
that nicely, with more than a 200% improvement for both cases.

Since the above is very high IOPS testing to show the scalability
limitations, I also ran this on a more normal drive on a Dell R7525 test
box. It doesn't change the performance there (around 66K IOPS), but
it does reduce the system time required to do the IO from 12.6% to
10.7%, or about 20% less time spent in the kernel.

TODO: probably make DD_CPU_BUCKETS depend on number of online CPUs
in the system, rather than just default to 32.

 block/mq-deadline.c | 178 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 161 insertions(+), 17 deletions(-)

Since v1:
	- Redid numbers as I enabled fixedbufs for the workload,
	  and did not disable expensive merges but rather left it
	  at the kernel default settings.
	- Cleanup the insertion handling, also more efficient now.
	- Add merge contention patch
	- Expanded some of the commit messages
	- Add/expand code comments
	- Rebase to current master as block bits landed

-- 
Jens Axboe

