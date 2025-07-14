Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE214A8E
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476544; cv=none; b=MvIyDVm3OcRCnZqmgvClz1m1JJaP5M/co2StWgrzN3v7EZVL9yNvylfMMRKA0H36FUIYO8gnQnQ2ID5juv5Awcpg60QZGIKxGLj5+BA9VHHP6c7rw7Pjh+IX6EPKkb9CfVyA4FDjKzPzEqsN97MASwGIF0LLCkXH36vKpLeolvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476544; c=relaxed/simple;
	bh=hF5kssbqVG8Mq0Ra/tTGmUWHegs6b1QmPBesI8um1wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meqI6d2KhkLE/Rs2JLgCvv2V2muMxqRWvxiptu1epa/QfqG8zOuDUcmM9ogl61m0IGncWERheynJIIpQxQSNeE3rNg5sz4TIBLxcnYnq0U+bhyJnVXv6FdynvfkAYvBl2P97PNOSy55OGc9t7DjebszH7BSdtTwqaLZj5cybmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=geyqAMkN; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="geyqAMkN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752476542; x=1784012542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hF5kssbqVG8Mq0Ra/tTGmUWHegs6b1QmPBesI8um1wE=;
  b=geyqAMkN3XrNWnY+81ZEh+TSc9LAMTmWD1YRQHLDOIBpLEXrVge+qHDN
   fReEYJ8y05n70w1/ql566iDlsdRP5A/ZWiCCLO10K4NMUXZDeE+7Yyn5R
   pH5JLML3tdwlGCEC23WTGYrO0er0JyuHNjBhjrvXtsr864BS48PQrmQ1Q
   iVcPxqd19BouAGObVQGJ4X99BeOpq1E6yJ3aDbw7SUTmjnaPQmjNulJ8T
   A9Ka2qccls40vbIf+9GLRMI1HeuzGflF0HwtUekCARRlDUXqREamNXS+8
   nrZYgPb+rfZVfFwD/JPmPmrngZw/4zGwd3gPu1OHnecW9Zx40AGOpMyJ8
   g==;
X-CSE-ConnectionGUID: 9/YZtqPcRXWqzBCEcEiBTg==
X-CSE-MsgGUID: yK6w+UABSkeVp3QUc0jTcQ==
X-IronPort-AV: E=Sophos;i="6.16,310,1744041600"; 
   d="scan'208";a="91733316"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 15:02:16 +0800
IronPort-SDR: 68749cda_1Kr7gDPmGjYT9tbol7xUOnvWlnLdRQUViEW9jvUmA9chAxK
 sE2VMccJkLT7Nc7zz2JCspLcYPorlpKz+A0DyZg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jul 2025 22:59:54 -0700
WDCIronportException: Internal
Received: from 5cg217424r.ad.shared (HELO shinmob.wdc.com) ([10.224.163.204])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Jul 2025 00:02:15 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] loop/010: drain udev events after test
Date: Mon, 14 Jul 2025 16:02:14 +0900
Message-ID: <20250714070214.259630-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case repeats creating and deleting a loop device. This
generates many udev events and makes following test cases fail. To avoid
the unexpected test case failures, drain the udev events by restarting
the systemd-udevd service at the end of the test case.

Link: https://github.com/linux-blktests/blktests/issues/181
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/loop/010 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/loop/010 b/tests/loop/010
index 309fd8a..6d4b9fb 100755
--- a/tests/loop/010
+++ b/tests/loop/010
@@ -78,5 +78,12 @@ test() {
 	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
 		echo "Fail"
 	fi
+
+	# The repeated loop device creation and deletions generated so many udev
+	# events. Drain the events to not influence following test cases.
+	if systemctl is-active systemd-udevd.service >/dev/null; then
+		systemctl restart systemd-udevd.service
+	fi
+
 	echo "Test complete"
 }
-- 
2.50.1

