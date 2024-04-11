Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6A1474C9
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833960; cv=none; b=KnjtA0k+I4IUhrR7O2MAhh9i80kSuGtBgjZZQuGZijEn8e7ATXZKP3khQ85mXrihhZemSCwt/8GLimVRWCvR6vJFQceHPNH5uVHsDGR4SM/uDcWjKDZpoJuD+APo1fTnkwjvv3r5BGp6f3ZHMbwshpkF1hOQY7ODSGuopXyHA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833960; c=relaxed/simple;
	bh=Xe2ouHZKM2kASaDrrzIx5jJXgGT4TAs7T6mgQ8wPqts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihBW+yomfseKTwz29laHCHaQjK0D1v5p4nZhAw0gAi0Tc/u7wCX++nTXZPO6qfx6IWy2lsnJQNuSPbysqF5PanNTBwmF8oGiZXowQyTzVBgZQKUX65QdAIvtwHDzkMa9urJ9DKbwNcSXACOiAzV2h0rSHp0mDrovKSRY/1EECVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XhaaU6jU; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XhaaU6jU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833958; x=1744369958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xe2ouHZKM2kASaDrrzIx5jJXgGT4TAs7T6mgQ8wPqts=;
  b=XhaaU6jUlFn8uZiZNci60/qGW4AKv+f2mtcOs8YcH7VUPIlgkPjS0yTp
   1sfAye/BQAIoPFgTamNfD/ztK2+gAS940gUnTXBfHPWkEuG8lMlaSziFP
   hbc0eJZwcPV/v6hIDDFFouKgTD7QwKfQ8Gae2uSAXfhz4MZ/PPe3tyYoz
   g0FdX6pZouipmOS67HZj7x7HGT6ughX/lk2+QLJlGRopdv4cbRezR6R8R
   BNwBELLWXWddw6vkSAeJVRWcVjTLOrhRSVLMjk9CJP7UAIA0mpNixkibr
   Zn2L8y5+9yFCmkoBIa1YD0HSKrGkRocQKWXeBpTIODsDhxEJNstVcxqx7
   w==;
X-CSE-ConnectionGUID: GSQ2n6O0ScWjk+WG8qMp0g==
X-CSE-MsgGUID: AAgCQcwKQ62sUYftRhG+Yg==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579874"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:35 +0800
IronPort-SDR: OHBbbIKS0gSdTKWPChs1+dCZQhMXZNRI6/1RSY5a9DL+6Vhg1xpFhXyLwm9Ll4Bk3aUhjzNOUH
 dzGfCLNCLdLA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:20 -0700
IronPort-SDR: PBEXeBJ9bOh0/zbzWcuZrYr6YwAdEeYo6WjbISbmc8Nt+Xs+tri6hdGbMBcr0UHvayKa4+WH+v
 F5qdL3VQ4gkg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:35 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 06/11] nvme/rc: add blkdev type environment variable
Date: Thu, 11 Apr 2024 20:12:23 +0900
Message-ID: <20240411111228.2290407-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

Introduce nvmet_blkdev_type environment variable which allows to control
the target setup. This allows us to drop duplicate tests which just
differ how the target is setup.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[Shin'ichiro: dropped description in Documentation/running-tests.md]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index df6bf77..d51f623 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -20,6 +20,7 @@ export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 # Check consistency of NVMET_TR_TYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -854,7 +855,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0

