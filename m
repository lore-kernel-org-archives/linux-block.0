Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65C7F
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354736; cv=none; b=ZSAQoi8EYOKtMzWkSl3qgubVfUvknGTWq0JB7Md+iVgn7aAb+4kp/rFMfILC3yIuwszeDkPZmwev3OGg0Yz+qakUid0hZ1cEWTc/3NYZZQqPtzb0wnu3F1RBpB3iPOhH3Ipwqu2IxXaiEW29zREH5h/1C2FYKLSjN3V62kpAETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354736; c=relaxed/simple;
	bh=sValY2jZMY7kypT8y30RxotnJzXzzkLVyg2MlrviqjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmjZRss61/9Q1GxQu//C6aK4P8VAKLJSW0c3L0NZFeHLVruPcVeNL3J7pv1H2KolfIqhj7Y5VwFZ8HEWjREIXuAXY5IN4R+j2rnv22ZggDLYOAIKrFCUYtvRxRb4EDFbx9Zs5lJpLOf+rXpEUAAmQqTkRhoD40V7gaB4qqulHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E2SnxwJY; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E2SnxwJY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714354735; x=1745890735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sValY2jZMY7kypT8y30RxotnJzXzzkLVyg2MlrviqjM=;
  b=E2SnxwJYjebgenCV7YYxTDROdk1SXD1zWQ3aJoibjKgfmHYF4V/6NlhN
   BtV80vqolwajyzBoxWi3poInlMNddGMyeLIcmDq2G0K5MbTL/O/V87HEd
   qUgWv7/ryMjyHivR1QZy4PPxi+xVezFfPBgD7eaIKI80YsexO/Nrucm3Z
   rISvSOBpMCeGBeMvoBXeECJBuviXtZJ97PLvNKot0ZetwAGQgkVXzhxr1
   51fRAjWumIgn73BxoaN5rvEQTJtLjvNp0KcrQsnuwnTzvaXHo6IRFpbl/
   Surw29iKyJ+cC8HANcialZ05V/owBYFSSch3BMEL/YnWGxdy16X38HS+8
   w==;
X-CSE-ConnectionGUID: zOZSyyWATN6+AGSKM6yzyA==
X-CSE-MsgGUID: Lo4BlCJbRUK/YVKWntnk8A==
X-IronPort-AV: E=Sophos;i="6.07,238,1708358400"; 
   d="scan'208";a="14835435"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2024 09:38:54 +0800
IronPort-SDR: cj9WXTAjPXz9fEpmF/90FKocK4BgFWLtGkflvQKeC672TVEA331zIktFuy/MKAgvE9zONXgWRk
 TvSqqhIQ+VYdlve9T7azixvXQV81C66sFkiY1t772bpQzSAzl3iEaEEaoheKqgGIIhbA13M2NO
 gXJcAT+2+sPXX1wMnq0dbVfBqJgNwDjH6xcODN8hV8yuRVHKbrTYzApDpCKuObBAfcFyU4mYwq
 4bTyX8ezBEpMlZWQN8jn1w43Zb8vRd0/j3nQ0kL9rORc4VgNodNbqhVzkJfOIi7aoxPMOFBQvZ
 PCg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2024 17:46:57 -0700
IronPort-SDR: Rkpcjq3+F4UhkwGMYr2a5qppwopgi6JNs+/tR9Bj1xKxI4WOWQlaaA7hQIrHzER8siQZHlcCrc
 J17La36tlfd2bM/ZvxyS628u4DzYv0jitDZwRk5VDi++FTcYXSwuvqIrLxH9mllnwL3/IecLWM
 5dzVatx8kb9P69tuoOoZt6Vwa5ALrg1caUKyKF3ZCnegVztd0vmZL3Vjsp9636dWVZX7xOKNWS
 m+zBqb6pjM4SDOV3l6uyoMCQQu2q7tnspXiF5TONzp1C+vzGg4To6parHvyLS7hxmAzvip7/bd
 Y2c=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.19])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2024 18:38:52 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Alan Adamson <alan.adamson@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/039: adjust to util-linux v2.40 dmesg format change
Date: Mon, 29 Apr 2024 10:38:51 +0900
Message-ID: <20240429013851.181700-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since util-linux version 2.40, dmesg supports "caller ID". When Linux
kernel supports CONFIG_PRINTK_CALLER, dmesg adds thread ID or CPU ID
with parenthesis such as [    T123] or [     C16] to each message. This
made the dmesg string check of the test case nvme/039 fail. Fix this by
filtering out the added caller ID field.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/039 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index f92f852..a0f135c 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -24,7 +24,8 @@ last_dmesg()
 {
 	local nr_lines=$1
 
-	dmesg -t | grep -v "callbacks suppressed" | tail "-$nr_lines"
+	dmesg -t | grep -v "callbacks suppressed" | tail "-$nr_lines" \
+		| sed 's/\[.*\] //'
 }
 
 inject_unrec_read_on_read()
-- 
2.44.0

