Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72783208CA
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469425; cv=none; b=ctHUB/9ZG0O6nDdF17QdkcfTEsxRBSIoCziCdgZn0aZi/Scz3gZIwhfDJ6aNuuyohqqotti9QF4UMLtjck/Yi1g8R2DKL6EMkVjqDLTIBApPvcADmMfrOGYPKgHUNd23LPK52d22Uh0QvLfMxmT0HOwQp5sAhn8KvoJ66R35qP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469425; c=relaxed/simple;
	bh=b6XxMoqKPRqzA41Ihhuy4iSUUqw7rjt1XG3TB7PIE6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4fYI60aMxNU9qfJGZZ8rv/TI1065AuRvH9N4BSje4oSC8MbGbin45rE7rq0zXPQIMBlYKwDXQWsLIUUpu6P/C7pAY/toyCtffsLYNOg+AiNA0EimPu7dD8praqI94Y6DBOJAsF+G9knW/zN6K/UGCnPzWXz3s9mGJ5Xyc2IdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dH+M+e7l; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dH+M+e7l"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCTnB5R0Bzlff0R;
	Tue, 17 Dec 2024 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734469420; x=1737061421; bh=23bQf
	w34nixb5IIDjji7jV9sgJ/RP3Oy+qWdQwnjyGc=; b=dH+M+e7lrMYZxaN3qxYPo
	+kouhwYkiEZnFItZjL07sz8ksImAcx+I82qLiUPQhWhA8bbycyhoLTJVh3aOl4M3
	LB0RVorIUKvOU8NPPz7FVLgaxR3XwVU1YeepVAwG/fD5a/4ZhEbZ3lJIRL4m14bG
	kyl5Sih9kjdq5J//ysv+upQW1o9gPJ2HTMNnrmTpaYm/XRYXflYntWttxYz10xtt
	cNQq6LE5Ojc3jOchukwvvXe5c8STy4BkXxXLd1EwSULV7znAOI+ZF92iCxCZt4gE
	C2Ud9hJ16I0GVaXkO+tw7urWMr3VxRgtC03FvcFa8+d5GkF4jsq+jFHWlCjQ0lK6
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GKwTLJ0JXGr4; Tue, 17 Dec 2024 21:03:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCTn65xMXzlff0H;
	Tue, 17 Dec 2024 21:03:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/4] blk-zoned: Minimize #include directives
Date: Tue, 17 Dec 2024 13:03:07 -0800
Message-ID: <20241217210310.645966-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241217210310.645966-1-bvanassche@acm.org>
References: <20241217210310.645966-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only include those header files that are necessary.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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
