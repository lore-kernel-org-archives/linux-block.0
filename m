Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6E3C8721
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942989; cv=none; b=ZEisUHBEBLhm6NaA5OD0sglTE1VChxq/3S6NYJN5ud2djYCYFWpwSlydh6Ektemg0zlLFWVXTZZAt1imuIcaxjC33aNeWm6XjDtPFim+N/Yg4gBBfTmrANYgObZ18FqWk/XzayMHm3McmwatKUZo+5UMOZjyhtc5l6N3Ua1b+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942989; c=relaxed/simple;
	bh=RxiX+2kB1Kg81twj3q/ThrHno5eqofNSwL3TIKw0nIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOa+pol93ql+xP8wkzVppoI8kA6aMrlGYV0cIDAqpcrNgywthImoJikth/gkdl36nsdRTSHH/sGVhp4VU6fRyz3utv1ZYatWQ04mCNDtcal8BIhcAbH73G2TuI1iivMt/9BvlTxCqq1knxewQuGIBHYaeNuU6Yh1g/qRqEHb2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AbPLSegp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AbPLSegp"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so4487896b3a.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774942988; x=1775547788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4zrNQ1+hM10X372wm0lwqlhzeSkOK5YKY8PR2eVC/w=;
        b=AbPLSegppgtqm/cJmxDyKOi2gMM8oKT9lkRTr651zQUJyfhTYc75avjyz8MObtsoAK
         Y/WIkAOQd15Y4TPzn8bBAQb7qhM9KUROl0hE9Wkvrsl2rMRtZqOUpqQC6QwgYA9Fy1ds
         iC2jm0xKC9OuG6IeCBr+SPZOnWdSWGQYrWy4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942988; x=1775547788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4zrNQ1+hM10X372wm0lwqlhzeSkOK5YKY8PR2eVC/w=;
        b=ookIXvDp6963zDKXSgQUJmG3Cz7+7WrwiTRn97J7BHBlL5/LQtEUjSHa+D3o3JH1hT
         ZhHzuRx59N83cCS8ME0zvvdMlHP5WWHmUeW5fNcBXjLlmsvv4fCTJb7WFHmnr6tv/afM
         NuiX8YdpHw/SMIwxWxAwswZAdJuHAN+Vc6wu8UW/W6SPYdi07KoLVZ47IFo/n2ENoxtE
         sFGBEbA5M+9sJs0+Yo6AX9azwp7z1fkDKNygZsL44M/B8pvr5vqA5nOpVxLwj7dT7hHV
         Cee5sOq8L54njD2jQ+KZrooLzhkpyCs7VhkKFwoRV8BQz3TPYqa7w08B/0g2mSUhXecx
         cYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1f2v42cYPd4uvLhMi7p56wksqVX8L7vDHdw8MucLGRiDiF2kOIrhlAayybDrXfOen7fJtCBV09wf/ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGINoItWlavYKz63yUxfgAVcWw3uHpQ2jdrWztZ7bELMB6yyiC
	o0ZE4NTRdnoViA45WWus6n9mehzQlHmOkF0EbovEK5QoQekLk5ykjHm5RMv4xgQaUg==
X-Gm-Gg: ATEYQzzMYhQlHtt02KGQxv60BrE5NjOtRn3u3oLJ8PdMmYmTqbvqcgkl2JwD8CyEGwb
	Q2J8eZQnTQpEDJqqDjVUtPX3DMIn/AaPtzJ/jcu3OJ/nX0V1Kavm7yYxKH4gnYvTlXrgAKgZJil
	+q3ABnnnjEriQV8OsAEV1j/NycBvOc+vKyRuhuB8pRsnfcD7Oz6eqYquvN7T29f3DykC+LWgK60
	24FBjhTFzmu6kaGIhU5RQ6/pzOLO59LuvveFyboukeKgz6jY5H5UvWx3c5fI+VhcB0q9uaR0jwH
	r5TLA8IpZoEiUs7XKdJGG9Kf3VYQz2lF0Cv9nuAxWqJAWk3GAD5Tpd6KwfP16ovq2KUsbs093iy
	2QGhfxNq8ht+UYUYVaRozaanZul6JKQ84c7TeWRitit2qsZp0C5wD/Rzq6DRVYztyj8F2IH0Up0
	e/8pfSfceyly5CXi0f0n/eShInrZgAbVyyTLAxyNNVtEKUr7JtnIADY0DowaAEM0S6igntUg80J
	0cVZjJHj73WbQ==
X-Received: by 2002:a05:6a00:3486:b0:829:7d31:dd9a with SMTP id d2e1a72fcca58-82c96002073mr14909919b3a.51.1774942987629;
        Tue, 31 Mar 2026 00:43:07 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca846e08dsm9447759b3a.24.2026.03.31.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:43:06 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Qu Wenruo <wqu@suse.com>,
	Avinesh Kumar <avinesh.kumar@suse.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3] zram: do not forget to endio for partial discard requests
Date: Tue, 31 Mar 2026 16:42:44 +0900
Message-ID: <20260331074255.777019-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Qu Wenruo, the following

 getconf PAGESIZE
 65536
 blkdiscard -p 4k /dev/zram0

takes literally forever to complete.  zram doesn't support
partial discards and just returns immediately w/o doing any
discard work in such cases.  The problem is that we forget
to endio on our way out, so blkdiscard sleeps forever in
submit_bio_wait().  Fix this by jumping to end_bio label,
which does bio_endio().

Fixes: 0120dd6e4e202 ("zram: make zram_bio_discard more self-contained")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Qu Wenruo <wqu@suse.com>
Closes: https://lore.kernel.org/linux-block/92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com
Test-by: Qu Wenruo <wqu@suse.com>
Cc: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
---

v2->v3:
- updated commit message and added Avinesh Kumar

 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dcea703a6766..aca67d7144e4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2684,7 +2684,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 	 */
 	if (offset) {
 		if (n <= (PAGE_SIZE - offset))
-			return;
+			goto end_bio;
 
 		n -= (PAGE_SIZE - offset);
 		index++;
@@ -2699,6 +2699,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 		n -= PAGE_SIZE;
 	}
 
+end_bio:
 	bio_endio(bio);
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog

