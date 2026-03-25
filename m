Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F551396D0A
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474663; cv=none; b=juuZ5suYgWHLDWStabklgJTGjVagC/kXdETGRg6rWb8thiF1hAoOp5F4EP83pflD0Fe8khDzcQxEjwoUv+yfAVZctxslxXbuzuw5Hco+5OIXEQHaq3niDZuHzvMtg/ADgeJq8DwBxDj8425QqW8O8ntJpm3XUaGHdSZ2zJyhXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474663; c=relaxed/simple;
	bh=HGvjgd+7iW0kaqnwO2/TxrHdN/k0qYfR13Yfyi3ar6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQFN/RZd/VYd34eXG3oRMlVmzNj19kitPqlHNbwiyvF5Ol8WSgcQNVEFX3VFr4EGNdZOnULBUE3EujXi18xbBpf0wWzDvF9NZrTPtax+7lqu9R3H6201xFZUHI1PYRC1BeJO++Dd+u+x3a0CGtjz/me9uMpT37Y7AgI6m4qcB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yu8mMx/x; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yu8mMx/x"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0cb5rrCzlgy1v;
	Wed, 25 Mar 2026 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774474652; x=1777066653; bh=rmAfh
	XtbhQ4oawC7zstiRCaaSHG504dxHICFY3p4qHU=; b=yu8mMx/x7RKZIE7uM3WFG
	MOFWKSGnTPMuqB6lXTqqrojjXroZ19zygHteDjMojLresMP7eIpZwSSBiu0soKbz
	ZjJvFLxsk3y232IpJROS0hmH+0otdUeSajSvaSODF5JYt5meVDiQbhhoCGBbQYrK
	9geG7ztdlVhP4AnoXW1CqCba4Yy9vY91LUxsbusablphbLtHGxDSdmx6+EVJw96N
	47sHgsPpgpNSpxsZHAobEkTQXtrfo7YmZTKIhLNSHljuQoFJR2HUwmEgUeEtHLHi
	c89AomvJ1wQx73tLXhe6M/TW1CXEJpmUQPESliCsku+wrFbzTfcw0C5XMU1eARw/
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZIEqhj7PQuuD; Wed, 25 Mar 2026 21:37:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0cV4f22zlfgQJ;
	Wed, 25 Mar 2026 21:37:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/5] block: Fix a source code comment
Date: Wed, 25 Mar 2026 14:37:11 -0700
Message-ID: <20260325213719.2850619-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325213719.2850619-1-bvanassche@acm.org>
References: <20260325213719.2850619-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a source code comment that is no longer correct since commit
889c57066cee ("block: make segment size limit workable for > 4K
PAGE_SIZE").

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 78c83817b9d3..87724d30be4f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -470,8 +470,8 @@ int blk_validate_limits(struct queue_limits *lim)
 	} else {
 		/*
 		 * The maximum segment size has an odd historic 64k default that
-		 * drivers probably should override.  Just like the I/O size we
-		 * require drivers to at least handle a full page per segment.
+		 * drivers probably should override. The maximum DMA segment
+		 * size may be less than the virtual memory page size.
 		 */
 		if (!lim->max_segment_size)
 			lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
