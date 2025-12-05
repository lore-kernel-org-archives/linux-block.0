Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6881BBBE5
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904177; cv=none; b=i5JFZt2g2eSnrayYuMCMMCT2lMNQKC90seIIJiBOXTF3n2Mc+j1XvuXzwDWchzJQ8mcGarrgRKYTKBLKnRCZRiLF6lTD21x2x4tST36K8hxvelcFP7DC8NM3PtTcDzsT9fWuXnHNwqZBIcA7la5JcvsXTndaXqRtZpo6wbDTMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904177; c=relaxed/simple;
	bh=7qns2XNVqTYQgxRsBnCzadTMovutDrS78lnWeM3sHsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4ebVlmtPrbyzbxUWgfA17ZMhddXvU2/Ew/h9H4tDFzkRf0uGsT1Ylfu9jALuSZQ/4sA5AKkiWZXyL66UbxWss3BRrKimxmFZcX7FRKkOrVPZY6lJkkN7eDMOhuoTxFGIUYBFYDwoqVcVim+b/ABSYyJqlJwBzPH6ZMXXQeTY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=A3wCHBtw; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="A3wCHBtw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1764904174; x=1796440174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7qns2XNVqTYQgxRsBnCzadTMovutDrS78lnWeM3sHsA=;
  b=A3wCHBtw/q9K27SpXsnJndif7wiS70khsUWAEnZ7EpPAEnpgjb6G02xe
   LM3Nd7shlK6CAD1rvdF91Y2cO/OHtGMIN4ry+NbxgxyF7HaUV5ooY/eJq
   THQyVvVe5zI9+IF2/SrzzP8Ki5eRKd+ITQBVm7SYs3J7J7slib+3UH2rS
   Oh9fxO76vfhAzkaMjkm9ynGP0eBJsWbgHW1a10chLevpKUt7//2uSRMck
   B5nBl3IR3HzRq3IPubPuGyHksjutXBmBpQxMLz7fMmG2U5gizqeLNbsBi
   6ng35XnL22j1vWYXDS7MstKxiByzPGyifuqRVYisFDmms7pT311jxr7BM
   w==;
X-CSE-ConnectionGUID: OX4WCMdcQ4mIVgdQ5WsudA==
X-CSE-MsgGUID: SJCrtulgTwGUGv/ERuY/5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="209510970"
X-IronPort-AV: E=Sophos;i="6.20,250,1758553200"; 
   d="scan'208";a="209510970"
Received: from unknown (HELO az2uksmgr4.o.css.fujitsu.com) ([52.151.125.128])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 12:08:23 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 391E6C01AE3
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 03:08:24 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (az2nlsmom1.o.css.fujitsu.com [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id E2BCF180A32A
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 03:08:23 +0000 (UTC)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTP id A5FCE82121A;
	Fri,  5 Dec 2025 03:08:20 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Li Zhijian <lizhijian@fujitsu.com>,
	Hannes Reinecke <hare@suse.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2] scsi/004: Remove reliance on deprecated /proc/scsi/scsi_debug
Date: Fri,  5 Dec 2025 11:10:53 +0800
Message-ID: <20251205031053.624317-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kconfig option `SCSI_PROC_FS`, which provides the
`/proc/scsi/scsi_debug` interface, has been deprecated for a long time.

Instead of adding SCSI_PROC_FS as a requirement, refactor out the script
to remove the scsi host to ensure all pending I/O has finished.

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

Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: The new idea comes from Bart. Thank Bart and Shinichiro for valuable suggestions.
---
 tests/scsi/004 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/scsi/004 b/tests/scsi/004
index 7d0af54..72c9663 100755
--- a/tests/scsi/004
+++ b/tests/scsi/004
@@ -39,9 +39,9 @@ test() {
 	# stop injection
 	echo 0 > /sys/bus/pseudo/drivers/scsi_debug/opts
 	# dd closing SCSI disk causes implicit TUR also being delayed once
-	while grep -q -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBUG_HOSTS[0]}"; do
-		sleep 1
-	done
+	# Remove the SCSI host to ensure all the pending I/O has finished.
+	host_cnt=$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
+	echo -"$host_cnt" > /sys/bus/pseudo/drivers/scsi_debug/add_host
 	echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay
 	_exit_scsi_debug
 
-- 
2.44.0

