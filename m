Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120E23315C
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577763; cv=none; b=YEtl9k+iOkZdfvYJJweBii8ytxzoYaz4A4rKC0Xbnad/mvAmVc75lXaOpOFblh0Z0iLFD632FZahUBxVD1YZXZ6dwi5R4sfkIPF2OzNSZDQdKgLDsO9T2j9ZgPm6J4rbYbxoV8BkVBsicVJpMfdhim0z94GmbBYA0ZhasuH05ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577763; c=relaxed/simple;
	bh=MgPxIncYoIu1IyU0/pxsqdBGr5YKFoGwEiRiwr1vak4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9GO+ecoLCe5+IKn8Y+6X81HB2I3bZISYYYRnMVhsRyJqUgSVV73LpIhoWK58DontOUQz2FgGFDmV5QANDJ8A/z6frHse8c7npnJZPj47if9cVlXE+JIBtB1Pq2IAZvqFkYurneo73WlMY4/cTA5KIML3nB8Vc4rAyIBjmvgt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bKq11qpG; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bKq11qpG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577761; x=1775113761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MgPxIncYoIu1IyU0/pxsqdBGr5YKFoGwEiRiwr1vak4=;
  b=bKq11qpG+FeBd/1W2Kd3aiLOU0q+IwcVqOcqkeGOkfKbdGfffIRqx9EM
   rKeMGgPMKwcm0m6obqR94PGq3kqafw/Us2XP2kKygKTb8XpO6H7eDjYvH
   lmnWGi7Btb9lieAAflyrLTNydS4Iu1Z4uhKjJeer9b50LPIvoHY5hM6Y1
   0vyPXXi/LsVQJ+/eKlT5DEnj/rFkYN11XgVw7c4Ue0G8haYj+2z8Lg5YX
   LbJDg6D9P5Afxyq4flVu/C6v+Vxl3XSx44dVfeR0tkI4sbDssm2ixumCq
   VQoBzP/mYxQnZxW8MvRiRAe+bCV21lLDMZ4Q0ft2XS4A9CuelQK23zfnu
   Q==;
X-CSE-ConnectionGUID: FPTuqQWhRQSx0sUAO/1Prw==
X-CSE-MsgGUID: 3deTz+z5QDCwgbn26VeyhA==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367750"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:20 +0800
IronPort-SDR: 67ecd4a9_GZyGbwKYYUmXgRKymJxuDKwC469HVyDuwEzoIkrY4wGQij1
 4GqkhJL7fefMEVD4YQX6IGM8A5pOeSBrjKJ0pZA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:45 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:20 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 10/10] nvme: add testcase for secure concatenation
Date: Wed,  2 Apr 2025 16:09:06 +0900
Message-ID: <20250402070906.393160-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

NVMe-TCP has a 'secure concatenation' mode, where the TLS PSK is
generated from the secret negotiated by the DH-HMAC-CHAP authentication,
and the TLS connection is started after authentication.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
[Shin'ichiro: added _have_systemd_tlshd_service, avoided "exit 1"]
[Shin'ichiro: used _systemctl_start and _systemctl_stop]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/061     | 109 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/061.out |   7 +++
 2 files changed, 116 insertions(+)
 create mode 100755 tests/nvme/061
 create mode 100644 tests/nvme/061.out

diff --git a/tests/nvme/061 b/tests/nvme/061
new file mode 100755
index 0000000..7477078
--- /dev/null
+++ b/tests/nvme/061
@@ -0,0 +1,109 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Hannes Reinecke, SUSE Labs
+#
+# Create secure concatenation for TCP connections
+
+. tests/nvme/rc
+
+DESCRIPTION="Create authenticated TCP connections with secure concatenation"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_kernel_option NVME_AUTH
+	_have_kernel_option NVME_TCP_TLS
+	_have_kernel_option NVME_TARGET_AUTH
+	_have_kernel_option NVME_TARGET_TCP_TLS
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
+	_require_kernel_nvme_fabrics_feature concat
+	_require_nvme_trtype tcp
+	_require_nvme_cli_auth
+	_have_systemd_tlshd_service
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local hostkey
+
+	_systemctl_start tlshd
+
+	hostkey=$(nvme gen-dhchap-key -m 1 -n "${def_hostnqn}" 2> /dev/null)
+	if [ -z "$hostkey" ] ; then
+		echo "nvme gen-dhchap-key failed"
+		_systemctl_stop
+		return 1
+	fi
+
+	_nvmet_target_setup --blkdev file --hostkey "${hostkey}" --tls
+	_set_nvmet_hash "${def_hostnqn}" "hmac(sha256)"
+	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
+
+	echo "Test secure concatenation with SHA256"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+	if [[ -z "$ctrl" ]]; then
+		echo "WARNING: connection failed"
+		_systemctl_stop
+		return 1
+	fi
+	tlskey=$(_nvme_ctrl_tls_key "$ctrl" || true)
+	if [[ -z "$tlskey" ]]; then
+		echo "WARNING: connection is not encrypted"
+		_systemctl_stop
+		return 1
+	fi
+
+	# Reset controller to force re-negotiation
+	echo "Reset controller"
+	if ! nvme reset "/dev/${ctrl}" ; then
+		echo "WARNING: failed to reset controller"
+	fi
+
+	new_tlskey=$(_nvme_ctrl_tls_key "$ctrl" || true)
+	if [[ -z "$new_tlskey" ]]; then
+		echo "WARNING: connection is not encrypted"
+	elif [[ "$new_tlskey" = "$tlskey" ]]; then
+		echo "WARNING: TLS key has not been renegotiated"
+	fi
+
+	_nvme_disconnect_subsys
+
+	hostkey=$(nvme gen-dhchap-key -m 2 -n "${def_hostnqn}" 2> /dev/null)
+	if [ -z "$hostkey" ] ; then
+		echo "nvme gen-dhchap-key failed"
+		_systemctl_stop
+		return 1
+	fi
+
+	_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
+	_set_nvmet_hash "${def_hostnqn}" "hmac(sha384)"
+	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe3072"
+
+	echo "Test secure concatenation with SHA384"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
+
+	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+	if _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then
+		echo "WARNING: connection is not encrypted"
+		_systemctl_stop
+		return 1
+	fi
+
+	_nvme_disconnect_subsys
+
+	_nvmet_target_cleanup
+
+	_systemctl_stop
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/061.out b/tests/nvme/061.out
new file mode 100644
index 0000000..97e8948
--- /dev/null
+++ b/tests/nvme/061.out
@@ -0,0 +1,7 @@
+Running nvme/061
+Test secure concatenation with SHA256
+Reset controller
+disconnected 1 controller(s)
+Test secure concatenation with SHA384
+disconnected 1 controller(s)
+Test complete
-- 
2.49.0

