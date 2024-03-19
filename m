Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7625B1E3
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838226; cv=none; b=pOBazHNHHEGyq1zeL6nAlucGYNTBsOBYdDZML9q92iVqXy1cquongdx9eLYWASZc3wo3GJTrNxGOQnwfKeuT8NRGqs01gHcnvYTHyikOQOkobpY7pTKTQV7Dy/Yf+3DWBTAJxM1x3gS5GJb7hAzfFwoBiqVsazYkZ1ZiIcuZrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838226; c=relaxed/simple;
	bh=D16GLrKwFJadqGdiyBR91aFbEXz1qgjCwiRq8drld6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LepW8euFnZjpJ8agMSs2ay/eWRgMPusmpFrGypim6mKlwFsBbizt85gaLSTk4vl4pqgqWkjSm5KktQ5hqih+Bk9UP/40FHfOosfnM7woNveq9POuJ7OWvRhSZ2IQajm38vx0P0B0onUVz33LFcjSDMvcGh43CVWtj6cvi+0A5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BWqmtVR3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BWqmtVR3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710838224; x=1742374224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D16GLrKwFJadqGdiyBR91aFbEXz1qgjCwiRq8drld6s=;
  b=BWqmtVR34m2HlTEVXCopyTK3l0DDKHZCxYaj7xsI2Segg8BWKRgx0v37
   Juvt/Jd3KZJucWQVnVYhomGnKY5vT4ir3FV9DAYIJI6XKZ7M6WjpLJ1s2
   5qyRzQESQ/BBUMIaoPRcUnuRelxAtVUG09H7tcmrFvAWRlyP9LoRRkxsN
   yfQI1qv6tpQTD71+3tLqutOTOmqJDfbspO/J1TkIwLul0riPP+vGlGHfE
   ZNzHLmTSeJLf2tfJXcaR09LrhJXx7ZMyxlQTYhflHGu5JsXKCx7SkYQQn
   kts9wCIsGr7WW3N0Zbzg84Uz8ww1bF3KZRhTTa1FV073L9M2kpm1dkWKN
   Q==;
X-CSE-ConnectionGUID: YjGcXkrGSiq8eKfa8zwZRg==
X-CSE-MsgGUID: nOXWL4hlQ0GlJBFfD7Fovw==
X-IronPort-AV: E=Sophos;i="6.07,136,1708358400"; 
   d="scan'208";a="11444968"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2024 16:50:17 +0800
IronPort-SDR: rAEj6DKYAGnzCCHe8oBy4/rIGjmjm31w8AkeqDLsoyUp4N9Ju7bSupCYc6h5+B0q6mYD5Cg6Cs
 MdJuYZmWkcKQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 00:53:30 -0700
IronPort-SDR: BOsIESP3jGk4Sn7XmX24ug6p1HTyDedWRLF7exk4RVpmAMJDGumyberIn6A4McvSKi9fHChlul
 1/wrLfFbQrXA==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2024 01:50:16 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nbd/rc: check nbd connection with nbd-client -check command
Date: Tue, 19 Mar 2024 17:50:15 +0900
Message-ID: <20240319085015.3901051-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_wait_for_nbd_connect() checks nbd connections by checking the existence
of a debugfs attribute file. However, even when the file exists, nbd
connections are not fully ready, and the stat command for the nbd device
file in the test case nbd/002 may fail with unexpected I/O errors.

To avoid the failure, check the nbd connections not only by the debugfs
attribute file, but also by "nbd-client -check" command.

Link: https://github.com/osandov/blktests/pull/134
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index 9c1c15b..266befd 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -43,7 +43,8 @@ _have_nbd_netlink() {
 
 _wait_for_nbd_connect() {
 	for ((i = 0; i < 3; i++)); do
-		if [[ -e /sys/kernel/debug/nbd/nbd0/tasks ]]; then
+		if [[ -e /sys/kernel/debug/nbd/nbd0/tasks ]] && \
+			   nbd-client -check /dev/nbd0 &> /dev/null; then
 			return 0
 		fi
 		sleep 1
-- 
2.44.0

