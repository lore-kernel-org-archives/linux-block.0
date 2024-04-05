Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77C1C02
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712282223; cv=none; b=A5Ov4bTRhkkqzb2JGdjgO7rPTvtd2OLGaT5hS6OzDNoPMB/tYf4SjsEGC6/joma7pQYCmY3TBJs0UWwCSEDGhCl6QwRbQh3/etCceqXt2dK1AwHv1FSZ3AdgmOm+N/BFa8uMnb3WN0U8L2fALOu25H7LdJnz7rqSCjCcjklrUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712282223; c=relaxed/simple;
	bh=4MMejEGTUrtL+yes1ppMD1Jm7uDcKf5cvbQXRQCiDko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kvMs4V4sQBblBxu+mJOnGbPv3Dmlgdj1uPLhpihCedqrAQxhvAnqwFKNhx+N63Mc0S3a2y6JEnFa8F0RrAXDmxFIuftuMRQdf/Thhk2NGPmrBRRUlwfInzNDlbrndX0c2SiF9YRvm19aoJ25CvBBqMLJfsjjPevek+7W0/yL1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/TD3/ZA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/TD3/ZA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b96c8ca2so27680427b3.2
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2024 18:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712282221; x=1712887021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXPLOXdMP5Vk7looRQOnifkvbKoxK4ZAzw1pKKhIfWM=;
        b=c/TD3/ZApgmACexDtvFqnNKFptAUUk5OOAuugKGy5PKKi2KHyKTR6MbM2tOb/FL/4d
         TdlmQLvkaTUC24IP6M/WybEp1cIQW6nPGnD2OVq5v75agByGl3vlcEuiFYkQLsMWYmHK
         kTAXnk9N3yVvk2YEi/G73oQcpDYUAw+5CZRU4l7/zkUDBte2SzvBoj7mYdplQPX7uaQc
         ZSWwOxJ0O6CM5VbU+vNDhrJKUzJWJonL/SPBl0CRG1W4k6xFCV0RcwWMUgPE/iT4dChJ
         4YuCLj2AIH0ElLJqkowRhCvqQcf7iNT5mm6xDTQos26UWlTvkcZy9nNA7Li9wU+JyZac
         LM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712282221; x=1712887021;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXPLOXdMP5Vk7looRQOnifkvbKoxK4ZAzw1pKKhIfWM=;
        b=N5kPTVqbk8VX3Gdv51Iyq8VY0IDjMfxTi+UkQ8770z700zoJrk3qctcg2YTtKlKiVP
         d1pMHGQsTuftdv4S0UNhTEbfHspG2thYBsoDQqZr3LpGlqsiViGZLq4VKeIM31udvOHQ
         aNTE2+dDe620hXLPVw4GL+9MqLzzObD+wyeKRkopPGVsdTSIrPxjd4grsydf+JFHvAJU
         eLJDON1JAi2i3QvUXewAQ6ftU7gFyb4KQprihfLFnfp2n9YsggkmGwFgmXmMoTz0U00k
         mVVVf0eHMytCEplnsOW7NXcWa6EbfjiaEsB25u8umMGTLedycqmDhvCcs3IpBP3DejBm
         198Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKyXZ/0cSS1TmZJqvhI4xjt5yeuhZI4b1KFe/O+MmBSoBLXd7KnGOSS1gIGBQ1GeNDt3NhwTtknad7/J1NFhLFcWF9rDirj67B3fU=
X-Gm-Message-State: AOJu0YxrQJbtjEsII6LwObtvqdebZp0DQk8BSuAlKlBgNGIyhU2GRQnX
	zVIhPnjCOdJz8eDPE/0eNetWMC/nxODUWwJlD8pKo5NhmQVWo9a7G1qtau2TYpKxK7ddqAsYnb4
	9XJtYeV9aSAfeDKs9N6lp/Lyk1A==
X-Google-Smtp-Source: AGHT+IE0CRxUeUQwkVCqkeH2m3Yaxx74i9cETUDvGRsVNNa87wlHR9dvJWEEfXEcaxillbBd/i3+neF8bMBG32JyzWw=
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2a3:200:b12b:59df:64f6:cb16])
 (user=saranyamohan job=sendgmr) by 2002:a81:a153:0:b0:614:f416:9415 with SMTP
 id y80-20020a81a153000000b00614f4169415mr164ywg.7.1712282221457; Thu, 04 Apr
 2024 18:57:01 -0700 (PDT)
Date: Thu,  4 Apr 2024 18:56:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405015657.751659-1-saranyamohan@google.com>
Subject: [PATCH blktests] block/035: test return EIO from BLKRRPART
From: Saranya Muruganandam <saranyamohan@google.com>
To: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc: Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"

When we fail to reread the partition superblock from the disk, due to
bad sector or bad disk etc, BLKRRPART should fail with EIO.
Simulate failure for the entire block device and run
"blockdev --rereadpt" and expect it to fail and return EIO instead of
pass.

Link: https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@google.com/
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 tests/block/035     | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/035.out |  7 ++++
 2 files changed, 87 insertions(+)
 create mode 100755 tests/block/035
 create mode 100644 tests/block/035.out

diff --git a/tests/block/035 b/tests/block/035
new file mode 100755
index 0000000..3b307f1
--- /dev/null
+++ b/tests/block/035
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Saranya Muruganandam
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
+DEBUGFS_MNT="/sys/kernel/debug"
+
+
+_have_debugfs() {
+
+	if [[ ! -d /sys/kernel/debug ]]; then
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
+
+allow_fail_make_request()
+{
+    [ -f "$DEBUGFS_MNT/fail_make_request/probability" ] \
+	|| _notrun "$DEBUGFS_MNT/fail_make_request \
+ not found. Seems that CONFIG_FAIL_MAKE_REQUEST kernel config option not enabled"
+
+    echo "Allow global fail_make_request feature"
+    echo 100 > $DEBUGFS_MNT/fail_make_request/probability
+    echo 9999999 > $DEBUGFS_MNT/fail_make_request/times
+    echo 0 >  /sys/kernel/debug/fail_make_request/verbose
+    
+    echo "Force TEST_DEV device failure"
+    echo 1 > /sys/block/$(basename ${TEST_DEV})/make-it-fail
+
+}
+
+disallow_fail_make_request()
+{
+    echo "Make TEST_DEV device operatable again"
+    echo 0 > /sys/block/$(basename ${TEST_DEV})/make-it-fail
+
+    echo "Disallow global fail_make_request feature"
+    echo 0 > $DEBUGFS_MNT/fail_make_request/probability
+    echo 0 > $DEBUGFS_MNT/fail_make_request/times
+}
+
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	allow_fail_make_request
+
+	# Check rereading partitions on bad disk cannot open /dev/sdc: Input/output error
+	local out=$(blockdev --rereadpt ${TEST_DEV} 2>&1)
+	echo $out | grep -q "Input/output error"
+	if [ $? -eq 0 ]; then
+		echo "Return EIO for BLKRRPART on bad disk"
+	else
+		echo "Did not return EIO for BLKRRPART on bad disk"
+	fi
+
+	echo $out >> "$FULL"
+	status=$?
+	
+	disallow_fail_make_request
+
+	echo "Test complete"
+}
+
diff --git a/tests/block/035.out b/tests/block/035.out
new file mode 100644
index 0000000..3fbfd77
--- /dev/null
+++ b/tests/block/035.out
@@ -0,0 +1,7 @@
+Running block/035
+Allow global fail_make_request feature
+Force TEST_DEV device failure
+Return EIO for BLKRRPART on bad disk
+Make TEST_DEV device operatable again
+Disallow global fail_make_request feature
+Test complete
-- 
2.44.0.478.gd926399ef9-goog

