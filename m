Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007447;
	b=gBd2nOu6QP9m7jf8WSbf65fX3+MdSKaSdmBWZsgZihtl1HUlNn9pwP04XPCc4ppowTzH
	 pVtR0FKGOoHig/o6WmlfZN9KC6ebaUsbEOXkkkib3hfa/yyQSOyXDj4TkeHmIay24ZzAs
	 YVlSL9QIQBuLqgJqv+pneBLFd6cgOYfS3E2a9gZGLU/tUMYhl8dyXNQhYIpcR9V38NAU0
	 /sFe+qISQ9uFttVTc4Y9cw6kfrJmjBmSE4oELk8VWc7d4w6sb4UXGbx/xCMkEhWvmx6gy
	 uOGixPnzyEGxW1BGvTDD/axvinNAiEH/Zq4tcDdIvEYFjcH7Unauq/zfdPeSnIgVulA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007447;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=G+7Zvegs7qt1nRSh/wHg70utm6ALKh4FLelSbXl2gqk=;
	b=GuzW9fi04ft0sl/cJTGKxJkmaX9n8NuJhL4IKV8wotShhfDC71GBSOcfFCArO8im5/S8
	 8niEf9u6GCKdWnY02TZOHw6ZVT6etO21mj5CeJbmZiIg26yNn9Ppw5NAxrmkVjTmrHMua
	 669iT+7F61ViNOp1aG4BT3rUmHN+d+BIBHli6VdFyevj4e527gcmXZ1PCCPQblYvTa2am
	 j3zre84tOxCv/LP3aCpqpt5nxGeg7f3kh9dAjeRxzoYQO9B8f3qkXhFX8lGpITR3O7BkG
	 pfLJK1VTpM5oEnRu4KM0d/7JKI9epOUqpA7QLkpa7hxLNRsSmo+EJhTmFAZ7Wlp+kGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dTLiT0tF;
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5CE606A32C
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A5CE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dTLiT0tF
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Fi9zG0kILVgw7gwn3q1iC/p76/mjXn21af0ZN83dwgk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795007444; v=1; x=1795612244;
 b=dTLiT0tF2czqpOIUvxG9NXf5qZcICa2Pdz2EhIbHr5GF6kkC15HhHcWZNEdCZaskH3Jc6zOH
 2G9g6bSvV/WtCcB24HKCo7ztZs79idmUhYwToxnn33cMj9IwC9+tu8fNucj7T8mcGaIhUB/mYxP
 CpKHyivqw9OptyXP8EnsHyWM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 95c49d686309c77b;
	Wed, 18 Nov 2026 13:10:42 +0000
X-Mizu-Trace-ID: 95c49d686309c77b
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk,
	ast@kernel.org,
	alexei.starovoitov@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	ameryhung@gmail.com
Subject: [RFC PATCH v14 0/4] blk-iocost: BPF struct_ops cost model
Date: Wed, 18 Nov 2026 21:10:25 +0800
Message-ID: <20261118131029.797007-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

This series lets a BPF program take over the cost model of one
device. The BPF model provides calc_cost() for charged IOs plus two
transfer coefficients for the completion-time sizing, io.cost.model
selects between the attached model and the builtin one, and enabling
and disabling the controller stays with io.cost.qos.

The builtin model is a linear formula derived from a handful of device
parameters, and the right formula is device specific. A BPF model can
be adapted to the device and updated without rebuilding the kernel.

The series is based on next-20261117.

Changes since v13:
 - p1: stop updating attached and attached_link under ioc->lock;
   rq_qos_mutex already orders all their accessors (review from tj)
 - p1: name the calc_cost flags enum iocost_calc_flags and rename
   ioc_model()/model to ioc_bpf_model()/bpf_model so that the
   builtin model isn't called a NULL model (review from tj)
 - p1: document why iocost holds its own model reference, the
   field locking and the merge flag semantics, and reword the
   commit message to describe guarantees instead of code paths
   (review from tj)
 - p1: clear the autop stepping timestamps when a BPF model is
   attached; without this, the timestamps from before the attach
   survive until a model=linear switchback and can trigger an
   immediate profile step on that stale pre-attach evidence
   (report from sashiko)
 - p1: align the BPF pricing scope with the builtin model:
   dataless bios with no flush state and ops other than reads,
   writes and zone appends cost nothing, completion-time sizing
   prices reads, writes and zone appends, and a dead owning map no
   longer reports -EBUSY (report from sashiko)
 - p3: probe the iocost_ioc_tick tracepoint, unwind the private
   mount namespace on setup failure, report fopen errors faithfully
   and fix an inverted posix_memalign() assertion that made the
   streams test skip its whole IO block (report from sashiko)
 - p2/p4: document the iocost_ioc_tick fields in the trace header
   and extend the io.cost.model docs with the dev supply and the
   -ENODEV attach conditions (report from sashiko)

Tested on next-20261117 (qemu x86_64): the selftests pass, and the 2x
example model doubles the charged cost over the builtin on a
rotational device (2.00x measured), returning to 1.00x after
"model=linear".

Link: https://lore.kernel.org/r/20261106122356.3224638-1-cui.tao@linux.dev # v13

Tao Cui (4):
  blk-iocost: add BPF struct_ops cost model support
  blk-iocost: add iocost_ioc_tick tracepoint for per-period device
    summary
  selftests/bpf: add iocost cost model test
  docs: cgroup-v2: document the iocost BPF cost model attachment

 Documentation/admin-guide/cgroup-v2.rst       |  55 +-
 MAINTAINERS                                   |   1 +
 block/Kconfig                                 |   4 +
 block/blk-iocost.c                            | 360 ++++++-
 include/trace/events/iocost.h                 |  57 ++
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/iocost_model.c   | 947 ++++++++++++++++++
 .../selftests/bpf/progs/iocost_model.c        | 188 ++++
 tools/testing/selftests/bpf/progs/iocost_ms.c | 195 ++++
 9 files changed, 1797 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iocost_model.c
 create mode 100644 tools/testing/selftests/bpf/progs/iocost_model.c
 create mode 100644 tools/testing/selftests/bpf/progs/iocost_ms.c
