Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967856;
	b=3kUVQvC2ej3IxmLGzCshoM75b9hlC7qlBZyUtTZhJaYtpJc5U3boLmKMKwImlElMUgvl
	 p1rcs5Sv/eNF9WsiZ4VtoC/x3AO79tIXji8HTT5Pb1X+InC62RNWWTmwCmNnpQsDCDx2C
	 NVoMHD/sdK41cmz3FFK5gdc1vzB5AnGTeAFzsFdGWpA2lFNwho9TP5e+CAKQlShvMSCbS
	 6x5Wp/S7QnczUrR3r0MtJYuNCuMcUFnH1VWWnDosG/QySH34OoK2iGJ/wCsVjIJJ9u4V2
	 L+oLCwjNkAPC38h1Jo3rCYOrPvoYYJwviz/lBOQI8rRn67kvZh4r+OL4nfiFmDcElMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967856;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+WnGg6RHgnyqDd5ldVy5BEuIn5Cw/n9Yw7ajiiWZxlI=;
	b=H9KjDNR0TyfdYShFFuI63fVDKqSaPGh4D0ia9Dl2+CB4nByZzebY7+f7/T2z1xmZmYP9
	 fvf4+AYialbcBoqIjz5GUUl6BIGu295Ufk48x1eX8MBsnRwBjwqDo5Q2BHgV3OILPFKQj
	 X1aTUzfZLSCzG7MVbonIy0eKvwuf+mzMMZYlYwn343RdQbp1wP+bbwpzmCcPvdy4E8/3v
	 ZtzuYUp2nmq+6Z/YQDnheAPrqe01LALNEovmVLqUQpQLJwUhhlGzHofOTRIa91NryuTHj
	 9ycGRRRARvlGWNaSmQqG/V1hqvMSTfWylkmk+U4Ptx021rPB9VBXBMi91UYl4QInZWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c6TY7xq8;
	arc=none smtp.remote-ip=91.218.175.106
Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C066606A326
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 12:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C066606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c6TY7xq8
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h/NpQVbSX0lmFSKYQ4kXG0v09GVq/A5mrfxqP7xtn18=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793967853; v=1; x=1794572653;
 b=c6TY7xq883Haj25OXqwpRsd4NIM3krJcHN0WzFuy1+uDp9Me8N96kyYLRSTGIAW9r+g6/aaj
 BlyvACGixAkQZIk3B5PDaxB4cNlwJoqzVVX94cVQFMwKJFPqARyJgz6vVxwvQtxd9rEQzoSq0B+
 6t8bl95TWsNXIKRdw2eGmM34=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 69ffad1ec8c56768;
	Fri, 06 Nov 2026 12:24:13 +0000
X-Mizu-Trace-ID: 69ffad1ec8c56768
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk,
	alexei.starovoitov@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	ameryhung@gmail.com
Subject: [RFC PATCH v13 0/4] blk-iocost: BPF struct_ops cost model
Date: Fri,  6 Nov 2026 20:23:52 +0800
Message-ID: <20261106122356.3224638-1-cui.tao@linux.dev>
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
device.  The BPF model provides calc_cost() for charged IOs plus two
transfer coefficients for the completion-time sizing, io.cost.model
selects between the attached model and the builtin one, and enabling
and disabling the controller stays with io.cost.qos.

The builtin model is a linear formula derived from a handful of device
parameters, and the right formula is device specific.  A BPF model can
be adapted to the device and updated without rebuilding the kernel.

The series is based on next-20261105.

Tao Cui (4):
  blk-iocost: add BPF struct_ops cost model support
  blk-iocost: add iocost_ioc_tick tracepoint for per-period device
    summary
  selftests/bpf: add iocost cost model test
  docs: cgroup-v2: document the iocost BPF cost model attachment

 Documentation/admin-guide/cgroup-v2.rst       |  49 +-
 MAINTAINERS                                   |   1 +
 block/Kconfig                                 |   4 +
 block/blk-iocost.c                            | 284 +++++-
 include/trace/events/iocost.h                 |  43 +
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/iocost_model.c   | 812 ++++++++++++++++++
 .../selftests/bpf/progs/iocost_model.c        | 180 ++++
 tools/testing/selftests/bpf/progs/iocost_ms.c | 197 +++++
 9 files changed, 1560 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iocost_model.c
 create mode 100644 tools/testing/selftests/bpf/progs/iocost_model.c
 create mode 100644 tools/testing/selftests/bpf/progs/iocost_ms.c

Changes since v12:

- the iocost_ioc_tick emission now sits inside the
  trace_iocost_ioc_tick_enabled() check, as tracepoints.rst requires,
  and the usage_pct trace field is widened to u64
- detaching a model resets the autop stepping timestamps, so the
  cooldown restarts fresh when the builtin model comes back
- iocost_bpf_supported() probes kernel BTF for the struct_ops wrapper
  type instead of /proc/config.gz, so an unavailable config no longer
  skips the tests, and the probe result is cached across cases
- the selftest sets up its private mount namespace and configfs mount
  once instead of stacking them across cases
- the multi-stream case feeds two interleaved streams and asserts that
  calc_cost() actually priced them
- the selftest cgroup names are created inside the per-pid work
  directory (leading '/'), nullb_create() rolls back the instance on
  its own error paths, and the streams test cleans up in the right
  order
- docs: document the attach rejection codes (-EOPNOTSUPP, -ENODEV,
  -EBUSY) and that root-cgroup IOs still use the attached model's
  transfer coefficients for completion-time sizing

Tested on next-20261105 (qemu x86_64): the selftests pass, and the 2x
example model doubles the charged cost over the builtin on a
rotational device (2.00x measured), returning to 1.00x after
"model=linear".

Link: https://lore.kernel.org/r/20261103132613.1952975-1-cui.tao@linux.dev # v12
