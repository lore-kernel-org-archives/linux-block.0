Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E943C454E
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441581; cv=none; b=bjvGzwxTUbODZCZ6KiTNLj7XkQaaQAjy/XtL72DI+JjSqoH2DwqYEAoJ0qCZX6L4hMdFkRuIotcGcm/dka8RVIDPnJ26BNZICDIRELedJKRbgqpCV7tJGyRZszgYAMSr6qqSCmlr7ScUwHgazhTjOs9C+xue16QBjx4fiPaQP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441581; c=relaxed/simple;
	bh=Sho3G6p14OiZXucBOIa63pRHpyIejlHTxyH4aqKmnIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkrgE/bTCEg58I+m8cb4D2Uj3oBlizeOSiC5Y3jjPpaVe5ryGUjZVz66+e+cjRQW30RBcVdnHULD+x7KVr5uEVC+NNTod3my7+3ZfB/uIt5DTeU8i32Nb+wmog2WdxGGiyfRcTO5rF/pHQmuhHQ8rjE4IFAtt9YJTSKTg/ZrDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RAXMt23f; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RAXMt23f"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0Qt6WGMzlfpLt;
	Thu, 30 Jul 2026 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1785441570; x=
	1788033571; bh=9Iq/eMeGA4Sd3ABTqAdypSK1i076JU7WUv8jbEThQa8=; b=R
	AXMt23fviuZEumm7SAJrywNpaq7V+7+bPlKjRgwD7d8cJzn3fNSbUr9Utz4uo1X3
	VjhkMnDuyLEHn+cHqU925gfO3dbmJnIzcwNapTW+3G8IMHZVVVR9xoarPJKCiBlr
	G0HAswdlqp+phcv724Xa7A30p5LfSRQK9WxNhAEizNnipKbrCuOfmsuiExrXHmp3
	sWzmITJzoNjhEVnmEa1IOPHyR1CdNqwoR52fxeF8f76pnF/WT8c842vZynTmfSQx
	LaRNzlLzFjb1vpXCYXSlAZ2p60ja/jU+JZypWfYFG1JYsf1DWoqCaQx8HMQmCmv0
	LQAwiBk4RrKV9H44yxtKg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ib0FYhdV8Ya0; Thu, 30 Jul 2026 19:59:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Ql65FDzlfpPB;
	Thu, 30 Jul 2026 19:59:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 09/12] xen-blkback: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:32 -0700
Message-ID: <036d4bf0071a097d32f721dc1f1926da62d93b29.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Let Clang verify lock and unlock calls. Enable lock context analysis in t=
he
Makefile.

Acked-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/xen-blkback/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/xen-blkback/Makefile b/drivers/block/xen-blkba=
ck/Makefile
index b0ea5ab5b9a1..864ef423226c 100644
--- a/drivers/block/xen-blkback/Makefile
+++ b/drivers/block/xen-blkback/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_XEN_BLKDEV_BACKEND) :=3D xen-blkback.o
=20
 xen-blkback-y	:=3D blkback.o xenbus.o
