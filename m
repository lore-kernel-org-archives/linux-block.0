Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D8127E30
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263536; cv=none; b=Xo0TM3q4dXLfMyGTEXXav5uTYnO4R2gCIAGzHmTFDDkDNncGinw8XXgOAXd/akp9wbuEnNcpUyokjbm8q2kSKe32fGt/YjaGqAOxIfHMp8j3vsMaz/QZ0kuCrDPdBbva5sSLnV18Wegw32zl8JY46JUJU9cK4BrCu7zNO55xkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263536; c=relaxed/simple;
	bh=PK8HMoLK5lKrHF0QhzaiuDc58LfZxl3I3zaL5rrdk/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLPedLFjU1Nk3hiJaQgzoIV/wlnzRBraI0erbsoxJnM9ViBGYqY8f8qJ8IMBST3Hj127Ixn2ce69vxxpS5WRCUuHagogUPTfZzK6nkLZcxCCk1pGtwsgxpboVKHDb1j0wX9NHeJU+MhDjfw8g5lvJwxigieYQHaUolxyiIgcqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JFQyn3XC; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JFQyn3XC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263534; x=1744799534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PK8HMoLK5lKrHF0QhzaiuDc58LfZxl3I3zaL5rrdk/8=;
  b=JFQyn3XCnHk9xyzDdE8iAWoNFHrJL5EYW9/3NDnbfDkgGB+63O3v8T6t
   QBeUxi8CTjhcBzFAOTfcGD3O18ar1hlVjsw4eIwnN9eYZyPtlJi89nejc
   9WFWKegHsPIZ+sRZzG/z47+r95mc66zzIlG9yHcV4SybmhmuNpGofVna0
   s3iBvgGCAY1TwDvpVNmzbnHw/1VL2nxx8rt6pTvtUabYEnrsus+ozFemk
   /BdybhzE2ERmd8A6CNT3xPIWSq3033oDdOUUACyeqjWmiISjYr0DtTsb2
   GbMCFBiwjofYKDzP6gmF6nfz/uYZfJbzkymJtKE1GTZKu7AZgN+wJ+May
   w==;
X-CSE-ConnectionGUID: ALMQ2XxrQFqMz99b6eQOVw==
X-CSE-MsgGUID: Rfi+SVYwQHWc2s9kYwF2iQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14322616"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:14 +0800
IronPort-SDR: fd8NRSiL6GIu1zE26RFieoLZSYxO4L7Fr+YgRi2pCpwpnsaiF9fXTd9zlbYiQkKHL+iSyr5Ki/
 xTi4A8kCJigPKgmxfzFyFsP95/zDkGlZ6pRfHu/7PyTczdXuAlVLkPYUiLqQLVFnd7VkjGP3L3
 +eyZY2cWQSOuo5RNUXO9Yo4J8mLH/eTFwLSwkH3+VwxftQSvpgewpnxlLthtmbhfp6RpIpDJEo
 87YlU1rZjKcE0NTJWnPkNhd4m/Qf7RiOFrPatFhkTPSx2xHK6Sb558jC3tg9g+TLovNs3+6O/Y
 rww=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:40:34 -0700
IronPort-SDR: NI9R/y1ONCsU82sincs6OnWmVgMiRXG5IMvnQKIxNffG6Qah2Kbp9ZjxQLZfkHspYa7h3vc6Pw
 KFFo9yyCDEj11iXQn/C8tEUGJuTjjXAEh67LmXICXuZsOwuy3BHknE0XVQZqwAn4ZkVbobihKN
 eAIBmNb31eCHvTeL2A03+ftjWBudC2qh8O2kzBxJv0STnIG6iKUxRGqXZLLRovnuNw0BExjVeY
 gJIL3JZdxusamzJivowezRrR1sVxUpqcaj95azqJcjR9IxfXqdk8owMbd6sftRClYA3zcdptgy
 7s8=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 06/11] nvme/rc: add blkdev type environment variable
Date: Tue, 16 Apr 2024 19:32:02 +0900
Message-ID: <20240416103207.2754778-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
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
index 34ecdde..d44a1c1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -20,6 +20,7 @@ export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 # Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -857,7 +858,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0

