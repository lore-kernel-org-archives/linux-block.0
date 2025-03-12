Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B11E32B7
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764436; cv=none; b=tv6ByzVC3f9reVNRhVAHOesEO1MoCUNimcK76XrhtJe7r0X7C2+/bSpTRnMFSBriva3SdGP8kvcwQHcNjoGIE/w4PFSo9J45jcTpxVph3pxOZu4+MhrZZaj2vtFrmvgthmSTOrG+7wnvUs2o2GI4X34pnztxwsI9T56ikVlZbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764436; c=relaxed/simple;
	bh=NDcYVTJkxcsSjFCr+V/HJpDRF2osTqPsc3ETT1xo4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0VQKUJRyyvaRxpwe64g8UctG0mNzf4RvAakBEQLxN/m5+dBnX96o6Ol4xChJEOfFXQslUxhYuGGQo8+ofUtApDvQCdS+gJan1u3STrAKq7k1v9udl6RfaKtq95+l8g0d39UYCieYMvoAfjcVUv52vvspkM1jwWNSqJL5kkdHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d+zWI1UP; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d+zWI1UP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741764435; x=1773300435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NDcYVTJkxcsSjFCr+V/HJpDRF2osTqPsc3ETT1xo4zM=;
  b=d+zWI1UPCjV+JvlpGuLknSxox6H7dI71CTkBon84uBoz1u3pyFlYthT/
   B8QAFoFidJEdhen/rfxtftRAvu9KeVZ883UaCGP87bRidJhP6llNz5ukZ
   z1xfpDlGZtKj9X7eRMLMv+iCvXVIQGjZf4SlUleIqsk7QPn8dDbg46jgA
   3kKnHDiL1R0SjeOa9M2LxmjzokWvUqGZgAmxLlQT3gjZDjDhKQEgV5uVO
   j52WMBcgI7suwMcfSSa+vteGftyArq+Usvn5VmkeW08C+HYzFQrlkI9WQ
   t58IsyUigVxOD6TTG3ACGN2CriUIX6IDxEEn7bf/8NouV//eA4SqnVmbm
   Q==;
X-CSE-ConnectionGUID: lAv+nD6ASwSAQK1laojVmA==
X-CSE-MsgGUID: /Xd2IZH0QG2+R+RsKAV17A==
X-IronPort-AV: E=Sophos;i="6.14,241,1736784000"; 
   d="scan'208";a="46887653"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 15:27:14 +0800
IronPort-SDR: 67d1297b_xMf/RRDJrYMArxh8ODVR99tU+ur5PpeIlYExYaptFo7Qq/A
 NFGO8e2nm8WAf0/uN5MvvKnUHyCh2iZlNe7yhpw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 23:28:12 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Mar 2025 00:27:13 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: improve kerneldoc of blk_mq_add_to_batch()
Date: Wed, 12 Mar 2025 16:27:12 +0900
Message-ID: <20250312072712.1777580-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f00baf2eac78 ("block: change blk_mq_add_to_batch() third argument
type to bool") added kerneldoc style comment of blk_mq_add_to_batch().
However, it did not follow the kerneldoc format and was incomplete.
Improve the comment to follow the format.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This is the follow-up fix for the patch titled "[PATCH v2 0/2] block: nvme: fix
blktests nvme/039 failure" [1]. Reviews will be appreciated.

I ran the command

  $ scripts/kernel-doc -v include/linux/blk-mq.h

and confirmed the modified comment follows the kerneldoc format.

[1] https://lore.kernel.org/linux-block/20250311104359.1767728-3-shinichiro.kawasaki@wdc.com/

 include/linux/blk-mq.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d904e870e72d..aba9c24486aa 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -852,14 +852,17 @@ static inline bool blk_mq_is_reserved_rq(struct request *rq)
 	return rq->rq_flags & RQF_RESV;
 }
 
-/*
- * Batched completions only work when there is no I/O error and no special
- * ->end_io handler.
- *
+/**
+ * blk_mq_add_to_batch() - add a request to the completion batch
  * @req: The request to add to batch
  * @iob: The batch to add the request
  * @is_error: Specify true if the request failed with an error
- * @io_comp_batch: The completaion handler for the request
+ * @complete: The completaion handler for the request
+ *
+ * Batched completions only work when there is no I/O error and no special
+ * ->end_io handler.
+ *
+ * Return: true when the request was added to the batch, otherwise false
  */
 static inline bool blk_mq_add_to_batch(struct request *req,
 				       struct io_comp_batch *iob, bool is_error,
-- 
2.47.0

