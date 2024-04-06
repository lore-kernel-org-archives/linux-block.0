Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BB12E55
	for <linux-block@vger.kernel.org>; Sat,  6 Apr 2024 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712378796; cv=none; b=JY4TkuNjxYvi/7RfA8dewATawHbCp/j4yEOci0J0hVZstfPb0RdEr8jlTZgaIJ977oYtCQa/uKU3pnCOuFZfFfxdzP9bNFJzg1abZuZ8rAEEVDn7ryc1qsaxCxTAFts1tdrTCctNdBlf9/WR0QOaN0kukvQ42Zl6sVRH2xtc6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712378796; c=relaxed/simple;
	bh=eSY8SmjSJBFEPTR1UEk8BIaMiQsyj/GGwQBveHVgSeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OvZiG/q5QaHrssmtPwPCnEytmVA3XQWV74rnBNg2+xII0qRi7rwFJYoHnoC1MHzzAg/j0nlEGifd6oNv0Sp0/C+sEGhuh0fvzSf8TU3CFz37nEwQgF+nZGDsOUKYmxKW/v5JhL7mR8nynFNfJMLlktuw2u3u/sWbZ2Xg1p94OoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bosuaZKW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bosuaZKW"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ecf5c622c2so1460138b3a.0
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712378794; x=1712983594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5IXfZlUVne5nh2CnHBJTI4+/aPzxiLXmE9xgPPBEMbk=;
        b=bosuaZKWIzGzeXvypNcyyNuyhLkr0VNTe5fRVB+y9+iRVGc2nxm6G/sSiBiBRwpIm2
         FaYlErAWa8RYn2Vo9acXhKWdyZAxZdranwdoJu45Wgkvk3q3L2bliL0ivgA8uqwIdH9W
         h6B202hzk3kQfIW3sePRe7+tY2gTCtTkmx0+bfNgQF0NOQQolBZceT07CIXrKAHC1Lqa
         7bUYBNn7OPIOnX3+iyssP0GxYsRIR7w4H1/bpsG3QI2lMrEhWvkKshDjZl/VMcmWX8ac
         LbYUcMYBe4DZvNZkF0pkSzw7Giu8EES4NSbqR6tPrUyvmxm9QcC6lvipz/eat+PistZD
         rm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712378794; x=1712983594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IXfZlUVne5nh2CnHBJTI4+/aPzxiLXmE9xgPPBEMbk=;
        b=W6oeJF8fPS+SD45JXy6puz+F3zfwGuDambvnOO3uH4AsjzM1s/msmzjhYGm1lU75OD
         xJMMhJY6ETYmAGuYpAgV6jp4NE+DnJvOzjJqZ1k4O+/IPHIW4Qh8Rife7h6+9hkst20h
         10TFKfr12Pq79e2igSBhJehy3sUMcemFLNLCr+aeFkP3V7jwfEns45UXFnB2WTPs/34e
         iDYU1Ea6BKy0unNqw4vIIYhfbrEItG05SCe7C8aLa7IzE+0mwAweRifWcBrI3dNYd4zn
         BB4dSadf8Xg4B86Ic/gn1kRXpZPrhP241C5UTi9f5CoHsTtsfCdXHc4vskyRkSb7uifn
         3iHw==
X-Forwarded-Encrypted: i=1; AJvYcCXvaalx6lrOot1pxdgTOO0APsz/UtkG9S006u8f3SS1lWWuAggyOxqH7XFVjp+pqUZTBOro1mS9AalYZ+8RHzdNYMzLA1Br3+mHdiY=
X-Gm-Message-State: AOJu0YxdRiiL+0Is55tv0rlMDmCV28rrImZomxZm+Wjt0fEGB4c9Za4u
	pmVzz1NsWr66zn55XcS82vlASGOZcFGdpZJsogUo1kIqNmem+6Z/dgJWP46OAcUkXSaUGXlazrr
	OqojhDzeqsH1yP9aMJic/woitoQ==
X-Google-Smtp-Source: AGHT+IHCQR6WZEjGNVySq5kpIgX0OQ1AhvwNbxadV2MZ6ziIhew6QARQ8RcHwAgPERgN+/7kMQfFm5mjCSb03Vr8qLo=
X-Received: from srnym.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2728])
 (user=saranyamohan job=sendgmr) by 2002:a05:6a00:991:b0:6ea:8ece:3b3a with
 SMTP id u17-20020a056a00099100b006ea8ece3b3amr394605pfg.4.1712378794294; Fri,
 05 Apr 2024 21:46:34 -0700 (PDT)
Date: Sat,  6 Apr 2024 04:46:31 +0000
In-Reply-To: <2ac46686-5fec-42c7-b267-128cedcc73eb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2ac46686-5fec-42c7-b267-128cedcc73eb@nvidia.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406044631.2474947-1-saranyamohan@google.com>
Subject: [PATCH blktests] block/035: test return EIO from BLKRRPART
From: Saranya Muruganandam <saranyamohan@google.com>
To: chaitanyak@nvidia.com
Cc: hch@lst.de, linux-block@vger.kernel.org, saranyamohan@google.com, 
	shinichiro.kawasaki@wdc.com
Content-Type: text/plain; charset="UTF-8"

When we fail to reread the partition superblock from the disk, due to
bad sector or bad disk etc, BLKRRPART should fail with EIO.
Simulate failure for the entire block device and run
"blockdev --rereadpt" and expect it to fail and return EIO instead of
pass.

Link: https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@google.com/
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 tests/block/035     | 93 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/035.out |  3 ++
 2 files changed, 96 insertions(+)
 create mode 100755 tests/block/035
 create mode 100644 tests/block/035.out

diff --git a/tests/block/035 b/tests/block/035
new file mode 100755
index 0000000..67896ea
--- /dev/null
+++ b/tests/block/035
@@ -0,0 +1,93 @@
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
+DEBUGFS_MNT="/sys/kernel/debug/fail_make_request"
+
+PROBABILITY=0
+TIMES=0
+VERBOSE=0
+MAKE_FAIL=0
+
+_have_debugfs() {
+
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
+	MAKE_FAIL=$(cat /sys/block/$(basename "${TEST_DEV}")/make-it-fail)
+
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
+	echo 1 > /sys/block/$(basename "${TEST_DEV}")/make-it-fail
+
+}
+
+restore_fail_make_request()
+{
+	echo "${MAKE_FAIL}" > /sys/block/$(basename "${TEST_DEV}")/make-it-fail
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
+	# Check rereading partitions on bad disk cannot open /dev/sdc: Input/output error
+	local out=$(blockdev --rereadpt "${TEST_DEV}" 2>&1)
+	if [[ $(echo "${out}" | grep -q "Input/output error") -eq 0 ]]; then
+		echo "Return EIO for BLKRRPART on bad disk"
+	else
+		echo "Did not return EIO for BLKRRPART on bad disk"
+	fi
+
+	echo "${out}" >> "$FULL"
+
+	# Restore TEST_DEV device to original state
+	restore_fail_make_request
+
+	echo "Test complete"
+}
+
diff --git a/tests/block/035.out b/tests/block/035.out
new file mode 100644
index 0000000..0f97f6b
--- /dev/null
+++ b/tests/block/035.out
@@ -0,0 +1,3 @@
+Running block/035
+Return EIO for BLKRRPART on bad disk
+Test complete
-- 
2.44.0.478.gd926399ef9-goog

