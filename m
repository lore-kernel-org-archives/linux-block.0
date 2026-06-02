Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238A3DCDAB
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420131; cv=none; b=oW79E7O9KZKqiPtkqkbinsOdzUScSENyC2YBBgqOZjJeFmpal9mI2zMnNTVzC0pL1oftjvR31t0Xw01seWT9F2Xt9VM7cb84k9yjBDohv7a9jcEbQvD8txTgnzaJYZT/u1wtzOuzKsdKmXKIaRHvEQE7vvJEBH+XFgKfmCtCS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420131; c=relaxed/simple;
	bh=PbjejrNawT6IZ42K2OrPYLND8imh1omKlH1OmqI+iRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPLYF1/D4urA1QIeLi1J3xD8REBPEcPunvumyu7dxGzWAcMzXlXlFj4aUg0VqsK1EkAUqUYvexrim9qcgWG11MrSglPw75nceplG6f87vycEp5TwD9jIbBxLtQl1fGZjCSVLlL4pqifj+RaAO3DjygxWDadveXkay9YblhFMxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=V8IVjlVc; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="V8IVjlVc"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHNd2Jdhz1XM0nn;
	Tue,  2 Jun 2026 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420126; x=1783012127; bh=iLgo9
	8zo1ytdUf3y8is2IG9mUanjcWnswmRCuBZWQgc=; b=V8IVjlVcnR2nxenoINcmh
	T/Y0wffIZ+wBfzeD6nIK5leKl8lVbJl3kF+1wXXf2CA9nOsVtl9Lh8wfxHhAVILE
	BnPJbPaynKLtllavA6WSwZNknSc6X/ZuA4I3h7AieIL1CR7OmzTRr3itIDOcs8RB
	kKsx+5Ob2gzQR55cHwpZxVwXGY4Jhh/KnCwKBePln6QsKw0HdklOLdaVYPhZR5xx
	m+qH1s15e7+e4Z61I3//4/+1LhfVkkLWZPpBBqkSbwv5cB+imUvkVe2ZLt5GsQtZ
	kgHzRwWCjHlnrfY9MuMg+5qj1Ye37eFB2eZffJB1CkJYC3qJ3lOAT/WTOe1Ys886
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sv2VGIFGO7YA; Tue,  2 Jun 2026 17:08:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHNX3Mdqz1XM0p5;
	Tue,  2 Jun 2026 17:08:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6 14/14] block: Enable lock context analysis
Date: Tue,  2 Jun 2026 10:07:43 -0700
Message-ID: <b946525dda6465965149a238eb3e7464f887e388.1780419600.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
In-Reply-To: <cover.1780419600.git.bvanassche@acm.org>
References: <cover.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all block/*.c files have been annotated, enable lock context
analysis for all these source files.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
