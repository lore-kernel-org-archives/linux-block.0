Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F349A32;
	Thu, 13 Jun 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237894; cv=none; b=JV7XudasR0sctyYov8ByTKOKreRppbrl+60XzpTNu//MptZdN+exGOAh8HCP4hBn2rRG3RwE0TM6iI63TkAeJINm5/nlP/0yXaubP6jyujNJbvXu/AUF4SMVhU6C9yH8jO79Q9eqmulXJNgmHdUwN0GcwxC/Ww4sK8uONvigkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237894; c=relaxed/simple;
	bh=SZefi0GZVNFS6wlza5IFvVBTTsmZN0q2ny+3b4RPSCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1nfuVkyaJeYLN7pUwZrZmcxANsMEP4jogPWJDtkdf+YXEK8r08xtyHhXBL8z41zUO81PGDTYA+Em0J8vy9yyMQQy5CGhSFtjr7lAQN5OVYaaWY52m+WtChKPDhRmKJB9dn25AK8pvixVHSnbG8NYshRmS8mi91NP7kFSkBljwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQCyg9V4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQCyg9V4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2D3C116B1;
	Thu, 13 Jun 2024 00:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718237893;
	bh=SZefi0GZVNFS6wlza5IFvVBTTsmZN0q2ny+3b4RPSCo=;
	h=From:To:Cc:Subject:Date:From;
	b=NQCyg9V4s+sJGt5RCWLFNEfoydPbD6uAkjxL6atxK6M0m4UIPdBlbz+wv90Fd2Ffo
	 NRyArc1kpAReNK9OcsxMAS8kSB8hW8oX/BrwiGIXfbTVL72EkONZxOjuxtphJQ5zng
	 sdmDtGqrPx7u7CJPQevJbpmoOMduoXwhXmPFcmTkOHzxVcEE1Y1KrgOLr4FPTlsNyT
	 f6jR24eIcvVwPNcgEdP1Fl+MeMyiB9O4cHmvVQnYbSyRTbLSGdOa5uT8ipIrhCtM2R
	 qtFa5tLb6M8eTh7EXsPjVpq0uReX1hXxWcjW8VxxLy9ZbHDQYtX3IVMRd32L9cJeNQ
	 7R1kKlvmD2/tA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] zram: use copy_page for full page copy
Date: Thu, 13 Jun 2024 08:04:22 +0800
Message-ID: <20240613000422.1918-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 42e99bd975fd ("zram: optimize memory operations with
clear_page()/copy_page()") optimize page copy/clean operations, but
then commit d72e9a7a93e4 ("zram: do not use copy_page with non-page
aligned address") removes the optimization because there's memory
corruption at that time, the reason was well explained. But after
commit 1f7319c74275 ("zram: partial IO refactoring"), partial IO uses
alloc_page() instead of kmalloc to allocate a page, so we can bring
back the optimization.

commit 80ba4caf8ba9 ("zram: use copy_page for full page copy") brings
back partial optimization, missed one point in zram_write_page().
optimize the full page copying in zram_write_page() with copy_page()

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/block/zram/zram_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3acd7006ad2c..4b2b5098062f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1478,11 +1478,13 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	src = zstrm->buffer;
-	if (comp_len == PAGE_SIZE)
+	if (comp_len == PAGE_SIZE) {
 		src = kmap_local_page(page);
-	memcpy(dst, src, comp_len);
-	if (comp_len == PAGE_SIZE)
+		copy_page(dst, src);
 		kunmap_local(src);
+	} else {
+		memcpy(dst, src, comp_len);
+	}
 
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
-- 
2.43.0

