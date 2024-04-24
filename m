Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3A15DBA3
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966459; cv=none; b=DX0A0FKm0PcQcopmuhUvhLLH9oKGZaTUl+/C5eo7oOArTtCYXMWHrmwvuctRSWnWKfrlprLlMBouyxR/gogWUWDfrYEzrWkR3NGa+IRw3zikyKORNVK7bbZl4ROJTEctAnpKNmFhaHl5n/igUt8ErLLH+df3fD9rBid3xerKoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966459; c=relaxed/simple;
	bh=7o+nnc7MxGMd1vDsvNmkcTY18ToPfVmmXKgbEkoiF04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxNBRndEKyOTnncdJ5vAiDqHdklrrjBhEcoZ4V+yDUkYLycvqWm/AZMCT+g2k0uEI7jMX40fS2TA0UrF16iP4nP4RAV5UDwW0lj9PDEgHOdhJt6CxcD8yLyBq0QjUQFf7H9++4e0lBuvgYi1s6Hws29VVBS5T2rL3lxsTqO8e80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cM4/+uc9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM4/+uc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KxPeyvpPnd0Z+Xnr2zjKgwwBQbSW39RkQQi8ZSeGLQs=;
	b=cM4/+uc9TtYJ9A9izOQUUPr+LBqzraGwKdOgeLWrMiS4icGr9s5zKQo6M3UuOu9Lgv0TBd
	WHHSkmg8NXTFlySMGIOnaXEgoFQH8CcdSgLkS4Ya7kROUgsPzD0WX6tMsOXfxuvq9fLO2S
	aN18R0Ar18hCXpG18OcsNkt4aaXYKs4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-tFR6Pg2mPPyLwsmXkkNlww-1; Wed, 24 Apr 2024 09:47:33 -0400
X-MC-Unique: tFR6Pg2mPPyLwsmXkkNlww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39862834FBB;
	Wed, 24 Apr 2024 13:47:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.70])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C37DD1121312;
	Wed, 24 Apr 2024 13:47:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] block: set default max segment size in case of virt_boundary
Date: Wed, 24 Apr 2024 21:47:22 +0800
Message-ID: <20240424134722.2584284-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

For devices with virt_boundary limit, the driver may provide zero max
segment size, we have to set it as UINT_MAX at default. Otherwise, it
may cause warning in driver when handling sglist.

Fix it by setting default max segment size as UINT_MAX.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@kernel.org>
Fixes: b561ea56a264 ("block: allow device to have both virt_boundary_mask and max segment size")
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/linux-block/7e38b67c-9372-a42d-41eb-abdce33d3372@linux-m68k.org/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d2731843f2fc..9d6033e01f2e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -188,7 +188,10 @@ static int blk_validate_limits(struct queue_limits *lim)
 	 * bvec and lower layer bio splitting is supposed to handle the two
 	 * correctly.
 	 */
-	if (!lim->virt_boundary_mask) {
+	if (lim->virt_boundary_mask) {
+		if (!lim->max_segment_size)
+			lim->max_segment_size = UINT_MAX;
+	} else {
 		/*
 		 * The maximum segment size has an odd historic 64k default that
 		 * drivers probably should override.  Just like the I/O size we
-- 
2.42.0

