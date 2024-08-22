Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB11CB334
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355526; cv=none; b=UcJ6WHDqo2XvkvL8tSPwsuBHdzCIcXmw1eutL3Tq3QOyM3nrJVRyxs1Ih12yr0VjdgeDIHFPO8JHgECqQjTahG3mch88bqqz3f13VA75SkuLRCeQkoyhU82SgzSZndAMc+fiJP6jzDhdNbt5jsBSYsiIfDJ92g4mfTtZartcSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355526; c=relaxed/simple;
	bh=EH6DGw3oIGH6mn74/zAp6eRMaKqGcnnNiq/AnrbpyYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCD4jiM932eR/G8IS8Vq30+wX385/zSHdQEZ4ZcJB0p3//I46AEXSURi/odLMg6PbgbeK0p9K7fnO2zHCvRYsejsaPRLOoazBOXkc5hF/tWAGc8Xcnuue7lU344CqzI9bJ/6Q6zHbwimhBgoliN7hMZNEAKoa4QHQgyvpwnGn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D492xFOY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D492xFOY"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5343617fdddso998913e87.0
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724355521; x=1724960321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3glpGU9x1kcJJgX+l/inQq4k3AYAsir0suA9GFYY2co=;
        b=D492xFOYbFfepR4zjZT6UeCsOQP/OXpRHXQQIL8f3/ub9hmOfZi5nqM3iWVNdljerM
         8rHsQPie0+2nOHayNTiXp+NF7bRDcUITxc0ddMhRDGWmfEGOm3ezDfio4NhWZJCv5i2a
         Dl+Uq+RtVls/MUKFWkotqv9+I5fqPr7nE84wROr1sc4N2nJQWmMDA3ztJrwxpHf3SaUD
         z1kUl4Ntj20MpGFbe/axPAi9NQZ5T8tOVixMjXdpvZODCCXJLXg5W57aYsZCdtkDvR6L
         Q1gWsJo3VbJzBinqkFBjbbMcpeTOKkUkZzv6sGRvauciSmK2FJ/SpRzF7IWrd8Aq55og
         4cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355521; x=1724960321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3glpGU9x1kcJJgX+l/inQq4k3AYAsir0suA9GFYY2co=;
        b=Mlb592Q8x7kyXGutC2/JnNg6aZMS+LU0X536RD0BsraTOFKmqz6+MWcGdP5fqWVGYY
         MQR3UPnhvh5ap5t/IN7I4BDQC1uSCyPzQKZ5oc6cDuo5fhuTuaMxtzM/JJzvuVoCRJm4
         V2ZauEV2JVn5d69UH9FhuR8OVTnKRPpGTXsZS8ZtQ0w9j4NJ8/g9/ugOqyjeEH6R5cmf
         Tpa43fKhnW/Rfs/GyMUbNB5XkAaXxXwft46VXCY5PRySbNXcH3DWneV1aIpszIfE5u+E
         2iXkQM5JtCt5rGCITW5bfZzvipLyfNdTQIgyf/AdstrI56ye+fCOY0vjf0XUEgkUR0Gt
         eIEw==
X-Forwarded-Encrypted: i=1; AJvYcCV2LMwIP2uiAM2uiw3fZXikqM04Di87rukNKqUcYWupIlKIn3I51Agh5ny/AaTFHzEsSjbtDyB4NttNxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6MVHfnqVzU9vAL/Q8y9RUW3TwPEIi6Hiyxmcf6VroynsA6SS
	8BDgBYJwMfRz151N25IGRzlLtUzPUF4BLyOSo0vWj7bD6gykYABIzg8NWLjM7bQ=
X-Google-Smtp-Source: AGHT+IHqvYbFPPhwdBEjAHOuESxTgY/1gVffG8gG/TzIbACUog4K/qu6fYhtERnRe8AF4PZoWif7ZQ==
X-Received: by 2002:a05:6512:2212:b0:533:45c9:67fe with SMTP id 2adb3069b0e04-534387bad1dmr31454e87.48.1724355520505;
        Thu, 22 Aug 2024 12:38:40 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f4ebdc6sm155987166b.188.2024.08.22.12.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:38:40 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH 3/3] nvme: add test for controller rescan under I/O load
Date: Thu, 22 Aug 2024 21:38:14 +0200
Message-ID: <20240822193814.106111-3-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822193814.106111-1-mwilck@suse.com>
References: <20240822193814.106111-1-mwilck@suse.com>
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
occurs because of the rescan operations.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 tests/nvme/053 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc  | 18 ++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/nvme/053

diff --git a/tests/nvme/053 b/tests/nvme/053
new file mode 100755
index 0000000..41dc8f2
--- /dev/null
+++ b/tests/nvme/053
@@ -0,0 +1,56 @@
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
+	local finish
+
+	[[ -f "$1/rescan_controller" ]] || {
+		echo "cannot rescan $1"
+		return 1
+	}
+
+	finish=$(($(date +%s) + TIMEOUT))
+	while [[ $(date +%s) -le $finish ]]; do
+		# sleep interval between 0.1 and 5s
+		usleep "$(((RANDOM%50 + 1)*100000))"
+		echo 1 >"$1/rescan_controller"
+	done
+}
+
+test_device() {
+	local -a ctrls
+	local c
+
+	echo "Running ${TEST_NAME}"
+	ctrls=($(_nvme_get_ctrl_list))
+
+	_run_fio_verify_io --filename="$TEST_DEV" --time_based &> "$FULL" &
+
+	for c in "${ctrls[@]}"; do
+		rescan_controller "$c" &
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
diff --git a/tests/nvme/rc b/tests/nvme/rc
index e7d2ab1..93b0571 100644
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

