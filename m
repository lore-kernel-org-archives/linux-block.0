Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAB23315D
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577755; cv=none; b=t5Pwpfm+G7gMdeXXOMT6Nn4CzFIXGmAo5us5Tix9Gq6sX4b/9SgiHdzaniXOs1ER/VZXGjYLsHwWFJvVPeDSOBgNHV/LeODClVPLrTX2JTLuc7ZQt2WtCoFgE/z6jvlOH6u2UvbE0U6Kn2ALBG4SkZAK2lFOQRv8qLQXB7JfTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577755; c=relaxed/simple;
	bh=//8Nb3BSwEDLv+lBYEejrYD/CHrsy84oq7ePiX7R4oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hayj7jelXtRuXXdKQ7yQ7Rabf+1jZHJ8h5q8OHpxLR6KlRKafOA61rO4S1LhJISAsUfTTnZNuP0ehFzRCKXLl4z9sARCvv0f4cHEF8Dk+U9upPw4KSzN9PpwF9gdsrst5XRvHzsF5f+g49Ra2hrVRyssJLEmyP9av+/amsp5RjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AqXcyFhu; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AqXcyFhu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577752; x=1775113752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//8Nb3BSwEDLv+lBYEejrYD/CHrsy84oq7ePiX7R4oY=;
  b=AqXcyFhuTX+tM+w5bpGAWv/PFzwt/wgsU3f9Z7nEr0HEZrUBIcnx0Ksp
   fZfVsScc3/JXvz0cbI7zLUmkXBeT4LySomNLawoReGE4AXcDCNf6b6ZrH
   W6BlyQ53Kj5VyvR3VEsPCbYZOrtXV8N15vqokCee2AzkXLm0gHudWUwLP
   8OxMzaD6lc4mI9B2v5R4Usg+IX8LdIyAtfIr5Xx8pBSupsEsmB78mxQnw
   WUdURsihhB0rtyOJW4mk3zEXAl/qRCD7RLP2XG4EO+J5bHM7Cwcv5fcx1
   dGwvxZph7bideUYAvrNBk/dc+0I/p3jX26Vp+6MQ3srNMyuKQfhx5uydE
   w==;
X-CSE-ConnectionGUID: XGoQlHZ+QF+uOM/UmweYxQ==
X-CSE-MsgGUID: LlvT/QRnRoOyaKN/FeslTw==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367544"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:10 +0800
IronPort-SDR: 67ecd49f_izzwpiE5lHRiuKNPc9S4wKlCTvon70LJdgWa/pi4TWgOO4j
 CFRhHshQvrOi8jEognqm5+4JHo7qGkvViHurcAA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:35 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 02/10] common/rc: introduce _systemctl_start() and _systemctl_stop()
Date: Wed,  2 Apr 2025 16:08:58 +0900
Message-ID: <20250402070906.393160-3-shinichiro.kawasaki@wdc.com>
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

When test cases depend on specific systemctl services, the test cases
need to start the service. After the test case completion, it is better
to stop the service. However, if the service was already started and
active before executing the test cases, stopping the service will affect
test systems.

To avoid such affect on the test systems, introduce _systemctl_start()
and _systemctl_stop(). When _systemctl_start() check if the specified
service has already started or not. If the service has not yet started,
start it and record it in the global array SYSTEMCTL_UNITS_TO_STOP.
When _systemctl_stop() is called, stop the service recorded in the
array SYSTEMCTL_UNITS_TO_STOP.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/rc b/common/rc
index ce7f975..068a676 100644
--- a/common/rc
+++ b/common/rc
@@ -13,6 +13,7 @@ shopt -s extglob
 . common/dm
 
 declare IO_URING_DISABLED
+declare -a SYSTEMCTL_UNITS_TO_STOP
 
 # If a test runs multiple "subtests", then each subtest should typically run
 # for TIMEOUT / number of subtests.
@@ -511,6 +512,26 @@ _have_systemctl_unit() {
 	return 0
 }
 
+_systemctl_start() {
+	local unit="$1"
+
+	if systemctl is-active --quiet "$unit"; then
+		return
+	fi
+
+	if systemctl start "$unit"; then
+		SYSTEMCTL_UNITS_TO_STOP+=("$unit")
+	fi
+}
+
+_systemctl_stop() {
+	local unit
+
+	for unit in "${SYSTEMCTL_UNITS_TO_STOP[@]}"; do
+		systemctl stop "$unit"
+	done
+}
+
 # Run the given command as NORMAL_USER
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
-- 
2.49.0

