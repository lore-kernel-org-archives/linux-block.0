Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44437441A
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MLau168C"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F4E1
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700027543; x=1731563543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpolysReVgxyZ9iB8V+ScjF0ki6VPMkTaXYP+O7+C6Y=;
  b=MLau168CjEKOrJiUMhDp05meXppbWEbJsfRLngF9ifdky5vAL/vhTayj
   7bmB/3nuYLq0lt0K9TG3cR5iKjUl0y+fgJaMWKYvKi71tuNe8l2AgRrMW
   BUQJASZPpTWAJl0n06S07tsb5HyB4UmMXdFrSIukFoWY1phjaUwLw2bx4
   QMLWID1uGNWa/ra3gr3tNccsCL8BB31AmlwhPJugl31ct3RStW9uNVOmB
   iBIJAT/yFxNT2Rhlr498zFJXFn3iYrxYjFHknxZ3Jl7uLRVIEzuypdHd/
   fEAmnGcX1KDCo2H96/bYsa23fbvpdfkgzPHEATz3M4DcqevvI1wTT7vwj
   A==;
X-CSE-ConnectionGUID: WzZzwEyGQnWAWFXPDiC3QA==
X-CSE-MsgGUID: /745Ht5kTD269uus7VE9hg==
X-IronPort-AV: E=Sophos;i="6.03,304,1694707200"; 
   d="scan'208";a="2334151"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 13:52:23 +0800
IronPort-SDR: 0g4zedN7eY+OPjLSVBabxbMB0fOJVHnqbo/wD1M+GCS4tqY6KW7bkmXUm86IG3CVTvwqHoXvHl
 ab3j49YLfrOFcp5xfwT2R1jFaIO7SSpn9MQQC9puY3mvoZ5OsKvxgBuMubYXiRMJPQ30CvZFrB
 7OBVdo3rGiaQv2b2yPAVZ4n+ukZ1Ckkr583YfWqTD2scbqYzckLf6DO5+Fg3jaeaKl/IeS1ivL
 OLg+sN6VOxmTGmvF6+kZKexbvdTcOPDUap8/si2z1/M89GElTOKldB77VdMIAIHELYHUIshMOY
 cjg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2023 21:03:50 -0800
IronPort-SDR: 25t3c2p2Hk15/eaYEXBY+AzbNCnqKHKstAcV+bbXBNDzVGL+6OgTPLteW2H/wrXiNOF+4d/Z3w
 7SzRK3nDUxDB/9QAJNYv16VGtWj1jintSkNpMMZEUf/z4BLBn56b/g5BrJWVNgoZPUhRaecXEg
 tzQrzucnaA+xU2TOOQxT9SWqVeyV78FgLkJrCUQIV6bKrfRakPJ3drefylbMMpwQkeaXTWzsKE
 phSqOBosUqOuSxCetB2033tjg/M22nFHxc+X4F21zzKbVmdW5EaLIzYw8fryrf8O2+DUdDNbvV
 +bY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2023 21:52:23 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel config NVME_HOST_AUTH
Date: Wed, 15 Nov 2023 14:52:20 +0900
Message-ID: <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel commit d68006348288 ("nvme: rework NVME_AUTH Kconfig
selection") in v6.7-rc1 introduced a new kernel config option
NVME_HOST_AUTH. The nvme test cases from 041 to 045 fail when the option
is disabled. Check the requirement of the test cases.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-nvme/CAHj4cs_Lprbh1zWsJ2yT6+qhNoqjrGDrBgx+XOYvU9SLpmLTtw@mail.gmail.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/041 | 1 +
 tests/nvme/042 | 1 +
 tests/nvme/043 | 1 +
 tests/nvme/044 | 1 +
 tests/nvme/045 | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tests/nvme/041 b/tests/nvme/041
index d23f10a..a7a5b38 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/042 b/tests/nvme/042
index 9fda681..50d56d6 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/043 b/tests/nvme/043
index c6a0aa0..b5f10bc 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/044 b/tests/nvme/044
index 7bd43f3..06e17d1 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/045 b/tests/nvme/045
index 1eb1032..126060c 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -15,6 +15,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
-- 
2.41.0

