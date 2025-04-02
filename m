Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957C232364
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577756; cv=none; b=FUALG6Hkfa45mi43Dm5btI1mT7U8vGTERqaOseJO9RfrR2ci7hT430d7qIjnlqISRKWim79WIToxqRCfDErYgo6X2EkxIoe8lR3ms2XCXRxBp8Yk3pnpjKSzRUrDY6oRozWdS1XreOQsvlRqcGMhCphyS6bvCZIopl7PivHVvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577756; c=relaxed/simple;
	bh=QYoXh2T33Um9vyJzMNSajt2mhPw/PFqAatUozcTWlZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8QKj+Rrbup3M777JgP6nBPJ2waZpUeLGiSCFx66XJvQ55rk338jRwqfolXaTEvcVOtuEuztykKTve/yecgLuvuuJEuI/HVSZZGxgMfigksKzYLKPIxkKzYA3fMeoNWNAn9dkYsouFLqqrDnnC371Hhd+PeJ1txEieUAirOkJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OKIbD681; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OKIbD681"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577754; x=1775113754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYoXh2T33Um9vyJzMNSajt2mhPw/PFqAatUozcTWlZA=;
  b=OKIbD681UfcXaOCswbKiWhN2mrI7c9oGGSTePoJgSlayVfW9U2DxRZfx
   BNYJijBLvz+QkuWiqMD2G57O7Q2wpMs/M+Q+7+jFg7VTWfZFoLAED3Gzj
   OsgaWiV5xLaUEbOtvzSCWjIb/mszfIu71ojHMgT6dNHwmtlyAXunwhTb3
   lJYwdWXdP11g3zun3sOu2wvCzgzsgTgyRscHQi6oRYldAd3ECOYc8uK7P
   V1InKPzlWro8ttI3IlX4as7bOaSBtEztLScC9xp32GPjzu6Duo6uCV1J7
   InYwYCCTny5jQC3CT8WI0zXbbr2ScTeBimcAhzCBGc557s1G/6IN4iXsm
   g==;
X-CSE-ConnectionGUID: /fpT4UqnTiu2xHUJSnS7Hg==
X-CSE-MsgGUID: +P2lmsQ/RwKjDoXsvbN1Dw==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367629"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:12 +0800
IronPort-SDR: 67ecd4a1_1vLfSGxNPa9W37Yrk7XlAbRAXofwefMzSyB6u58tb+JhEgS
 J/JN5M8F1NIfXwBZKXKHLs/dcYMGcbNlCqEEnUQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:38 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:13 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 04/10] nvme/rc: introduce _have_tlshd_ver() and _have_systemd_tlshd_service()
Date: Wed,  2 Apr 2025 16:09:00 +0900
Message-ID: <20250402070906.393160-5-shinichiro.kawasaki@wdc.com>
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

To run the newly introduced test cases for nvme-tcp TLS support, the
userland daemon tlshd and its systemctl service unit are required.
Confirm availability of tlshd and the systemctl service. Also check that
the tlshd version is larger than or equal to 1.0.0, which allows to
authenticate TLS sessions for nvme subsystem with the default
configurations.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index de68b31..9584610 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -597,3 +597,23 @@ _nvme_reset_ctrl() {
 _nvme_delete_ctrl() {
 	echo 1 > /sys/class/nvme/"$1"/delete_controller
 }
+
+# Check whether the version of the fio is greater than or equal to $1.$2.$3
+_have_tlshd_ver() {
+	_have_program tlshd || return $?
+
+	if _compare_three_version_numbers \
+		   "$(tlshd --version |& sed 's/.*utils \([0-9^.]*\).*/\1/')" \
+		   "$1" "$2" "$3"; then
+		SKIP_REASONS+=("tlshd version is older than ${1}.${2}.${3}")
+		return 1
+	fi
+	return 0
+}
+
+_have_systemd_tlshd_service() {
+	_have_tlshd_ver 1 0 0
+	if ! _have_systemctl_unit tlshd; then
+		SKIP_REASONS+=("Install ktls-utils for tlshd")
+	fi
+}
-- 
2.49.0

