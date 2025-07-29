Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B141E520E
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766505; cv=none; b=Y2BfvNaC5uMAPprQJa3X6FTYPkwozUNSibhULQsedPaw952a0OlWHPCwtGjiHl+3nmWYv4w5eu5+IwyV6HTneI8Sz7PFMNx6jhZkmHpCl6RGfzKQsonAhKvysKkRR30oF9LgaCkI+KQWDwJbSDGgmczbyXWqmXN/8DsFHguvZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766505; c=relaxed/simple;
	bh=gN8omh9+jZRnT2WyX5FyUkbqpxQzn9dfqD1XgXawL5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d37z3cQWyEn7v1PDj50p6OsOl/F/CjfBXDTM9aT82diXoE5xvJO/i/jKpVmQ+EIzateMoPPV6MeTcow9mEO5el9SCBoPTgguwk6USPSneOxoW+tEuqse37IAwfILMQBoYEGuaMk2UdKbUdA6wOBvtwHeLoVwI+JTYpByrmwQtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eX88Y/zY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eX88Y/zY"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6faf66905adso29636416d6.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753766503; x=1754371303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCNWGElp5pC1atxEbdepPd2VdGD7IrJ4GQmz0sudHLw=;
        b=eX88Y/zYhqfoyxvNv8Nl8NEA/MBUwjWDZIYZ5jP939333qitX7ppAUNGCwJ1V/kOqM
         H94Ux0Eindx1YffIyevjP3RJMzwu2oi+PDb8gcHEZnQ+RGSBe9U165FMkuN2yIuLejwQ
         /6Gbkn5Pk29MG402AZNA0sPyIcoWPNKBQBzx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766503; x=1754371303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCNWGElp5pC1atxEbdepPd2VdGD7IrJ4GQmz0sudHLw=;
        b=ddcNKzG4EACYSg/p0PweZqyabAf/ugzfpyKNZRJUjyJgmcI9lzruVzIQET4jTUTZBe
         y+VzEsZCgPZngZcYF0KJwiwjihxfC4s4OQUWxG/7IzteONzc9eRI2ik08hhrfFEDfTxQ
         5GfoDPdpI5UEEET/GOyD5L5YeISvZ7hIqRa6noINND39gfNhSytr1yZQA0VI0wgeXK+q
         nkts1vpfMKZJPXe+T1XY0jg785p5kZ33jxfgk67XK5OcBqM5jZ+s8YkxUqJcgBKynpRL
         89jI6Sgxt12cu9soWgVAa0ByGMrurRqx4tQNWnto9ghUp75Ns4hSiRlNBJCJ4Pf/yCqT
         kAMA==
X-Forwarded-Encrypted: i=1; AJvYcCWMoa4UTojQ/K8xjw8htHEJbAWcMgAxP/88glEzo6DfK5w6lpFLw2bFjPMoLsoycXPramhvvuJ7Sk9NFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7qGP5JwVBeuQVHwb819Jap7YTV/xwPTsKM9/yToGxaHW9wqF
	l2Fyqxl2hUhh1J22hRcF/7Dpo89NOP41i36dfv4/BmQgDtblPAu9KfdzDuMIzjMdDp7F//TTEiB
	WNCw6WH0yC1c=
X-Gm-Gg: ASbGncsl1k8GfzsKghJS8XtP+QFdxjdSzMA1V9iIBKRmVNVMY6EjBgZERD6s/8OxhkC
	R6f1psonSPx0jdZVUguNZ64cxHfmLa2XweLbO2/NCRmj6KWKDNLSt9G2siISys6mosHHrZwRnJy
	4yT3cuP4e3ZmLRbN/d1a20wztu9ocsdmdd9RK6YGGEnqFPMLBcWlae9p3FrcPKfxVbGL2YSTo40
	DgoR/joXex8fAno9ccIxm91PirfBA963ruS4LXbAZTtS7rwv5QSjLwqqQ1OfO5WY18pKityHZ7R
	1STeWNgxbKEX+A8tQPi/K90IlX49ixiIFcl6ZyWVMRmDFq+OpDK4BW//m7pWRzqr9SOlsNhkNiK
	yGOmTi3jL7AO8mtV4+tmofXgdERiweGYlnscvDfegJUKmjLiOhK1SH5Di0lm4IvFcqEFH9JETMA
	toVm/9uvHI2w==
X-Google-Smtp-Source: AGHT+IF/SW2bBwaEzMPz1p7KR+YUAhGTkvxxeMNF+awmsUxOwYCQHqsob47D0nMgbULN58Y1tyFZrQ==
X-Received: by 2002:a05:6214:dcc:b0:707:1654:cf90 with SMTP id 6a1803df08f44-707204b8fb9mr198625856d6.2.1753766503088;
        Mon, 28 Jul 2025 22:21:43 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7075e3208d1sm1260226d6.72.2025.07.28.22.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:21:42 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	tj@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] block: don't call rq_qos_ops->done_bio if the bio isn't  tracked
Date: Mon, 28 Jul 2025 22:09:01 -0700
Message-Id: <20250729050901.98518-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit a647a524a46736786c95cdb553a070322ca096e3 ]

rq_qos framework is only applied on request based driver, so:

1) rq_qos_done_bio() needn't to be called for bio based driver

2) rq_qos_done_bio() needn't to be called for bio which isn't tracked,
such as bios ended from error handling code.

Especially in bio_endio():

1) request queue is referred via bio->bi_bdev->bd_disk->queue, which
may be gone since request queue refcount may not be held in above two
cases

2) q->rq_qos may be freed in blk_cleanup_queue() when calling into
__rq_qos_done_bio()

Fix the potential kernel panic by not calling rq_qos_ops->done_bio if
the bio isn't tracked. This way is safe because both ioc_rqos_done_bio()
and blkcg_iolatency_done_bio() are nop if the bio isn't tracked.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Cc: tj@kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20210924110704.1541818-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 88a09c31095f..7851f54edc76 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1430,7 +1430,7 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
-	if (bio->bi_disk)
+	if (bio->bi_disk && bio_flagged(bio, BIO_TRACKED))
 		rq_qos_done_bio(bio->bi_disk->queue, bio);
 
 	/*
-- 
2.40.4

