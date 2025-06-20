Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBB229B1E
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432217; cv=none; b=jDjzVpH+YfBQfCh3WRQdZw5yBwDCc6CMXx6x6PriOh01kqkzJpw7rciQ/rig/E1cL31kI0W7bwTbUHOAvqSsswvId2Q9nqPO48H+5+TCouxdIRTRsxdzfGXGPy8S/W8cdggSdKLFbk/RiVzM0/QRN01cqTteLX3MfNB/AGeKj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432217; c=relaxed/simple;
	bh=/zB1r462+aGLd+XIbxxxUv7ScSA/NyRprvaCzE+ZCeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMoqPbOk+DMaONksF9t5l3vVa90svfqWmJp4TKjlD7nAEWcUxNOaqf21p9uKKcYzqrfNKHNQ6zeds8TWxKppQ0Oa4jPPsTvntiAvb0/231k+NZ0HYdhuZMdpn4TZsS8IqRAg9zUgHkSPThClEaS/xXcnJUHj1g+8IYReZIAAv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ADzf1PLz; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ADzf1PLz"
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-4a43f17c42bso3003671cf.2
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432214; x=1751037014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg7GpUyX0/c/4LyuoKu16z8Sljo1ya47O5ZdvClTMt8=;
        b=ADzf1PLzIBbtKEaE+yaDeGKPEgcDPHmJPjJRwn4cYSM9ccRhvitvjOlsXT3ESpzMyt
         fhwU/rmCP0QAuQXTGl4P6j+YIWbghKEwg9w4aw2+E1fDrVpxbCPdUBvsxyv8SO6L+e2G
         gq79F9C9ITvby/2HcPbMm6wTgNWshv8TBt7t1bcI0LvE/5QaaIyt/hbdF/KUAhpNthRq
         UnL3Ws1uM1AJzkbJwPNfgeAZt+ke4B+9cy1BJplNHzldu4Y+wxyHTve6Tck7BxapQBcJ
         1hpNJF2WRbCI7ZDW0N8ZZ9/V8FvNC3ZE/bExfx2mEOOTaPtCFJ1iSbyQBloZWJu41vVc
         VSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432214; x=1751037014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mg7GpUyX0/c/4LyuoKu16z8Sljo1ya47O5ZdvClTMt8=;
        b=U2396Elk5yITtqpDKavuPuwyBUhcbyJBNGmZ5f+QdWPJ3NlP4dWcQKA6dKX8vjJsIZ
         yCfmO0rJIuH9hNg4hJqKkaaqPXPDZeLW9fbHIjH1oTEydq/2P1gxcPWYd3/u3VUK0tKV
         RFmwq56kWa4wNedyJ1t0Xd3e7tKC2Y4aL0O1c4G6nNtXCTjs8pGmEfl6dt1q4AYIyuZk
         pwjix4w6/FR7BuKilyNN2m1L+5hAao6jpSu+g7SOWEAFufUi9EExmWGTROffpzcmf0PX
         nUL1UVk46UE5XWL641E48p6R50xGSwz4jIRaPMKKSGEgF6FRKRaDnt1vvXuWyNw4pnE8
         VMjQ==
X-Gm-Message-State: AOJu0YwkZwmF/BsZibafRGIqlTBGPWHcKv/o/kRc46p42kOYBM5zYpm+
	tXfA8NqN+0rbF3npvb7YSVujMtiR7GMcHB/s1SW+37rQqvQPf4YFmNg+CIjywYHOpseSfxxkAb+
	hSuIpj+bPQrUmSY5QXTgK4p2OcZVJABPyfGhhYLcXzy0jwxVUIk7m
X-Gm-Gg: ASbGncsKC2B/vS6510QOkVWKVdrzAbf6YaS00jtdbO35bgTvenRdNZA67hnrReoXG2D
	yWcscY6yHMUaKTEo/yzA3Bj3Ixe5Q+U8dkHdqyG10yfgIYkkD59fqrsByUxmEufhxkhOu07SPoS
	/6nS+Sk7znspXYI7838XAq58+9wqdOQ8k+Zph5Rg4yYCuryU4SZvJQjPXUMFvtv+J2E81b430Du
	EepdcUL9YRD1S69tvy89BLVmbPsz+3g/tTyy/boBK8qOlX4Maas3EQGA1vn56ji960Tg+/tGetQ
	aJKvoc3nzkrDXP5vwV+eTyNwrvbU0bZ8B+I1HAWK
X-Google-Smtp-Source: AGHT+IEucyTBvo6Wi22bNpouMFZBsftVJbftMnFwHgRjKPFrm92GaiblE8JG1z3hR1LB62GMPGJhtU/A0MnO
X-Received: by 2002:ac8:7c45:0:b0:4a4:35f2:a02d with SMTP id d75a77b69052e-4a77a1e7146mr18736041cf.7.1750432214227;
        Fri, 20 Jun 2025 08:10:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4a779e6e4c3sm747001cf.6.2025.06.20.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 334AB34031F;
	Fri, 20 Jun 2025 09:10:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2EC4AE4548E; Fri, 20 Jun 2025 09:10:13 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 00/14] ublk: allow off-daemon zero-copy buffer registration
Date: Fri, 20 Jun 2025 09:09:54 -0600
Message-ID: <20250620151008.3976463-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ublk zero-copy requires ublk request buffers to be registered
and unregistered by the ublk I/O's daemon task. However, as currently
implemented, there is no reason for this restriction. Registration looks
up the request via the ublk device's tagset rather than the daemon-local
ublk_io structure and takes an atomic reference to prevent racing with
dispatch or completion of the request. Ming has expressed interest in
relaxing this restriction[1] so the ublk server can offload the I/O
operation that uses the zero-copy buffer to another thread.

Additionally, optimize the buffer registration for the common case where
the buffer is registered and unregistered by the daemon task. Skip the
expensive atomic reference count increment and decrement and the several
pointer dereferences involved in looking up the request on the tagset.
On our ublk server threads, this results in a 24% decrease in the CPU
time spent in the ublk functions on a 4K zero-copy read workload, from
8.75% to 6.68%.

Two preliminary fixes are included as well:
- Move the ublk request reference count from ublk_rq_data (a tail
  allocation of struct request) to ublk_io to prevent a use after free
  if the struct request is freed concurrently with taking a reference.
- Don't allocate physically contiguous memory for __queues, which can be
  very large. Doubling the size of struct ublk_io caused ENOMEM errors
  when adding a ublk device before this change.

[1]: https://lore.kernel.org/linux-block/aAmYJxaV1-yWEMRo@fedora/

v2:
- Add 2 fix patches
- Optimize buffer unregistration too
- Cache-align ublk_io
- Restore check for zero copy support in ublk_unregister_io_buf()
- Check for registered buffer count overflow

Caleb Sander Mateos (14):
  ublk: use vmalloc for ublk_device's __queues
  ublk: remove struct ublk_rq_data
  ublk: check cmd_op first
  ublk: handle UBLK_IO_FETCH_REQ earlier
  ublk: remove task variable from __ublk_ch_uring_cmd()
  ublk: consolidate UBLK_IO_FLAG_{ACTIVE,OWNED_BY_SRV} checks
  ublk: move ublk_prep_cancel() to case UBLK_IO_COMMIT_AND_FETCH_REQ
  ublk: don't take ublk_queue in ublk_unregister_io_buf()
  ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
  ublk: return early if blk_should_fake_timeout()
  ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
  ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task
  ublk: remove ubq checks from ublk_{get,put}_req_ref()
  ublk: cache-align struct ublk_io

 drivers/block/ublk_drv.c      | 283 +++++++++++++++++++++-------------
 include/uapi/linux/ublk_cmd.h |  10 ++
 2 files changed, 187 insertions(+), 106 deletions(-)

-- 
2.45.2

