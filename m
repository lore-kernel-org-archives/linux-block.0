Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C22E6CB8
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997599; cv=none; b=mDqUhXIKIIM51iOVuu+4Kg/Ewl2QJJeKkkjt3qxz5a2KampQxwfBkzEHaXZppGrENJHP7GCGqQ58TzvtfmFfeE5NYPmjDn0xFy8dOO3jhHtWzPKaaXawn99gMn3FMn9npBAHj0ct+R/o1YY49nnGiWl+bVqV7KpjL9/NwtpWroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997599; c=relaxed/simple;
	bh=k7L4UigFG9RtH8rF3fSiua0sdY9POVY5hNPSfcW3jsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfA8G0GtW45zBhpL1TeRTrAV3Wt3HtUTV6ORsathWjLNvY+Zm0m/sH2T11KoszF2zJY0yFgLguC9Ee2pGUlNSyqlFwI57T3QcGztUhMDdAjj5OutlPdQMdlkFPXfghWEJo+2Fn55c+SQlOqgRPHkeIiYjFxurP5g8PX0czqq0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NnNNe7D3; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NnNNe7D3"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH714h7Dz1XM5kW;
	Thu, 28 May 2026 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997594; x=1782589595; bh=6NbH4
	rNgGbE+WQFo+E01o3eAWSCIvVjj2EdAsH8xE2o=; b=NnNNe7D3/t1NHVNu1/FeB
	Cz1EFV93baoKO5vOl8sMoIyvc5h269EywGP9yG6V63c4Ca6UJyOpU42YZNdWTnGQ
	34KEeulHZKSv49sD5csE6poR+wdwycAsh83qii9rxR8eW6awcZTWoCZ834UDzJFE
	k709t+ch3Zatzon1SNUdD5r72BXY/kGRmQv18XIcYiPG2Qnqcso1+P47j68GDYYt
	du6j0nDpYiOp+XlW1zuT1cj6daoPZcMYyupV5+pCRIiTwQ3P6FcA7Y+rdte3jaT4
	AIlWH+oxWsUfUfuJieqIT7XI5j2zWex2C8+ase9AEv2r3C256VssWHM0OMZ6TmB5
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BJzb3osc59K7; Thu, 28 May 2026 19:46:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6x27JGz1XM0pZ;
	Thu, 28 May 2026 19:46:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 12/12] block: Enable lock context analysis
Date: Thu, 28 May 2026 12:45:49 -0700
Message-ID: <e4d44af70627b83fedadd9501609a2eec5d21ec3.1779997063.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1779997063.git.bvanassche@acm.org>
References: <cover.1779997063.git.bvanassche@acm.org>
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
