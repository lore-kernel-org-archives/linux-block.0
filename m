Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F98472
	for <linux-block@vger.kernel.org>; Sat,  3 Oct 2026 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791001721; cv=none; b=dd1kyZzITzaBOBpvfl//0xaBr/iE4tyHhZgoTvNozqItUCXo0fBCprgKx2KhN1xUOWuk6lZ7vBOmww0kzgy7UP75PcYkDVQBXIuGOWVtfhyGXbuDFMAzFrmgtqwR3JQQh1BAnMFYtl36jGf4rXUFJuM97QLBt1G74p14tDMA+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791001721; c=relaxed/simple;
	bh=igfX93Ek/o5BTIQvnxOAKjm8TGoICNWPZi75TRtjCLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ER8qcPhOpJT6g5kMaBxrfah421FT2wGxDT060xn0GjuckZhVcjlJg71nLIhPupxG8d2v5Bkfk+0hLvru2AgPVkCQuGM1/jTjweM3zGe+WP6KinPteTGFgPRCR2asddPS/XVDvk480k2nQnwrHmSTMONh8xNgDGdwPmAtFdWKr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oP5YIn+I; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oP5YIn+I"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=igfX93Ek/o5BTIQvnxOAKjm8TGoICNWPZi75TRtjCLs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791001716; v=1; x=1791606516;
 b=oP5YIn+IOYQKDS4bAMTz8jlWnPJ+beBddbiic/eQQaoXxtmQS+WmMpjXu2AFv81o/2YJMuhW
 qhr7CF5bsET6UvweJEQIDBVPQ2fhAitilIvrTvlFVMVa5PpFhY1k++lG8hEA00zOYM6DfY0zP+O
 vrP7hUOjdzCUNKk8nIyh+phk=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d41f557bf6bebaff;
	Sat, 03 Oct 2026 04:28:35 +0000
X-Mizu-Trace-ID: d41f557bf6bebaff
X-Migadu-Flow: FLOW_OUT
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [RFC v3 0/3] block: Introduce a BPF-based I/O scheduler
Date: Sat,  3 Oct 2026 12:27:45 +0800
Message-ID: <20261003042748.33795-1-kaitao.cheng@linux.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Hi,

This is the third RFC version of UFQ (User-programmable Flexible Queueing),
a BPF-based I/O scheduler for blk-mq. The goal is to let developers build
and iterate on I/O scheduling policies as BPF programs, with userspace
loaders handling configuration and attachment.

The code in this series is an intermediate version under active development
and continued iteration. I am posting it to seek community feedback on
whether the overall direction and design make sense, identify problems in
the approach, and get suggestions for improving the design.

UFQ provides the block-layer integration and request lifecycle management.
It exposes struct_ops callbacks for scheduler initialization and teardown,
request insertion, dispatch, completion, and request and bio merging.
Without an attached BPF scheduler, UFQ uses a simple per-ctx queueing
policy. Once a BPF scheduler is attached, its callbacks implement the
scheduling policy, while UFQ retains fallback handling for failed inserts
and resumes its built-in policy after detach.

The series contains three patches:

1. Add the UFQ elevator, struct_ops interface, and request-management and
   merge kfuncs.
2. Add ufq_simple, a minimal BPF scheduler for exercising the UFQ interface,
   together with userspace loading helpers and build scaffolding.
3. Add PFQ (Priority Fair Queue), a newly developed BPF scheduler that
   demonstrates a more complete policy on top of UFQ.

PFQ gives us a concrete policy to explore how well the UFQ interface
supports more involved scheduling decisions and to guide further work on
the framework. It has not yet been used in production, and further testing
and workload evaluation are needed.

The underlying BPF support needed by UFQ and its examples, including the
graph APIs and support for KF_SPINLOCK_SAFE kfuncs, has been merged upstream.
Those changes are therefore omitted from this version, which contains only
the UFQ framework and its example schedulers.

TODO:
- More thorough correctness and stress testing, including scheduler
  transitions, merging, and error paths.
- Evaluate PFQ fairness, latency, and throughput across workloads.
- Split the kernel implementation into smaller patches for review.

In particular, I would appreciate suggestions on the boundary between the
UFQ framework and BPF policies, the struct_ops interface, and request
ownership and fallback handling. Feedback on alternative approaches or
missing pieces would also help guide the next iteration.

Changes in v3:
- Add PFQ, its userspace loader, statistics, and usage documentation.
- Serialize BPF scheduler attach/detach and combine the callback enable
  state and user count into a single atomic state.
- Refine request reference handling and isolate failed BPF inserts on a
  separate fallback dispatch list.
- Use trylocks in merge kfuncs to avoid blocking on nested scheduler and
  ctx locks, and add a kfunc for setting request->elv.priv[1].
- Drop the BPF kfunc spin-lock support patch included in v2, since the
  required support has been merged upstream.

Changes in v2:
- Remove bpf_request_put (Alexei Starovoitov)
- Update the UFQ README (Miguel Ojeda)
- Add bio merge support
- Fix synchronization issues during UFQ scheduler transitions

Link to v2:
https://lore.kernel.org/all/20260503035623.28771-1-kaitao.cheng@linux.dev/

Link to v1:
https://lore.kernel.org/bpf/20260327114741.91500-1-pilgrimtao@gmail.com/

Kaitao Cheng (3):
  block: Introduce the UFQ I/O scheduler
  tools/ufq_iosched: add BPF example scheduler and build scaffolding
  tools/ufq_iosched: add PFQ eBPF I/O scheduler

 block/Kconfig.iosched                         |    8 +
 block/Makefile                                |    1 +
 block/blk-merge.c                             |   28 +-
 block/blk-mq.c                                |    8 +-
 block/blk-mq.h                                |    2 +-
 block/blk.h                                   |    5 +
 block/ufq-bpfops.c                            |  267 ++
 block/ufq-iosched.c                           |  789 +++++
 block/ufq-iosched.h                           |   79 +
 block/ufq-kfunc.c                             |  169 +
 tools/ufq_iosched/.gitignore                  |    2 +
 tools/ufq_iosched/Makefile                    |  262 ++
 tools/ufq_iosched/README.md                   |  198 ++
 .../include/bpf-compat/gnu/stubs.h            |    7 +
 tools/ufq_iosched/include/ufq/common.bpf.h    |   83 +
 tools/ufq_iosched/include/ufq/common.h        |   87 +
 tools/ufq_iosched/include/ufq/pfq.bpf.h       |  125 +
 tools/ufq_iosched/include/ufq/pfq_disk.h      |   38 +
 tools/ufq_iosched/include/ufq/pfq_stat.h      |   44 +
 tools/ufq_iosched/include/ufq/pfq_tunable.h   |   23 +
 tools/ufq_iosched/include/ufq/simple_stat.h   |   23 +
 tools/ufq_iosched/pfq.bpf.c                   | 2736 +++++++++++++++++
 tools/ufq_iosched/pfq.c                       |  329 ++
 tools/ufq_iosched/ufq_simple.bpf.c            |  604 ++++
 tools/ufq_iosched/ufq_simple.c                |  120 +
 25 files changed, 6024 insertions(+), 13 deletions(-)
 create mode 100644 block/ufq-bpfops.c
 create mode 100644 block/ufq-iosched.c
 create mode 100644 block/ufq-iosched.h
 create mode 100644 block/ufq-kfunc.c
 create mode 100644 tools/ufq_iosched/.gitignore
 create mode 100644 tools/ufq_iosched/Makefile
 create mode 100644 tools/ufq_iosched/README.md
 create mode 100644 tools/ufq_iosched/include/bpf-compat/gnu/stubs.h
 create mode 100644 tools/ufq_iosched/include/ufq/common.bpf.h
 create mode 100644 tools/ufq_iosched/include/ufq/common.h
 create mode 100644 tools/ufq_iosched/include/ufq/pfq.bpf.h
 create mode 100644 tools/ufq_iosched/include/ufq/pfq_disk.h
 create mode 100644 tools/ufq_iosched/include/ufq/pfq_stat.h
 create mode 100644 tools/ufq_iosched/include/ufq/pfq_tunable.h
 create mode 100644 tools/ufq_iosched/include/ufq/simple_stat.h
 create mode 100644 tools/ufq_iosched/pfq.bpf.c
 create mode 100644 tools/ufq_iosched/pfq.c
 create mode 100644 tools/ufq_iosched/ufq_simple.bpf.c
 create mode 100644 tools/ufq_iosched/ufq_simple.c

-- 
2.53.0

