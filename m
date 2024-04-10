Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5217B517
	for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768568; cv=none; b=XaezEL0K0i+98pMnaYzerpP6CZ629doF/6LO0FIhgMdbL+e7n9fhX5i6KTgNqMTE9S88T68/ddssCpnZ86Ah7AJ5nYSBOBRb26QGpJaecVQNjE7daw4DO6Y5SOCy02I2ItlIL3y08+3tCrIcjAmk/rPGMQGT9qyi6H1weXZGLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768568; c=relaxed/simple;
	bh=gJrAzHwiKnhRsGEas0/gkDPsTTR0Nnbek3ovo/OFJF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jm39t+72RDwE9+ymwtkG/woppFW9u1YZZPAHKkEzERUvBRvYWTMmpFupMH4rYQI7MxCVp0PDp8iLuCy8mCdsNsBOlw+Y+1Kg+l7076LpZyhUFbI0l9mVO+YHHuinrdu9pPUGWE4u29Nt1i23GSTN8USwNy8kiZZjZonMOGqFC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvYUG57H; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvYUG57H"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dbddee3694so17227a12.1
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712768565; x=1713373365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgQl6sbdgv14zki/MVtNU5Wub4PZeMl5Tu34n9QE4P4=;
        b=CvYUG57HAsItVdMDpBT4/yeVDcu8hqQXCASqmQOpY/Fof3TJSxjMWhjR0EVo9ERJ+G
         +efa0i4sQ7E2AR8avT0iz5wt0H4LGU+SCzogz01m5F0tP7uJdK3cYPpz71/TMtVbJ708
         pH43z+Bl5Ywb8bH2S49QI9jS24jTJPLE9XZVKNOkUGYaDCCRmqr8dD81q03GdxNEWny4
         4sh4bh0H3OAhVKC5nF/McXHVCOYOonQCLKZnTNzTkqJOB3Pq2O4PyJA7+JaOLPYiizX3
         DVglBItaAQ7sftraCPH91/iA4UfQCot2IdEWBiQZrL1t9iDyusOiaOOvfrMD7YcsrAcC
         fjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768565; x=1713373365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgQl6sbdgv14zki/MVtNU5Wub4PZeMl5Tu34n9QE4P4=;
        b=jEFGzC/cuNXZUaMdl1iWChsvZ3xE7kphyxiAAc6ejdwGO2Q0dIHvH0XbsJqHlghCo/
         X/lNyVWlefm2zBs+/7LUx/0gsWXIOWLE3Wlpyr8i9PBgr4RWtyD9nXhiROJnm955DLjv
         00lMm3l/6CfM9MflTwthlVtXaeqMUK0lU7nWm1625P6EquQ3G2LX8LztBLZ2oyv1qmGw
         l+sjEURY/wZFa28dmVWp/LRE8rJYy50CqXlMjRcbgXyJWI21v0+qwnndsYlWEWC9tke5
         5hYujlFA+5uQIJmStPDOA1Zs9x31wTfyuuHmUsFBmgDTQ7kOOmjEAyEOtclddpX/RizR
         /k6w==
X-Forwarded-Encrypted: i=1; AJvYcCXVVXv5E4pxJS6yH0bM4l+FPmzfE2YG9n66D00hM4o3zY+NkYKfvLjCd6CiTC+VWtbW2zbL2/R2E8qEoaMVC1fg1CjwJOsrlPvTeSA=
X-Gm-Message-State: AOJu0YxtDe+4OzIHBTbeNZW1qnSMc/e+Kltcbhwjhn9+pHQQC3akEWzm
	pelAzzrJnMuuWYXeCxYHUCo8ETPs5lD3B8YSLpE5LCogsZetnWXCfL8IsvrzF4j8WGYOQxPSzyJ
	qbF36cSHO5k784qvQbHsq3Tva3Q==
X-Google-Smtp-Source: AGHT+IHIsUkx1v7b51G3r3AafXG0diE9ucWdR5toUUKtU2aqRCz4pbaNB0Xf28tSPcyqBMmVOr9nPbGtK7cxlTIgI84=
X-Received: from srnym.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2728])
 (user=saranyamohan job=sendgmr) by 2002:a05:6a02:6a2:b0:5e4:2b26:960a with
 SMTP id ca34-20020a056a0206a200b005e42b26960amr578pgb.4.1712768565206; Wed,
 10 Apr 2024 10:02:45 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:02:41 +0000
In-Reply-To: <lfv2rqcpyyeqv7efpc4ozru7daycx4nv5nmc2xh4luzgtk3tjf@oq33dghcnt3j>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <lfv2rqcpyyeqv7efpc4ozru7daycx4nv5nmc2xh4luzgtk3tjf@oq33dghcnt3j>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240410170241.66966-1-saranyamohan@google.com>
Subject: [PATCH blktests] block/035: test return EIO from BLKRRPART
From: Saranya Muruganandam <saranyamohan@google.com>
To: shinichiro.kawasaki@wdc.com
Cc: chaitanyak@nvidia.com, hch@lst.de, linux-block@vger.kernel.org, 
	saranyamohan@google.com
Content-Type: text/plain; charset="UTF-8"

When we fail to reread the partition superblock from the disk, due to
bad sector or bad disk etc, BLKRRPART should fail with EIO.
Simulate failure for the entire block device and run
"blockdev --rereadpt" and expect it to fail and return EIO instead of
pass.

Link: https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@google.com/
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 tests/block/035     | 86 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/035.out |  4 +++
 2 files changed, 90 insertions(+)
 create mode 100755 tests/block/035
 create mode 100644 tests/block/035.out

diff --git a/tests/block/035 b/tests/block/035
new file mode 100755
index 0000000..0ba6292
--- /dev/null
+++ b/tests/block/035
@@ -0,0 +1,86 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Google LLC
+#
+# Regression test for BLKRRPART.
+#
+# If we fail to read the partition table due to bad sector or other IO
+# failures, running "blockdev --rereadpt" should fail and return
+# -EIO.  On a buggy kernel, it passes unexpectedly.
+
+. tests/block/rc
+
+DESCRIPTION="test return EIO from BLKRRPART for whole-dev"
+QUICK=1
+
+DEBUGFS_MNT="/sys/kernel/debug/fail_make_request"
+PROBABILITY=0
+TIMES=0
+VERBOSE=0
+MAKE_FAIL=0
+
+_have_debugfs() {
+	if [[ ! -d "${DEBUGFS_MNT}" ]]; then
+		SKIP_REASONS+=("debugfs does not exist")
+		return 1
+	fi
+	return 0
+}
+
+requires() {
+	_have_debugfs
+}
+
+save_fail_make_request()
+{
+	# Save existing global fail_make_request settings
+	PROBABILITY=$(cat "${DEBUGFS_MNT}"/probability)
+	TIMES=$(cat "${DEBUGFS_MNT}"/times)
+	VERBOSE=$(cat "${DEBUGFS_MNT}"/verbose)
+
+	# Save TEST_DEV make-it-fail setting
+	MAKE_FAIL=$(cat "${TEST_DEV_SYSFS}"/make-it-fail)
+}
+
+allow_fail_make_request()
+{
+	# Allow global fail_make_request feature
+	echo 100 > "${DEBUGFS_MNT}"/probability
+	echo 9999999 > "${DEBUGFS_MNT}"/times
+	echo 0 > "${DEBUGFS_MNT}"/verbose
+
+	# Force TEST_DEV device failure
+	echo 1 > "${TEST_DEV_SYSFS}"/make-it-fail
+}
+
+restore_fail_make_request()
+{
+	echo "${MAKE_FAIL}" > "${TEST_DEV_SYSFS}"/make-it-fail
+
+	# Disallow global fail_make_request feature
+	echo "${PROBABILITY}" > "${DEBUGFS_MNT}"/probability
+	echo "${TIMES}" > "${DEBUGFS_MNT}"/times
+	echo "${VERBOSE}" > "${DEBUGFS_MNT}"/verbose
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	# Save configuration
+	save_fail_make_request
+
+	# set up device for failure
+	allow_fail_make_request
+
+	# Check rereading partitions on bad disk cannot open $TEST_DEV: Input/output error
+	if blockdev --rereadpt "${TEST_DEV}" | grep -q "Input/output error" &> "$FULL"; then
+		echo "Did not return EIO for BLKRRPART on bad disk"
+	else
+		echo "Return EIO for BLKRRPART on bad disk"
+	fi
+
+	# Restore TEST_DEV device to original state
+	restore_fail_make_request
+
+	echo "Test complete"
+}
diff --git a/tests/block/035.out b/tests/block/035.out
new file mode 100644
index 0000000..125f4b8
--- /dev/null
+++ b/tests/block/035.out
@@ -0,0 +1,4 @@
+Running block/035
+blockdev: ioctl error on BLKRRPART: Input/output error
+Return EIO for BLKRRPART on bad disk
+Test complete
-- 
2.44.0.683.g7961c838ac-goog

