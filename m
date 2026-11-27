Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764252;
	b=HkgLdwovboyhnTcP8gIglWzuN1vKNK5uHBqNp388AU7C3U0uah30NOcdpEulWvz4gqR7
	 wkE+g8VveeD09qkbmWOMqJhJg5ZtvQEHFsVDrSkIu6I1ocl2LXjN8MVtAB9Y3Ncw2qlbZ
	 7mq+kSEJO2J75MxQtdY8wixKOcyZMKOi2sZ87vo4ybTQB5PV4uLI4ZCc5uuMmAe8fudAF
	 gzgv8tAyqccjKK2Xn/OpaXOakfKH35m3wxNGTFGzRlqjc4FWRN07JzEgidCttZ1eaDPS+
	 yUrS/QPw4+BbA34RFJa+Njs89XSOWpBBC9u1lfSY3oSyZIoEFqWAEC96cwDN2MQleLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764252;
	h=DMARC-Filter:DKIM-Signature:Subject:Message-Id:
	 Content-Transfer-Encoding:X-Original-From:X-Lms-Return-Path:
	 Content-Type:From:Mime-Version:Date:X-Mailer:Cc:To;
	bh=6Q8n/+0yzOS8zRUOgySzo3szziagZeOEeZ2s5FzRuXA=;
	b=KpyWqWbENsXkFOFLFT9NrABSyVjhI0mKmAmicCZJ0zjtWwCXWP22lk6FDs1c1pQJkjte
	 MgdX/Id3Ygf7TdnlU7pDCMp+4bMe5NxxNSSU/gCXxLn1RVqUfgrvjpp3iOPfYwwvHHQMx
	 y1rCYPxe1c1CMPZTACOiwxMM0cM1LL106y50EZ3A76eSQ83OVYdUxwaCD7rjQC8FJJdqS
	 2Uq/a4G4sbjfLvvPsNCEDLhjktrpdnGQCYJSFYe1mCW/T2zCbiF+pTBppuUXhNvC4my0U
	 n+HxQC6vpGNyyC/owT2x4fxStFYHIoz2RXLa25GgNbhhZ9dReZ2n9lgWV9E+IPUSlEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=ipFr4Whr;
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C91606A324
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 07:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C91606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=ipFr4Whr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1795764242; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6Q8n/+0yzOS8zRUOgySzo3szziagZeOEeZ2s5FzRuXA=;
 b=ipFr4WhrIKSWDXWwamevVqpXU1lnOUkO6qAfltgOeDtDTRmyfzNj5kaoiy+Z85vCEi2d0V
 ohNrTMQqSr3KI4j4PLVMvJBuSenuJs3CTd+6l5ir1WYfOkxVXVDWSbFrvUbe5UeUvs6Tx/
 7anRgRtnfNGnNw7QcawIwLPjs3lSatnBU9PrJPs40oAzg3KPS1uzcehbi0+XCYTp6qH7az
 yHP9E+SeVSq4+7Er4+vZipLg+odSeRaMCehM1PAwUKlv1poyy8V8eJg6Ux3Y/+GRU6Gy2s
 SQfwASnnv4S+UTRcjbS90hYT4gnMcpcfSetxvVESGwDlmivLy39L3V8yoQnpmQ==
Subject: [PATCH] mm/readahead: read folio order limits under the invalidate lock
Message-Id: <20261127072340.73758-1-zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26b093010+be7b16+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Date: Fri, 27 Nov 2026 15:23:40 +0800
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Cc: "Jens Axboe" <axboe@kernel.dk>, 
	"Jinchao Wang" <wangjinchao600@gmail.com>, <linux-mm@kvack.org>, 
	<linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Matthew Wilcox" <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, 
	"Andrew Morton" <akpm@linux-foundation.org>

Block device mmap readahead can race with set_blocksize(), which updates
the block size and minimum folio order under the exclusive invalidate
lock. page_cache_ra_order() reads the minimum before taking the shared
lock and can allocate a folio smaller than the new block size. On the
buffer-head path this can cause a NULL dereference in guard_bio_eod().

Take the existing shared invalidate lock before computing the folio order
limits so they stay valid through allocation and I/O submission.

Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
Cc: stable@vger.kernel.org # 7.3+
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Earlier proposals:
  https://lkml.iu.edu/hypermail/linux/kernel/2511.3/04090.html
  https://lore.kernel.org/r/aUN9BFdxHQj8ThMS@ndev

The earlier syzbot retest hit a bug in the fallback path. Since
b244c89a70b3, the caller holds invalidate_lock before the fallback reads
min_nrpages. This patch covers the remaining mmap readahead path.

A/B testing on arm64/QEMU at the declared base commit gave 10/10
baseline hits via madvise and 6/10 via MAP_POPULATE. Both paths had
0/10 hits with this patch. The 20 patched serial logs showed no kernel
warnings or crashes.

 mm/readahead.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6e5563290..80f3e141d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -484,7 +484,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t start = readahead_index(ractl);
 	pgoff_t index = start;
-	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int min_order;
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark;
 	unsigned int nofs;
@@ -506,15 +506,17 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		mark = ULONG_MAX;
 	}
 
+	/* See comment in page_cache_ra_unbounded() */
+	nofs = memalloc_nofs_save();
+	filemap_invalidate_lock_shared(mapping);
+
+	/* Serialize with set_blocksize() updating the minimum folio order. */
+	min_order = mapping_min_folio_order(mapping);
 	new_order = min(mapping_max_folio_order(mapping), new_order);
 	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 	new_order = max(new_order, min_order);
-
 	ra->order = new_order;
 
-	/* See comment in page_cache_ra_unbounded() */
-	nofs = memalloc_nofs_save();
-	filemap_invalidate_lock_shared(mapping);
 	/*
 	 * If the new_order is greater than min_order and index is
 	 * already aligned to new_order, then this will be noop as index

base-commit: 29378f5cd79a27718ead9717fe7b094b651a8e1e
-- 
2.39.5 (Apple Git-154)
