Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F118BBAE
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380996; cv=none; b=mfauaNqtfYG9mfAZYp11clAQQ9g2LRd+HCybpYqpVjlK2eLQwnxK6ACuY3mH5KhQlD8nV2Seb81peJLHnl3eSqcvvaZzxTfVOysr4r1KpTKiqIPR0KhXFce3CahkE6HEbPPn+C97/vC293zSMae7VVXKsNo+gOclkHCbOP4S/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380996; c=relaxed/simple;
	bh=yiOBXAAMR2RPq6t3rhDZipLW2RElokEi1yZq0mg2its=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nK1Rc9vZPxOL1GDIpKywyhg14T3AC0pYS32MnmuOi4/5B/C3kwZCsJBjmV78B0R5mOb8ZKOW3hDN2r2Wo0/Ji1AEn2By1nQcaNP8fM9RcA8tjl13/ZcMHWv28U7pw9susewDkVOZD9RVloUPYlUzST2q33Dv4vsMTboHSy2Y1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CO+wSHvO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CO+wSHvO"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so1915088a12.0
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725380992; x=1725985792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjBQiSI/EgBU6FriPosIOGq+TtZhMJPpr3ANm85z/c4=;
        b=CO+wSHvO1Qir2jCmKFztA8PPSBoFRpQkcdHbdMELWGu/i/5L+WlgjhLQW7PBs+fR7l
         Y2oLneansbuIzOEDcfNvj5q6xGSndw5ifd8pQrhIYLILor4aHVsPHgPbWOtHsoPTmhSm
         1/0O+vMtToUOmZsM+nSOKZYoJDWx/dv6kRGw/Y6DEC+482oLHgABfiu/TMcC4ZVUGjcc
         /m5zAbk/6XzosUnjiegb7Y/hEsnECGivvHRonTmNCd9LYgbgpaLX/MF1OpHcN+fjuglu
         FaQZFei2gpgiAzQ/F7i3X9DkUi0a3oqx3pkkPQunZhG7/65GlSjue5RvPEolGbIEDx5m
         YgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380992; x=1725985792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjBQiSI/EgBU6FriPosIOGq+TtZhMJPpr3ANm85z/c4=;
        b=k0S0yGF07d0nM8TVyJjlt1TfqYwhRoeTr/jWY5saGGLTYSlOtv4Uzt0uJDgfsNc/Bd
         hAzYrNhKz1Zfrjce5MjT+LEsmQiIHKQJYlSm2qI0O6pqU58CcVKcUBV0kwPMvBPshHXy
         dOK6FlK2W18Ju/AggdcWKkspOBkkL/W8rQXoUb20n3xOuRiRbv0Se8Ui6X+Up7c0+apz
         OYqznKViGGGQu28j9VQIoYaa0DvYb8s5g+CC6DtifyOSXPdyHux9u6up2q4H4+D/3b9N
         MVBOiv3R397CyMd1XKE5xkf0p8ghrwpGPDnSov82wQ13eWo7zBvX57wfY2awWh96vOwZ
         WOAA==
X-Forwarded-Encrypted: i=1; AJvYcCUt2Y9BLm0dYxfBbGjkhf7LTUc8vjeescoxeRzepLfSwT+zXIOv90fn0sTC9I+hAv/xX2+l0QtFZp1sHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnGeI3xIZ/k3naXTUyY7NC2NxlYhEbDbhfQp8P9P9O1prxGJR
	FgfPh7KzAR7YErL/pG59d74MmzHM4dl75fJDncr+l4b/Anhrx4SZf1Fl6wuHSs8=
X-Google-Smtp-Source: AGHT+IHlZUobr/C0J2+/9pQ8nTa5nQhyGcKMEPbg1UP4/CUKEz9Hj/g76GDCLJIKRO6LyPd+J7Bumw==
X-Received: by 2002:a17:906:f590:b0:a86:f960:411d with SMTP id a640c23a62f3a-a89d872464emr757306466b.2.1725380991815;
        Tue, 03 Sep 2024 09:29:51 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a89891d7368sm701977566b.168.2024.09.03.09.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:29:51 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v4 3/3] blktests: nvme: add test for controller rescan under I/O load
Date: Tue,  3 Sep 2024 18:29:30 +0200
Message-ID: <20240903162930.165018-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903162930.165018-1-mwilck@suse.com>
References: <20240903162930.165018-1-mwilck@suse.com>
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
---
v4: - use while loop for array assignment (Shinichiro Kawasaki)
    - add "blktests" to subject line
v3: (all changes suggested by Shinichiro Kawasaki)
    - add "Link:" tag
    - add comment with patch description
    - declare variable "st" local
    - use "mapfile -t" for array assignment
v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
      point arithmetic and achieve more accurate sub-second sleep times.
    - add 053.out (Nilay Shroff).
---
 tests/nvme/053     | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/053.out |  2 ++
 tests/nvme/rc      | 18 +++++++++++
 3 files changed, 96 insertions(+)
 create mode 100755 tests/nvme/053
 create mode 100644 tests/nvme/053.out

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..3ade8d3
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,76 @@
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
+	local i st line
+
+	echo "Running ${TEST_NAME}"
+	create_rescan_script
+
+	while IFS= read -r line; do
+		ctrls+=("$line")
+	done < <(_nvme_get_ctrl_list)
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

