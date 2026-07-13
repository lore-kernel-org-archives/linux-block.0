Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE51F91F6
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903172; cv=none; b=LPBeP5h3dPtYphKvUjXgJN3dNM4vxb5IREbah0bpmd10BPQeJZLkbLIam1LnnuqxBjxoPiHTSHtVXh6smWWAsj7l1PwxxjozkNRQI/MfFcSc6eX0tj+mUwlSeV1b0NiWDu7Xk7kGDHcFqijYo0U+anW/jo7k9HLH1crxl2x397w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903172; c=relaxed/simple;
	bh=iflCEb2XJy49OrBBeSRD6n31GmM6IEbT7U8yNg72vfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3yOqL+vgf5dLzd5OKjqKUBjf0O+lJ0fTs3foLfc6cckErBbgCvY6SnXsRUeP/qTNiGqC5oY2X2Ft2idA4o5DpZj4LNyPdgeoyrw4DY4LL+0is2Fch28DEceDBjOqGVTzVaJAgzRSzcB2c0JjXgF1sWztgToDEd+1ytXparbIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YwjCYlJm; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YwjCYlJm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903171; x=1815439171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iflCEb2XJy49OrBBeSRD6n31GmM6IEbT7U8yNg72vfw=;
  b=YwjCYlJmokiblJEXHHgoQ4wfup56pH9X96hZF5hfpZHQT8Qkn07PZ5EP
   puWx2NaFh1jaixMr2NqqAJMGUh8c1VuMHBgfDNpCJi5e5tVUYT6fnGWQS
   XtMQ1v4Cdc+VcxRCz4zuWkR5sa17mDPG/KhVVWv9LKASCYs6acVJIwe63
   Mk/3iWSSnkUBZFyv73QeWhwOmcPGo8oEpeYry6N0YEyN0+zfug4NHiBRK
   0rWZzFjZpY1lxKToHBK5KU7fTn0cmbMIK///KeubAuHTZx5/CoSNc4vlN
   mI0SPP4g1TfT4630XzGemm4/xpP2yB1ARtxVnBAIJRYuKgqVQRyy8fbP8
   Q==;
X-CSE-ConnectionGUID: GOQDJbq/RHqCVlwsJ1uC8Q==
X-CSE-MsgGUID: Q6OVUQnYSA64JQhqpU+/8A==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596165"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:29 +0800
X-CSE-ConnectionGUID: RLYlnn3CSuenrLH2mvCtZw==
X-CSE-MsgGUID: /uMrcwnQS/m9QZHGhbysFw==
IronPort-SDR: 6a5433ad_YMMaqFoMrWU+d9tiMSgZXNaU0THFFks04VCBHQ6V/T7Qy9x
 Xte8MHrEp1hvnrWGmwRsnNgiiBsXRH9hewY34qw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:09 -0700
X-CSE-ConnectionGUID: p8qmfKSMRZGyFJ5+Nq3s2Q==
X-CSE-MsgGUID: 2T1IbVkXT2qV0bCBogOkTg==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/4] nvme/rc: use _set_attr() in _create_nvmet_passthru()
Date: Mon, 13 Jul 2026 09:39:04 +0900
Message-ID: <20260713003906.21153-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 91316870b124 ("common/nvme, nvme/rc: use _set_attr() to trace
attribute writes") replaced sysfs/confgfs/debugfs attribute writes with
_set_attr() function call, but it missed to one place. Replace the
missed write.

Fixes: 91316870b124 ("common/nvme, nvme/rc: use _set_attr() to trace attribute writes")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index d6496b3..1d71811 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -225,7 +225,7 @@ _create_nvmet_passthru() {
 	mkdir -p "${subsys_path}"
 	_set_attr 0 "${subsys_path}/attr_allow_any_host"
 
-	_test_dev_nvme_ctrl > "${passthru_path}/device_path"
+	_set_attr "$(_test_dev_nvme_ctrl)" "${passthru_path}/device_path"
 	_set_attr 1 "${passthru_path}/enable"
 	if [[ -f "${passthru_path}/clear_ids" ]]; then
 		_set_attr 1 "${passthru_path}/clear_ids"
-- 
2.55.0

