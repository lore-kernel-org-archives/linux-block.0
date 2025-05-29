Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1202566E6
	for <linux-block@vger.kernel.org>; Thu, 29 May 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562459; cv=none; b=ebMqq6px/rRoKbyxR1PZpl72xZz4F1P9On+Iwa+HsL/js/p2FLN264P2YOLB7Z4AnOGF5lTylncK8aYJ9QoW4aJB9fMyGJPTH4GSSSN8uUCcR3vDPDQkLLOQLgQpWeNSJBvGPPWAGth9NfykIf5Sm0mDXrTeh4E46RPIogxJu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562459; c=relaxed/simple;
	bh=XiF7wGjABVa2ixJPGEc6toPofHwOMyBqL5d/ZjvYjTI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IeuUwrq72F/xaRNx96lpLDGY0sNoJYTBJh/sDhjPX3GT1Pcc3oR6PlHIs8WcLDsA9D4YUSuMuXOSFpXqrQz1398hZzoe3GurNxH7VU528M2M/1h1WYJcdXXFur16QsxSJ3iqK1nCeD/si0BGTcWE/gRbIg+RqYCGrHCujidkkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VLQh6oQb; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VLQh6oQb"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2349282084bso18921905ad.1
        for <linux-block@vger.kernel.org>; Thu, 29 May 2025 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562455; x=1749167255; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jj3IjTnWdLVVuKoHpxyImOpar+R4KFFhXQKA1dsDs2o=;
        b=VLQh6oQbZXniBSfM/MjhSxX8KMAL/L6tSDGaCnvC/moaF4fp4UmZI0eb0Dor4juo7H
         w6gsSyLBdApd9ve2q9Eq4ioI1r3c1fZCHsoy/tQqxS73kibjL3edStbpcvZnHd/4ipy0
         tTaw+8jsP2KIhAUjr9aRdfxjWOa0RLXllyQvJBMU/3csCek+Ah6MgIoI4dwRmqamRGZE
         37nDpJ08tSoJLtY4ezWOZPI/hoYusGplbMMCbXwpnFXVYC7OeEoFqaXv1O04LmPmqMOz
         jZE+/fo1dats91vgu6AQ16rVlqgxjrOyngnDLjVX+LVm+QaCevjIHviJQGkzya+44sXA
         4g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562455; x=1749167255;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jj3IjTnWdLVVuKoHpxyImOpar+R4KFFhXQKA1dsDs2o=;
        b=fNMDFjYBZAIr9+JpfeETxa7R2AuaN9YnJkD2eyHYTQHo/2EtjijJQhUYejcplOoUV4
         5AB5n6rzFGf0zo6rrwZNsr8HuLFZ1v+BDKhXY+I1HSSfw2h/1EWH/DgCtZRARuiRZtTJ
         CvSeYQHo3ki4+Q5PoIaKOpbJ5dGCb+H0xEb56EMJFbAGCHAfT4x4AhoPUEhzLOCkn+bM
         POsGDVcGAJaxhYhXGf1tIKtQf2EIBWTvcnUBsuP25vJbXMWVQCFzWasIII32HhMB3i90
         Q/pELphYZfTqHXgxJjeYCGKm0HH8k7S0qcJqwdxSPB7XazUeAqBQjIapAwwYBKQaWzW3
         l7pw==
X-Gm-Message-State: AOJu0YykhKjDS22RTMwzeYGTsNXRwujJiOY169zvhYJsp+Iy5SMAmlE9
	rArT3wUZslzrp5VO++yjydlrCAe/l+Axf1A1KoTG6B+ZkZkkrWTgWBa0kDVxWMHUpkMO4gjIME4
	lYLQGQMBcUXtOXDRSStB9zr6qoqoeYtaiGQyX
X-Gm-Gg: ASbGncumTr+IVCsTQm2SVtJixO9yYcgzD07hzodO1KGFKL4nljqP64eriKg3X0iZYJb
	WgAbz77a2PG50Kw4MOpbJt/7N42T+9NhBANkMdcUxCn6QtdTd+Py3+20gg3Jzi31U61mV/fCjZw
	aHkgKBJRQ4H9WoxrbM0T1qalRULLSjnnpI5GhLw7t2qiAJwo2oAkLvahBpYfjMMcb7vuA19FzOn
	ExDXraxeN8+rcuPq93yqzPFyydW73gyshkg4t4RV6PAPeROSQRcAOUcfE/WBYKq2WfFTDK36691
	e9EDsTshgCna/1fifrtN4z58XtzQJILccGvYCXFM9LlBLQ==
X-Google-Smtp-Source: AGHT+IHwYv3aS/UV/mIzpaJf/NinvhUhG4l1dgysG6d8oRv+uAJ7dWaE03S1YWGE1vvaDvNvVGXvA3OKvnB9
X-Received: by 2002:a17:902:d58e:b0:234:e3b7:5cd2 with SMTP id d9443c01a7336-23529a116e5mr19249165ad.46.1748562455349;
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-23506bf8e52sm1349915ad.37.2025.05.29.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B4C6A340350;
	Thu, 29 May 2025 17:47:34 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A7892E40F18; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v8 0/9] ublk: decouple server threads from
 ublk_queues/hctxs
Date: Thu, 29 May 2025 17:47:09 -0600
Message-Id: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7xOGgC/3XQTW7DIBAF4KtErEs0DL/uqveoKgswJChtbEFst
 Yp89+JIVb0gy4f0vpnhTkrIKRTyeriTHJZU0nitwbwciD/b6ynQNNRMEFCCAENn93npb7Zc+in
 kPo3Uq477qMAM2pJam3KI6ftBvn/UfE7lNuafx4SFba8bJhgAIgrB9ZGDMZ1hlNG51JkXm9+mO
 YetZk/h6McvskEL/pWfbLIgBeo6bbQOKg4S2gzfMQwaDN8Yw1gwUUgpbJsRe0Y2GFEZKZCB65g
 VKrYZuWdUg5GV6VAxO2gXIz45Sv0zEnSDUZWxaLEz2nAPrM3oHYMtRlfGu8HZiIY72/ibdV1/A
 cP0aTxWAgAA
X-Change-ID: 20250408-ublk_task_per_io-c693cf608d7a
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to allow ublk server threads to better balance load
amongst themselves by decoupling server threads from ublk_queues/hctxs,
so that multiple threads can service I/Os that are issued from a single
CPU. This can improve performance for workloads in which ublk server CPU
is a bottleneck, and for which load is issued from CPUs which are not
balanced across ublk_queues/hctxs.

Performance
-----------

First create two ublk devices with:

ublkb0: ./kublk add -t null -q 2 --nthreads 2
ublkb1: ./kublk add -t null -q 2 --nthreads 2 --per_io_tasks

Then run load with:

taskset -c 1 fio/t/io_uring -r5 -p0 /dev/ublkb0: 1.90M IOPS
taskset -c 1 fio/t/io_uring -r5 -p0 /dev/ublkb1: 2.18M IOPS

Since ublkb1 has per-io-tasks, the second command is able to make use of
both ublk server worker threads and therefore has increased max
throughput.

Caveats:
- This testing was done on a system with 2 numa nodes, but the penalty
  of having I/O cross a numa (or LLC) boundary in the per_io_tasks case
  is quite high. So these numbers were obtained after moving all ublk
  server threads and the application threads to CPUs on the same numa
  node/LLC.
- One might expect the scaling to be linear - because ublkb1 can make
  use of twice as many ublk server threads, it should be able to drive
  twice the throughput. However this is not true (the improvement is
  ~15%), and needs further investigation.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v8:
- Fix queue_rqs batch dispatch OOPS when dispatching a list of requests
  associated to > 1 ublk_queue (Ming Lei, Caleb Sander Mateos)
- Simplify queue_rqs (Caleb Sander Mateos)
- Narrow a couple of types (Ming Lei)
- Add stress test for per io daemons (Ming Lei)
- Link to v7: https://lore.kernel.org/r/20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com

Changes in v7:
- Fix queue_rqs batch dispatch for per-io daemons
- Kick round-robin tag allocation changes to a followup
- Add explicit feature flag for per-task daemons (Ming Lei, Caleb Sander
  Mateos)
- Move some variable assignments to avoid redundant computation (Caleb
  Sander Mateos)
- Switch from storing pointers in ublk_io to computing based on address
  with container_of in a couple places (Ming Lei)
- Link to v6: https://lore.kernel.org/r/20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com

Changes in v6:
- Add a feature flag for this feature, called UBLK_F_RR_TAGS (Ming Lei)
- Add test for this feature (Ming Lei)
- Add documentation for this feature (Ming Lei)
- Link to v5: https://lore.kernel.org/r/20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com

Changes in v5:
- Set io->task before ublk_mark_io_ready (Caleb Sander Mateos)
- Set io->task atomically, read it atomically when needed
- Return 0 on success from command-specific helpers in
  __ublk_ch_uring_cmd (Caleb Sander Mateos)
- Rename ublk_handle_need_get_data to ublk_get_data (Caleb Sander
  Mateos)
- Link to v4: https://lore.kernel.org/r/20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com

Changes in v4:
- Drop "ublk: properly serialize all FETCH_REQs" since Ming is taking it
  in another set
- Prevent data races by marking data structures which should be
  read-only in the I/O path as const (Ming Lei)
- Link to v3: https://lore.kernel.org/r/20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com

Changes in v3:
- Check for UBLK_IO_FLAG_ACTIVE on I/O again after taking lock to ensure
  that two concurrent FETCH_REQs on the same I/O can't succeed (Caleb
  Sander Mateos)
- Link to v2: https://lore.kernel.org/r/20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com

Changes in v2:
- Remove changes split into other patches
- To ease error handling/synchronization, associate each I/O (instead of
  each queue) to the last task that issues a FETCH_REQ against it. Only
  that task is allowed to operate on the I/O.
- Link to v1: https://lore.kernel.org/r/20241002224437.3088981-1-ushankar@purestorage.com

---
Uday Shankar (9):
      ublk: have a per-io daemon instead of a per-queue daemon
      selftests: ublk: kublk: plumb q_id in io_uring user_data
      selftests: ublk: kublk: tie sqe allocation to io instead of queue
      selftests: ublk: kublk: lift queue initialization out of thread
      selftests: ublk: kublk: move per-thread data out of ublk_queue
      selftests: ublk: kublk: decouple ublk_queues from ublk server threads
      selftests: ublk: add functional test for per io daemons
      selftests: ublk: add stress test for per io daemons
      Documentation: ublk: document UBLK_F_PER_IO_DAEMON

 Documentation/block/ublk.rst                       |  35 ++-
 drivers/block/ublk_drv.c                           | 111 +++----
 include/uapi/linux/ublk_cmd.h                      |   9 +
 tools/testing/selftests/ublk/Makefile              |   2 +
 tools/testing/selftests/ublk/fault_inject.c        |   4 +-
 tools/testing/selftests/ublk/file_backed.c         |  20 +-
 tools/testing/selftests/ublk/kublk.c               | 344 ++++++++++++++-------
 tools/testing/selftests/ublk/kublk.h               |  73 +++--
 tools/testing/selftests/ublk/null.c                |  22 +-
 tools/testing/selftests/ublk/stripe.c              |  17 +-
 tools/testing/selftests/ublk/test_common.sh        |   5 +
 tools/testing/selftests/ublk/test_generic_12.sh    |  55 ++++
 tools/testing/selftests/ublk/test_stress_06.sh     |  36 +++
 .../selftests/ublk/trace/count_ios_per_tid.bt      |  11 +
 14 files changed, 512 insertions(+), 232 deletions(-)
---
base-commit: 533c87e2ed742454957f14d7bef9f48d5a72e72d
change-id: 20250408-ublk_task_per_io-c693cf608d7a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

