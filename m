Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893293;
	b=Emmjg1CsXd4EDjIUpIqIXezKAqBuq4IRkny2WsyLy9JqiPjXOeLBuI/eN9fEtjxf/erz
	 vrA3vxs+pCa3QcMwiOwEsqrMnODHF9FnshqcwBoK9jid9qfouMf/bmVfxcnUV9P0sh8hF
	 vFGybx4kdKbxpp1BS537S37D5DkxyhniB0okm538e5qlIU25lSo6glxBlXcC0R7/sAnJo
	 a5rSydaNWZLHti/9MGG+tV4GCWDyCyIegL9UgMVsAzgLzMngtpHUfY5e5+07gHieat+J/
	 gOMVKLMXdVMk0k8Ln9Po1ysBYQScO9u9TcdtmYQZ1wZHnqgBXZ5rEPdgr+yv7fjTRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qLoQdF4EvfhL28QNvcz5mAbPrfEnrSCR6OB0l9IZmq8=;
	b=h8DXV0WcOEeSb1S0fl8CXPVX/onq+8S1IDX1Vsyo5Wu9CfnY2YwEGoKuwmqxlRRrNd9S
	 CPqvO+A8BVpUPflBizwESPRdfY38+m3nmMPuVTB0Rfy7TGaR5stNv90+p4BVjxqEnX46D
	 MAI7KdwueSuK9N22+i3uPaceDOXTYfNT5hjApu1aEnuP9RQepAmb32qey2Ux2O9Toy0QA
	 4vjs8j8yYmAVjfseGyr/ijiYK3bLP4da/u9V8ApNIsQ54qvN82dgoYHmrvH1iVXKfKZoC
	 1AIbJ3srQAGqigITPKuFT8sTVh4azhk49WXbJ/tz4gtxNGD5AMtL81+ixnrEASp0ngQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zi1cebqv;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD75606A330
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 05:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD75606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zi1cebqv
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso5174596eec.0
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794893292; x=1795498092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLoQdF4EvfhL28QNvcz5mAbPrfEnrSCR6OB0l9IZmq8=;
        b=zi1cebqvOoZpbddi9ING218Dw5D1ASIxZvEfzcvB4m0RfaxCWMUJrG3CGPupXuLAn9
         31yLuIFTxKydyY+rI1nKXzCnV686RcSRWX5utYL3YjQj2l1rIRLZo2Me+QQn2KFJq+2L
         bZTA5ZTHqWelMfcGB4ufX6rj1Z9JHgOKh6ZZvRh4o/RiCkBd4BIjlwfM1PhAdV9vJwXY
         K9sEHd48+2hmfi8MwC0Kvpz1+YZR0SPmvg6GR59jRFi6O9Si3FDN3D7RrV4gyND2/v8U
         AShLJ7H0+cgqxSmbxnGflOE/YjRSjKwltZiu1wCv3U4wXBmjN9hgwmDNxu7fiSWVYUrL
         tC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794893292; x=1795498092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLoQdF4EvfhL28QNvcz5mAbPrfEnrSCR6OB0l9IZmq8=;
        b=Hey1c93BpiD+mtpqqhvUFQxjS34pJzP2D3q2qtcYTxoAqL8+eFBWxjf6V+Apvj5mrj
         WWtvy0/NszPX4lN4wutXhGxhU3r3a/5rr/gRhtf0eotENqpR30135y+6Imo6fq4Chgy5
         ruYjtrMyr/1UgVPANw4ryDV05TWLqTfVKAelnrWmeXwWpXAbM6pV1q8kSxmH4sOafHHD
         vTyZYVETcuidviRRDdX9yI5/q01WF/8zJzC00tQx5hzBXP5/Gono0ZAgjcFhNROmXFg7
         eXqHtye1AmcH2p1Lw23sHYLlcrT67gbxpBJ1Z5Q9/jbDVeVnvsasD7dNEE5s1ZuTluaJ
         +IMA==
X-Gm-Message-State: APuU4Z/IDw1MONAmcI6gKLmGbdHaoDLNqVdYqWlLO/qfkDj3okiFLU0I
	v68hc0aQWdLk+JpJG7dfjnLklS2ubXnpPOoJmldabfef88GSMA6wmbGNeDYbCzeCf0k=
X-Gm-Gg: AZFdTZe5x81D2KMjQaS0SEsRNvbFkXQIMW9lnUPR8BxX+VmBCkSF6vgGT+nREI57LET
	QuvZSxkz2hpRZuvgqpbEbggzcCi+pRkAuQxMfyxM5/9aYC4KSXZER08+xznkqfoW5R6xoJNB225
	wEZWV1jRS/GBsVKQDys/Fef2lTGziKBqPuA6MrUemOlXpUMSfysFIP2kArnvCZ8if3A2DpwnRFn
	3euvmnzxfbdM6xS7ZOwEB3u1be+u96b204uij7Ro+S6wA9OjrK77u3kaoqZEw+Ufrer6jrkXWp4
	QQ8LybfdaLXhGLD+mD1c24XypZhP+vBlbriEYLMZxGDuTupSJUk6h2ZVUrhFhmfgJxLOOeECvlE
	6PSelJUEAImlU/Cm7pRlCNskpcE1JgiKFTw9wc6hcY4N+U9fxjWmVmghLiJW1oCZpVRhil1BTZl
	lJYI6NHqFFuqrTzu/IaSESM0fRckDEWBoUzRjCXJ2yxhtlmguNE4TbaEsrZZ6lW2kYoUtHVZ/pe
	GLsWXvN3YbcOHZofHO9xo6OqrTQQL80bKykpnY4lMHsHjqnYMcajP97pYkRVM0tP03S2NTRErzi
	4bojK0F0lKd5BgdxkAlDch95g3/M3DmPkD648hO8zSytes0v/npxA0jdeojHFujM4SHi0TISWEU
	k3RfJkSSHfMQGSrB+/6aICFw=
X-Received: by 2002:a05:7301:4206:b0:369:535f:4d12 with SMTP id 5a478bee46e88-37963a53df5mr11478566eec.3.1794893292400;
        Mon, 16 Nov 2026 21:28:12 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4182:5788:1d84:2750:6580:bea9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm41068384eec.9.2026.11.16.21.28.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 21:28:11 -0800 (PST)
From: Ankit Gupta <ankit6791@gmail.com>
To: linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ankit Gupta <ankit6791@gmail.com>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH blktests] nvme/080: test write zeroes larger than 65536 logical blocks
Date: Mon, 16 Nov 2026 21:26:10 -0800
Message-ID: <20261117052741.25471-1-ankit6791@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The NVMe Write Zeroes command encodes the number of logical blocks in a
zero-based 16-bit field. When the controller reports neither MDTS nor
WZSL, as nvmet-tcp does by default, the host advertised an unbounded
write zeroes limit, truncated the block count when building the command
and completed the request successfully after zeroing only a prefix.

Add a regression test for the kernel patch "nvme: limit Write Zeroes to
65536 logical blocks" [1]. Fill 65536 logical blocks plus 1 MiB with a
non-zero pattern, zero that range with blkdiscard -z and check that the
whole range reads back as zeroes. The length scales with the logical
block size, so the test covers both 512-byte and 4096-byte namespaces.

[1] https://lore.kernel.org/linux-nvme/20261117011230.10288-1-ankit6791@gmail.com/

Signed-off-by: Ankit Gupta <ankit6791@gmail.com>
---
Tested on arm64 with v7.4-rc3 (aebb72744764), NVMET_TRTYPES="loop tcp"
and NVMET_BLKDEV_TYPES="device file". Without the kernel patch the test
fails for tcp with both block device types ("zeroed range still contains
non-zero data"). With the patch it passes for tcp and loop with both
types. The device type gives 512-byte logical blocks (33 MiB zeroed) and
the file type 4096-byte logical blocks (257 MiB zeroed). With
NVME_IMG_SIZE=64m the device type still runs and the file type is
skipped.

Claude and Codex assisted with writing and validating this test.

 tests/nvme/080     | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/080.out |  2 ++
 2 files changed, 92 insertions(+)
 create mode 100755 tests/nvme/080
 create mode 100644 tests/nvme/080.out

diff --git a/tests/nvme/080 b/tests/nvme/080
new file mode 100755
index 0000000..bbd3031
--- /dev/null
+++ b/tests/nvme/080
@@ -0,0 +1,90 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Ankit Gupta
+#
+# Test that a Write Zeroes request larger than a single NVMe Write Zeroes
+# command can describe zeroes the whole requested range. The command encodes
+# the number of logical blocks in a zero-based 16-bit field, so one command
+# covers at most 65536 logical blocks. When the controller reports neither
+# MDTS nor WZSL, as nvmet-tcp does by default, the host used to advertise an
+# unbounded write zeroes limit, truncate the block count when building the
+# command and complete the request successfully after zeroing only a prefix.
+#
+# Regression test for the patch "nvme: limit Write Zeroes to 65536 logical
+# blocks".
+
+. tests/nvme/rc
+
+DESCRIPTION="test write zeroes larger than 65536 logical blocks"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_program blkdiscard
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
+}
+
+test_write_zeroes() {
+	local ns dev bs size len_mb
+
+	if ! ns=$(_find_nvme_ns "${def_subsys_uuid}"); then
+		echo "FAIL: failed to find the namespace"
+		return 1
+	fi
+	dev="/dev/${ns}"
+
+	if ! bs=$(blockdev --getss "${dev}") ||
+			! size=$(blockdev --getsize64 "${dev}"); then
+		echo "FAIL: failed to get the namespace block size and capacity"
+		return 1
+	fi
+
+	# 65536 logical blocks plus 1 MiB: 33 MiB with 512-byte logical blocks
+	# and 257 MiB with 4096-byte logical blocks.
+	len_mb=$((bs * 65536 / 1024 / 1024 + 1))
+	if ((len_mb * 1024 * 1024 > size)); then
+		SKIP_REASONS+=("namespace is smaller than ${len_mb} MiB")
+		return 1
+	fi
+
+	# Fill the range with non-zero data so that stale data is detectable.
+	if ! head -c "${len_mb}M" /dev/zero | tr '\0' '\377' |
+			dd of="${dev}" bs=1M iflag=fullblock oflag=direct \
+			status=none; then
+		echo "FAIL: failed to fill ${len_mb} MiB with a pattern"
+	fi
+
+	if ! blkdiscard -z -o 0 -l "${len_mb}M" "${dev}"; then
+		echo "FAIL: blkdiscard -z failed"
+	fi
+
+	if ! dd if="${dev}" bs=1M count="${len_mb}" iflag=direct status=none |
+			cmp -s -n "$((len_mb * 1024 * 1024))" - /dev/zero; then
+		echo "FAIL: zeroed range still contains non-zero data"
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+
+	if _nvme_connect_subsys; then
+		test_write_zeroes
+	else
+		echo "FAIL: failed to connect to the subsystem"
+	fi
+
+	_nvme_disconnect_subsys
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/080.out b/tests/nvme/080.out
new file mode 100644
index 0000000..15119b8
--- /dev/null
+++ b/tests/nvme/080.out
@@ -0,0 +1,2 @@
+Running nvme/080
+Test complete
-- 
2.50.1 (Apple Git-155)

