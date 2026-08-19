Received: from www421.your-server.de (www421.your-server.de [78.46.152.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573F3A783F;
	Wed, 19 Aug 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.152.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161622; cv=none; b=mANB50qhHaCAoGQt0sKTAQir8KKsKeIXCF9FVK5dbLP5NxyE47eLSQjAP8qZ2l2jIdUj2b7BPp3pvkP3dM+6Ka6GMlZs3CW5ZHjdNUJo9d0Hvx6muh9i5SsOfym2hYhcYd1fzpyx7qOtPTn9QIrGpQczm3DqrLChqPNgSNyHPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161622; c=relaxed/simple;
	bh=G+GLxW31F0LNyPu8V3H6tTOrbxrdRcxP2ltJwmHOh9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ugg6C0u5ER5+s3DCVAY+BclLWdjQqOQ2SyxVb3U582T7tUdGrdBclncNVxRrFg7v2NlsonnL6MVWzATcYYxOfAlTDbxdPYjEFWNLENZ+aFKZO0zPP6SCoVm/wIHzV11nw03FMabC9CVPnvstRupT5I016BOMcFFPCYKP3AJE0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de; spf=pass smtp.mailfrom=jregg.de; dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b=ueBPGmaD; arc=none smtp.client-ip=78.46.152.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jregg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b="ueBPGmaD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jregg.de;
	s=default2602; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=35xN52EkELKnnM4R/kRRIszaIhIMDNArMarXzvvgvK4=; b=ueBPGmaD6tUYj/MVHmQidRtr/A
	4P3YOt1oIZkrEFuJbPgOgOJ8ZVNDhf8MvZv6iwL8DtXVZzCakhc9M0EsYijsbhKNQOUaWncd8YAaR
	oXzXUhmlDp6Yfruxd6whhVrAJjYah1v5vsETIEF89pAjOQn0QkbSWBrWkRSGAdjAyjKPnIvtktj9Q
	I9QGthExX008Hqql+xvj/43DOGzdwWcGMd4ldTO+SPL8hESLmlQLFnI8wPPft83/3G4pfwqHvrkFI
	kaBk4OxTb5P4qcWUr1dlufcg1xUNVsWtRq4qJKVs3G8kOBDRKHPTxuOW8797gRy5LB9hnK+qdabYI
	wiqjYp3Q==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www421.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mail@jregg.de>)
	id 1wwkNG-0000mp-0F;
	Wed, 19 Aug 2026 19:46:49 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mail@jregg.de>)
	id 1wwkNE-0000kS-36;
	Wed, 19 Aug 2026 19:46:49 +0200
From: Jenson Johnathon Reggentin <mail@jregg.de>
To: corbet@lwn.net
Cc: axboe@kernel.dk,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jenson Johnathon Reggentin <mail@jregg.de>
Subject: [PATCH] docs: block: fix dead http link in blk-mq.rst
Date: Wed, 19 Aug 2026 19:46:35 +0200
Message-ID: <20260819174635.37505-1-mail@jregg.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28097/Wed Aug 19 08:24:38 2026)

The current link http://kernel.dk/blk-mq.pdf leads to a 404 error page.
https://www.kernel.dk/blk-mq.pdf leads to the correct document.

Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
---
 Documentation/block/blk-mq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
index fc06761b6ea9..c2af39f14d6d 100644
--- a/Documentation/block/blk-mq.rst
+++ b/Documentation/block/blk-mq.rst
@@ -139,7 +139,7 @@ completed.
 Further reading
 ---------------
 
-- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
+- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://kernel.dk/blk-mq.pdf>`_
 
 - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
 
-- 
2.54.0

