Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576B3D6CC6
	for <linux-block@vger.kernel.org>; Sat, 16 May 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933334; cv=none; b=D0CUR4fVvjASuNp0j3tYQrjZnnnDOxHpKgKRPZ+in/egeIjLAXdx2Tsry90qXRMfgutG0MD47i77Qwl5CPqOf51y50InSu1HVCommLwqlhwWzixIsw6CA0YBuUGbcyNPjp0Bewhi+DUntVGyiAf2k+0xjZnx6dmTQFG560P6kFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933334; c=relaxed/simple;
	bh=LdEW2zjydpQdvEn4yoz2obAdUuVvOYgKJu4/poDKRTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGO/XxpzrVr9676lKnZ/ZjpOAWUNZRhNMVYwY6gl8qiDxmOZCieucyoS/j6wMSFd/TkIrzp+tw4jLoKnqE+Na2qFvtavXVnhglqSon1rOJNSux5EisC8/v1mpqF7Z0GsvzvdrioCnQoAwceAwujBuge555Tei+uiV61Dqm3fkSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DVMMUYfc; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DVMMUYfc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778933333; x=1810469333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LdEW2zjydpQdvEn4yoz2obAdUuVvOYgKJu4/poDKRTg=;
  b=DVMMUYfcrsPEeW2N3cfL8+vNdE6v0ISHNJ811uozDMCkS0yVBhX5jwrp
   hScRxZhpJxdrtp/jRV7yukMJ1uf1pyCgyR2nlh1oseDggQ9GxQGfPTXFj
   EzzTgNfR6w1jcbm4Kc1/9fNM+QM2JvqpYSZ4ebYm+zER6EKfg2i/pePAM
   7nqu0HtzsTwSFIvLWS21xrYjyjx51pIQXkQPG8O+lhavZQkuTyWYgSP17
   JoOY9JSjQudkmzVdM6hjCPTW+E/5g3TiXpo5xZ1fviwJ4W4Yd9hbqs4sz
   K1HY55fz4c3lZxfZEAPHvovxEF/+lI/V7K0rfZLclrOKY1SJjb5Z05a2z
   g==;
X-CSE-ConnectionGUID: UKyNiJcQTamALck18dQ3JA==
X-CSE-MsgGUID: y8U7gxYdTFu01N2BZ4jRZQ==
X-IronPort-AV: E=Sophos;i="6.23,238,1770566400"; 
   d="scan'208";a="145562577"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2026 20:07:43 +0800
X-CSE-ConnectionGUID: I348Og49QHGGYEbxFLewrw==
X-CSE-MsgGUID: Slh43elkTCCSZyQvic7QgA==
IronPort-SDR: 6a085e06_44jSGQ9JYeCNlFHBBFylajDCh23h/yvyeD05u8GCE2yWK5W
 uvPnFlAuevqzN6QfhMnp7Q/ul9G5yctdczkXxCg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2026 05:07:33 -0700
X-CSE-ConnectionGUID: AykGN6zPRlqZnMENCkbanA==
X-CSE-MsgGUID: Z/KT1E2LR9Oe7pC6jz+lZA==
WDCIronportException: Internal
Received: from wdap-zejtyqwo0v.ad.shared (HELO shinmob.wdc.com) ([10.224.105.206])
  by uls-op-esai2-o.wdc.com with ESMTP; 16 May 2026 05:07:33 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/3] common/rc: add _set_attr() function to trace attribute writes
Date: Sat, 16 May 2026 21:07:28 +0900
Message-ID: <20260516120729.113659-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
References: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many test cases write to sysfs/configfs/debugfs attributes, and these
writes are important for understanding test behavior. However, bash's
xtrace feature does not record the target attribute file in commands
like `echo X > Y`; it only records `echo X`.

To capture the write target, introduce `_set_attr()`, which writes its
first argument to the file specified by its second argument. This allows
xtrace to record the complete operation (e.g., `_set_attr X Y` instead
of just `echo X`).

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/rc b/common/rc
index d2c1d74..7dd5898 100644
--- a/common/rc
+++ b/common/rc
@@ -780,3 +780,10 @@ _min() {
 	done
 	echo "$ret"
 }
+
+# Write a value to a sysfs/debugfs/configfs attribute. This wrapper is used to
+# trace sysfs/debugfs/configfs attribute writes when the --cmd-trace option is
+# enabled.
+_set_attr() {
+	echo -n "$1" > "$2"
+}
-- 
2.54.0

