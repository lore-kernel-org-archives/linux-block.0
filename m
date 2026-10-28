Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205912;
	b=ZAj6coCWlyTrBW7AQl6zZj7Teml/hcVwjVRVxp7nrmU99E3M8EmEWYhiR/Z+HNFAXxlb
	 suxl3QDfkovvd+FaOujL6xYfvzAdVTE1Ju71HJh+Vo7+zl1PorhGchYdKVpwlEXs5dCtK
	 aRM3/oMMCZibNk2hDyK1oiqcngn5lAJzyLxTLp8eBf+dmM8lj3lObyOgv43SOpvEJj/aZ
	 /70czTrKDD+/MUYQtj0diB/TBEINNPSXQaXJyDuSyFPVFQgMOWhlUlvw0a4n/2aitZdST
	 IgSq70BVnGnJxOknQKy5KNJ9Zh0TXr+fLmDurGVCDvZONcil787v5NflxpTEo5D2BTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=811PjhUSm7GGtAaJiVpooIPKJfuCEJZcZ1pj1hrX9P4=;
	b=BHA2UAufr2l3xbMkFSPSSL+WtMLy/XK5m96fSarf5uzL7V0XPjHtwR3PY5H5dOyVGnre
	 KwFdznvs04R0eyxto46D1BzhVJXdkBOLWwligd0XK0Kwfqcq6IDxjhjkW09hJyAdjFxVz
	 3a3PivyLp+O5e6a3yLqPyKGlEu9Q7xughWk5Hm+6AsgxDYWVQAUZNhtZL4xY/Vezlh0g6
	 mYR3I9+MKfERZNW9WWCgDCVhRXQqMj6QlitUkbfpD/4NiWlw8fvNSZX2nRyHF7y95YCXa
	 J799NtsIwm3f1kNoYCONE3AJszHWqi/YSfic7UYBarGyYVRokDEfEAzbHS9o/R7XJ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Tlr77qRF;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC480606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC480606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Tlr77qRF
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-825b40f8a26so544514a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205911; x=1793810711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=811PjhUSm7GGtAaJiVpooIPKJfuCEJZcZ1pj1hrX9P4=;
        b=Tlr77qRFwKBXfz8Q3bNmBDeiAi2pu8j3XfENVbEygcrnEgES22MxVeEftFbBg81Evf
         /i8qdojG8nV9xAkM7UzfX1IG/1nphyoGv4A29iIBFh2WNO+rn0NwVGYEt3HDuayaKhsp
         yQo8WZ0CWucVz3dcgQ3vEY5y3pePl38y2nqKzrnmiv5wvKHoMN/iAGQkYTrNz+iuI1Yi
         km8u833YZtswLb0EDq0uOSaafM+GiaODbfbSjSZf3zOu4w89QppPr/fxaCO7uWvX/jEm
         QHmklBMz76sWsnygyr/RrWgvidfN5it1HJCmtCC1Bda+CMypLkneTrPDoJ6fwbuyW39O
         IPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205911; x=1793810711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=811PjhUSm7GGtAaJiVpooIPKJfuCEJZcZ1pj1hrX9P4=;
        b=H1XpK+gC2pviIdwBkh4D9wOjuuB+ZpQ9B19p5X8qbu1yS4ld/gL5uI7zPMZ+SwF1ML
         8zU4i/k6keTgIyanRvsmDc6g8ld4JgEHiqrBAP8UUIqNTJpDWbFN7P8pS9xjNqmDTS7L
         ninChacu1bR8qNpawzAiCP55nhDjXd5fHg0XYYQ+yPtiRpLWDFfGwkYxMQA3MsZo+i03
         raNWyT+ir9YaMUGCqziW08nvYZt04YTV/UN+TZOtZlV1efwtN/njaxnasYjtFKIlJjnO
         RR9QW3iT5q+01ZSqeQ/p5Nw31w010x8T8L1A5A+9uayWXxMZrtexq0jJ8PfwN7FHaSra
         UZiA==
X-Gm-Message-State: AFq9FYKFI/3b5xcb2rdi8ReATxoBK6FHBe2kKcd+VuxpYuk3gQdnHYws
	xRUa3yY2VzFiLs31lE63rWI4oxqBiyQ1WkTApd/fpyu9ReT43KJ7l0bUJvdtZ5b0ZwTNL0UCoY9
	23JFgajo=
X-Gm-Gg: AYBFou1QN1/zav4/rHgARugI1Iw6uxq2HJEU97eYiG/rXTB1zVDQp+4wwdmtmxzah4P
	Y9u/O+rwDjWyWzEcxejQUM8AGW3S5uumyH+uM+r9OqnFOa763RAdjck0tzDLUUrLW4yWA3OXpkO
	7T3HvNE7cNPUNQKdTCInjDgjb/slzqPMoHeFRuGZZKUhZixm1gcF46KvlTPc3x75hNTT7IS/Loo
	dUgY+CQ6SgaWs4nsleMcdUZGaOQRXxAgFMRfC89Zhd4Dnb6HWynuSNIi03E5sqUyXdXQe/MOgYy
	NDcRXl2A4LAO+oSKsxPAOdob/GdCI7Ds9ynJn7N+xJwT79wE4pXQifFCFQVpkGfYSeGDtpMKX95
	M4AUIJYKVfdh6xqQNvizmadNwxpraxjPbutf+sRS0Z2uWwbmwiQBnIBzqeC2h75Tw71iw7Z2Bpz
	vRHLgPFCzBTETlpv8wIF/f/aDmSZUWlYcc8ruApHbknfqvjP7MheEyETucSLJbseZ597Q8NHMFt
	a14H4eOxBkRQ3vo5YzYC+er7+qJFDouX8av0A+jWVHY/mj7WQ8N75oDvvJZvSJxKI1sSuz+WPlY
	Qu1dyqA8yvF7FR/tTKX6cXYUXl/XYsllOBGOL+RcWmaoXdmAmvaJcZDa3+SsKJiO3NJuU1YOxQ=
	=
X-Received: by 2002:a05:6830:2e05:b0:7fa:5c68:d050 with SMTP id 46e09a7af769-85ac0ed82bamr2514094a34.26.1793205910898;
        Wed, 28 Oct 2026 09:45:10 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 43/98] blk-mq: free the bitmaps of tags in the SRCU callback
Date: Wed, 28 Oct 2026 10:41:46 -0600
Message-ID: <20261028164415.1262013-44-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

Commit ad0d05dbddc1 keeps struct blk_mq_tags and the requests until the
iterators under tags_srcu are gone, but the two bitmaps they walk are
still freed right away. When the number of hardware queues shrinks,
blk_mq_tagset_busy_iter() may be about to walk tags that
__blk_mq_update_nr_hw_queues() frees. sbitmap_free() clears the map
pointer, so that's a NULL dereference or a use-after-free, depending on
the timing.

Free the bitmaps with the rest in the callback.

Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU callback")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index aaea2e2c2f23..e3edf18697af 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -623,17 +623,17 @@ static void blk_mq_free_tags_callback(struct rcu_head *head)
 		kmemleak_free(page_address(page));
 		__free_pages(page, page->private);
 	}
+	/* An iterator may walk the bitmaps for as long as it may see the tags */
+	sbitmap_queue_free(&tags->bitmap_tags);
+	sbitmap_queue_free(&tags->breserved_tags);
 	kfree(tags);
 }
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
 {
-	sbitmap_queue_free(&tags->bitmap_tags);
-	sbitmap_queue_free(&tags->breserved_tags);
-
 	/* if tags pages is not allocated yet, free tags directly */
 	if (list_empty(&tags->page_list)) {
-		kfree(tags);
+		blk_mq_free_tags_callback(&tags->rcu_head);
 		return;
 	}
 
-- 
2.56.0

