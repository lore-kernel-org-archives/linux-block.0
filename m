Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66691586F6
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945611; cv=none; b=PSWQj5zc+G0LM/0XWeWQq7nIh35ChqxffEDSwR0Gd2j/6nv+3UPUpkR/UcswQYiNUpKqlGRlhZHziZEAR+JAg4uCtcK+BbYAB5hhzyQ638ER2sU5/UDjTCyv/Yk+AtqSFDsWiXOt/ui9rmbDpvMz55oc1tlAhdeYMefpcqZnn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945611; c=relaxed/simple;
	bh=nqz9/msx15KbB+BgGwlvy/0PKz1/iD3nOvV9RFRZu68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRkC9xyMYx18WcApxjz2nVJ5+wOG/doOyfrgufW+D75CtCScqE6QfVeSdoOPSn2ubKSiCMIezxQ7jdewak/UP8QVAQk7Wm5tWEQz6X9Gtynue9c2bnqmrNosVIe+YA+RCUImOrQsqhwSQQArhWhnJSkjsnWj8tXIFdhl+oeIymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nwaAcxXH; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nwaAcxXH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945609; x=1745481609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqz9/msx15KbB+BgGwlvy/0PKz1/iD3nOvV9RFRZu68=;
  b=nwaAcxXHuhr6HXFMIwDU1y8MrofUeYsGs1FPp65Fz1eSGtKrgxM1syBk
   wjBlAftKedk2mdENOyhcTiF4Oy+1wzzttbWGc77+B5EhfFRVgUM/uqy+N
   Kk6ahVkav8SMJ/8PLOVHz1mttmzxRrI/2KweLCwUNePtYQKEa6BZ6KomQ
   +8gUeobe5H9c830UOBRB8F4Uu3h1rzDYazlBE+uFhf7a95V84bpn60lec
   Jtxd3x8S+k/hEQ3aZ+w7+/HQW12DJlDjcuz4M0to7ZH2awyq7erzLLlNU
   G6DODw2GL4RcN0eZi28x3N+LbP8E3bLXdZpDUc1KHGjgjadPWbSEjEKi9
   g==;
X-CSE-ConnectionGUID: 6D1e821VRMK/G+OwVvPyCw==
X-CSE-MsgGUID: empZ2SAEQdyC2eplh/nctA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515694"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:04 +0800
IronPort-SDR: YVUbv9+3qDLxrUhZBFiBryonU7wYuF+y7gtEdKTLAmenGRNcsoaJjX132I9THyJewURtHISHwI
 rze3c3PyE/znZ1KngpMeiQP5ojEM9qG9noyzLgevf0oHZ1bOVQERGdpK/AHU+Yp8FsRNZKgN8Q
 gvLrw9Ef6Cn/aj+3jXuJmLk2u6LregjlEkVOWdMv9fUXF8Hm9CDLw/PYCC1oxh8dhfptfqrrvY
 /cTt7MGltHr1CZHpabcJpNtjpT8nHyY1Q2qDCl1eBXIGlFsHFga0yU2KQJ7uKu2ZPm1eHoMn5q
 TeE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:14 -0700
IronPort-SDR: pzNP4i1S5B7uUSQ5rY6jpRFfzZUbNZEQHnHXl9DZ9h7MioOlSR4BFRsQflb5dPBzdzuWywqrVx
 11bOxLgkwBvisEqu5m6ZpwlVSTj9rMGgkqMPc++2ZI6/1Mi8cNYl/NNRgfq73g2lXpTyIuhuS6
 Qj7y4fmkwlEk+w49ECBKu0++L6BqAPR3CzYRG/XVG7nI7BecOpsY3ShtW94g5Xkz78GUtxIPrS
 NHkw0m+yGe6FyuIm3ZdF8AdimR9VXHIa+qSVNRm9nUd7JYP9Hl2+j7dUlkg7zAiHkoLQIQBsLq
 XSo=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:03 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 07/15] nvme/rc: add blkdev type environment variable
Date: Wed, 24 Apr 2024 16:59:47 +0900
Message-ID: <20240424075955.3604997-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
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

