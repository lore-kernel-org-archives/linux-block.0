Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DF199FB2
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763602021; cv=none; b=DIbCPF+F1Ph04fT6q4dyeqK3PcMiPZEInMcqE/yHXcfnYUST01GiJ4Vs1QK5x01ldFqFRDGSUut721ZpdnHFmlZqigOqx5/dXMGopIkjVNbc1Mrxe16P7Ojb+8rE+PEw3epNlDoaiwdL4tsA42GqpbaAN80Um6WJlpH0S+WZ3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763602021; c=relaxed/simple;
	bh=anYceXlGLR1gj/IiG8jEKNrR6cYF1rUmlhEXZxH+I3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vb8Z7XBe8RX5rbiWcppN7ktYPPZoo+fzur+caSRLZUEtyLRrNuOn0o10CAjQ4SuyYbjfxvGCV90kQelVGJA0Y6w4SGdylwwKlmuofxJT8PRRYu4y5GzfwGl9725XYUzsb2KUQPmnuTFTrMg/0K8bZ+zcf5HUEvgXYIM4bAjy5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HuaaooeT; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HuaaooeT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1763602020; x=1795138020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=anYceXlGLR1gj/IiG8jEKNrR6cYF1rUmlhEXZxH+I3o=;
  b=HuaaooeTYry0HS1jU9KB23uJJP0qLjR0dopiyZ2EKtWjzvbQMqBWghE1
   N42bY8KFRdt7KuQmfG8Il4a+LkwCM6FZPTayxSBGG1tFLhMhUvBqIhcsb
   VMWXHIwWPZLcXH5F616pXTLqZZJmtdqBczT4u98kaY4yZTzYISBFh60Kb
   EXYCgnkBgkc/rZPgNwSTdnaQd+gyDUcD6izba5/O3asWraigb6Gy6DNeO
   3N/LQTNC66NIby3LAxzuzISX5FkVMIR1EYZ6bUUdO/CDgQ47bO1nJJdUY
   AV4zggVFUznd9kAuFBheFqtt+rn8psn9pQOz5kCiZobE52q0mDjStYnLY
   g==;
X-CSE-ConnectionGUID: aY+lCTl9TrqFNfkonnqP3A==
X-CSE-MsgGUID: Ib6+TukaSwu3K9RjkzzWrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="219212627"
X-IronPort-AV: E=Sophos;i="6.19,316,1754924400"; 
   d="scan'208";a="219212627"
Received: from unknown (HELO az2nlsmgr1.o.css.fujitsu.com) ([51.138.80.169])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 10:25:50 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id 842721C00094
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 01:25:50 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (az2nlsmom1.o.css.fujitsu.com [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 3D4DF1801E87
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 01:25:50 +0000 (UTC)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTP id 9E73F829F0F;
	Thu, 20 Nov 2025 01:25:47 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Date: Thu, 20 Nov 2025 09:27:31 +0800
Message-ID: <20251120012731.3850987-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test will queries message from /proc/scsi/scsi_debug/<num> which
relies on the kernel option SCSI_PROC_FS

Prevent the following error report:
scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out command) [failed]
    runtime  1.743s  ...  1.935s
    --- tests/scsi/004.out      2025-04-04 04:36:43.171999880 +0800
    +++ /root/blktests/results/nodev/scsi/004.out.bad   2025-11-13 12:46:33.807994845 +0800
    @@ -1,3 +1,4 @@
     Running scsi/004
     Input/output error
    +grep: /proc/scsi/scsi_debug/0: No such file or directory
     Test complete

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/scsi/004 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/scsi/004 b/tests/scsi/004
index 7d0af54..fd4cfb0 100755
--- a/tests/scsi/004
+++ b/tests/scsi/004
@@ -19,6 +19,7 @@ CAN_BE_ZONED=1
 
 requires() {
 	_have_scsi_debug
+	_have_kernel_option SCSI_PROC_FS
 }
 
 test() {
-- 
2.44.0

