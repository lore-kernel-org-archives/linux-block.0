Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D1039903E
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475201; cv=none; b=rik+hEkuLIpxzb5pxg84I7OAmUSpjqEhjZFK8n1TW8YgJK9UeilG5E8xO8NqCg99S8qDlYsdR8LJ7N/fVP0vhLFt+0vrlvGrxWeMJCI3mVh4H6E2GtIOYXjRzzd2MVZyNhKI3JS7UfC/wP6t1AxSB62rIJKAqg9Mfq77kI9GVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475201; c=relaxed/simple;
	bh=CTPlISUjl8/ry1w3Uk6t1yxleFLUFPSqTCRCspfBcdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkTXSZuxChhGQDUDNa07Z5tkxqTYu5osVEy+nh/n1LQCDgNhBjAC/8Ld+YmUYtAMSAJNLaD1ChAXDyPcun1Pm3L88oA1dD9I4Ox7kIjIg9WWqHj/h8Pn7YmdddbGpR+oYW09PgswKhIy1UwoUDlCzkDJ7eAt6H47sOw4aZ4dbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3ZRGZqLC; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3ZRGZqLC"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0q31rfNzlfvpM;
	Wed, 25 Mar 2026 21:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475191; x=1777067192; bh=cUY8Z
	IZUnT7TvUjXRYM0ul8QBL8x1VmxdKcS0szvdEM=; b=3ZRGZqLCgu8wY0OYMWMV1
	kKqeBf1qV/JqlF/AaVzZaIjVYJTFYWj0QhMLmV/d3yvU3s5kOY9y4K8k74bFkYfR
	lhfzpK7MprWwQnd0DArA/y39C5WTCln1mLc/3srtNCZO9bZ6PpM+9TSu/8MMRiod
	9Ai+5wbxPl8vRmN+6qBNNSZUbyuOs9hHBPuA1XFGXupdzl8s4MZU52StvHznjYSI
	1gG1fMA7VyR8rRY3n5PhqzW1vmGRk3l2i6R3qcNF/5K6ENkYvk8ar/5u9XPGbPTz
	raztQV80o9dW4HfsBOpy7mUmjaq1bFE1fo4wCOQ76yMQkks5ZwaxEc1682wWPSMu
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2PWy_-xpe4AW; Wed, 25 Mar 2026 21:46:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pr5n8QzlgyGs;
	Wed, 25 Mar 2026 21:46:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 23/26] xen-blkback: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:45:04 -0700
Message-ID: <20260325214518.2854494-24-bvanassche@acm.org>
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
