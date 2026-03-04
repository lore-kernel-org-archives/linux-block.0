Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAF3090F5
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599980; cv=none; b=VShc6rinPTvF03egKsSXS9UbjUVZpDjXlR/+Bxi24bbQc/EwLg2xrYeD7XIPwAXvANSQ+5xUrmvszQ+SSAV/KD3FHUskJGknP1cWXX5zeSOq7VS8MwzdaGFkboqB1CxOi2CvPrFIyN5RGhvS+fCd77h1xB1gLQKODWwAuiJnl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599980; c=relaxed/simple;
	bh=FRibMBPQ+XmvMSVTopgRhzCP1sone2mAh+16SksAKIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+kBGXBRPTFfGObRxVpt/xY11qBi6IIoF5DuW5seu07azHKjFLCmqy+BZfK+tfaKEnTV2lTi2Z1mOVo/fkRFFUrp77BalTarB3A2DyEvon7nEBID69KNXRdzwBhNWyxXew0/c8rHgYk7LeAq2218GK4wTSHBn9pjyWUsEUReGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fhuezt+V; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fhuezt+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yR
	8YrUPRBUqrUt83xh7TPpD7jiK1YTxbI1PSs49d3iw=; b=fhuezt+VqgJkfPxFow
	7kNKyQW2XQ7rBLDpJl0ESfhkRf7ZDWkGfb/lM7f2vUEtTRBdMu8YfZs2s7sWcBoy
	Z+c3VQRkSaSjXFKFiqSeS/gwfnTBh3Zguz+rP4LI4FmfrFeamnze6Z7wBB4bYN8t
	0y2BXmDlyDNshtQwOZmgqg1vw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXhltyuqdpwkS_Og--.58555S2;
	Wed, 04 Mar 2026 12:52:03 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v2] block: use __bio_add_page in bio_copy_kern
Date: Wed,  4 Mar 2026 12:51:19 +0800
Message-Id: <20260304045119.396832-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260304025335.225965-1-yangxiuwei@kylinos.cn>
References: <20260304025335.225965-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXhltyuqdpwkS_Og--.58555S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XryfAF4ruFW8Wr4fWF1UGFg_yoWDAwb_WF
	y8tw1kWF1kGF1Y9F45Ca13JFy0q3WDuFy093WjqrZ3JFykJF4DuFWFyr1qvFZ7CFZ7ua47
	trsrJFnrCryIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbJ73JUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6hMPn2mnunMAkAAA3+

Since the bio is allocated with the exact number of pages needed via
blk_rq_map_bio_alloc(), and the loop iterates exactly that many times,
bio_add_page() cannot fail due to insufficient space.  Switch to
__bio_add_page() and remove the dead error handling code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
v2: Fixed patch format by adding "---" separator and diffstat

 block/blk-map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 53bdd100aa4b..768549f19f97 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -398,8 +398,7 @@ static struct bio *bio_copy_kern(struct request *rq, void *data, unsigned int le
 		if (op_is_write(op))
 			memcpy(page_address(page), p, bytes);
 
-		if (bio_add_page(bio, page, bytes, 0) < bytes)
-			break;
+		__bio_add_page(bio, page, bytes, 0);
 
 		len -= bytes;
 		p += bytes;
-- 
2.25.1

