Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FD2C68F
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879278; cv=none; b=eJi3XmD1sjsWDAL9j2J+RBqxy1QMW7aSKuMrXR8bQXJ3nhF9hqXUNG4h47C+oPJNq+U/DOCYQ5BIx0kCd9iHj7EGtizp2e97Yma3bHn/+woxZObxCq7BArCSgUSx8igLQ0lmW6zY5Zvc94JasUlsRD+vQiT4cVLV/OccvF5d1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879278; c=relaxed/simple;
	bh=WN50uJEmY+Oxo3TpckSX/FP9sVap2YvGMIfxYyHOp8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VA4hg4DxYbRIUnH9W95U5JgnertSud2wnjhUoFUMOtPL4flDb8bTupFUuNPkRVUni3So+x7wVqCE7FF/9VjDEACOx8hUHrZNe+imcgS0UfmkqC2YSpVo3SX60Sp7CfP0vmFJAHxc8akcJENWOtULyV7zKk8KT1TCDVSF3/65jiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFP5GXdo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFP5GXdo"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so532467276.3
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712879275; x=1713484075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=clnkfWuD7V4vH9zrtQQEmfziX2ooB8ABjjMf2UVHdpk=;
        b=YFP5GXdoD8kvkCNKMb+kxqL8BCLPehYELJZtruxaO76APrxMZC8o/WT719aa6cWqgr
         2IcfXv/k7jcVaJ3JCKkkllni8/QY5UCpVZgf/40N0h9/E1GvKxlzDWDrkqkiNsZVOsUH
         3W+g4lPEKHw+36NN+OKEr2ZfkcNvLDa9vkQaPKnmnO99jg98AXN1yGZjDy7QZWvsSL1r
         59W1tpoyEF86eWCXcrq3vIdoohmZa8XwyL7F7J+EI3Trl1PsjeWSIBqafIqy8peNUjMG
         pCm7atN1ojUJ33raf5w9+45rHjoI2C8GOUJLKWRA8k5Pzpnk7OiPCHhYZhPaxSXE9Skm
         r3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879275; x=1713484075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clnkfWuD7V4vH9zrtQQEmfziX2ooB8ABjjMf2UVHdpk=;
        b=Bn+6EdDqmFC5yP5QOdBLf+xgylqCS9wEu+3aVMkGRl6detydUFQtm7Hd5YbJQuKTTR
         gDqshn0IdCnqUfhO9tOEKATWlBruWOPa+EOc+531DQ/1dCdqE//QmAHCEoVjjj5DyKH3
         kUpGHWRC5H5Z1FG9GgUkXelR8Hkjcidrtrujig0y4OBRRxI+hVmRpykXZJ5lCu21Kvp8
         vpn/GDwJBPXebMlT4MjhThGnyYku/nxwR6c3dRCUBt8LXy8pfQhdY+9FbVsARq4OxojK
         Jc/wnKPyDFoZ4It1YbQcrdj0aTVSqg1yfYcQqBsqpfQ54ETnpovJm4E4dWtrAuKJwcLJ
         k7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhrLbZs6+hoB3AWTxZQZzmkx1DBzqfmpIxDZRPz7B9TxghW1+HIrolyTtpCw5+IkqhdTU9f/oZ+ne961kOtxkxS2ZbSMHWAZnhkGU=
X-Gm-Message-State: AOJu0Yxi5tZB/Hy72NVDyAyQjYug2O24Wz+/bBG9E/UFlOxwAXl+SSNY
	pMO/sqE7SbrsRWxa5Ffd/1h/Fv9tL0lDx+5zwsD9SnLr03KBGrfBCEdSfyhKAmzNcPsXRe59K6n
	t17EkyTvsJ8zy71YtKfU48tIFag==
X-Google-Smtp-Source: AGHT+IF4HqNhSE7ZODNfIPdcKRTIYoaGZp33s4JqgsUYutKYtlZv5M+BXOMwwSDMfeGuP5AEbKBAWCuX8WPV1RYKtaQ=
X-Received: from srnym.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2728])
 (user=saranyamohan job=sendgmr) by 2002:a25:f512:0:b0:dcc:79ab:e522 with SMTP
 id a18-20020a25f512000000b00dcc79abe522mr106823ybe.11.1712879275740; Thu, 11
 Apr 2024 16:47:55 -0700 (PDT)
Date: Thu, 11 Apr 2024 23:47:42 +0000
In-Reply-To: <7ksgwjpcdt7up3r5rvvxoojllbnqnxu4fdzajpyzgns3sax2yi@hbkgnensb7i2>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7ksgwjpcdt7up3r5rvvxoojllbnqnxu4fdzajpyzgns3sax2yi@hbkgnensb7i2>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240411234742.590340-1-saranyamohan@google.com>
Subject: [PATCH v2] block/035: test return EIO from BLKRRPART
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
 tests/block/035     | 87 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/035.out |  3 ++
 2 files changed, 90 insertions(+)
 create mode 100755 tests/block/035
 create mode 100644 tests/block/035.out

diff --git a/tests/block/035 b/tests/block/035
new file mode 100755
index 0000000..d4e67fd
--- /dev/null
+++ b/tests/block/035
@@ -0,0 +1,87 @@
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
+	blockdev --rereadpt "${TEST_DEV}" &> "$FULL"
+	if grep -q "Input/output error" "$FULL"; then
+		echo "Return EIO for BLKRRPART on bad disk"
+	else
+		echo "Did not return EIO for BLKRRPART on bad disk"
+	fi
+
+	# Restore TEST_DEV device to original state
+	restore_fail_make_request
+
+	echo "Test complete"
+}
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
2.44.0.683.g7961c838ac-goog

