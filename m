Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516A299937
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152306; cv=none; b=YCm6Dqsp/mW4P+uL9CS2NAFVWe1vW66W0Z/OukDf7aOMwuPKzdpmhVEDoSO6jfrHvOkDQG62HW2H2o8I5ZPMMxDBIMrQmVRVdoNHeABOBpaX68wjNxUYGezegmXBbzLmLxMUF61jSisP/RDKPUa3tX4duHjUQuj0DytvT6Hd/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152306; c=relaxed/simple;
	bh=/fa0kghQhm5O+O6AQn7vdzPhM20JsGoJq9btUGscqpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX6lQ7gt+55tdksUUocJ9qHMTRigaVKirQhauU4CM+kbyIedlAihkMP2hj0JGH21Dn7tFhnlkKmOimx0XgzodAIsUEqs50V75KMIYT1qhYKNlgMXXp+emHofncXrsgK0bgrCUI6Bn9KKcT6f/8m5dFcJfJTFoziVrp5z5VFQ23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PvNl3ZEN; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PvNl3ZEN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762152305; x=1793688305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/fa0kghQhm5O+O6AQn7vdzPhM20JsGoJq9btUGscqpQ=;
  b=PvNl3ZENqKEL/BcUzyxmBBi4TYhijRm7b4SlCUneYFrW4lGeWp3aenl0
   x//4T02ooG/sYcVPSu0VkBEG4+k4ZtXKOBuVCtBk+Yrb3mwCHK/dEcvs7
   sn73SRqH4MT9C31bicX5EPtITVpa9cHh69hQvOD3JZGJovMJ4ujTnkTG8
   VlVb52HLAmShsonVKc00Ybr+SXuWHNwveerjqb8FjqoyiEohDnCu7l4Ff
   1b25x0/Ct4JlkvjJS56GJW7bnpJXofypGRrBQHMggBtzKPYqh2OGKnmzP
   txWCBcI4DlvtpKpBSlKjHoD66g8OHOiPfaOsxbF/QrrXTxiM79ZHEFEo9
   A==;
X-CSE-ConnectionGUID: SX0Xnrc+RuOK2O5CUNRxnQ==
X-CSE-MsgGUID: KZv9MOSoTa+vhYlvGVRifA==
X-IronPort-AV: E=Sophos;i="6.19,275,1754928000"; 
   d="scan'208";a="134391239"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 14:44:58 +0800
IronPort-SDR: 69084f6a_7Y9/vMtwlvWX4xplYe1ZsYitn/FyJ3hVmGp1jR45LKpQF0t
 SVa/0t/3S6XMhFZd9nVMNDjQwWUT/6cMNW6vqeg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2025 22:44:58 -0800
WDCIronportException: Internal
Received: from wdap-zcgq2z60ds.ad.shared (HELO shinmob.flets-east.jp) ([10.224.109.249])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2025 22:44:58 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 3/5] throtl/004: adjust to scsi_debug
Date: Mon,  3 Nov 2025 15:44:52 +0900
Message-ID: <20251103064454.724084-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
References: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the test case throtl/004 assumes that the test target device
is null_blk. When it verifies the dd command error message, it checks
the string "/dev/dev_nullb" also. However, this test will fail when the
test case is extended to support scsi_debug.

To avoid the failure, remove dependency on the specific device name.
Save the dd command error output to the FULL file, and check only the
error message part in the FULL file.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/throtl/004     | 4 +++-
 tests/throtl/004.out | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/throtl/004 b/tests/throtl/004
index d623097..777afcf 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -22,7 +22,7 @@ test() {
 
 	{
 		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
-		_throtl_issue_io write 10M 1
+		_throtl_issue_io write 10M 1 &>> "$FULL"
 	} &
 
 	sleep 0.6
@@ -30,5 +30,7 @@ test() {
 	wait $!
 
 	_clean_up_throtl
+
+	grep --only-matching "Input/output error" "$FULL"
 	echo "Test complete"
 }
diff --git a/tests/throtl/004.out b/tests/throtl/004.out
index e76ec3a..3997531 100644
--- a/tests/throtl/004.out
+++ b/tests/throtl/004.out
@@ -1,4 +1,3 @@
 Running throtl/004
-dd: error writing '/dev/dev_nullb': Input/output error
-1
+Input/output error
 Test complete
-- 
2.51.0

