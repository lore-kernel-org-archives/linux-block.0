Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EA43AA6
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762596041; cv=none; b=lAzwOL3DEr0PMYV6lUlZmAReSqK35UTF51IJAuHw+ae9WNsjrqwGZ4AKagubCXc7wbIU+iR4ITPCJ2utf41PRK8+uxeLr+81EZGscUHogXiynTVnOyNI2Dckf7eguTDFoH5ZBQ/MeCE6pQq7QgEEW5eimB+Brhf2ysJ/qvwdZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762596041; c=relaxed/simple;
	bh=KqTJ2CufMZ+ThcCh7L7R3Lv4gnjj8ujItl3iUTxwCRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HL6RheJXNrQ/ibh2oWUirSmuvWni58ziVRyiZTf9jXIBs6l/yHhduHOXIhV7fcuKCyXdmgBMCuYs87pk0LQv8gyUGN1vhI26/FvRODCD/4eApoMccYX9loTPI4e2QqvrhYJ4NPryKgn5/FnXoDlKdfQZIIH2Qfp4p35Nx2IpzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1xMrSKp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1xMrSKp"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1308447b3a.3
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 02:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762596039; x=1763200839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDlym4E47nHmf72D9TAcgTMeuiY8lX4btOrhkJ8Nb8Q=;
        b=Y1xMrSKps1bS8Y+1PBCjCu1f9iSCACN0TVpYH7pmJx3xHzuh6IQjcCmrTa4R1eeagZ
         tfN8xb4sbEAvSWnXnS+uf3LaLo6mgCxQNXCcAOIlVSXIYB1O0Np6249bD2HHNfZDCCvn
         vjXRWatweordqdrdD7oIxvFZ6qwDgSP2Uc2wlHYAcptTKJzoUysP+Y4R2ijTIvmjpkok
         gAZ0tLTrSACO0HAkg1VRxJOv2rdb4NFzS1yBDEjvYbdLK/Mwe2GXlmmyx1vpwXVGTa6B
         2Xv8fTh8VNO814LYY7dY4d+g9tz7OI10erOe2um/W+6OPxY4CxTRPDq5DxpNZqqQ+mzy
         gvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762596039; x=1763200839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JDlym4E47nHmf72D9TAcgTMeuiY8lX4btOrhkJ8Nb8Q=;
        b=QzSxuDPw6OyImDLZMetB4+t3i05Ha/ifYJ9R+qu213RsiC5+m6SzzNyzBJp/qd/bQE
         H0ow6gmWycVDVi1bNTwwrDpILj/BgF3PeCs3JMzTVUop+Jj1zhYqVAM4xz8zyv//DZSl
         U4bkJQfIuifWYqgk7yuMRdmVvuRbkGB7BmzV0yCToRqP8KDzWDmBfSLN6oX0mmTuQI0h
         xpnNLNnrIYJ/wIGXumoeineyNSLuGSAe+z+jpBvgiXasN42D760dvRVG0ErsP5gt03eP
         vojWSwa3kCdqtyncf+/THtypP520mmpTVOsw4fMMC950ZC9BssVh8yM+0jV0CEIVHI2V
         O8mg==
X-Gm-Message-State: AOJu0Yz4kRO3p7sw/x1atSIzkbWBlKffVvu/+61BqBz1Awvg6WKFcrKj
	wOFBZwzAuyhimhgbIqegy9DMKbxaCmeQdTxvNaD7pQY09V2eut3Fdgug
X-Gm-Gg: ASbGnctzRP8dVBoI455faaX4tQMtQkb9DkGyyYvxlS3ehLT4b6lhqCW/wNx9XGeZ6EO
	sesgzYHIBsaSL+nsEV9kO6a2YUzMb/d/TozJX22VQ/FXB+0XFMuxGCY2N5iyR/g8/P8bbdyY5Jt
	/+aCkw3WE9gjX/yd0meIa+3AW2qULK25RLWWZMcx31+M7YjLRr1AEoqmjS+MAKXUpDn7qeHRlch
	8RrwXogqhoj5Y+ltJzPSUseXDqId+huFhka+UcS5sK+V/+Z5dWXvB88p3i4BRsIK+UP/J3/gmUT
	X/YPI7J3pvSoAeINq1XieEBbQSZFp8GehTOgwsV2LmapqA20FlR1t8Vhced1DgPvaiOZG+qIqGp
	mh2uEkBkqEmKxYRD3bs01Ur6TJUhJ6C5NYh5Lb77ecObj3+MCFeJR7F2u1SqrBsEV+LQNzeha63
	8FrFluXFfXe+oRcqWioQOYP21xbDAi2TiMUZ3JAy+WKegUTSUhzoohBOddEA==
X-Google-Smtp-Source: AGHT+IESr4XaESE49/E7bLBplJ8hskZEJU18QFSxGMQShkt+7RBImDuO4PCHfUM0Kg7sbEkDUSlBvg==
X-Received: by 2002:a05:6a20:244a:b0:351:fbe0:986c with SMTP id adf61e73a8af0-353a13a6733mr2792811637.2.1762596039289;
        Sat, 08 Nov 2025 02:00:39 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59de7sm5468677b3a.65.2025.11.08.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:00:38 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: shinichiro.kawasaki@wdc.com,
	wagi@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktests 2/2] nvme: convert tests to use _have_kernel_options
Date: Sat,  8 Nov 2025 02:00:34 -0800
Message-Id: <20251108100034.82125-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
References: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert multiple _have_kernel_option calls in nvme tests to use the new
_have_kernel_options helper function for more concise code.

Modified tests:
nvme/039: FAULT_INJECTION, FAULT_INJECTION_DEBUG_FS
nvme/041: NVME_AUTH, NVME_TARGET_AUTH
nvme/042: NVME_AUTH, NVME_TARGET_AUTH
nvme/043: NVME_AUTH, NVME_TARGET_AUTH
nvme/044: NVME_AUTH, NVME_TARGET_AUTH
nvme/045: NVME_AUTH, NVME_TARGET_AUTH
nvme/050: FAIL_IO_TIMEOUT, FAULT_INJECTION_DEBUG_FS
nvme/062: NVME_TCP_TLS, NVME_TARGET_TCP_TLS
nvme/063: NVME_AUTH, NVME_TCP_TLS, NVME_TARGET_AUTH, NVME_TARGET_TCP_TLS

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 tests/nvme/039 | 3 +--
 tests/nvme/041 | 3 +--
 tests/nvme/042 | 3 +--
 tests/nvme/043 | 3 +--
 tests/nvme/044 | 3 +--
 tests/nvme/045 | 3 +--
 tests/nvme/050 | 3 +--
 tests/nvme/062 | 3 +--
 tests/nvme/063 | 6 ++----
 9 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index ab58f3b..98e5d28 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -14,8 +14,7 @@ QUICK=1
 
 requires() {
 	_have_program nvme
-	_have_kernel_option FAULT_INJECTION
-	_have_kernel_option FAULT_INJECTION_DEBUG_FS
+	_have_kernel_options FAULT_INJECTION FAULT_INJECTION_DEBUG_FS
 }
 
 device_requires() {
diff --git a/tests/nvme/041 b/tests/nvme/041
index 6855a47..8f908c5 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/042 b/tests/nvme/042
index 17d8a73..34d6684 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/043 b/tests/nvme/043
index 7f9e67e..616f7e7 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/044 b/tests/nvme/044
index 1352910..4727dbf 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/045 b/tests/nvme/045
index 4dd0f94..bf38824 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -13,8 +13,7 @@ requires() {
 	_nvme_requires
 	_have_fio
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_options NVME_AUTH NVME_TARGET_AUTH
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
diff --git a/tests/nvme/050 b/tests/nvme/050
index ba55c6e..91f3564 100755
--- a/tests/nvme/050
+++ b/tests/nvme/050
@@ -16,8 +16,7 @@ nvme_trtype=pci
 requires() {
 	_have_fio
 	_nvme_requires
-	_have_kernel_option FAIL_IO_TIMEOUT
-	_have_kernel_option FAULT_INJECTION_DEBUG_FS
+	_have_kernel_options FAIL_IO_TIMEOUT FAULT_INJECTION_DEBUG_FS
 }
 
 test_device() {
diff --git a/tests/nvme/062 b/tests/nvme/062
index 7c88719..19275f8 100755
--- a/tests/nvme/062
+++ b/tests/nvme/062
@@ -12,8 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_TCP_TLS
-	_have_kernel_option NVME_TARGET_TCP_TLS
+	_have_kernel_options NVME_TCP_TLS NVME_TARGET_TCP_TLS
 	_require_kernel_nvme_fabrics_feature tls
 	_require_nvme_trtype tcp
 	_require_nvme_cli_tls
diff --git a/tests/nvme/063 b/tests/nvme/063
index 5bfe8be..bded9a3 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -12,10 +12,8 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_loop
-	_have_kernel_option NVME_AUTH
-	_have_kernel_option NVME_TCP_TLS
-	_have_kernel_option NVME_TARGET_AUTH
-	_have_kernel_option NVME_TARGET_TCP_TLS
+	_have_kernel_options NVME_AUTH NVME_TCP_TLS NVME_TARGET_AUTH \
+		NVME_TARGET_TCP_TLS
 	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_kernel_nvme_fabrics_feature concat
 	_require_nvme_trtype tcp
-- 
2.40.0

