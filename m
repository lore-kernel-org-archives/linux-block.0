Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AE2F60B2
	for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273051; cv=none; b=uNggZ3x5Q4M/uw+CAT6P0PaTqOjvTj24rLHG11TewdF8EDleFa+GFY31OOHs9x+y7kbWOVmk2+bIuwd1kmsuF5BJsjDPFaX0nJXCsch++HpLA8hCEoOft4D9OZ8L6z3w1hqnqF6jXLVRB+R57EWNaaEMsN3erVOirN/ebG1i/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273051; c=relaxed/simple;
	bh=zBKs3v18TmkHu5lgs2GGW0Bb0o1/4P9mk5KfPwEvsmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQnT2soM7t1Q6HZSFRRivLJRK35R3sZtgIi5siiVp4NE4v2OcKVkBn8SAQwr0w4oFepFwsptHxT0doLcFy0fsVoA9IHFbooIfqugeEOfV2wu6ygu2ti2dLKza2wvzrNPSpsRucg26h7af7FiLkP7VwVPhqw93NhmdzOVzgAUxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=g4P3gKYr; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="g4P3gKYr"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-353804b591eso1616409eec.0
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792273049; x=1792877849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98lvOFB4BKc/fdFgIwOSXoD4lQbopt4a5ggn5fPV5lM=;
        b=g4P3gKYruCCHC7mltzTzFjPa2nvt5gVYvaTHkKqHlc7l9BglQnQ5VP+LUR7+f3l6Na
         4DP5LMPiLe8wnmFWdNNMKWe1P8FQQfmsw/9GPDaf0iFApmeRG7IjcZIIsFqIl+fLmIoL
         3q0uF7zHSpQfOgytxTWYTSeaBqoPJrDU28gn/PMx6KU5ppxcITsLCCniCntc2209tepG
         vhOFHVTWpf2H674oHXKhWf7rHTp2Sm/srZls3YwKVCAhljO9S9ehDFvpb9/QTjP96OkW
         ud0RpMDhlJmoI1Q4bkvoayosFZnLMyEjXQCINtGhuSPKKSMcrGiVZ3Iskacg5y9aw3tV
         MOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273049; x=1792877849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=98lvOFB4BKc/fdFgIwOSXoD4lQbopt4a5ggn5fPV5lM=;
        b=gjyxoSxqc16jI98oe4c+gISU5mYg+foS0o28r2ni5CR7bCf1dYYYAiVVqTJG6pvv15
         8OD47Wf+0SUgJhABKWM70w/PVWEW+oDZrjUzdFAV45X1vQLbVh2UkA2YjsxHQy1z8z/o
         D+CQ15+/3L/emPRUmVywvfM8Llj9iQ+sd9gciQA00qi1WCoHkn0RXmRMyw86FgU2VmnN
         i0IZ0LZLh0AckD2rBuQah/I4CgN4C8hj2cYPFBfU3eBH9XsR2iETW0ABhMXlpgmCb4rT
         HyV493n7svfr/EpPol9MD4yu9MVBmVzhRc6DAqy943oYkmexRJVCX4B7LLrCVJ6M7jkN
         YJFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAdJV7/jbe+tju1JuIju/Zt8tUQiUI/cOxVItC3GopR/s+z13jHNt6lJhUhPRXJHug+K5toDIpKb/MIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIT51JGVbtV7rNCG3fGu4qfZOaqTln4DI2VAOHgAQu3kSFmTGsj
	587fGiA0oLvljAGZW3V3NyVpUlC6a8nBbrVr1BI36z3aTJsTzxv3h31x9tXrxFqmz2E=
X-Gm-Gg: AYBFou2xBW/NduXzi09Lrnx6JWRWXkP+yjyHPtvmsQ4HjyeCr1v5ZMzBh/fHL+TUOdH
	dL4uyIBWzSJV5vT7h08tgZ+tCVvTvq8AuvnGWma5D4UHLLYvDZxtEbUeNYYKWSExxv1vB38y6C1
	0BBkEhPLkncIbC5mNGFo/OeZvMO8dLQJn7aNWAqDnAYsRUpX7cCh/+rWcZ2/I3jlXf34Raz42jX
	mOLk/438e6K6FLXl9/nwzqMh8iUoGmQxxsRm5u6KlQ7brrTcxCN1X195MueOWCEFjKmAZenXUiK
	KshX1xGon17H+EeX8cq7FF2yPC5Yg0G+lpX0us3hIxwvYxjpnEfHmYUqYycn5IaoaJJ0aVPxx/1
	+1wCkpWqxU0zMmHKng33cXWxUZz2VWy0qyZBVo84VA5ibPhh6K3DJ+NiuzGROAbHBT5uxPh37By
	F7x944JDvV6Y0k0CJIClyT9BcomARTOkeQUjNnuIKiy7N4S6HLGkig/IMMeL8DXG9HCngIaTtZQ
	iVkdPb89t6e+YB+R8FaW86pDq6guCfFWJrPJFTX1Ys=
X-Received: by 2002:a05:7301:6447:b0:359:2729:1797 with SMTP id 5a478bee46e88-361a224d1a7mr6629144eec.30.1792273049428;
        Sat, 17 Oct 2026 14:37:29 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm18104511eec.18.2026.10.17.14.37.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 14:37:28 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Daniel Wagner <dwagner@suse.de>
Cc: Saravanan D <saravanand@crusoe.ai>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/5] nvme-tcp: initialize pf_cache_lock when allocating the controller
Date: Sat, 17 Oct 2026 14:37:15 -0700
Message-ID: <20261017213722.74846-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org> <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 09:46:39AM +0200, Daniel Wagner wrote:
> Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
> and startup") the I/O tag set is allocated before the I/O queues.
> blk_mq_alloc_tag_set calls nvme_tcp_init_request for every request,
> which takes pf_cache_lock of the request's queue, but nvme_tcp_alloc_queue
> initializes that mutex only later.  With CONFIG_DEBUG_MUTEXES the first
> connect triggers DEBUG_LOCKS_WARN_ON(lock->magic != lock) in
> __mutex_lock and lock debugging is disabled.

I hit the same warning on nvme-7.4, and also a second path to it, a
reconnect that grows the queue count. Every teardown frees the I/O
queues, and nvme_tcp_free_queue() destroys their pf_cache_lock. When
a reconnect raises the queue count, blk_mq_update_nr_hw_queues()
initializes the requests of the added hardware contexts, and with them
takes pf_cache_lock of their queues, before nvme_tcp_setup_io_queues()
allocates those queues.

  shrink, 4 -> 3 queues
    nvme_tcp_free_queue(4)        mutex_destroy(q4 pf_cache_lock)
  grow, 3 -> 4 queues
    blk_mq_update_nr_hw_queues()
      nvme_tcp_init_request()     mutex_lock(q4 pf_cache_lock)  <- WARN
    nvme_tcp_setup_io_queues()
      nvme_tcp_alloc_queue(4)     mutex_init(q4 pf_cache_lock)

  WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x434/0x117c
  Call trace:
   __mutex_lock+0x434/0x117c (P)
   mutex_lock_nested+0x24/0x30
   nvme_tcp_init_request+0xb0/0x260
   blk_mq_alloc_map_and_rqs+0x388/0x670
   blk_mq_update_nr_hw_queues+0xb30/0x1058
   nvme_tcp_setup_ctrl+0xa9c/0xda4
   nvme_tcp_reconnect_ctrl_work+0x70/0x2d8
   process_one_work+0x7a0/0x1b5c

Dropping the mutex_destroy() from nvme_tcp_free_queue(), as this patch
does, fixes that path too. It may be worth mentioning this fact in the
changelog.

Tested against nvmet-tcp over loopback with lockdep, KASAN and
DEBUG_KOBJECT_RELEASE, covering connect, reset loops under I/O,
shrinking and growing the queue count through attr_qid_max, and
reconnects while the port is removed.

Tested-by: Saravanan D <saravanand@crusoe.ai>

Thanks,
Saravanan D.
