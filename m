Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946E346FA5
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832482; cv=none; b=Ty3w6fbEjVhA7wwJhllOPxqwWb3tNqlGpzz9SMIxXp/2WwP1YNwSa+rzVY7/RAv0K5oBu8HiYqTrcrq+NMNgacjat95jmSyZl/gvDBUuttUd9GJSqkK2g6HdpenuM20AG6oObSmrUWeC5ODAVDsvTJ17OILyIbg2Q2/2PCsDx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832482; c=relaxed/simple;
	bh=A3IH64x50WE7AgzI9g1WtgmkQgW+rfS4j/nA35LWYpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQlx7lf+t4dJew2PbUwWE1f3e+3st+reRAD/eqswUL2MT4SMZi9DhKJ2PigWyDrwQmfGPPJmh+ESq3zNHZ6vyjpx1Is7cS3hfJeuTu2HilljeshTjArE88LDY4Qf/hpjTFZ2NKl242zAGzBmg6Q0C/QI4v10Rg0qxC3vZkn+xEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ow65POFl; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ow65POFl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832481; x=1803368481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A3IH64x50WE7AgzI9g1WtgmkQgW+rfS4j/nA35LWYpk=;
  b=Ow65POFloOxzW3XZ/08IJTdF095K3XyeKc7MXXGGtrEcr+H87o/EtuQm
   5A0N8KdtMWAhNpYk8yeBJwi/gdY7LYcquUCryXDuX3ybGEavnWMyErIcf
   qLtkh/j6pYekbbIFAGh4OlmNHhkebP2dUS2Y9/9upfsT1ckrz5JDqtb+z
   I0arleSn2sDS08idFKgyNK+7RDmtb464fw4kM7PJXUfFT/BYw5ERmk84i
   sF2hHjyh2vuiWFWS7vqvtIJmBDKjVPSyzvJCTbEhoEJaLHYLjVM4S8uiN
   /64ppMy2TLM6n71cnf7BElAledf0zyXl6W4eFtuuTTzu9qCOvH12pMvxc
   A==;
X-CSE-ConnectionGUID: KfJ0yk31RyyF3B+DntE+ZQ==
X-CSE-MsgGUID: kTidlX8STOm/7zxZRuu2fA==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="140846180"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:16 +0800
IronPort-SDR: 699c049c_9YATen5+RLO4KwipShL8vYuXmwKXi8SZgRWvN509MpeIdL4
 Y/xAAdC2WgTtmnH6UPbx4xDekQ+jb9Nwhb0ncBw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:17 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:16 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] src: add nvme-passthru-admin-uring to .gitignore
Date: Mon, 23 Feb 2026 16:41:10 +0900
Message-ID: <20260223074110.144758-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a94b77010d56 ("nvme/067: test io_uring pass through for NVMe
admin queue") introduced a new program nvme-passthru-admin-uring under
/src directory, but omitted it from .gitignore. Add it to .gitignore.

Fixes: a94b77010d56 ("nvme/067: test io_uring pass through for NVMe admin queue")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 src/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/.gitignore b/src/.gitignore
index e6c6c38..988d785 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -13,3 +13,4 @@
 /miniublk
 /nvme-passthrough-meta
 /ioctl-lbmd-query
+/nvme-passthru-admin-uring
-- 
2.53.0

