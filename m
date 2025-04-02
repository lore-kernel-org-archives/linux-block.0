Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531B236421
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577754; cv=none; b=qIbFySw4MBRhnXLgj/ScN8plRIAnxMEHW1FrIGzfNK5hzJF7gTVxHm7APWI4HSxdu+K0+MEcXDLBMuRcV5bxKv/Am6rRMdrQglbEAta5SZhkweCdkO+a8HNemCYE+dtp6YEt90r6BY2h3Ucya4iCNcNZuT2T5mGoC8WVQMmESgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577754; c=relaxed/simple;
	bh=+YXy23ytnJLV0YbuAGgRiT2EsTOOJ5DnpJeZbJUGvdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIYEYUyjlVtUGvVrbFr//ZpqxxeAKreD9a7TjACwPUHbGJXTCcD9lLNXc2l8eiTs0Pj5ubpMi6nFGXqR8KxBE8i6Lh4dWUGlLExEJkmv4LFQbuPWYfnxHZ9+BvkB0ADUY5J6AWAkqu+5EPcRRDrBo/mJFC6O7sf8RG+EGgDyROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=obMbrSSc; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="obMbrSSc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577751; x=1775113751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YXy23ytnJLV0YbuAGgRiT2EsTOOJ5DnpJeZbJUGvdE=;
  b=obMbrSScrSx2X15Z3HbtcD5I6M+XDaeHNouXvALKijarebUZcYov3QY9
   Y2d2MlZei5imr1cOWjUtUSMJ6YkbitwMuUAS/M+dcp0TTYZVGQ28Z5iaZ
   Nmu1by17MZEjfwiahPNzCezDfg6NFd5r88g4FO1go/I0EcbNPS3zGXpZE
   h5Oh5Wv9lv6jiDA0NvsCB4JSXwGOhePcu2jZ66k7A5Fd72Iph0uTBCpeT
   OoY9BTVdnb3FZ9Pn6z/6FbSt6YjKem70CldWEOabbbLY8UABhDW030oaM
   M6z+RwJQGIWIm56/1MzaJOklMURea5i+ZKqINgiB55CaHs7AsKNw4KxON
   Q==;
X-CSE-ConnectionGUID: cqm9Q9lfR1Wquy+X83NLrw==
X-CSE-MsgGUID: 2XQRTor9QHq60eJYb6L8FA==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367519"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:09 +0800
IronPort-SDR: 67ecd49e_695biO7rC922p9IgbB0FcNcYDvGPp9uHTty1riOpK4OtO3E
 Cnc1nYgwS2i5Z2uBp7sZsjyGEnMYnJHFr2A0xmw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:34 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 01/10] common/rc: introduce _have_systemctl_unit()
Date: Wed,  2 Apr 2025 16:08:57 +0900
Message-ID: <20250402070906.393160-2-shinichiro.kawasaki@wdc.com>
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

To check that the test system has a specific systemctl unit, introduce
the new helper function _have_systemctl_unit.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/rc b/common/rc
index bc6c2e4..ce7f975 100644
--- a/common/rc
+++ b/common/rc
@@ -500,6 +500,17 @@ _have_writeable_kmsg() {
 	return 0
 }
 
+_have_systemctl_unit() {
+	local unit="$1"
+
+	_have_program systemctl || return 1
+	if ! grep -qe "$unit" < <(systemctl list-unit-files); then
+		SKIP_REASONS+=("systemctl unit '${unit}' is missing")
+		return 1
+	fi
+	return 0
+}
+
 # Run the given command as NORMAL_USER
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
-- 
2.49.0

