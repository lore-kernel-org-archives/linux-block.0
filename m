Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2819E977
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287286; cv=none; b=ZITJF46xZ/LcyKYEEweZZh8oRXBlL0wedoTNgguYODbGzSge+R5CbBuv/5Aq5HAlKSI9qEWH/SMEuorB4hlw8cTCz0IASW33jG+NXfx68VhD6oayU+oPqIJEBJ78IrkluE8AiOitx91nBcGJGyHAxm4/rr4Zq+Bw9XjUXwnmQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287286; c=relaxed/simple;
	bh=KDplJl/RrUBdZt2PBYnQbFIAOQzTNLGE+ZD3JCo4kSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRrdVmTafK49GG3t0RnXweEs5iDYAlQEtOL3ufm6ehOrX4WU6RgupsFxF/ZfQGtQAUV3+fQ7txjlnIPwnF3DvacLTItcUW/z4CUvAd0pq/cTuosl/tt2bZMmpScg8kQmASRfKeOsUV1cOVqIy7IHftxuugjSmAeBEYPWxyoFG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vpq+LbFL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vpq+LbFL"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8692bbec79so486479366b.3
        for <linux-block@vger.kernel.org>; Mon, 02 Sep 2024 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725287281; x=1725892081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ9LsPTxm+VbQGotIboa4weytFmVBj0/VPIq2l60SY0=;
        b=Vpq+LbFLbTGKOyeVT5B4Ko2lpNhxFy7wDKqIi0WBTkTh0bnhlFr3P9Uu6ic34p9kCy
         d9II/Qpj0ORYdOjlhM5/3F7z1ilS+rqv+8WXg3Xl7fDMdwqdvh8Xf0OVQwsyUmMR6TmQ
         u+6jQQv2MPKOWnvVvCSZ1OKM9GxYZKuHhdbE8V8u+QKR1tOmFIUWKh638U2O3lrBTUsm
         Ws3nBqjVmd776HBVrOBii4nRtYBx1/HIANnn3Uc64WPAgghS8BEZf2jvf94RKwGEMvkv
         Hua2ix1uDDGIBfTuwWcqnt098XJKU/vnBYN68M5fKpeMFzNz3FRjtgY6lkhMXuXUsFLd
         ydww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287281; x=1725892081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ9LsPTxm+VbQGotIboa4weytFmVBj0/VPIq2l60SY0=;
        b=bJb87o+lu7YBrluezL0yf85YYK1hUi/ZuMA9qiqEq6WUzgWKk7pI/ypo9n29Ry6XfM
         y01uvojUv/KsljqZmiPBXCA0e7ZwCbHeTo248qIk5t7wp+yr5ZzrbypS6GAMGLfUXUWY
         1LnVjhOMFPZ6tBB+V9/nlUyIrsqrFuAL4XIM/12arMMXjaD2J2y5JjZPn98GY3ZOzVSI
         9paZWfZGCg86C922DfXJu8YnWm9K5kNITS1kkd8mo4sjZ2mQ8MFAvVwv8+Nf/RKYf5io
         QxrX6oGZaOTsXZwyS7XMsWi0te7V5H/gEzJxUPdo/ZhRcBCF6G6RNlMs7/5xxyY7C5QB
         6qbw==
X-Forwarded-Encrypted: i=1; AJvYcCV+pIPoG4+Qs/qUM91TkAxhmtqgpZdVoUEat3jOyI4fy8anZ8syacf6PiByzWm9V1JZRWfmRt+sFOdt4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnyhxe8vL8vlG0yyftdvaCewnRmwmtoehjSIzvBxuwda5YYxiI
	AyfACWRK7dyk+Bbv4M5wjNwatdI9cjamZHzUsIZpgPk2cg4NVDSOWur1lm30KyOPMoP7yedleBK
	R
X-Google-Smtp-Source: AGHT+IFNo+U6H0njqtK5FYf7X4oDFyjmGEpzlRSMX+ycejfBh12MlSOr41SNUtIdm7WPwSAjc412zg==
X-Received: by 2002:a17:907:d8f:b0:a7a:b781:60ed with SMTP id a640c23a62f3a-a89a35a1159mr655497466b.17.1725287280917;
        Mon, 02 Sep 2024 07:28:00 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989222fa8sm565950366b.213.2024.09.02.07.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:28:00 -0700 (PDT)
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
Subject: [PATCH v3 3/3] nvme: add test for controller rescan under I/O load
Date: Mon,  2 Sep 2024 16:27:47 +0200
Message-ID: <20240902142748.65779-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902142748.65779-1-mwilck@suse.com>
References: <20240902142748.65779-1-mwilck@suse.com>
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

Link: https://lore.kernel.org/linux-nvme/20240822201413.112268-1-mwilck@suse.com/
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Nilay Shroff (nilay@linux.ibm.com)
---
v3: (all changes suggested by Shinichiro Kawasaki)
    - add "Link:" tag
    - add comment with patch description
    - declare variable "st" local
    - use "mapfile -t" for array assignment
v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
      point arithmetic and achieve more accurate sub-second sleep times.
    - add 053.out (Nilay Shroff).
---
 tests/nvme/053     | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/053.out |  2 ++
 tests/nvme/rc      | 18 +++++++++++
 3 files changed, 94 insertions(+)
 create mode 100755 tests/nvme/053
 create mode 100644 tests/nvme/053.out

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..df643ec
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,74 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Martin Wilck, SUSE LLC
+#
+# Repeatedly rescans nvme controllers while doing IO on an nvme namespace
+# connected to these controllers, and make sure that no I/O errors or data
+# corruption occurs.
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
+	local i st
+
+	echo "Running ${TEST_NAME}"
+	create_rescan_script
+
+	mapfile -t ctrls < <(_nvme_get_ctrl_list)
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

