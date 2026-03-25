Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB4396573
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475206; cv=none; b=sK1C+Q1Ou0M8rTqrh0Vy0IQa4MJ5mhHXOGpVImeFakeZTZLg1i1vrqJyoASbF2X0ktiVG6Aw62YPjvoSvNarpz0Va+ilqaqNK0l6jWv+uHuX46fW4S4e7GOQ4HKV4l4l5rI9Y+3K7NXtA9jqcAkFzhTh/YLmMiBUReEK1nkRAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475206; c=relaxed/simple;
	bh=x4yv8ewAfsPIlD3fTsfU4A7rKB0T5S5oXLA/EJSHyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXPibR6JoLyXnlpjq9sc7hdCdB8umPKtCtVe7ku9b6RryhGbnyY56tGHI+eMyajQqctYpQA6Iy0KITPji6IieV/10JayKizFWxWB5exkFM7YhgXBFQ7nh/0jfLGxqU5XHE0NQhit8LPfJ4X0Scam/1EgcTWpezYgKcvjgiLZmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=l9oR84Lg; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="l9oR84Lg"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0q76ZshzlfdGT;
	Wed, 25 Mar 2026 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475197; x=1777067198; bh=x4yv8
	ewAfsPIlD3fTsfU4A7rKB0T5S5oXLA/EJSHyR0=; b=l9oR84LgWrtKf0nh++WNU
	zq94PK6lV78/6h1QIHmPxQgUXxmD9W+kzZAkxnHTxRHspYutrihE9MfGh6nQ5g0F
	t5k8BtvCVIkzPP4qwAvt91g99Wpsj7h7370zP/N0Ie6V6bPY637xI9DhFoi95rvZ
	goBQgmA3xAAuGGaQ9fz7nefqG9SylzU92EzN1+0JZYXqrM3ZkxF98qh6RkTgzFcl
	kjcjiwoZb9dBa8QjaSCiJksAXu8bo81lx/rcNicGJBrUKzi0EDBAjMPu7vuTmuH2
	cNvavuNVCGDSdQzssYnlMgLyTW03Ze5Y0ccywBntcQMsmogGCcwSVOclhYNHgHgY
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fkQRj6nIpTTp; Wed, 25 Mar 2026 21:46:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pz0yxPzlgyGm;
	Wed, 25 Mar 2026 21:46:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 25/26] rnbd: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:45:06 -0700
Message-ID: <20260325214518.2854494-26-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let Clang verify lock and unlock calls. Enable lock context analysis in t=
he
Makefile.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
index 208e5f865497..42c2cccdb53d 100644
--- a/drivers/block/rnbd/Makefile
+++ b/drivers/block/rnbd/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
+CONTEXT_ANALYSIS :=3D y
+
 ccflags-y :=3D -I$(srctree)/drivers/infiniband/ulp/rtrs
=20
 rnbd-client-y :=3D rnbd-clt.o \
