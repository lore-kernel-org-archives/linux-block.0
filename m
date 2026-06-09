Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2A24BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042816; cv=none; b=aT428FiJcvGXBDioMKcT//MMFsO3NrhCJ0B0sfJEEBEqXizbTv8UQBuJMV3GGnEmXHawl8ixnco0cWZN3z3SBaRwNDzmMG9JmZsqYUN3ShruyixuDFMxd7ReGDaNwpQ/oQLRHnmjmfchvr9UfWYclnqoVHNe8kqScYnIk2NdTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042816; c=relaxed/simple;
	bh=Sho3G6p14OiZXucBOIa63pRHpyIejlHTxyH4aqKmnIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hwizfhm1lV5DE9Z6D7fwdAIiboVpEeJoKAh7X6E9zS9p7XkZB5lwL8etxq58vY+7jru0jw/5r7OSWtIboz2L4mPu2lW7Zt+YcFYjM2PS3/smR/3wvOIQRrLy+CXc2Z3y/nrFAphmoMMuX7Nrh2iARXui2hxmFKoi3N2F4BJ0qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=O3KQNQP4; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="O3KQNQP4"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjgM05bCzlgyGq;
	Tue,  9 Jun 2026 22:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1781042811; x=
	1783634812; bh=9Iq/eMeGA4Sd3ABTqAdypSK1i076JU7WUv8jbEThQa8=; b=O
	3KQNQP45vsvTUh/v7hV2ay8ENlath81ac+xKbhwo7var68EMTWBg1HznNKY6OLZO
	r29IELTSJMhdpjdNAiQUk7yUx9ahY7+/xq/o6QMeZvWALV7ABTT8zBbRYg2X3AdO
	6JscMQ1nwXLKXfJg7RP1klRvBx4HfbPxHxZmNhKdIDucb8qzZZXy8z3UDZpz6Sl5
	uIb5ZHPNcz9VG9AbjzIWN/wuMuVZtRgPGUPfp2j1UxFhvw8Ajb9MMB3jchayxSQ8
	sf/mMRaXZ1r4yZonnzgPTj1lA1bKzV8ydGTrgwLF9Tt2OGNEJmjBz8T5/5920bTh
	9l5+NiohIzGnZW7RlfAkw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h8EnIHn762_a; Tue,  9 Jun 2026 22:06:51 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjgF4DQdzlfddT;
	Tue,  9 Jun 2026 22:06:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 24/27] xen-blkback: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:11 -0700
Message-ID: <1d0c6b40ec040f4db5f996f9c0c88cf7bd683930.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
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
