Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956789;
	b=TPOG28QJ5GZ2DKvXRsKph0Pjht+vnyuvHCBUyUCnNGk9XZ0ofy/X3gteRUk2fMZe71Em
	 xsrqQylMFIOIOsXe4q1Rlc4PlGWMv0y112Nm8V2MCn0/LOMWetUPIz5CE+4URwsLpf6Qh
	 m8naIlvGfezbvQ3DKwmCizm3Y1pq7Ss4IxKDCX2li37SzQLuKRJFfp/ayaY/hLT8IuHhJ
	 RzPfgz7iZq7UWOq/tO4toaPwtmnJU7/yT93fr6fbxRkj3lfvxjGUf/9QaYt+zUd0bCHwN
	 3fujgMvocUoidmR0Ol4HJ2hrJKjPJGPoUtkCY1NP6OZRkQe7LAEaodlU988RSGkqYYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=evjYsb09S0TgOw02p0STuAlXIjc/A3541+khH0GBgyQ=;
	b=B7QA8+oH9BquHFRriKVouVKHPJRg7TVvZTnZTqdNT24y22gWtCA+mESkoI8kx6XGkIAq
	 OjMsKB7g8rOOHf5kIKeekvxq8p3ir2e2o6GmRGh5Lh9+keI7hbSb3byjOYThrndCC0jpE
	 HBhnydI0+uw7uGNAPZrQU4rmXwjRCVo7BTj7hM2Fi8X1my2Bd7SCqc6irxsFqxM6lGF4G
	 Kxx8sGlau0G4sfSkbzugiD7XEyh4MDb+PqlZMrWqoB+LUVyQaO21aCtTi+NyP2viY4dia
	 dU4jXtH3utTgV2uvqrfpdFo52qsOwqB75zxhaOibW9apqbGd5EZ4/0xZ7V7KPsTBA+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Pc2dfD+T;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA550606A335
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 23:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA550606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Pc2dfD+T
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jTgMm15F5zlqdqt;
	Tue, 17 Nov 2026 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1794956784; x=1797548785; bh=evjYsb09S0TgOw02p0STuAlXIjc/A3541+k
	hH0GBgyQ=; b=Pc2dfD+T9J1FsyQv1WtG+SBHXWo2IJcoL9DiGHUqFfqCyngP6mU
	CABvUeqig3jvfvRMfpTJeNdtGUczay/YWMdFlgw0OlWUm/TWcJV1ImH1kyASyoi9
	AveF3rPaaAEfWhOmaX+PpSmu/UUXGrAUswAuXtZgVQXrTPBe4RMigoZwc46++NSY
	EmaxjXv05gGmaKX7OXqhKbTF7FDGxQz8wO10pIec5uSwxsrnH+22lWrb+ctca6qQ
	hyFVQjgLqxja9cDcItY7KIHpltmm0Ct7fB8kQQzYGe6n5nVcttFtiSWoByqiQuzy
	JpOqW1hXRkaqJatxvxS1v+wy/Z1+aJDQdAQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fhjqvmI3PrqT; Tue, 17 Nov 2026 23:06:24 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jTgMh4zlczlpJ45;
	Tue, 17 Nov 2026 23:06:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests] nbd/006: Measure NBD IOPS with a null_blk backing device
Date: Tue, 17 Nov 2026 15:06:13 -0800
Message-ID: <20261117230613.3989814-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test that measures the maximum number of random read and random
write IOPS that the NBD driver can achieve. Such a test is useful to
detect performance regressions in the NBD driver and to evaluate NBD
performance optimizations.

Minimize the overhead outside the NBD driver as follows:
- Back the NBD export with a 1 GiB null_blk device that is tuned for
  maximum IOPS: no memory backing, immediate completion, a 4 KiB logical
  block size, one hardware queue per CPU and a hardware queue depth of
  1024. Keep the device small because nbd-server opens the exported
  device without O_DIRECT and hence all NBD I/O passes through the page
  cache of the null_blk device.
- Select the "none" I/O scheduler for the null_blk device and disable
  readahead such that each 4 KiB NBD read results in a single 4 KiB read
  of the null_blk device.
- Connect nbd-client and nbd-server over a Unix domain socket if
  nbd-client supports the -unix option. Fall back to a TCP connection
  over the loopback interface otherwise.
- Use one NBD connection per CPU, with a maximum of 16 connections.
- Measure the IOPS with fio using the io_uring I/O engine, the "none" I/O
  scheduler for the NBD device, direct I/O, 4 KiB requests, a queue depth
  of 64 and one job per NBD connection. Run a random read pass and a
  random write pass that each take half of the test time and report the
  results via the "read iops" and "write iops" performance fields.

Note: since nbd-server performs buffered writes, the write IOPS mainly
reflect how fast nbd-server can dirty pages in the page cache.

Fail the test if configuring the null_blk request queue fails or if
nbd-server does not start listening in time.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/nbd/006     | 159 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/006.out |   2 +
 2 files changed, 161 insertions(+)
 create mode 100755 tests/nbd/006
 create mode 100644 tests/nbd/006.out

diff --git a/tests/nbd/006 b/tests/nbd/006
new file mode 100755
index 000000000000..cd3e705f4b2f
--- /dev/null
+++ b/tests/nbd/006
@@ -0,0 +1,159 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Google LLC
+#
+# Measure the random read and random write IOPS of an NBD device that is=
 backed
+# by a null_blk device. Use a Unix domain socket for the NBD connections=
 if
+# supported by nbd-client and nbd-server and TCP otherwise.
+
+. tests/nbd/rc
+. common/null_blk
+
+DESCRIPTION=3D"measure NBD read and write IOPS with null_blk as backing =
device"
+TIMED=3D1
+
+requires() {
+	_have_nbd
+	_have_null_blk
+	_have_fio
+}
+
+# Whether nbd-client supports connecting over a Unix domain socket. The
+# nbd-server "unixsock" configuration option has been introduced in the =
same
+# nbd release as the nbd-client -unix option.
+_nbd_have_unix_socket() {
+	nbd-client --help 2>&1 | grep -q -- '-unix'
+}
+
+test() {
+	local nullb=3Dnullb1 nullb_dev=3D/dev/nullb1 nbd_dev=3D/dev/nbd0
+	local sock=3D"${TMPDIR}/nbd.sock" pid_file=3D"${TMPDIR}/nbd.pid"
+	local -i nr_cpus nr_conns i
+	local -a connect_args
+	local use_unix=3D0
+
+	echo "Running ${TEST_NAME}"
+
+	nr_cpus=3D$(nproc)
+	nr_conns=3D$((nr_cpus < 16 ? nr_cpus : 16))
+
+	# Load null_blk without creating any device and next create a single
+	# null_blk device via configfs that is tuned for maximum IOPS: no
+	# memory backing, immediate completion and one hardware queue per CPU.
+	if ! _init_null_blk nr_devices=3D0; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	local nullb_params=3D(
+		blocksize=3D4096
+		completion_nsec=3D0
+		hw_queue_depth=3D1024
+		irqmode=3D0
+		memory_backed=3D0
+		queue_mode=3D2
+		size=3D1024	# MiB
+		submit_queues=3D"$nr_cpus"
+		power=3D1
+	)
+	if ! _configure_null_blk "$nullb" "${nullb_params[@]}"; then
+		echo "Configuring null_blk failed"
+		_exit_null_blk
+		return 1
+	fi
+	# nbd-server opens the exported device without O_DIRECT. Disable
+	# readahead such that each NBD read causes a single 4 KiB read of the
+	# null_blk device.
+	if ! _write_queue_sched none "/sys/block/${nullb}/queue/scheduler" ||
+	   ! grep -q '\[none\]' "/sys/block/${nullb}/queue/scheduler" ||
+	   ! echo 0 > "/sys/block/${nullb}/queue/read_ahead_kb"; then
+		echo "Configuring the ${nullb} request queue failed"
+		_exit_null_blk
+		return 1
+	fi
+
+	_nbd_have_unix_socket && use_unix=3D1
+
+	{
+		echo "[generic]"
+		echo "allowlist=3Dtrue"
+		if ((use_unix)); then
+			echo "unixsock=3D${sock}"
+		fi
+		echo "[export]"
+		echo "exportname=3D${nullb_dev}"
+	} > "${TMPDIR}/nbd.conf"
+	cat "${TMPDIR}/nbd.conf" >> "$FULL"
+
+	if ! nbd-server -p "$pid_file" -C "${TMPDIR}/nbd.conf" \
+	     >> "$FULL" 2>&1; then
+		echo "Starting nbd-server failed"
+		_exit_null_blk
+		return 1
+	fi
+
+	if ((use_unix)); then
+		echo "Using Unix domain socket ${sock}" >> "$FULL"
+		connect_args=3D(-unix "$sock")
+		for ((i =3D 0; i < 100; i++)); do
+			[[ -S "$sock" ]] && break
+			sleep .1
+		done
+	else
+		echo "Using TCP socket" >> "$FULL"
+		connect_args=3D(localhost)
+		for ((i =3D 0; i < 100; i++)); do
+			nbd-client -l localhost >> "$FULL" 2>&1 && break
+			sleep .1
+		done
+	fi
+	if ((i >=3D 100)); then
+		echo "Timeout while waiting for nbd-server"
+		kill -SIGTERM "$(cat "$pid_file")"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Use -connections instead of -C because some nbd-client versions
+	# do not declare that -C takes an argument and pass a NULL pointer
+	# to strtol() if -C is used.
+	if ! nbd-client -L -N export -connections "$nr_conns" -b 4096 \
+	     "${connect_args[@]}" "$nbd_dev" >> "$FULL" 2>&1 ||
+	   ! _wait_for_nbd_connect; then
+		echo "Connecting to nbd-server failed"
+		kill -SIGTERM "$(cat "$pid_file")"
+		_exit_null_blk
+		return 1
+	fi
+	udevadm settle
+
+	# _run_fio passes --group_reporting=3D1 and --runtime=3D"$TIMEOUT" to f=
io.
+	: "${TIMEOUT:=3D60}"
+	_divide_timeout 2
+
+	local fio_params=3D(
+		--bs=3D4k
+		--direct=3D1
+		--filename=3D"$nbd_dev"
+		--iodepth=3D64
+		--ioengine=3Dio_uring
+		--ioscheduler=3Dnone
+		--norandommap
+		--numjobs=3D"$nr_conns"
+		--time_based=3D1
+	)
+	local rw
+	for rw in read write; do
+		FIO_PERF_FIELDS=3D("${rw} iops")
+		_fio_perf --name=3D"nbd-${rw}-iops" --rw=3D"rand${rw}" \
+			  "${fio_params[@]}"
+	done
+
+	nbd-client -d "$nbd_dev" >> "$FULL" 2>&1
+	_wait_for_nbd_disconnect
+	kill -SIGTERM "$(cat "$pid_file")"
+	rm -f "$pid_file" "$sock"
+	udevadm settle
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/nbd/006.out b/tests/nbd/006.out
new file mode 100644
index 000000000000..acc8af5bfb2e
--- /dev/null
+++ b/tests/nbd/006.out
@@ -0,0 +1,2 @@
+Running nbd/006
+Test complete
