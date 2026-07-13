Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A1214A9B
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903174; cv=none; b=fTIW42rx04f9AH6Czeff4fQ8uiWckr/1vU9p9/8QUyZc0br+Y6ud8o8coifroRnyortBeNXHPrCPv1l3B0apIVWDr802cTco7rCq6btms8O0Y+lSPf/wfyoAzdWeWlMzGXJMf3XJX0X4nbBPEVc57VTxDEqMKorvBXJv+St/Qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903174; c=relaxed/simple;
	bh=mIo3rXHbmOxTmJNEKH5qOQCJUhuDzPKTHLwlpLqV3KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2gRcL8bHltQnYw6HykEes9/pXqbeWkHKwQ3wTtt0+lEuut/XYaIqpLQIavBpkbSlAz09H0mLu3W1vmns86/T/AT0UDQQH/EH0TrH1bTSTOGBJdx7+stv1VIFJLT7tVZsiNQJpNETGwP5utxOvlKtCtTWmbY6cwq0Q4lYoHgxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JhlEbvTh; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JhlEbvTh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903172; x=1815439172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mIo3rXHbmOxTmJNEKH5qOQCJUhuDzPKTHLwlpLqV3KQ=;
  b=JhlEbvTh/XOs44tLoFvap7jyQMl9asYk+AzdZo9v6ER+nezpP1Xvexm9
   a9aTPrsl2Wkjt6YfBJ6otWZwUUPcGfJ4b4Lw56E9mjtZ9cD3yKD71hv6N
   eKR0xRp+WmIWlg7SYmOljb6cHDZKID9/Lhh8bJPQqEHaJYF1rITxl/Puz
   vr+Ce/qmMVcmDLi2s+IAh+P7pSiGPf21DswEKqIGpffr0GQdhK9PFg65w
   qcmEggC0MaZacO1CRPcwE6GEgWpuIqxJAuCVK5VH8fbH8lG3HhxFxbZcZ
   G9RtLpY7W4PKsxs0Xs5NP8wX0/gDRKajWDcmDzvCpUzUGpd286D/WsHdQ
   w==;
X-CSE-ConnectionGUID: xkLDZ4OmT/28gOO/QhUJWQ==
X-CSE-MsgGUID: zdyVrDG4Tkqc/zszYH/KRA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596167"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:29 +0800
X-CSE-ConnectionGUID: RbkkATMgSQCgxi8u32H68A==
X-CSE-MsgGUID: YOv/g0JLTFmiD0Dhoom6XA==
IronPort-SDR: 6a5433b0_gkDRoS3ZaVFxnHO/S+GC3N5IKWxQKf2d1jSd7j7W8wgjGqh
 TpEjSu6oey+aKE0R+8PSbLwSX8nTzb8k4fWqEiw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:12 -0700
X-CSE-ConnectionGUID: rqFW510mTOeLajmnUS+GhA==
X-CSE-MsgGUID: wQaYklwbTzGGyOBYyOmS8A==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/4] new: guide long command options
Date: Mon, 13 Jul 2026 09:39:06 +0900
Message-ID: <20260713003906.21153-5-shinichiro.kawasaki@wdc.com>
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

In the past, command option confusion caused a script bug. The command
option definition change and command option misunderstanding were the
cause. To avoid such troubles, guide to use long command options.

Link: https://lore.kernel.org/linux-nvme/Zbu2qJGoz9UQfPw7@kbusch-mbp.dhcp.thefacebook.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 new | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/new b/new
index 4773175..58b5006 100755
--- a/new
+++ b/new
@@ -279,6 +279,9 @@ test() {
 # - Use the \$() form of command substitution instead of backticks.
 # - Use bash for loops instead of seq. E.g., for ((i = 0; i < 10; i++)), not
 #   for i in \$(seq 0 9).
+# - Use long command options instead of short options for readability and
+#   stability: e.g., 'nvme io-passthru --opcode X' is recommended over
+#   'nvme io-passthru -o X'.
 #
 # Please run \`make check\` after your test is done to check for shell
 # scripting errors and other mistakes.
-- 
2.55.0

