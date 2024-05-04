Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C01429E
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810505; cv=none; b=eggrFnADDe+vceGl9aTm4ftxdnrlUHYVlXEr8iTUMMgrH2epj1cnToMSP2ASsER3KVW7O6k2CPi8GfTGAiRcDomxGEpGTD9AADPN+06ZjBcFe0CFxAPU6VkoFnJINsz8a5l+/aw98sIbToWiDBeN1KgNHir3UINVS8SFZe3k2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810505; c=relaxed/simple;
	bh=nqz9/msx15KbB+BgGwlvy/0PKz1/iD3nOvV9RFRZu68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhKEmL0UyJl6wPCi2vWGuvvj4tIxJCSKUmZPmtmmaStKlp7R2qC03THJkR1EN/XukTf4ivcVV6Xamz4yzFdLF7vU+6ofo/42mMlkosQQ+Vv0Z1IGSuqoNa6gOVnmfdRPvSbHdWJNzPY4A/0bvs9D01Ol5lW7VjNVrX6RGD92AS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oZNE1/LD; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oZNE1/LD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810503; x=1746346503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqz9/msx15KbB+BgGwlvy/0PKz1/iD3nOvV9RFRZu68=;
  b=oZNE1/LDqk4EmEg3syKtE0LQFqC2Q6ebNxRalNPGpR1ZwlLP7rlJXY4W
   mYFnib7+nve52jN0kRJSi9VLxtrsEgV0ehtqpwCXY5WGTCvVQCH7rDczG
   HTOrXRO5Ndq4duG+lek6J5k1OBj38hJgsIND3Xlqu3rOUzRjsHQkZlkIi
   Qm0XyS57Ex1tc1+iyu7vxiHhXlp2PpJqVuNKK+On3NzJmkeiZY79HektS
   p/cq1MyUP1/ilaiTARXprjDRnHn2RhqXpt9rSn8eWbMsNHY4DqRvqoU3K
   C+o8B4Ur/xylJZh4LQM4Iw8O3GgabVu+OCZGB+C8w0gUDwY0o3cS/ZnV1
   A==;
X-CSE-ConnectionGUID: uPTb+5O7TxSgGzAac7mVQA==
X-CSE-MsgGUID: k4KyxGHkTDm8MVFZ97D+cA==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540320"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:01 +0800
IronPort-SDR: APEvm6zVk6z/6QP0eHnfdcGh+28GXK0Ubvt2in+upID8Sx1M+KshR+Lvn2FcLDhzF+6WKlXJLH
 +CjrhR5LHxkRhvbJSme1KB6WuyPZP3hMNEnnDycqR4NjA/h6V7qude2nbLpL1mTZbns5KhE9XX
 nqfJcMi+TgkFVE3B6GUcAscF+0XO2qQyetzvMZ9g6gJ2q7t0dTmHlcK60wLBT1OrP5k70LvIzt
 ZfVBVLFSBmH7aKWonvJAj2Zm/TwwWgREXLauqgtYi2arE9FZKHyp9fzplKCGf5BIDR95bOYcxu
 1PY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:59 -0700
IronPort-SDR: e0d9yRP8e6xPux5jz6oc+Osm4Llx8Us6D1K4ZhCX1cEoEpcbVTT8D53OgijBAdVwNDo2nA9O7P
 Y+e/zlCp7EuS/ArYeJODVKl71N/2/AO7xZvXaf7MgrmIgWYEnhhXxD9jkisBEI1JHLded7mXU3
 OBR7uJZNiAz7Y+9w6DrKusYu7+TfgMVcDd2s+Op/56MO03JywwCXrC5MqfAjW1EIyCsj5ftdZm
 v9pt3nddhB2YptQieLrl/niyjRrm3Fy3VzHJGAnahtOXp6bsTgnE2OD/BCwWeln4sMsg2Sw1ZJ
 xgk=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:00 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 09/17] nvme/rc: add blkdev type environment variable
Date: Sat,  4 May 2024 17:14:40 +0900
Message-ID: <20240504081448.1107562-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index f35ed09..ec54609 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 _NVMET_TRTYPES_is_valid() {
 	local type
@@ -855,7 +856,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0

