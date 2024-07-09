Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7915821E
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529091; cv=none; b=gyTA5rRg510Hw84Q5A0e+igK2nUwSihVQ7Z+ALB8yWbGawIbFI4DuIpgpBLHcebrqZBK8Hg0uJQzCWHPFbM7XgYZX/J6mt8+/N03PbUX0+vg5JO9HAuVuWiU3I746pZyKudaEdXc6u45efhV66FplRVI55kwSL0QfujAVlJxJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529091; c=relaxed/simple;
	bh=R8W6pPRkbUqWUXO2svsOmgrcmwHeLVcEvBgnrS2yZfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=leJo3YIn78pYnVyLjPrhwScIvk6O9qKE4npv4fYrgLmtd+kuxiHZ86n1BuevDL8w+j3yaaIiPdP8sMdDujXzC33jz5hcJbw+h6Q4LT2mD7I2q2SgkrjBvNen2jpw5prq95TzJB+cOMMStbCoYZyoxTX21F5ZGKNZPel+6AIJnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DqDQfMcl; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DqDQfMcl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720529090; x=1752065090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R8W6pPRkbUqWUXO2svsOmgrcmwHeLVcEvBgnrS2yZfw=;
  b=DqDQfMcl2g99+Z7ioP11vLQQFx+1bCumF8u4Rz4VDKdzLin5XIIA83Uq
   bRaN72Fhl4n6IkILBTV30skSls8UYwo7qOaX4jiDawgzXX3XL7ecLAedR
   rTqkBYMosVs19EbsWYfet/xcY7Ha6Yw75CyAPoa4F8sM/hhb4QYpNVNz+
   aPsrz4Tu+pK1usYjd1yIj/wm8onHffGfsjW6rvOEbrmuudgX/u4gL11qh
   fzdFN9N5YIL7TuDNQoiDO9wClEeqVAbxSoCz1j0qqqMEzohRgX4bqvuu2
   tXVQ0kHu6Q4uIFZN92tzF866r3wONjJZ2JSEWKos20eB/9Lc2UpdFGxHH
   w==;
X-CSE-ConnectionGUID: lbTFVy8yR+WfNZ0xYtFsAQ==
X-CSE-MsgGUID: /BtIKNW5SRyG/ATFd7x6pQ==
X-IronPort-AV: E=Sophos;i="6.09,195,1716220800"; 
   d="scan'208";a="20905408"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2024 20:44:43 +0800
IronPort-SDR: 668d22e3_XHBJFzmGfDX1t9LmiI8Xc6eVl4uyQ+/GS6Wl3bD3brzh1Ln
 +9eB59pSlcRE4BOR869buN7httfSOXxuJ+LjctQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2024 04:45:40 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2024 05:44:42 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bryan Gurney <bgurney@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] dm/002: repeat dmsetup remove command on failure with EBUSY
Date: Tue,  9 Jul 2024 21:44:41 +0900
Message-ID: <20240709124441.139769-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case dm/002 rarely fails with the message below:

dm/002 => nvme0n1 (dm-dust general functionality test)       [failed]
    runtime  0.204s  ...  0.174s
    --- tests/dm/002.out        2024-06-14 14:37:40.480794693 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1/dm/002.out.bad     2024-06-14 21:38:18.588976499 +0900
    @@ -7,4 +7,6 @@
     countbadblocks: 0 badblock(s) found
     countbadblocks: 3 badblock(s) found
     countbadblocks: 0 badblock(s) found
    +device-mapper: remove ioctl on dust1  failed: Device or resource busy
    +Command failed.
     Test complete
modprobe: FATAL: Module dm_dust is in use.

This failure happens at "dmsetup remove" command, when the previous
operation on the dm device is still ongoing. In this case,
dm_open_count() is non-zero, then IOCTL for device remove fails and
EBUSY is returned.

To avoid the failure, retry the "dmsetup remove" command when it fails
with EBUSY. Introduce the helper function _dm_remove for this purpose.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This patch addresses a failure found during the debug work for another
dm/002 failure [1].

[1] https://lore.kernel.org/linux-block/42ecobcsduvlqh77iavjj2p3ewdh7u4opdz4xruauz4u5ddljz@yr7ye4fq72tr/

 tests/dm/002 |  2 +-
 tests/dm/rc  | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tests/dm/002 b/tests/dm/002
index fae3986..8ae8438 100755
--- a/tests/dm/002
+++ b/tests/dm/002
@@ -37,7 +37,7 @@ test_device() {
 	sync
 	dmsetup message dust1 0 countbadblocks
 	sync
-	dmsetup remove dust1
+	_dm_remove dust1
 
 	echo "Test complete"
 }
diff --git a/tests/dm/rc b/tests/dm/rc
index 0486db0..21a35f6 100644
--- a/tests/dm/rc
+++ b/tests/dm/rc
@@ -11,3 +11,26 @@ group_requires() {
 	_have_program dmsetup
 	_have_driver dm-mod
 }
+
+_dm_remove() {
+	local dm_dev=${1}
+	local i out
+
+	# Retry dmsetup remove command in case it fails with EBUSY because of
+	# non-zero dm open count.
+	for ((i = 0; i < 10; i++)); do
+		if out=$(dmsetup remove "${dm_dev}" 2>&1); then
+			break
+		fi
+		echo "$out" >> "$FULL"
+		if ! [[ $out =~ "Device or resource busy" ]]; then
+			echo "$out"
+			break
+		fi
+		sleep 1
+	done
+	if ((i == 10)); then
+		echo "dmsetup remove failed with EBUSY"
+	fi
+
+}
-- 
2.45.2

