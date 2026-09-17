Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1F1448E0
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610961; cv=none; b=FuhylfjafHUTJjnnZe2eYO3F1RLSifPLQj1xVSrwCQBIF+NVRq0lJiT11GiAiAxKhVe4H7Bn1EPN18a0Ky5QgcAxwTSiSYEt7rc9tK3Jtt2gKUZ0jn6V+yJfL0Qacip5+tiaRfLiLUs9aSQbJnCXAFW1qVHX7eW7NFAHoGsqBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610961; c=relaxed/simple;
	bh=7LA+Wo90KJrahhYc9Xn33gpgQEdc3BVxwF6qZ0cnV9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKOeyvJEOSVXY7Bo0G12TI4c8335i6VKHHTjU7i6NYLObUUe5ESuDE+jA1QeRBgPDsj7SamPGoRpUiKXcFR+RtwBwj8NKDIpOP3GkRaI5f4X8Ew7mr4G8Y/BWhnlySffSyA0/RxlfGQNfJ8RGSCzePPscnIPAB3KdYahGuy+HLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PiduxOjn; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PiduxOjn"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c3b639adbcso289053b6e.1
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789610958; x=1790215758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WjaHClK4eeYr76PCiEzXBFF+hZ9DGlnJHEu8nAe5+o=;
        b=PiduxOjns8aC0saapzNFAURBUlCgBFZhh4r1N5fQZBvhkviPXsul7Tm77dRdhSh+8J
         e2rVqnvsuci6j363GD6k3WOa0x0rWtZ9TukTLIaL9THnXNTziChEMSHULPnaWqHXwfDz
         J7GRifLtaofb6ROGGA3lw6M4RWjvDK+qsrWSjB94CISe+6Fka/Vozka4/pKibFa2yUrt
         hU7OPtpqaJYBOeZVHakuepODscwnmP6WgHnT5gaFGxqTz23naAnzEpZ08IRBUzTGn9gY
         FDcey8urgobsOP6WYCaqsqP6tiRYo48tHpN8q/lYbL0xk27OTevIdrrBlnaUPF6WREAk
         vUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610958; x=1790215758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WjaHClK4eeYr76PCiEzXBFF+hZ9DGlnJHEu8nAe5+o=;
        b=tHqt/UJKVfDTiPdOnwUSrW9QYOe7xwBMp/Vfax/P7iWBxvR1VDVg9KApQp8p1/xMba
         Frc9MLdz6QYyIffImbho0RC49yZ2ygZZRv/7E+sw/MP5jbpPfH5uT14z5iLwd1PT8EpE
         7izlwwog19IAhGSYr0dK9JOtEBnzyefaNwNyQ3CA9TBy71jTN5M77oWLN7TBtm5C/o6t
         8ZwqGKzuQxGs0TAhfyjSMyoEb+WhHbAtlnaBLqXfPlm81qlqajY4RE4ugFmCHoNXSVRz
         ZDdZqEIEQ3vEdovinV9aAB11/IspYDu8G4rSXIya/U+98i4sWwS4Gv8eDY7LcPg7gBAG
         txfw==
X-Gm-Message-State: AFuF++kgsfFtlXwIy4L08WVcN/sOXxuIS6zpJjotcfLCjt7j3NcQhKNt
	s+J6FII1ZUS0STSJeyRk+V/v2M7kF/qea8kYVeS2ivPDA9l4GNQnGPx1Ns/pEW4jf87agDzB2jq
	l7Cv1JVxl5WNn5XNwJli4aGKB8UEl0dpe0hDC5wxwu+K5cxUxQTSn3+H0J1F1fZCHM5bIQS6WnT
	94BXqHwKKmSCwycN5mwPZMBwoHMfA/Z8SpMK9hUjAbJlwR/1CnoLOuv0Q5ew==
X-Gm-Gg: AYBFou2nFJvbpH34PRCweheWaKeqQhQTN9d+vJ8+RPFxViv7TnhnCsWEGZ5ZU/dnX2w
	vLJhufwATU2tTjik2zEKHb8/YScSTnP5Zo6s1dHjKbuC1QF2AvzYDwQtEFzmCHfa2h4VMudAwsN
	f2kgty19wKATpkvOCjopqTAE0P2D/UbUANO0BFMBZMCtd8TmOtyWrDzh0mublC3wLArQ0tUU0Os
	t2jGiIIH7rOYouumQW8xWrbdXdsb+uVl7+qgLo5u4A3ZJ0LwMQysG/xD2J5fNM8dPbMJYMaoeJh
	Re2yYTmxoUGk6frjnikk6Fyg9sx2dGr3t99wMr6WUweKvqwBBcfwALtx1RFmthWYDuSSroxJcFc
	HsUWDajcGIar3IXylTsuNrcb2F+2iewuafiswKsfrRAWqhb4DIbfDs2rRo3TrmGQ0xPbeKcN0cG
	3pSWQgqp/KhP1ERxxp0N0VhxU5o/a8wV7yWygAimPJ427frbHDQai8v6ESQEFv6DNek9oDhJX6u
	4judedR/MZBv/f0BtP8DmISKdW8hfaVE3XS8yE=
X-Received: by 2002:a05:6808:6d97:b0:4c4:7c83:9139 with SMTP id 5614622812f47-4ca4a3f692amr4432798b6e.18.1789610958199;
        Wed, 16 Sep 2026 19:09:18 -0700 (PDT)
Received: from dev-mkhalfella.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm1862569a34.16.2026.09.16.19.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:09:17 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH blktests 5/5] nvme/070: test for ABA ghost writes on a multipath fabrics namespace
Date: Wed, 16 Sep 2026 20:06:25 -0600
Message-ID: <20260917020752.1672578-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917020752.1672578-1-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unacknowledged write that is retried on another path can still be
alive in the fabric. If it reaches the target after a later write to the
same LBA has landed, it overwrites it, and a read returns stale data.
Nothing in the tree exercises that window.

Add a test that builds it deliberately. A ublk loop device backs an
nvmet namespace exported through two ports, and the host connects to
both, so nvme-multipath has a second path to fail over to. io_timeout on
the subsystem drops to 2 seconds, then miniublk's inject command holds
one write in the backstore for 4 seconds. The host times that write out,
retries it on the other path, and the held write completes at the target
afterwards.

nvme-ghost-write-detector then writes distinct patterns to a single LBA
and reads the block back, so a resurfaced write shows up as the wrong
pattern.

The test requires nvme_core.multipath=Y and a fabrics transport. As of
today it passes on loop, which defines no timeout callback and so never
times the write out and never retries it, and fails on tcp, rdma and fc.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 tests/nvme/070     | 98 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out | 35 +++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

diff --git a/tests/nvme/070 b/tests/nvme/070
new file mode 100755
index 0000000..e9a4690
--- /dev/null
+++ b/tests/nvme/070
@@ -0,0 +1,98 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Mohamed Khalfella
+
+. tests/nvme/rc
+. common/ublk
+
+DESCRIPTION="Test injecting delay on nvme-target backstore and expect no corruption"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_ublk
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+	_have_src_program nvme-ghost-write-detector
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+count_paths_to_subsystem() {
+	local subsysnqn="$1"
+	local dev count
+
+	count=0
+	for dev in /sys/class/nvme/nvme*; do
+		[[ -e "${dev}/subsysnqn" ]] || continue
+		[[ "$(cat "${dev}/subsysnqn")" == "${subsysnqn}" ]] || continue
+		count=$(( count + 1 ))
+	done
+	echo "${count}"
+}
+
+set_io_timeout_of_subsystem() {
+	local subsysnqn="$1"
+	local timeout="$2"
+	local dev
+
+	for dev in /sys/class/nvme/nvme*; do
+		[[ -e "${dev}/subsysnqn" ]] || continue
+		[[ "$(cat "${dev}/subsysnqn")" == "${subsysnqn}" ]] || continue
+		if ! echo "${timeout}" > "${dev}/io_timeout" 2> /dev/null; then
+			echo "FAIL: can not set io_timeout on ${dev##*/}"
+			return 1
+		fi
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local ns port nr_paths
+	local -a ports
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	truncate -s "${NVME_IMG_SIZE}" "${TMPDIR}/ublk-img"
+	if ! ${UBLK_PROG} add -t loop -f "${TMPDIR}/ublk-img" -n 0 > "$FULL" 2>&1; then
+		echo "fail to add ublk device"
+		_exit_ublk
+		return 1
+	fi
+	udevadm settle
+
+	_setup_nvmet
+	_nvmet_target_setup --ports 2 --blkdev none
+	_create_nvmet_ns --blkdev /dev/ublkb0 \
+		--uuid "${def_subsys_uuid}" > /dev/null
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	echo "Target ports: ${#ports[@]}"
+	for port in "${ports[@]}"; do
+		_nvme_connect_subsys --port "${port}"
+	done
+
+	nr_paths=$(count_paths_to_subsystem "${def_subsysnqn}")
+	if ((  nr_paths != 2 )); then
+		echo "FAIL: expected 2 paths, found ${nr_paths}"
+	fi
+
+	set_io_timeout_of_subsystem "${def_subsysnqn}" 2000
+
+	if ! ${UBLK_PROG} inject -n 0 -o write -d 4 -c 1 >> "$FULL" 2>&1; then
+		echo "FAIL: can not inject write delay"
+	fi
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	"$SRCDIR/nvme-ghost-write-detector" "/dev/${ns}"
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+	_exit_ublk
+	echo "Test complete"
+}
diff --git a/tests/nvme/070.out b/tests/nvme/070.out
new file mode 100644
index 0000000..b43fec7
--- /dev/null
+++ b/tests/nvme/070.out
@@ -0,0 +1,35 @@
+Running nvme/070
+Target ports: 2
+starting nvme-ghost-write-detector test program
+iteration number 0, writing data
+validating written data
+successfully validated
+iteration number 1, writing data
+validating written data
+successfully validated
+iteration number 2, writing data
+validating written data
+successfully validated
+iteration number 3, writing data
+validating written data
+successfully validated
+iteration number 4, writing data
+validating written data
+successfully validated
+iteration number 5, writing data
+validating written data
+successfully validated
+iteration number 6, writing data
+validating written data
+successfully validated
+iteration number 7, writing data
+validating written data
+successfully validated
+iteration number 8, writing data
+validating written data
+successfully validated
+iteration number 9, writing data
+validating written data
+successfully validated
+finished nvme-ghost-write-detector test program
+Test complete
-- 
2.55.0

