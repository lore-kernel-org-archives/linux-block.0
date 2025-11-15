Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502429CB4C
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209200; cv=none; b=ZgVnVMgwqe1i0FCnxK52pubVo0ejazQ3XYls8v5Ztzfoj2XTe2+pj9up75xIYXa/6yJjngyUXon+raG/acBllfiLIfFh62Kdt5HNq+ufY+76CJ+VPHWfYNSRMpTs2qQg5cc+M5R8uicb2VW7OTRmeMFNnvu52L08fLq3d2vRHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209200; c=relaxed/simple;
	bh=LIFeb1rjjjhb85UYE14aIpsl7hUuCifvgZ3pXhid8Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb1Qjd7nShsOc3X9ppT/6PV3rnFdqORdSW3KLTKeDY3jJ65JnZWnWiPC6sdG+GQ7T9QR7vzMB6dyGJ/AwP47uMsJmIN/0VkKRG6rx1XzdR/r7K7CKY7mJ7hs5eCwcxsdNDaDuHOV4QvQw1u5IvaNVXknIUAb+GJfQnVYx1mZcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giZamhAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giZamhAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B9FC16AAE;
	Sat, 15 Nov 2025 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209200;
	bh=LIFeb1rjjjhb85UYE14aIpsl7hUuCifvgZ3pXhid8Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giZamhATJhK6kouvsMNHFizgQRHQyrAZ0iEnmyYgdxUCRUW5cTeOHFSOwDr362wcq
	 dkBfWNDX8WJFEzHjzRggQhyNE+z5ZpXjt7HsqR2aEsVJKrWQkT0hpOiwim0a2nS+dS
	 +y8pBtTDOqtgqoXK2xvTl1/ZCL6UChw++DJfrcjmq7Asq4WQQlIKFihykw5O3B5RSI
	 90L4jZymT0lu/ti5ZizphyAqCL6SZP69heyLzhzG2QtyWpYQowWbTc7xNQC7sOV0ZM
	 SR/xnW/nO7zdhdIxsAkJsnPxXlyxqNBQFgyO2MZzVT+hH7aQaGvGjeQWKe4chywUjp
	 z7KOyBBT/sQwA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/6] zloop: fail zone append operations that are targeting full zones
Date: Sat, 15 Nov 2025 21:15:52 +0900
Message-ID: <20251115121556.196104-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115121556.196104-1-dlemoal@kernel.org>
References: <20251115121556.196104-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zloop_rw() will fail any regular write operation that targets a full
sequential zone. The check for this is indirect and achieved by checking
the write pointer alignment of the write operation. But this check is
ineffective for zone append operations since these are alwasy
automatically directed at a zone write pointer.

Prevent zone append operations from being executed in a full zone with
an explicit check of the zone condition.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/zloop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index a975b1d07f1c..266d233776ad 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -407,6 +407,10 @@ static void zloop_rw(struct zloop_cmd *cmd)
 		mutex_lock(&zone->lock);
 
 		if (is_append) {
+			if (zone->cond == BLK_ZONE_COND_FULL) {
+				ret = -EIO;
+				goto unlock;
+			}
 			sector = zone->wp;
 			cmd->sector = sector;
 		}
-- 
2.51.1

