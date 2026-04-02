Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248F3164AA
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155245; cv=none; b=GuglIH6eV60fpZmgN+qaG8e9BLmVyzBrQKIYMGF0OCwp0WbNQFWDqbP3zadORQxAzXM1PXCUGytTmNmhA5dnRiWh2zbcSfpB9i2MOOgGPaK6+jD776aXD7u+BMxIftxmFGGA2tOQzZHnKSu4YRhCF4j7+hwmxbp7YZ6G8V1nwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155245; c=relaxed/simple;
	bh=k7L4UigFG9RtH8rF3fSiua0sdY9POVY5hNPSfcW3jsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0wV8r5S1/X/Fn78cGhqjg4hkwRmrMQRHP7jT9BjREJPgtyFZtFY7/lksdW3xaA8VmHbwhxDP8OttpDG2JS4NtNYk1CsksYa7b4aM2f/6irNEqPeRDKUsMup2sHjjXRu4kzhdwfTZkruDE59iqql1eRhMcfmNzed1nvhe8TObzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2jdAS8Sl; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2jdAS8Sl"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJq0X1Zzlh2fy;
	Thu,  2 Apr 2026 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155240; x=1777747241; bh=6NbH4
	rNgGbE+WQFo+E01o3eAWSCIvVjj2EdAsH8xE2o=; b=2jdAS8SlImvKyRqj6Owdg
	ToM/+mzsBnt2iE7ohpcgHBMHSoZBXkrnppn+p+208a0pYspmJc3tmyHTVeTqMm2a
	OyyaAzKe4Qmoc9Q8VVaeeLFeMJEL3Njk0HXdTi0P9cX7KyocCjnRcEpAYXzDnuFi
	zrFywtB3gCoSGQNaf9XW/Hm+ThxZSsuF8TCSp5DcItCq/+uYYiVCKxQgMUuxBrkl
	2/mbD3tGLV3Iaj+7WE8Qdj8vOx8fTtw9wQvENA8WsSISWcJtwqdh//TUQgR9w2AO
	WuTkkaqHLbQv7MZtHjomd3BpqvJsfAemRZpkHMRQ9+sSkLpwWNG7pSs++xBvi0n9
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NOGpOBBBJyXH; Thu,  2 Apr 2026 18:40:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJk3SrHzlfvqC;
	Thu,  2 Apr 2026 18:40:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 12/12] block: Enable lock context analysis
Date: Thu,  2 Apr 2026 11:39:44 -0700
Message-ID: <20260402183950.3626956-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all block/*.c files have been annotated, enable lock context
analysis for all these source files.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c..54130faacc21 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the kernel block layer
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-y		:=3D bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-merge.o blk-timeout.o blk-lib.o blk-mq.o \
