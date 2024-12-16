Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD01DDA33
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382994; cv=none; b=aUYucIqgE32iLeNUU0EImLsF8J7jlWxWA4Hfem87TQM5yheHN6NLC6VdnQBSnfpqyLFF9uLbUj4SeKPbYAB2UGrP6+mWqM6vdhnmJTZsjkqk0DFLBOxuAmvHkFaIAY5SxZNs4eUBHrl+ZjGRTEzSflp/fieZhsswGNih4CbQtUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382994; c=relaxed/simple;
	bh=LNKloMuydOZ6vdKyiJ/L3WMJa3QVlxqMTyb5lpAXZcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqLXhShXGMhx8bd8/bxlbXRiDWPoDXtBmT/KBVkwe0I3Ga2HgVmbd1dH1RIaO4fHOHHpVx4Wjj72Q4MGeAi1lWnagPiWGD57bvfpOHOtfVaJGiNFqgE5qtMvnjpdMjig3FhMM9SsuceMUQsUZDSU4YgIdWAxu+41xYE+/Oc2axs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dNfjBy8w; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dNfjBy8w"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsq36qGQz6ClL9C;
	Mon, 16 Dec 2024 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734382989; x=1736974990; bh=ENQil
	eXtI/V01YPDsiwCqc+qezZbrvAB3Bg1UdX9Tew=; b=dNfjBy8weVBFkpCiWbvcT
	6jpkTwsf1f4QztdTTOuFLbrnb8wV1GJZFQZ8H6A7FfNQIm/VMIGTihvH/AAUw4PF
	ZGcaQWtB05KDMKgT9ukwuOb3PkMbXXKfwmnU0HUOGtdX+B8Vu+8p1YVbV7YbXAXH
	iv2uk8RWS8+2EvgEWfyxrg4IHS5FYRLvmRztPZhJZAU2JbMCZSaxnRIlfK3h3Gyw
	Ey+u7lc1b+oQOanno94AGOd3MfrhgqnQ47aNs4iepC9PrJ1Y+v/K8VNthXSlZHWD
	Nr/UxMD/jOeZGg1e/er9YdQjqHcmw2ZXlhqDMGTIBZz3vvWi5i15jgtQpDsWUKYx
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z3ThdsurqFSF; Mon, 16 Dec 2024 21:03:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBspz02j2z6ClL93;
	Mon, 16 Dec 2024 21:03:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/6] blk-zoned: Minimize #include directives
Date: Mon, 16 Dec 2024 13:02:39 -0800
Message-ID: <20241216210244.2687662-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241216210244.2687662-1-bvanassche@acm.org>
References: <20241216210244.2687662-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only include those header files that are necessary.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 84da1eadff64..1575b887fa38 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -11,12 +11,8 @@
  */
=20
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/mm.h>
-#include <linux/vmalloc.h>
-#include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 #include <linux/refcount.h>
 #include <linux/mempool.h>
