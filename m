Received: from www421.your-server.de (www421.your-server.de [78.46.152.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1B1A9F97;
	Wed, 19 Aug 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.152.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787167475; cv=none; b=hK/mzaW2alJMYbkB/L9b6WsdClZ3Q8O9Xrq78TfOAaX7Mnw/aP7zCubJRQ6+rR3dpDZ6L83o9dIkrXhrcoX7s7Lj2Jkug2HkGWYxtO+9Q/oQ+PKXrs/U2LKWLxp8iHXNeyTccmhQgwKC3JZTJ9hKf3sRcfk/2SyXiOdzLDMuRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787167475; c=relaxed/simple;
	bh=LImpQICgxonlEMe+Jz1/4UvyllI4Wy77xpEWxm61FNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Suwpu9+A3nxTN3BBE4VjHM22WxXRxsj3G5KsP+DH60C59h/EBVqPzER/BmN43Kpo/ponLYoUHL4+qXmYEI0h/9uAOfwf3ZyaTmK49Y/V//mdAfzO3bS+c8/5aiqaP2E/bZV1hGpitZ2FZRSAGS7ghMmUSQVTQVc3t8rkKDssPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de; spf=pass smtp.mailfrom=jregg.de; dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b=lfrt951Z; arc=none smtp.client-ip=78.46.152.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jregg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jregg.de header.i=@jregg.de header.b="lfrt951Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jregg.de;
	s=default2602; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=V4VuIeEVI99B2s1Ynd2OgNz8ccOo/1HBJ01jSLDzVq8=; b=lfrt951ZMDiZW1ElkVambb2BIu
	J6slJ7kilDU81RQYTnP1b4pk+1M7uwsF3zP7nY1J/Eb7E4q4i04T13mrhVb63fqXlafSxy5ebXEJg
	Ht+shTrk7Ve4nbIbp/bEEp5YYim0N1XaexoutRY8DAwecR/f0PPWZ64N9ZGV9d4Ac6ck/2RpnFd+y
	ucMaFaRj8mKEbNT6xALdntJp3hno9gSWF0k3KMGeNuKWbgEN7o9Re+xjjWroL07BnrvCukhtQJ95d
	BbxpKtUZCdRVixCv1WRhbFU/yy9HEQX7RfeOMJEJUZjA+Udmy3asOGI36MV9n6fTJX78/dRHKZbT/
	NDrhZk1w==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www421.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mail@jregg.de>)
	id 1wwltn-0008eJ-2I;
	Wed, 19 Aug 2026 21:24:31 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mail@jregg.de>)
	id 1wwltm-000PqB-25;
	Wed, 19 Aug 2026 21:24:31 +0200
From: Jenson Johnathon Reggentin <mail@jregg.de>
To: corbet@lwn.net
Cc: axboe@kernel.dk,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jenson Johnathon Reggentin <mail@jregg.de>
Subject: [PATCH v2] docs: block: fix dead http link in blk-mq.rst
Date: Wed, 19 Aug 2026 21:23:59 +0200
Message-ID: <20260819192422.42189-1-mail@jregg.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819174635.37505-1-mail@jregg.de>
References: <20260819174635.37505-1-mail@jregg.de>
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

v2 to add the missing www. prefix in the actual file change.

Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
---
 Documentation/block/blk-mq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
index fc06761b6ea9..2798761efe0d 100644
--- a/Documentation/block/blk-mq.rst
+++ b/Documentation/block/blk-mq.rst
@@ -139,7 +139,7 @@ completed.
 Further reading
 ---------------
 
-- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
+- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <https://www.kernel.dk/blk-mq.pdf>`_
 
 - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
 
-- 
2.54.0

