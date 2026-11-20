Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210493;
	b=qSq6ccX7yVCO9ZIOyaBNpPkqpGp8W7RUIQhtK8rJPN4fLpt+C43YW3MzszVj9tNUXjKj
	 dFQBphS68M8jhMS6AATIcO4vo9w4Y17F3BdBgBLoVaMDtjsHw6l2OWjUUDkj+A3kWKxfC
	 yfGJ+TGmB5udETfKX+oOLr0b5TGPXN7nq5coRaFaM2/93dymkTYaGaVsUQ+cRISo4OkMz
	 VqHNc5S5UWbZXc0JGoQ3xK11WeweoskHJfcj9gKh/VPUxg6pn2YF0yg9JFp6DsofKhThd
	 UnW+LbjFjJKwKlvkpNpjg7LiPCk7tickuKuTMtnrxqDsK5IHKJUbnXao7xZBUzbkjkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ixqEQhxCSYNvAqG4phx85VgTo8bxWOftif5SyDFQrII=;
	b=ef9WdS3WZaLDSeTWG6iPODnh0zxRLk0Xtft3cMFLMoT8h03eCQeHU1S65pZY+3BATaY6
	 tr95RAbMjg7EgavBgN70UFo/Tpniy8sWCfjmiRTE8Kk2Wh4+83jhVSz5jCS0+wpJy272P
	 JdAcYQRGCX9QD8WX9cSeveX4+jl5Zx9q/Trsl5NBJnYWW1TjdwYWVliQeSUAW4jPh2kbc
	 Pwy8uR5FpWE5eukwYP+e4qvi9oQIiK7DcOJkAN+U9lA9z/zfjYhHTn2IjP/rDHS41rtRX
	 15RWa2WzYIaLARgLE4qI0VG12KEOlx2VNx6MbupmiB4bLr+L0Tt/QQk5pE5rkZN5uKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=aNM0paYX;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6160A2636
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 21:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C6160A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=aNM0paYX
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jWTBb4Qhxz1XM0p5;
	Fri, 20 Nov 2026 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1795210483; x=1797802484; bh=ixqEQ
	hxCSYNvAqG4phx85VgTo8bxWOftif5SyDFQrII=; b=aNM0paYX59yQo0id4eZ4v
	tGihu2LMWM3MOiVlDBY8JyPjwmnhh9EhLQrBReVtox9OSlJfemTMbyOUQZmNus56
	PhhrnUBmOfgtzrRrZy0sOtN8SrvZjNA7sLCr9stafs7RkLkfTxj7ndMZwwTba/7+
	cYZxPInbz5kdn9Ljm/UQSeS82aHvMO2Gv4Ef5BDHi/TfBzIJFf+0D8DOl9Ac40IW
	Mn7w5v+VuxnGgRQf4e8bc4l2239hIlWWBk7Nw/kGtBkECwqtOfFYIM0bT+1k1XPm
	AmgoOkQebNAMINrAdu/5IXoXoN2lRMFsS8YY7vJvL7E8Fki82WbqmALCZ3vHVOSn
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WRt4PBcOrqGn; Fri, 20 Nov 2026 21:34:43 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jWTBV44pfz1XLyP5;
	Fri, 20 Nov 2026 21:34:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 2/2] nbd/006: Measure NBD IOPS with a null_blk backing device
Date: Fri, 20 Nov 2026 13:34:34 -0800
Message-ID: <20261120213434.2945873-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261120213434.2945873-1-bvanassche@acm.org>
References: <20261120213434.2945873-1-bvanassche@acm.org>
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

Add a test that measures the random read and random write IOPS that the
NBD driver can achieve, both for a single outstanding request and for
the maximum achievable parallelism. Such a test is useful to detect
latency and throughput regressions in the NBD driver and to evaluate NBD
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
  nbd-client supports the -unix option and nbd-server supports the
  "unixsock" configuration option. Fall back to a TCP connection over
  the loopback interface otherwise or if the Unix domain socket does not
  appear.
- Use one NBD connection per CPU, with a maximum of 16 connections.
- Measure the IOPS with fio using the io_uring I/O engine, the "none" I/O
  scheduler for the NBD device, direct I/O and 4 KiB requests.

Run fio four times, each run taking a quarter of the test time:
- Random reads and random writes with a single job and a queue depth of
  one. These results reflect the NBD round-trip latency.
- Random reads and random writes with one job per NBD connection and a
  queue depth of 64. These results reflect the maximum NBD throughput.

Report the results via the "read iops" and "write iops" performance
fields, prefixed with "numjobs=3D<n> iodepth=3D<d> " to tell the two
configurations apart.

Note: since nbd-server performs buffered writes, the write IOPS mainly
reflect how fast nbd-server can dirty pages in the page cache.

Fail the test if configuring the null_blk request queue fails or if
nbd-server does not start listening on the TCP port in time. Fall back
to TCP instead of failing if the Unix domain socket does not appear in
time.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/nbd/006     | 202 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/006.out |   2 +
 2 files changed, 204 insertions(+)
 create mode 100755 tests/nbd/006
 create mode 100644 tests/nbd/006.out

diff --git a/tests/nbd/006 b/tests/nbd/006
new file mode 100755
index 000000000000..03bb0fc66bb4
--- /dev/null
+++ b/tests/nbd/006
@@ -0,0 +1,202 @@
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
+# Whether both nbd-client and nbd-server support Unix domain sockets:
+# nbd-client must support the -unix option and nbd-server must recognize=
 the
+# "unixsock" configuration option. Since nbd-server does not report whic=
h
+# configuration options it supports, look for the option name in the
+# nbd-server executable.
+_nbd_have_unix_socket() {
+	local server
+
+	nbd-client --help 2>&1 |
+		grep -qE -- '(^|[^[:alnum:]-])-unix([^[:alnum:]-]|$)' || return 1
+	server=3D$(type -P nbd-server) || return 1
+	grep -aqw unixsock "$server"
+}
+
+# Undo those setup steps of test() that have been completed. Uses the lo=
cal
+# variables of test() via dynamic scoping.
+cleanup() {
+	local -i j
+	local pid
+
+	if ((nbd_connected)); then
+		nbd-client -d "$nbd_dev" >> "$FULL" 2>&1
+		_wait_for_nbd_disconnect
+	fi
+	if [[ -s "$pid_file" ]]; then
+		pid=3D$(<"$pid_file")
+		kill -SIGTERM "$pid"
+		# Wait until nbd-server has exited such that it no longer keeps
+		# the null_blk device open.
+		for ((j =3D 0; j < 100; j++)); do
+			kill -0 "$pid" 2>/dev/null || break
+			sleep .1
+		done
+	fi
+	rm -f "$pid_file" "$sock"
+	udevadm settle
+	if ((null_blk_loaded)); then
+		_exit_null_blk
+	fi
+}
+
+test() {
+	local nullb=3Dnullb1 nullb_dev=3D/dev/nullb1 nbd_dev=3D/dev/nbd0
+	local sock=3D"${TMPDIR}/nbd.sock" pid_file=3D"${TMPDIR}/nbd.pid"
+	local conf=3D"${TMPDIR}/nbd.conf"
+	local -i nr_cpus nr_conns i use_unix=3D0
+	local -a connect_args
+	# Setup progress, used by cleanup().
+	local -i null_blk_loaded=3D0 nbd_connected=3D0
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
+	null_blk_loaded=3D1
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
+		cleanup
+		return 1
+	fi
+	# nbd-server opens the exported device without O_DIRECT. Disable
+	# readahead such that each NBD read causes a single 4 KiB read of the
+	# null_blk device.
+	if ! _write_queue_sched none "/sys/block/${nullb}/queue/scheduler" ||
+	   ! grep -q '\[none\]' "/sys/block/${nullb}/queue/scheduler" ||
+	   ! echo 0 > "/sys/block/${nullb}/queue/read_ahead_kb"; then
+		echo "Configuring the ${nullb} request queue failed"
+		cleanup
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
+	} > "$conf"
+	cat "$conf" >> "$FULL"
+
+	if ! nbd-server -p "$pid_file" -C "$conf" >> "$FULL" 2>&1; then
+		echo "Starting nbd-server failed"
+		cleanup
+		return 1
+	fi
+
+	# Wait until nbd-server listens on the Unix domain socket. Fall back to
+	# TCP if the Unix domain socket does not show up.
+	if ((use_unix)); then
+		for ((i =3D 0; i < 100; i++)); do
+			[[ -S "$sock" ]] && break
+			sleep .1
+		done
+		if ((i >=3D 100)); then
+			echo "${sock} did not appear; falling back to TCP" >> "$FULL"
+			use_unix=3D0
+		fi
+	fi
+	if ((use_unix)); then
+		echo "Using Unix domain socket ${sock}" >> "$FULL"
+		connect_args=3D(-unix "$sock")
+	else
+		echo "Using TCP socket" >> "$FULL"
+		connect_args=3D(localhost)
+		for ((i =3D 0; i < 100; i++)); do
+			nbd-client -l localhost >> "$FULL" 2>&1 && break
+			sleep .1
+		done
+		if ((i >=3D 100)); then
+			echo "Timeout while waiting for nbd-server"
+			cleanup
+			return 1
+		fi
+	fi
+
+	# Use -connections instead of -C because some nbd-client versions
+	# do not declare that -C takes an argument and pass a NULL pointer
+	# to strtol() if -C is used.
+	nbd_connected=3D1
+	if ! nbd-client -L -N export -connections "$nr_conns" -b 4096 \
+	     "${connect_args[@]}" "$nbd_dev" >> "$FULL" 2>&1 ||
+	   ! _wait_for_nbd_connect; then
+		echo "Connecting to nbd-server failed"
+		cleanup
+		return 1
+	fi
+	udevadm settle
+
+	# Measure the read and write IOPS twice: once with a single job and
+	# queue depth one and once with the parameters that maximize the IOPS.
+	# _run_fio passes --group_reporting=3D1 and --runtime=3D"$TIMEOUT" to f=
io.
+	: "${TIMEOUT:=3D60}"
+	_divide_timeout 4
+
+	local fio_params=3D(
+		--bs=3D4k
+		--direct=3D1
+		--filename=3D"$nbd_dev"
+		--ioengine=3Dio_uring
+		--ioscheduler=3Dnone
+		--norandommap
+		--time_based=3D1
+	)
+	local rw numjobs iodepth numjobs_iodepth
+	for numjobs_iodepth in "1 1" "${nr_conns} 64"; do
+		read -r numjobs iodepth <<< "$numjobs_iodepth"
+		FIO_PERF_PREFIX=3D"numjobs=3D${numjobs} iodepth=3D${iodepth} "
+		for rw in read write; do
+			FIO_PERF_FIELDS=3D("${rw} iops")
+			_fio_perf --name=3D"nbd-${rw}-iops" --rw=3D"rand${rw}" \
+				  --numjobs=3D"$numjobs" --iodepth=3D"$iodepth" \
+				  "${fio_params[@]}"
+		done
+	done
+
+	cleanup
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
