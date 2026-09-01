Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EB35BDDB;
	Tue,  1 Sep 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284413; cv=none; b=qG+BU3V8dR2TesrTyXBvf7iXiv28lhSTOIHfUMgSR5VTpNfzVkYR+ju2Y8gcegPJgu6HjjIJS8KGiNucJQmTI/iUb48ts2nJ4PwUK6+nlplWh8O7LqUULmiiMbWAzqb0cNLbZVulJJ4VghNBNLoDj3x2hjcWtz+FN2YhAGFI+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284413; c=relaxed/simple;
	bh=1Ht3yjlTvtc8/eirxqfsyimikew5ju7FlokWRWgmhsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlVoRRGQ/XCYDfsgHG0d2R7ZZ3CkQ+z5dVsU12R2t0jZmAKT1ylxFtTaBMNDoxPEoO2Uj8WWz7oxmvTtm+6UyW4GD3iWDdq5eaNXSDra5jUUCHTdIErP2XgQZYv/X4+MfzRwY8oSnw3gbDm8lEah0yh3+W7pNplP9t5oFwoYpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Ozn3ovuC; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Ozn3ovuC"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788284403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGZpv4j6PAsaPOPSHpSq9llUSCcuSZCHp5WMqPEkyMo=;
	b=Ozn3ovuCUz0rUwWg1Ny38mEK48LMSUhhBKh/nky5dkQGzm/pw7Nh9HcywL5fCq7cb4sjWP
	fEVXnJ1LTTFCJ3uLlGP6CyA9SNIOufpcsXZYVr6N7gSZ6nHrOmB/ZKHMxHrINL0ynBTuU+
	tnQbajr+8S5/yCwJo+VaO7AsiNaHcZs=
To: axboe@kernel.dk
Cc: Stian Halseth <stian@itx.no>,
	linux-block@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas@gaisler.com,
	davem@davemloft.net,
	glaubitz@physik.fu-berlin.de,
	regressions@lists.linux.dev
Subject: [PATCH 0/2] sunvdc: fix silent data loss under LDC congestion
Date: Tue,  1 Sep 2026 19:39:44 +0200
Message-ID: <20260901173947.3292110-1-stian@itx.no>
In-Reply-To: <24f8b266-f17c-4909-b43d-8ab05721c5d8@kernel.dk>
References: <24f8b266-f17c-4909-b43d-8ab05721c5d8@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop
when vio_ldc_send() returns EAGAIN"), Linux guests in LDOMs see
occasional spurious write failures that manifest as filesystem
corruption. The failure signature is:

    sunvdc: vdc_tx_trigger() failure, err=-11
    I/O error, dev vdiskc, sector ... op 0x1:(WRITE) ...
    vdiskc: writeback error on inode ...

The buffered writeback data is silently dropped. A revert was
rejected [1]; Jens proposed requeuing instead [2], but that patch,
tested in October 2025, appeared to leak memory and the effort
stalled [3].

The leak is real and diagnosed: __send_request() maps the request's
pages into the LDC channel's fixed-size map table (ldc_map_sg())
before ringing the doorbell, and the trigger-failure path never
unmaps them. A descriptor whose doorbell was never sent never
completes, and since dr->prod is not advanced, vdc_requeue_inflight()
never visits it either. With the requeue approach every retry remaps
the same descriptor, orphaning the previous mapping; the 8192-entry
per-channel table drains (contiguous allocation makes large requests
fail first as it fragments) and the disk eventually dies with
-ENOMEM. Mainline leaks the same way, once per spurious EIO.

Patch 1 fixes the leak (also a standalone mainline fix). Patch 2 is
Jens' requeue patch, unchanged, on top.

Why the bounded busy-loop cannot be "tuned" instead: the LDC tx
queue holds 128 doorbell messages while the dring holds 512
in-flight descriptors. Any writeback burst of >128 requests
(ordinary for XFS multi-stream writeback) overflows the message
queue whenever the vds service thread in the primary domain is busy
for a few milliseconds - e.g. one txg sync on the backing pool.
This is normal flow control, not an error condition; OpenBoot's own
disk driver retries it indefinitely.

Testing on an UltraSPARC T4 LDOM (Debian sid guest, 8 vcpu, disk on
a zvol served by a Solaris 11.4 primary), workload = 8-way parallel
kernel-tree copies plus periodic 512-file sync bursts on XFS:

 - Unpatched (7.2.2 + nothing): three failure events in 3.6 hours,
   each losing writeback data, on an otherwise near-idle host.
 - Patched (7.2.2 + this series), identical workload: the same
   trigger fired (vdc_tx_trigger message logged) and was absorbed by
   the requeue - no I/O error, no data loss, no checksum mismatch in
   the verified copies.

Independently, the tester who found the October 2025 memory leak has
re-run his original harness (parallel tree copies, SPARC T4-2, 6.18
plus this series): 20 hours, ~130M IOPS across six cores, 861
requests requeued after EAGAIN timeouts, no memory leak observed [3].
In the original run of that harness, those events surfaced as EIO
and the leaked mappings eventually took the LDom down.

A note on semantics: with this series a permanently unresponsive
backend parks I/O indefinitely (as pre-a11f6ca9aef9 kernels and
Solaris guests do) instead of failing after ~10ms. The per-vdisk
"timeout" property (ldm set-vdisk timeout=N) remains the bounding
knob for deployments that prefer failure over waiting.

[1] https://lore.kernel.org/all/20251006100226.4246-2-glaubitz@physik.fu-berlin.de/
[2] https://lore.kernel.org/all/418310b3-2b77-4534-b2fd-27dcc11e333c@kernel.dk/
[3] https://github.com/sparclinux/issues/issues/2

Stian Halseth (1):
  sunvdc: unmap LDC cookies when the descriptor send fails

Jens Axboe (1):
  sunvdc: fix -EIO issue due to lack of retries

 drivers/block/sunvdc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 1 deletion(-)

--
2.53.0
