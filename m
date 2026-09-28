Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5654D1793
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602391; cv=none; b=DsptnyovF1gRbQ+vi8eKFsG2TwpJ9PV2ojZMWZlHBCsN7oNU6kjBdu926JEdLp/PkWGCSfkhe4txiYajkYwfoF4RIxrNeZDel5JQvAloDg6iB+7Y2+qvf4a53+q4PtDhLdJe/ZV5kxnDlBdIZUToGcG0CpN09xlFsYBrMxzBDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602391; c=relaxed/simple;
	bh=dp8A9m21F4Z6vnwVaB36/IYEFqc7xZs52MFL03Y1vS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh3Neat+I/7r0Ybh55dKo190Qu/75IuqK3+vnhJPTPqoPW/OXQXohZ1YBuRUOjDtzuRuXdglbMCAadkV7WCGJ8u/w6o+gCpImnEBJTSDPXcrAYE9b/1DYWS598b4J5Gxb0bAh+F0lNFrvVlvrUa/fGd3TAedPyoQa5T4JcUSbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0Vea775; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0Vea775"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so18556675e9.1
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602382; x=1791207182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=raEDt673oWsC7HjzDuokLb4yrdGb5LOQuk6WNjaexbY=;
        b=n0Vea775koJUlSUtF5+MNAJGT1aIZ2lp/MSZJl83hA2FW9hBK4FWdZHONhBVtNhryr
         j63EZ2n7a7ro0iSl7+VsBVaiLUwPniO15bfIH7dhdUd8pHcLQViQh3xyM5n+KMsTVAgZ
         MUjIUrThxu6h5r/3C0RvK4lr/TP/WwXPCJM7pc+8SXbjDAV5JL83DOXh0DmyVJRExuUl
         0+gVrhXT4/xfoanMnKt7zpikee0YYBJrAot+UKHgG3vGVGsplXPPHBFyV8x8Fv/VCY6H
         TzDfRVOU7HyRc9NbZsQ/TU9+/E1QT4d4YNlVmI1ce1q0q/vKSLbzf2KWIAt26nDT6pq3
         CJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602382; x=1791207182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=raEDt673oWsC7HjzDuokLb4yrdGb5LOQuk6WNjaexbY=;
        b=KQOe0TacRYjrEJGGSBAu+z3dlW84bxYRfwZ/Ka5eB19yCFLmBgokJ6zMubhE6sA2iv
         3NlMff83inRpoUG8asqaSKvlvCa4a50+hxvgHkdp3qdubAw3UqUfWRpCsa0wwXpsDjnZ
         uxTu9sEQXXVUV0niHd1jpQWKYBTSFk3ssMtVcRI9shzPuPWNj7SRW3HB+A8O9gib/x+Q
         zKR20iDmJDJQFj2zwvISh26hXN3uOJGX978MIMXHVYEUr0PNYiMR68e/C09fq5ngKX98
         QTwGTx+tozuVnOl4cOT8/WQD65GE79ER+Jnws2DL3M6NAxUUHrx4GmHE5m3ZZO6VuX0e
         wKXg==
X-Gm-Message-State: AFuF++mFQszDMgdfmTSexf9ZZS+umQy620GBPFRUwIjzWH5x09qOmE33
	gzeeMW0wqyhtH3VirusnRjZzBWpVWCWo91y3G5gNnN1XoIjKqvo6Aet1fH25V4RZ
X-Gm-Gg: AYBFou2YRWV2YIn87fIn/qt/bIZf+sxvWOfwzTqSY+mcvy/y5ql2vxJS/lAhQzNTycA
	JAjMShfwIwxHbBanrHk6kiP4FoBTle8ftmbfdazdMcU7ys7rGp6BvVCJc9CX9x1L4hLl6R/WX50
	/PmQZhadonAQXPx7b/MnFy9PdYX0qWg+HqwdRbIFLrj3Om2D3vzO4lJIep+PfBhYJsGGICNAwNQ
	5BM1p05JjmZ7t0zWdh+0IWjBBZrYsB/qBKzVHOynDUkYSjjuLCUIIP4jzOL1ULY0vxsImxxeveo
	EGYs21Vdm/NW/58XqKqCil4B5G6MrW8xgleXTn3fApuD0Jcp7MGDIITztZV3E602/5+5Cr2Z4tA
	vKkhZwYOPxurfYgzthJ7hcKpRie8zZa0XkbwB9k10i7/ScSd8IbeEG+KjPSzYJ3X6ZDN1rT+tXm
	cY36nRdWVEHDB2MnnyS0lRsVbatQxxxIUy5Lyr+GJ+GwPR+NEDLDvNOpLnJO1oTjf/NaA4nyQzu
	BmwN49TVULnuEXuTFl2mljLEojmpw67135uare30+OUsmRg1LhzDqtyX/cpWe1P0t2N4GHGwde4
X-Received: by 2002:a05:600c:c3cb:20b0:49f:fc13:189d with SMTP id 5b1f17b1804b1-49ffc131a3bmr73381205e9.1.1790602381298;
        Mon, 28 Sep 2026 06:33:01 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:33:00 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v7 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Mon, 28 Sep 2026 14:32:27 +0100
Message-ID: <6bb81fd0941222a30477dc849684d47333d1e4ce.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 83a7ad9f5bc7..65d6cf7201ce 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1434,6 +1434,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

