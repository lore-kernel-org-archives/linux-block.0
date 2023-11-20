Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="InSvx35v"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DC1AD
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 18:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700448581; x=1731984581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i4Jq9ujSuw+tbJO/gE7VpPB4GEvE8wZu/dgRKJY3A04=;
  b=InSvx35vRp2gvQa2v3Oh2JM3NJY78mZiBajMleko+53VCoRXcL/493xD
   hSPBdM5AyPDh8GAY77NkMYtYC5vkYXoWtoikcNWjHcuHadW45BIEM8htG
   LX4Gok5ItGHZDBCgtL4H731cZPPGvfyk8FMGsXAotK1P/O6IWG8KXwvG6
   IabMnxMa8P/xGHX/6vfXfLId4hSdfy7ACxTFykT+wiU8vgIaexN5M1fCx
   JnW7tMEP5IGjGYV80SNvP9COQoT1k+DGvAU6/lQHvt2DuqDaIcjUO8Hqa
   rbaf9ai3rpzlroTr68nW0ZxfBwWv+uIvZUmkp0XLw3iyxDrYu35mXq/AS
   g==;
X-CSE-ConnectionGUID: i9MFBUxkTXWneYpk4PAl/A==
X-CSE-MsgGUID: zjLWfecjSma1Mkc07NaERA==
X-IronPort-AV: E=Sophos;i="6.04,212,1695657600"; 
   d="scan'208";a="2825576"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2023 10:49:37 +0800
IronPort-SDR: xn8rbW5ImhYXodqyJxM+sd9upXZeoDA3LmCwFv9XB+BzZ5FIGdgLfhtHLef7Bens42bfKVT2fV
 Vxl8IBWu+RLsQkJkCrSA8o6+xBrWCAZGK/P7X0noLfdlbG6y1FYs3yiLB5cXGfRhm+zpour6d4
 jpoARw6fGnlkofXGdgtfEUFoOqpy+m7EGr2Gowu2fsRAmidLymH/ABejCNOS9b4GA4qAFoqW0f
 9O+7YqwrQg09mL6JaR+UjhSuz8r4YWhmbCRTr7ha+dcimoB7NAgCquBOippkIe/S3pddC2Lpue
 IFE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2023 17:55:18 -0800
IronPort-SDR: LyAhL587kEd5mvoOmm30w330KTXV8mNMw880HxO4A6NL5WFwNQbjO1jB4TXSs17Xi6HHsF1KXW
 J8WQtqzPnyrkAbpS8Iw7El8wcTUpx4VMdyaa+nrWaO6tudSUenOSZwDuCAW5/ahWC7ysqhkAx0
 8hOwAJYonEtAFEwDStaQ8gKF+xh45QgLMoVFBGeyLYI3gnd226fmKt1dAGNtlc6ZyFhEd+yKBg
 C3V1qZel8zB79AqgKu+JYpuL/h37xn3ilcONbNxqi0gfzgK334c9sSYuDVuRqtrGvnz4cYOPoa
 qng=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2023 18:49:34 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/1] nvme/{041,042,043,044,045}: check dhchap_ctrl_secret support by nvme-fabrics
Date: Mon, 20 Nov 2023 11:49:31 +0900
Message-ID: <20231120024931.3076984-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
References: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel commit d68006348288 ("nvme: rework NVME_AUTH Kconfig
selection") in v6.7-rc1 introduced a new kernel config option
NVME_HOST_AUTH. When the option is disabled, nvme test cases from 041 to
045 fail because nvme-fabrics module does not support the feature
dhchap_ctrl_secret.

To check the requirement, add _require_kernel_nvme_fabrics_feature()
which refers /dev/nvme-fabrics and checks if the specified feature
string is found or not. Call it to check dhchap_ctrl_secret support in
require() of the test cases.

This change relies on the kernel commit 1697d7d4c5ef ("nvme: blank out
authentication fabrics options if not configured").

Suggested-by: Daniel Wagner <dwagner@suse.de>
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/041 |  1 +
 tests/nvme/042 |  1 +
 tests/nvme/043 |  1 +
 tests/nvme/044 |  1 +
 tests/nvme/045 |  1 +
 tests/nvme/rc  | 16 ++++++++++++++++
 6 files changed, 21 insertions(+)

diff --git a/tests/nvme/041 b/tests/nvme/041
index d23f10a..c4588d7 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/042 b/tests/nvme/042
index 9fda681..815d65e 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/043 b/tests/nvme/043
index c6a0aa0..e65abb0 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/044 b/tests/nvme/044
index 7bd43f3..9ee0747 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/045 b/tests/nvme/045
index 1eb1032..be408b6 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -15,6 +15,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1cff522..3c4b2e1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -155,6 +155,22 @@ _require_nvme_cli_auth() {
 	return 0
 }
 
+_require_kernel_nvme_fabrics_feature() {
+	local feature="$1"
+
+	_have_driver nvme-fabrics || return 1
+
+	if ! [[ -r /dev/nvme-fabrics ]]; then
+		SKIP_REASONS+=("/dev/nvme-fabrics not available")
+		return 1;
+	fi
+	if ! grep -qe "${feature}" /dev/nvme-fabrics; then
+		SKIP_REASONS+=("nvme-fabrics does not support ${feature}")
+		return 1;
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.41.0

