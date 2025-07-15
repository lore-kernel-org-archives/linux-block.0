Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D0BE4A
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752553927; cv=none; b=byk7scnTTf/NfRETMC9xwZOtiCDmU2smhiNCt/461l3lElDWV5ozonO4bGd7/PTJd9YlMA6jTUj03JKZI1nLZ+qxU49H1QkJxLi2LeAJkDbjIs6ev9/TEgVEvD+Kb0O+r/uhsLamnb8JSqJoHLd6YEblP6iGkVThLB4LsdmWHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752553927; c=relaxed/simple;
	bh=hJ1kKPQ5I0T6/9zGABhSkjeChaXKVuw9uLlRfFwsic0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcYcCi045V6bNFvAwvuz1FF0X+YPdKWN9bdbgMr4zEIi7fEXpQJcjoijVAzNUyrXKn2KVhJctFXwg23Kd89gja60uXCsMFzYAE61MVinENSXFlnQwLc1uoqhae6xFTPBE3v6euqCTZbwH2HZ+XnGSvKtzbavnTOHJG7LjS7HchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SPTgydI1; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SPTgydI1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752553926; x=1784089926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hJ1kKPQ5I0T6/9zGABhSkjeChaXKVuw9uLlRfFwsic0=;
  b=SPTgydI1OyoKQdU0FgttOWxAYRHLQc/gFh48BbLXxSvkwCgMzbxhdr9g
   toFb1xOETWqzKOW0z6as3py7jqhLUdpSGrc+fQvZeiDbSD14gSI3D61UU
   x4d6DM8pE6cpFZyMOLi/1foP/tvQYG/N4ToQmRtPFphmXoN8VZkz562JC
   xys5ORjAXlNy9m5MnG9/LKaSSLFCniib41ISI2GLFoLMAiMvx1VmKcvdx
   WSqA8Z8op2LrQxGXlkXQNuqIo+H+H/MTjLx2tN/BIEvJmPYneumsbrMrC
   JJ95DCFFnDQIIYGrK2Wtke4ITtzirNU6yEBkJ7SswDMuZvkNbBeJudRrp
   Q==;
X-CSE-ConnectionGUID: Arz8NSGDQMmPqOWgti2wTA==
X-CSE-MsgGUID: /ar6riOrR/SzoxdGfaB+ow==
X-IronPort-AV: E=Sophos;i="6.16,312,1744041600"; 
   d="scan'208";a="87065317"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 12:32:04 +0800
IronPort-SDR: 6875cb24_aJCFiYBbTkonBA1XSS1UxdpLd0CxAZYiKrjHss5B/2oviYM
 Y373eiL8lt4BBvllvEVcug9dui61lRfYYuTvmhg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 20:29:41 -0700
WDCIronportException: Internal
Received: from shinmob.hgst.com (HELO shinmob.wdc.com) ([10.149.67.127])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2025 21:32:02 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Gulam Mohamed <gulam.mohamed@oracle.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2] loop/010, common/rc: drain udev events after test
Date: Tue, 15 Jul 2025 13:32:02 +0900
Message-ID: <20250715043202.28788-1-shinichiro.kawasaki@wdc.com>
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
the unexpected test case failures, drain the udev events. For that
purpose, introduce the helper function _drain_udev_events(). When
systemd-udevd service is running, restart it to discard the events
quickly. When systemd-udevd service is not available, call
"udevadm settle", which takes longer time to drain the events.

Link: https://github.com/linux-blktests/blktests/issues/181
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Suggested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Added "udevadm settle" in case systemd-udevd.service is not available
* Introduced _drain_udev_events()

 common/rc      | 9 +++++++++
 tests/loop/010 | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index 72441ab..dfc389f 100644
--- a/common/rc
+++ b/common/rc
@@ -544,6 +544,15 @@ _systemctl_stop() {
 	done
 }
 
+_drain_udev_events() {
+	if command -v systemctl &>/dev/null &&
+			systemctl is-active --quiet systemd-udevd; then
+		systemctl restart systemd-udevd.service
+	else
+		udevadm settle --timeout=900
+	fi
+}
+
 # Run the given command as NORMAL_USER
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
diff --git a/tests/loop/010 b/tests/loop/010
index 309fd8a..b1a4926 100755
--- a/tests/loop/010
+++ b/tests/loop/010
@@ -78,5 +78,10 @@ test() {
 	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
 		echo "Fail"
 	fi
+
+	# The repeated loop device creations and deletions generated so many
+	# udev events. Drain the events to not influence following test cases.
+	_drain_udev_events
+
 	echo "Test complete"
 }
-- 
2.50.1

