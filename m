Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209F19ABC3
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443742; cv=none; b=ZAwUalBA9NtBEm03FiqDU6597Rhc+H2T3DNWqdtAv6xcoYs7tkZinPsPN5+1yJrbgXfJlqjNZ+UiHxgCl3Jj6DwbGuXeyUTgZXEayiTifoXzwm44D5A1HNLafBVPlRCvqa/t8v9KZ+9cEvPm24B7UMJWztCBAGVNL1h3HpMjTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443742; c=relaxed/simple;
	bh=V+GiZBhx1KTkotcJfuvWr5wtRuo79gx1jjjVW7KZggk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5SJPCUkJE3v2LBQ8iwLW1JgXkarZykdyBaDcXAQCmPraygdaPgONmG8hyq6IuvpiErOfVCty9AqgsRKSSoP9likH+Q+qji+zXa7XeKGhbrOL6xASGTZDkGczLHNfl3ckJn8XJWhovp/Y30TdYAH6g9v+n6k9Pf+UJ+/KNhg+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aDr/n7hy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aDr/n7hy"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so2961337a12.1
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724443737; x=1725048537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1+D94YGyMzhZFJZje/FHtM2e5+UTeORpDSLLRuDCMU=;
        b=aDr/n7hyLjNI9xDkYlni2ZRhQHGEdVBXbBwupeWkj4FEWiHRGuVrXwGkgYszpqcP7H
         1wGCjXYVmDDwNy3NTJyocDRx4NLZdWcF5a0nSewUDmZQ+z4YBbUPpUPSW9dZLb1HL2oI
         GEVC/lNgE8ImD8FsZbDE+kELkVn4HMLXffFUtY+3kVfrsg6lhc3c4rkfXMsUgk7yzp5l
         ZdEfdsli7mKZ/pHPEJFbCqkjV0lOom7uFXqYn8JwzjwHDPDlowSHuo+sq50tzvUdNbyX
         CbiZXb06KrYFBWrpQG9yitsesIyqigN/J0aGR7qu6GubZvRPcVbyl/gO9MDrv6Jvjdg0
         /n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443737; x=1725048537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1+D94YGyMzhZFJZje/FHtM2e5+UTeORpDSLLRuDCMU=;
        b=TtaIq9SERBR+bYSU5ScfsJSv62umBLSIV9RX/9WQT223hDmwdhnC7J6Dq3CpJYYLex
         O3R66/xBvOiegoZRompT2cbubON60UOYV7awA76RrSeq+A7WMSmjcaWPLLDZAv0QJ6yN
         64XCF8U5x5zlAD8+N2N7AqEoHo4rx1ecA7L2vRfAG2G2VJcz8c1nTrgIr/ovAXOjB/VJ
         Ie6zQbfcjO0f5GYus/G2KEr7klQ9kA2phdNzzG+BfHfA6SEj2Zc0W4hxO3iWbWXWu8io
         UexrFP6c2zoHgD882xtonUBzoUxf56p5gHmD7LVrpc6kVgUOTl8l3qN1qhr9OdNxOZ5a
         yxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXonkH8LDivuq7h4G+pkI5Bzp0v4eMGsHsz6iyD5UmPJLi4BrKFgAoENdjOwxjQ8TI2hNgrSB9zYys0+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtHhGeRdbKnQ9PX8P/LlLOpo8vquFqZMTURVjXZJUsUgpKM8a
	7TooPobMiMmfzpG/W9EKaXsSph5vpSd3vjYgnN10knP/ivbS5AS+zgaahImyPeA=
X-Google-Smtp-Source: AGHT+IFTEcqm6AeAQsCYJW/AsXIRPNiC5zHTUMGCgWM5PRToWM/ZU1C2AMgsUZExfSWobemNMXrsrg==
X-Received: by 2002:a17:907:9407:b0:a7a:ae85:f24d with SMTP id a640c23a62f3a-a86a548c9f6mr250931566b.51.1724443736669;
        Fri, 23 Aug 2024 13:08:56 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f299d9asm303522066b.60.2024.08.23.13.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 13:08:56 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 3/3] nvme: add test for controller rescan under I/O load
Date: Fri, 23 Aug 2024 22:08:21 +0200
Message-ID: <20240823200822.129867-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823200822.129867-1-mwilck@suse.com>
References: <20240823200822.129867-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that repeatedly rescans nvme controllers while doing IO
on an nvme namespace connected to these controllers. The purpose
of the test is to make sure that no I/O errors or data corruption
occurs because of the rescan operations. The test uses sub-second
sleeps, which can't be easily accomplished in bash because of
missing floating-point arithmetic (and because usleep(1) isn't
portable). Therefore an awk program is used to trigger the
device rescans.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
      point arithmetic and achieve more accurate sub-second sleep times.
    - add 053.out (Nilay Shroff).
---
 tests/nvme/053     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/053.out |  2 ++
 tests/nvme/rc      | 18 ++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100755 tests/nvme/053
 create mode 100644 tests/nvme/053.out

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..d32484c
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Martin Wilck, SUSE LLC
+
+. tests/nvme/rc
+
+DESCRIPTION="test controller rescan under I/O load"
+TIMED=1
+: "${TIMEOUT:=60}"
+
+rescan_controller() {
+	local path
+	path="$1/rescan_controller"
+
+	[[ -f "$path" ]] || {
+		echo "cannot rescan $1"
+		return 1
+	}
+
+	awk -f "$TMPDIR/rescan.awk" \
+	    -v path="$path" -v timeout="$TIMEOUT" -v seed="$2" &
+}
+
+create_rescan_script() {
+	cat >"$TMPDIR/rescan.awk" <<EOF
+@load "time"
+
+BEGIN {
+    srand(seed);
+    finish = gettimeofday() + strtonum(timeout);
+    while (gettimeofday() < finish) {
+	sleep(0.1 + 5 * rand());
+	printf("1\n") > path;
+	close(path);
+    }
+}
+EOF
+}
+
+test_device() {
+	local -a ctrls
+	local i
+
+	echo "Running ${TEST_NAME}"
+	create_rescan_script
+
+	ctrls=($(_nvme_get_ctrl_list))
+	_run_fio_verify_io --filename="$TEST_DEV" --time_based &> "$FULL" &
+
+	for i in "${!ctrls[@]}"; do
+		rescan_controller "${ctrls[$i]}" "$i"
+	done
+
+	while true; do
+		wait -n &>/dev/null
+		st=$?
+		case $st in
+			127)
+				break
+				;;
+			0)
+				;;
+			*)
+				echo "child process exited with $st!"
+				;;
+		esac
+	done
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/053.out b/tests/nvme/053.out
new file mode 100644
index 0000000..e8086ce
--- /dev/null
+++ b/tests/nvme/053.out
@@ -0,0 +1,2 @@
+Running nvme/053
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index b702a57..a877de3 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -192,6 +192,24 @@ _test_dev_nvme_nsid() {
 	cat "${TEST_DEV_SYSFS}/nsid"
 }
 
+_nvme_get_ctrl_list() {
+	local subsys
+	local c
+
+	subsys=$(readlink  "${TEST_DEV_SYSFS}/device/subsystem")
+	case $subsys in
+		*/nvme)
+			readlink -f "${TEST_DEV_SYSFS}/device"
+			;;
+		*/nvme-subsystem)
+			for c in "${TEST_DEV_SYSFS}"/device/nvme*; do
+				[[ -L "$c" ]] || continue
+				[[ -f "$c/dev" ]] && readlink -f "$c"
+			done
+			;;
+	esac
+}
+
 _nvme_calc_rand_io_size() {
 	local img_size_mb
 	local io_size_kb
-- 
2.46.0

