Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464D3B47F1
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698103; cv=none; b=oGsMGIrO6FM6tt3EQ603oUo0LlBIadYbX3Ud1QItTzoc/qpo1XMBzlMVuQe5hi/EjrvyqabVtXkWIA1JU/u6PV6maa4ShPbk8PbUyVjEvlVKjsVlzBu1TNMe3cyo29NsC2dw72ncGajkMLy/2eJZtPAhs78fdS/avekgH760zSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698103; c=relaxed/simple;
	bh=mJ9tvcXfVa1pMa0zT+towPPM94a7YZ0aB36t0A/lU08=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lt5cUlxlRXBv46/XrS35K+mBNYZGJGaGuBpAiKgVwgNocncFR9dcHqe8pgRjVdWxS/NBzCzZPkufA7VBoMEXRI//ffzXiixuh7O6VDQy7eP4md7bn/wtmJiKLu+oFLmj1PdC0Ry++lG/h3ttgTvSft9rcFrET38vtAYIekHNS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjnATNyn; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjnATNyn"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39d865b11b4so4956608a91.3
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790698101; x=1791302901; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iUFYZBBxsO9sVJ8mJtnVnz6Y+mSx3S7AjcZnY2SauxU=;
        b=JjnATNynrmTHNs9ZbqD9R1BsWh1U8i58FZO8VmsglZJwO7J3261fNMj0NCCgfb3kXB
         8X9N4urUrMUPv6ZaoSXwByKn9+PEw0MopwRFfYCAnXhCWy1wrI+G6nbmJdhvOMcWP6uz
         T5tAqu+IM9rR49cqLIrlf5W0eD1xhzflYbq49qffmGd9UU6grGzsVJhPCcCpRaSEchDq
         IXiMQomoqUJDpg3F1z6hrFcHPEyD6BIwBub0T4Z9AwK1Lj1QgZkos+jZdR2tyRDUIT/z
         4GII4wklx86P+1a412ktppu6Xvra4ieszcCKK5loFOZAZbAFuP3FRqmadPnizWxNiDBL
         ykoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698101; x=1791302901;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUFYZBBxsO9sVJ8mJtnVnz6Y+mSx3S7AjcZnY2SauxU=;
        b=1B1531noVG5Z5UB8i0qeZhcYHB+JxQVkNK7sJ57qtkO2mKsnB9px39ZN7jHl6R5mgl
         /lKZ01XlenAvNvWaPcE2mXOeZAUqZhTkx/2bZ3/Rsseoy7+954Rqx3wpGWeJjPOkZfe/
         Owrsc8GvZUz2RcaV5HHIHPUKzp+YATt/6gnlddARyEkq/rj7no8nMBCfHyJuRtYeXeoS
         GzGw3Q52DXT31ujlB9w8Wr/+Nq5CZf5F2PM0vNtcMiYitKRknz+XVTH7y8jNMKpDJfbJ
         DlREbXxICMkQhR1fF2AJ8NcjvlMWC+BkGCOJYfLIirifjnhd4UC4+z599bHlomeBIokO
         FZJg==
X-Forwarded-Encrypted: i=1; AKwUvByV2MBcw2lMjdCwhkpGKVUK/+nYUQFOmscttrp/JzyJkdg7mzg2114z2X0SXbgzIkTPy0QtvdabFXJ9JQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmp7epEueHOP2X2LRahlZcWP3zP61W9SWOITn6701gKM7atk93
	+php/Lq/4Qhyv4gO3hIe0eIXfCmqkBVAwF4HWu4oSNJ7PaErpS/0ibKz/UddCDP7Y2zYbzUjV69
	MZkeLPSWpND2wPQ==
X-Received: from pgbdp8.prod.google.com ([2002:a05:6a02:f08:b0:cc7:a092:edd9])
 (user=tadamsjr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b0f:b0:39e:4c80:f67f with SMTP id 98e67ed59e1d1-3a098983faemr14188233a91.30.1790698100830;
 Tue, 29 Sep 2026 09:08:20 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:08:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929160813.1599129-1-tadamsjr@google.com>
Subject: [PATCH] block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV
From: TJ Adams <tadamsjr@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Christian A . Ehrhardt" <lk@c--e.de>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

When a passthrough request uses transfer direction SG_DXFER_TO_FROM_DEV,
bio_copy_user_iov() sets up a temporary iterator iter2 with
data_source = ITER_SOURCE to copy user data into the bio pages before
execution.

bio_copy_from_iter(bio, &iter2) copies the data and advances iter2, but
the original iter is never advanced. Consequently, iov_iter_count(&i)
remains non-zero in the caller loop in blk_rq_map_user_iov():

	i = *iter;
	do {
		if (copy)
			ret = bio_copy_user_iov(rq, map_data, &i, gfp_mask);
...
	} while (iov_iter_count(&i));

Because i is never advanced, blk_rq_map_user_iov() loops indefinitely,
continually allocating bios and consuming map_data pages until it
exhausts pages and fails with -EINVAL.

Fix this by calling iov_iter_advance(iter, bio->bi_iter.bi_size) in the
map_data && map_data->from_user branch after bio_copy_from_iter().

Fixes: 13f3956eb568 ("block: Fix WARNING in _copy_from_iter")
Signed-off-by: Terrence Adams <tadamsjr@google.com>
Assisted-by: LLM
---
 block/blk-map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62..2685f6177ceb 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -236,6 +236,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 		ret = bio_copy_from_iter(bio, &iter2);
 		if (ret)
 			goto cleanup;
+		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	} else {
 		if (bmd->is_our_pages)
 			zero_fill_bio(bio);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

