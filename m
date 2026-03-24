Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD83A542D
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331424; cv=none; b=RJW0z9TJn9UIIUOyjIdHQL0W/N5BWubWu+6QhwyhFwgl20FpfBGMxKXhYeiVh8G/uXLhErkVJj8k8FR6Qo+e+984qeYbBjFc/aHsPKFJWg/UW5X0tQGPo9XLRnqSv20V76WzxC3TGhQujwfYwLqjuf0qD+OUwpxJFauHy2JqL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331424; c=relaxed/simple;
	bh=dOQ2efWiEfuBdcPn5qd278jHXzByWNJZ9a9xKGNV2Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au1jLwd+Fjgl4vXOn0dw3yBVXq0OrMlx3zb8fy1uj1xeHPsU5q7eHZTioWHd6P7wLOH/sRplTk6FFG60qFixshs6gUuVZJHOCtLiBo5lAdR9ImJAytYVbnCeNiGBctAdjsmQZh+p66pDBOOLVRDgy2w/bcaAldJCyMiiZ69lTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K4Hm7lLQ; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K4Hm7lLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331421; x=1805867421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dOQ2efWiEfuBdcPn5qd278jHXzByWNJZ9a9xKGNV2Z8=;
  b=K4Hm7lLQ1Beo1x8OVINM9DDl068T8ZHGx2trr85SYgqpiy0MVpHPuDQJ
   4o3xY8IJ0Qz2FJSR9AY3cwI+DOpnbCMj3ZVEhm3wEJwAHqkUXY8UNFFzI
   Brs3HgpdItMm/df4XSxGSfcat6h8apCX/lcuyhIaIF62ZoNuJWUPlT2mQ
   CW8FFH+0T/ot3r+FiaPOlgLL33cLy5NDiopMU9NVvtjBfosCKZYOnsdCn
   cK7pwkMCb192jej6IZiqyTDiDyom8krkKryqhlG8AInv1lBIH7q4ZyfTh
   Rb22WNXw7SwBNyaynZ9/gITgQc97DubXCryeZ9laIoSLPnmqhNfAWoNUh
   A==;
X-CSE-ConnectionGUID: MJuY0u4dTGW4LcG/21dU5g==
X-CSE-MsgGUID: bMcS/YFkSoyGamOErwZxng==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614101"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:07 +0800
IronPort-SDR: 69c22603_r7wD5R1qXE5DlbcbbRbGHi3+2F6XIdsmRKBbfCRhdjyymXX
 YVxDn8apons//2cM0cHXVFPUT8kZm+dDoHQl+ew==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:55 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:55 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 6/7] common/scsi_debug: ensure scsi_debug is loadable before loading it
Date: Tue, 24 Mar 2026 14:49:48 +0900
Message-ID: <20260324054949.3821569-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
References: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, _have_scsi_debug_group_number_stats() assumes that scsi_debug
is loadable. This does not work when scsi_debug is built-in. Before
loading scsi_debug in the function, ensure that scsi_debug is loadable.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/scsi_debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/scsi_debug b/common/scsi_debug
index 97a65c2..6aa7420 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -49,6 +49,8 @@ _scsi_debug_key_path() {
 _have_scsi_debug_group_number_stats() {
 	local ret=0
 
+	_have_loadable_scsi_debug || return 1
+
 	modprobe -qr scsi_debug >&/dev/null
 	modprobe -q scsi_debug delay=0 >&/dev/null
 	if ! [[ -e ${SD_PSEUDO_PATH}/group_number_stats ]]; then
-- 
2.49.0

