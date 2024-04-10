Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0107F
	for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708148; cv=none; b=cZTITA8jzvwtU+ZfxZp8MkRBT7E9G/TtGO4wVcTRU/biWYhxnJhVGQiNp3s5MobIn7q2JUk6An1OYXpkNmdEaeaSnT09e3bJJuHFr9CEMIJzWBE+rTGu2gfeM+V78YYpcNxBAEPcLlqTmMQtUb+XInMiJMOSAFN9kB3vZX46A2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708148; c=relaxed/simple;
	bh=36wikt0PsIlyFrXCu41nN7jYxxEk5Y45W/MlTjPxSH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tObTsv4BuhonEwbYFVWynCX316CFjU0p9T5+gWuwhGBZnSaXl1OQl3V1dHbVRuJBzeG3AuIYUPZjXxgNb5n0YIBacQWgt9UbMWmi2RDxGdcGW3vZBa7Fr+7GXCa3iJ9A99TJiLPZJ/c6J2SmsFNxvjvztcv/iZg0Brw0ZWYIwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDHfx1vf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDHfx1vf"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed663aa4a7so1319541b3a.3
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2024 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712708146; x=1713312946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RnM+UV5ihHEMLNgKVMeOwf2fbnd4TUGE7DUo65WsuKE=;
        b=aDHfx1vfjZOFVLD+jeex/EUTKz/U5mhYfTiObeBoEAUxUiGoG1usd6Z3B2yN4sopJ0
         pLJUe4okCVl3QIDinnh8jPwu+eNw5jlgBJv47uFPPcGaCOVJg+XS3Ysw6FAW2GPOgwaI
         VUVjeIOiEOGsKo0wXutzhh7GxgZ0ZRaSwhuS6YnUu1OJ4klAylWVQgMrwb/23FrK/7eH
         /SfycYaXZ0vt2vfW3ZKA5URP3FdXc2+xQx6KwXFXtwuJHX3IzT4r0HisC/Q1sDTdEYST
         WBdk3MovUhgIoPFCfaACaR+dJ1pVl5CB35nOjxRb7pqhQ/vufZ1c3SWeMqLnhwQ0kzp9
         LZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708146; x=1713312946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnM+UV5ihHEMLNgKVMeOwf2fbnd4TUGE7DUo65WsuKE=;
        b=YkgZf1vWslXFMF/kgfsyXlVIPYDlVLNhWQ4AZivoJ9cv16JlRmTSrHjNOO7h64ezTa
         3zoIUEHRYbYuiXtFu3jCpXCJv5WsCGUa1xg7QUpKNjAq9SkDr044c6TiWEiBbYasHyGq
         ePJVT6tZe4pcDea4en9y11vGfRnSLXl/CL4KkWojcPYP1qBZWehpmnUfJqnKRybeHc1W
         PGzCWtRJYeYVGF1gcTh1bLIqO51VbwhbKHWIs53yQWv56OrU9fVMlPyRhF/E0vUWEsYf
         VVJvfYzcPb2y5Ds/IunhwNq9atCWrMvZgd+uv+L55TOrRn4mS9qx2DakUfnRDTy7vLF1
         kHiw==
X-Forwarded-Encrypted: i=1; AJvYcCVcU1UJnYehPz1HpVshM9vWNF6ZXPIsChPNzVV3nzTEZbPb5nMid6uX7Svz8r4OwREfWXEJp20BOY7tpNHr9OYne+WIAKCkBAVytmM=
X-Gm-Message-State: AOJu0YwNztB4Vc3MdqLwjK5DNjpDoonZm/g05N3PNbF7++EfLorhfV21
	RBeZNL+SBJc2rwiMOz4NoewUJr+urFU8dgQOvM7EmZ0abNa6m2MOYsgWLB/USH/8Tm+EkmNHfeS
	eqahP9IJ6L88sHV1zuZI7NDMrhw==
X-Google-Smtp-Source: AGHT+IG6s3YN7eURQ0q0XwddSehDcIyDL6adZwjjl9EWrp+GD4IXmbSrsEe6WENVz4eYADP4Kl6/RTU/7FvQQ/k+4H0=
X-Received: from srnym.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2728])
 (user=saranyamohan job=sendgmr) by 2002:a05:6a00:2d0e:b0:6ea:aafa:8145 with
 SMTP id fa14-20020a056a002d0e00b006eaaafa8145mr55218pfb.3.1712708145865; Tue,
 09 Apr 2024 17:15:45 -0700 (PDT)
Date: Wed, 10 Apr 2024 00:15:42 +0000
In-Reply-To: <pbhs6izmwy5sfn3u7ldd6egwi3m4xadmvdgjh2qzy3houvwzyt@v2auexg4hkke>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pbhs6izmwy5sfn3u7ldd6egwi3m4xadmvdgjh2qzy3houvwzyt@v2auexg4hkke>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410001542.4036191-1-saranyamohan@google.com>
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
 tests/block/035.out |  3 ++
 2 files changed, 89 insertions(+)
 create mode 100755 tests/block/035
 create mode 100644 tests/block/035.out

diff --git a/tests/block/035 b/tests/block/035
new file mode 100755
index 0000000..e15f115
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
+	# Check rereading partitions on bad disk cannot open /dev/sdc: Input/output error
+	if blockdev --rereadpt "${TEST_DEV}" &> "$FULL"; then
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
index 0000000..0f97f6b
--- /dev/null
+++ b/tests/block/035.out
@@ -0,0 +1,3 @@
+Running block/035
+Return EIO for BLKRRPART on bad disk
+Test complete
-- 
2.44.0.478.gd926399ef9-goog

