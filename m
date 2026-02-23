Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43604344050
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818635; cv=none; b=av3hkZgL0Lp9ga7mVlY9Mybm3US+IMn3lxPXSM5yMN5E1hpLvNdz14zqix1TVismwe/q/WAIIhKfn0F9bxPmWTCshE2HCVeoqs6weHMCpXlAEHTv1uE05XF+ec5Qiqdrp1Dr+8T/OqdDNKd9X0eIFrpJThOweiTAL7dAzNJ57Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818635; c=relaxed/simple;
	bh=7t+J+tUUXEHJkiZGqw5eTJMqhkB8UMVepv2+gKUVDwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfbPV8ahszTEsqbjj/qzcqFtgNIIyKjcDqTK+WNyuCyHJ4eHSasdQ81wKAIHeGNCo3z3jw7nYuhauGtAt05A068/WMEJJcNS00G82heND7lDT032TCgqQZr+CnsHA+QRUVgP1n4t/LSfTLS242NKvV5VAenm+U7qFWREK8s43yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TZWypNv4; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TZWypNv4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818634; x=1803354634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7t+J+tUUXEHJkiZGqw5eTJMqhkB8UMVepv2+gKUVDwQ=;
  b=TZWypNv4yjXqcY4MUkOKx57qv482dHIlO5CPyG0jqzbi+vhsRHuApIIl
   X7ViRIlg/ljs2FqMKxsjlF4WXc0zpHyQ1OhlDS9eah6v2JS+QxRJCa7wo
   CT6Jy09LmHcoZh/hM7zkHkTuqyY/fpsv0bEsZ+K6Epb6tzrWonXS/o43N
   YsYRnAT2sJdHEYAkgh1WIE3EfT/PaT9xbs9AQ8kNTbSgaDQJP4qPKMSJN
   Z6YHNukZRmkgk2lgoOFQN6gOQ0DFxv/R0AFAaAq+90UiMxcu0PP6Pv++3
   FSIMK9dWVGeQf0kLzyqmFBuxqgTgjdwyQxgTlszHKvDmAQIBI9UKULYIc
   Q==;
X-CSE-ConnectionGUID: pMcI/ndzRjqKEeXqR5S6YA==
X-CSE-MsgGUID: c4R18tOtRkuj4kBdgUpKDg==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="141205352"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:29 +0800
IronPort-SDR: 699bce85_Zz7iHKROgZ7zSXiGPTmSaBDIpFZpEheRtcULYkJ9ES3yfN9
 eIoj/2QJu6YEKmL3L6eHy3fyKW4STzlS/hS9vhg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:29 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:29 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] common/nvme: unload nvme modules only when loaded
Date: Mon, 23 Feb 2026 12:50:23 +0900
Message-ID: <20260223035023.21902-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To test nvme target driver with various transports, _setup_nvmet() loads
the nvmet module along with other required modules based on the test
conditions. The loaded modules are unloaded by _cleanup_nvmet()
following the same logic as _setup_nvmet(). However, this module load by
_cleanup_nvmet() does not work as expected because it unloads the
modules regardless of module load status at test case start.

For example, when the nvmet and nvme-loop modules are already loaded at
the beginning of nvme/060 test case run for rdma transport. In this
case, _nvmet_setup() loads the nvmet-rdma module, which has a dependency
on the nvmet module. At the end of nvme/060, _cleanup_nvmet() attempts
to unload both the nvmet-rdma and nvmet modules. While the nvmet-rdma
module is successfully unloaded, the nvmet module fails to unload
because it is still used by the nvme-loop module. This results in the
following error message:

  modprobe with --wait option succeeded but still nvmet has references

To prevent the module unload failures, unload modules only when the
modules were loaded during the test. For that purpose, replace
"modprobe" commands in _nvmet_setup() with calls to _load_module(). This
ensures that only modules not already loaded are recorded in the global
MODULES_TO_UNLOAD array. Afterward, the recorded modules will be
automatically unloaded after the test case completes. Also drop calls to
_patient_rmmod() in _nvmet_cleanup(), which are no longer necessary.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/common/nvme b/common/nvme
index a419cd3..64f1828 100644
--- a/common/nvme
+++ b/common/nvme
@@ -213,13 +213,7 @@ _cleanup_nvmet() {
 
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_nvme_fcloop_del_lport "${def_local_wwnn}" "${def_local_wwpn}"
-		_patient_rmmod nvme-fcloop
 	fi
-	_patient_rmmod nvme-"${nvme_trtype}"
-	if [[ "${nvme_trtype}" != "loop" ]]; then
-		_patient_rmmod nvmet-"${nvme_trtype}"
-	fi
-	_patient_rmmod nvmet
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
@@ -240,11 +234,11 @@ _setup_nvmet() {
 		return
 	fi
 
-	modprobe -q nvmet
+	_load_module nvmet
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -q nvmet-"${nvme_trtype}"
+		_load_module nvmet-"${nvme_trtype}"
 	fi
-	modprobe -q nvme-"${nvme_trtype}"
+	_load_module nvme-"${nvme_trtype}"
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		start_soft_rdma
 		for i in $(rdma_network_interfaces)
@@ -263,7 +257,7 @@ _setup_nvmet() {
 		done
 	fi
 	if [[ "${nvme_trtype}" = "fc" ]]; then
-		modprobe -q nvme-fcloop
+		_load_module nvme-fcloop
 		_nvme_fcloop_add_lport "${def_local_wwnn}" "${def_local_wwpn}"
 	fi
 }
-- 
2.53.0

