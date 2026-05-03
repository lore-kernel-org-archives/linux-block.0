Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890239890A
	for <linux-block@vger.kernel.org>; Sun,  3 May 2026 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780630; cv=none; b=XyLvrA8byKop3CVXIuURCDFgez5HZ0LL5KL2XK6/TXVdp2kCdf0/AIL3QIT1ewUNIsHv9OS65wpox0YbIlMYAEKNS9eARL5naTcFq8cGtI/ZJ1jayJJmlGgRgB8Vv1Htldr/KpFffAw0CS+Qq8Ov3hIbx3y4KVfM2Quel0OBa7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780630; c=relaxed/simple;
	bh=hAE6HCqRG8x2SlEJpkqJka2MHr8n993wVwxNdtqP7vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiWMpb1kjx6z+CNReeeuARpUXSGdiqDZ+AFqhAmTGW+qDmbAiQ7FuKBZ0WU76wby34VOWF12EegEvIm5dD0dBOSe7ykRfcHWaGKxF+eZA8ui3mAyTGepsHlYtL4P2IwraOXMLzxHVIlfBlc513PIzAYOfb6+2SpAggf2SwN55ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TiitcpSf; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TiitcpSf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777780616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qrpZPxwTHWgxoPwD/KyFHZZa8ge1uutA4flbtd9qwuk=;
	b=TiitcpSfUxBNu8lDHPowCSao5yr+71nw5UMqB3Pvqyg67vs/XUT26w4wKvEXdBHxQs4u32
	LxMaCTzEF3qQLtl7DVb8uu6MQzbQjbUtRQvUPlQBisTv/WuCu2mzjCv1bVM8QuBqcVICGp
	onjb7wf9sVnK4ysyBrZX3qdkNdg4KPA=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: axboe@kernel.dk,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao cheng <kaitao.cheng@linux.dev>
Subject: [RFC v2 0/3] block: Introduce a BPF-based I/O scheduler
Date: Sun,  3 May 2026 11:56:20 +0800
Message-ID: <20260503035623.28771-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I have been working on adding a new BPF-based I/O scheduler. It has both
kernel and user-space parts. In kernel space, using per-ctx, I implemented
a simple elevator that exposes a set of BPF hooks. The goal is to move the
policy side of I/O scheduling out of the kernel and into user space, which
should greatly increase flexibility and applicability. To verify that the
whole stack works end to end, I wrote a simple BPF example program. I am
calling this feature the UFQ (User-programmable Flexible Queueing) I/O
scheduler.

This patch depends on new BPF functionality that I have already posted to
the BPF community but that is not yet in mainline. Details are in the
thread:

https://lore.kernel.org/bpf/20260427165906.84420-1-kaitao.cheng@linux.dev/

To try it, you need to apply the patches from that series first.

I am looking for community feedback on whether this direction and the
implementation approach make sense, and what else we should
consider.

todo:
1. More thorough testing
2. Split the code into multiple sub-patches
3. Identify concrete use cases

Changes in v2:
- Remove bpf_request_put (Alexei Starovoitov)
- Update the UFQ README (Miguel Ojeda)
- Add bio merge support
- Fix synchronization issues during UFQ scheduler transitions

Link to v1:
https://lore.kernel.org/bpf/20260327114741.91500-1-pilgrimtao@gmail.com/

Kaitao Cheng (3):
  bpf: Add KF_SPIN_LOCK flag for kfuncs under bpf_spin_lock
  block: Introduce the UFQ I/O scheduler
  tools/ufq_iosched: add BPF example scheduler and build scaffolding

 block/Kconfig.iosched                         |   8 +
 block/Makefile                                |   1 +
 block/blk-merge.c                             |  28 +-
 block/blk-mq.c                                |   8 +-
 block/blk-mq.h                                |   2 +-
 block/blk.h                                   |   5 +
 block/ufq-bpfops.c                            | 241 +++++++
 block/ufq-iosched.c                           | 640 ++++++++++++++++++
 block/ufq-iosched.h                           |  64 ++
 block/ufq-kfunc.c                             | 131 ++++
 include/linux/btf.h                           |   1 +
 kernel/bpf/verifier.c                         |  20 +-
 tools/ufq_iosched/.gitignore                  |   2 +
 tools/ufq_iosched/Makefile                    | 262 +++++++
 tools/ufq_iosched/README.md                   | 145 ++++
 .../include/bpf-compat/gnu/stubs.h            |  12 +
 tools/ufq_iosched/include/ufq/common.bpf.h    |  75 ++
 tools/ufq_iosched/include/ufq/common.h        |  90 +++
 tools/ufq_iosched/include/ufq/simple_stat.h   |  23 +
 tools/ufq_iosched/ufq_simple.bpf.c            | 604 +++++++++++++++++
 tools/ufq_iosched/ufq_simple.c                | 120 ++++
 21 files changed, 2464 insertions(+), 18 deletions(-)
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
 create mode 100644 tools/ufq_iosched/include/ufq/simple_stat.h
 create mode 100644 tools/ufq_iosched/ufq_simple.bpf.c
 create mode 100644 tools/ufq_iosched/ufq_simple.c

-- 
2.50.1 (Apple Git-155)

