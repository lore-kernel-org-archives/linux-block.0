Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F83793B7
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883406; cv=none; b=RrcwmEBCGkjO11mlFaHd0X6bBAANGqfSPXLvrJmadkIWTsbmtlszLrqpj+Dzh587TZp/ugarIaWZ1UeJLXXjTu2OPNZC+U185TAogFwGLXcVQ84QvREW7HL6BgJ9dfvXkPQMgW0KVfp5k4PCyWjNjvEykxUwhO7LB9WOWbqfHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883406; c=relaxed/simple;
	bh=RmTxviYeFD+kxaP37UaKhNpja7wr7nUMBYTDoejJfWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Caf2ma7lUjsLjtctxyBis4BVMgG6xZ5z0RbcTMIUkJd3xW9xQHexVzJF1+yK+MkYO5iTSA/P+fXb5VFuUuoLBNhOgq2AZ4aB73L56hYFLifXgSm+iPvbqlRb2OcfXKRM1vaW7NDlu2A7ATU/yyjPu+O79EGaspMcXiZuYI1csJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LAzn4S/o; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LAzn4S/o"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZJr4nV1zlfgPv;
	Mon, 23 Feb 2026 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883403; x=1774475404; bh=AZ3sG
	Qj4YIz4DJk6WdxfGfC5ktdFyZ0XPqv+VnHtmLU=; b=LAzn4S/oqisT56ZlKWpGG
	kfDj3F6v85lEoeXerNV76xQnUNJYfTpvvzhv0lf5y964PqU75HEN36gPe3BwqOCH
	Pp8W0OFZBOvk0aNUFEh1epLJxU3M9OKk4KB6MxchfxHpflBciwJIS9bboo9/uq+l
	e6W60VkEqHvpMf6W0hy6kx1PpYCNKbfqsXjquMYVsaqvuknq0WZfEr9aE9zBssA7
	cM/f4/pXyTcN6QhS+5e1O1fJrHrL0kHUnBuHrx84NTZCDNPHkSIjx1Gv2JhuD77g
	yRD64Gi4CW/tdnIJfxW8DhMHnyb9rX3bzncJEAiXTr4WEJoB1MpxmY9DX6SmAn5Z
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N6jmErEjZGm9; Mon, 23 Feb 2026 21:50:03 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZJp09Bhzlfl7s;
	Mon, 23 Feb 2026 21:50:01 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org
Subject: [PATCH 02/62] blk-ioc: Prepare for enabling thread-safety analysis
Date: Mon, 23 Feb 2026 13:48:50 -0800
Message-ID: <20260223214950.2153735-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Clang thread-safety analyzer does not support testing return values
with "< 0". Hence change the "< 0" test into "!=3D 0". This is fine since
the radix_tree_maybe_preload() return value is <=3D 0.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..0bf78aebc887 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -364,7 +364,7 @@ static struct io_cq *ioc_create_icq(struct request_qu=
eue *q)
 	if (!icq)
 		return NULL;
=20
-	if (radix_tree_maybe_preload(GFP_ATOMIC) < 0) {
+	if (radix_tree_maybe_preload(GFP_ATOMIC) !=3D 0) {
 		kmem_cache_free(et->icq_cache, icq);
 		return NULL;
 	}
