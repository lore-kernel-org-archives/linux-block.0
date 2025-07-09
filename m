Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBC2D838B
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061640; cv=none; b=je0kE5la/fAOzpTc4uxQvA6Ru8sr1XDnLtCRrBVmnyecL7hIUbnrqo7YEQ+ZdiGDtxdee1LHCZW1KN5oYMc8ZC5E/h/VfR2VhPCrFOoJaH8+pb/Q96to3KeR0yne33vuV1m8Kg1qM1uXB67eiQzmVVtZYgd+06SerG9ziURY8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061640; c=relaxed/simple;
	bh=DbuxOtVlHu+bLcqIaSy+AzItONUxbV/qLHqmtWRBgXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9wODwork2iJt5woAJJKk89rzipSrrhvXi1amcWy4ZTgxiDnqYdOTI7dcRHsIi1Up8jFZF6l+SsnDTFYLmKUP3a+JaHHD3XyaPgId/J4khE5Z6yehmHTURwHl1mtT6hQ9ED1VbsCY9Op7S3b6wQggH5+I0mdHOpDhqqpBCwR+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cno4ln69; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cno4ln69"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752061638; x=1783597638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DbuxOtVlHu+bLcqIaSy+AzItONUxbV/qLHqmtWRBgXg=;
  b=cno4ln69z1El72x4SfjqsF0T9bSpliUC/zboXchRuPV8mTr+WReLsYFy
   q6KShUR+Jhf9o+zKbMJPc1QiXBqa75lqa1xFLDBQbEBXRGucCeJ/1Nk9f
   UpXoiFlSmEuUDnXcrsqImwZXws7ZkS94QLdH34WyGjcCwWups2oUv21Q5
   YO0CoN5gJ+uprMlKSxfTVjaf4RmemO0L4zbhWFmLoRRPtf0ssts2r/jhJ
   wHvXX4aUEhJ3GiHB5ITjSwvK2qCm6nzOALYxxUhKciHHJ3EsAaKTq6sSD
   8woYS9h43uD2Fpl+epXQk1sOwIY6WBR5VzzK25AAMZyrJh7cSZHByopw9
   g==;
X-CSE-ConnectionGUID: kaKBF9r7T4aJOoaCLF7mug==
X-CSE-MsgGUID: R1Sks0+oSByVSkmXvCyGiw==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="91096343"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 19:47:13 +0800
IronPort-SDR: 686e482a_eFNFGVuVv3YoIuMz1VGeYszJ2hwzv4NkmK53wqgfPZfHjp5
 YwwUD/97Pftjo1drJLA3dN5YDAjVMn0GGTd+y7w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 03:44:58 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2025 04:47:12 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Date: Wed,  9 Jul 2025 13:47:00 +0200
Message-Id: <20250709114704.70831-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add zoned block commands to blk_fill_rwbs:

- ZONE APPEND will be decoded as 'ZA'
- ZONE RESET and ZONE RESET ALL will be decoded as 'ZR'
- ZONE FINISH will be decoded as 'ZF'
- ZONE OPEN will be decoded as 'ZO'
- ZONE CLOSE will be decoded as 'ZC'

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3f6a7bdc6edf..f1dc00c22e37 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1875,6 +1875,27 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 	case REQ_OP_READ:
 		rwbs[i++] = 'R';
 		break;
+	case REQ_OP_ZONE_APPEND:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+		break;
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		break;
+	case REQ_OP_ZONE_FINISH:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+		break;
+	case REQ_OP_ZONE_OPEN:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+		break;
 	default:
 		rwbs[i++] = 'N';
 	}
-- 
2.50.0

