Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A945975
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607847; cv=none; b=J+AgoIwLF2XZlr4SzpQnCGzrqWxqHhyxaxKsCYzSEby5an3wC1Puku8OHXMqjpojK+VuLcB5x2Ba3nqiBeGKBfN5wf0EyVkxTBIDliL8rKATUwBOwfCDnjPoTyIm4rkicIV31938TdR+pck4SBGEjhJ8KE4Gpo0vlktcdjJqT9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607847; c=relaxed/simple;
	bh=uWnndMichTYq8W6B4vN6SIKZ/TA0mBcuRU76O/+uMkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewc31ho67ySS5MH8xa83MT5Rd+htPoph3oCai7zBVDqrx6XfsT7ytubZQpxI9m+7o0QcenWzcsphT0tcjWxw9eL7U2MB1DDTkrdQVTMa1UWtI9M0ANhOC5qH/+CxPW65LsJaBRtRB3t8JuCvUVds4B9AseM8mKtrx3h888MnaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb49yNKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb49yNKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18728C43390;
	Thu, 22 Feb 2024 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708607846;
	bh=uWnndMichTYq8W6B4vN6SIKZ/TA0mBcuRU76O/+uMkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qb49yNKMWqKJ7s+Vj+IwF63S09hVjQYm0f7e/mpihFY393eBrkYf8ooam1aq1Wa/q
	 1fX693B3KsMkGmYf2Qil42QOx0r07p4/zmaPrqb4Y5345vSQp4l4TgLgphQXJG2OjR
	 JvrJqNa1BrEPVsv5k8DLnhy6yxVTPT7vi7PMTY5mi8vhm7G42X/Qna6btcnWHXHQMH
	 BK69kpnKr4vpGUObz8Oo8gr2tCEA2NWQgjLfXK0yF3xP0shnOkx//SZpX+lavL6sEV
	 Qr7N033Ef2Sq1mknVHuwvrVe1ToV0NZtDtqbayYB8YvyeP7VeqobquMAa1aXSuAPd0
	 0QyerMjoef81g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] block: Clear zone limits for a non-zoned stacked queue
Date: Thu, 22 Feb 2024 22:17:23 +0900
Message-ID: <20240222131724.1803520-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device mapper may create a non-zoned mapped device out of a zoned device
(e.g., the dm-zoned target). In such case, some queue limit such as the
max_zone_append_sectors and zone_write_granularity endup being non zero
values for a block device that is not zoned. Avoid this by clearing
these limits in blk_stack_limits() when the stacked zoned limit is
false.

Fixes: 3093a479727b ("block: inherit the zoned characteristics in blk_stack_limits")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-settings.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 06ea91e51b8b..5adadce08408 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -689,6 +689,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->zone_write_granularity = max(t->zone_write_granularity,
 					b->zone_write_granularity);
 	t->zoned = max(t->zoned, b->zoned);
+	if (!t->zoned) {
+		t->zone_write_granularity = 0;
+		t->max_zone_append_sectors = 0;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(blk_stack_limits);
-- 
2.43.2

