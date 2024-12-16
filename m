Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F41DDA31
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382991; cv=none; b=F4HrtR4cFbxyHRjZZYFgSec/dY7d51oH3KiE/E6ZjDIxcc3tRPj7WOS/qKXpvdc3jeJ2/RQcixga+caX+4t3/R0mWizKqQ7R9aHI2CQ/WOAdvUCtgSd3IKQhG4G8lVhv37tX7GNWOuiVFuzKHL2vcGfqRHzFjcYQT39xuMuPK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382991; c=relaxed/simple;
	bh=OwYGdLFUonBanDIx/aewJFj5Mvv5oBl9cCL+gLWu4XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFEG4yQC/4/DeI81s0eWAEtlts11iqluu48z2z646pOFBszsuLN4fQtFyH1/8W3RyOgx0KK8JsMSdonuqZrBx72Yy2eXwPPm30ApbXlrBOYYQWIEs0VwG0uwrXneqrSHFatClkv7GIvwp4wfi8ailNMCnMVKlgA7r4qjRVH00w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3c3eAN1A; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3c3eAN1A"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsq05lvvz6ClL9C;
	Mon, 16 Dec 2024 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1734382986; x=1736974987; bh=WYSOlgzuD9MM6UKRicdMilQFciqr1FqXfIz
	VVUMFrCc=; b=3c3eAN1A62dZw4JCmYZD8zYr+/r+GqZNfYbJ7ul+lr3HFqCOvFZ
	Z8mARP4NwJjIvPp7yOwE1j6JM6O1UiABXCk1O5E9cHcv0pp/Rfjrg5y4gkfDqgql
	Omfrp8epMhfE0ZT3CR16vSFMUW7nxzpYdxvZTmm3auV5l2W1UXUBlSbQ5Xh/Rzly
	uBrJrMXB3NNioRQCxi0Ukz3sw6oalThOwT/YvsP0OZ5sUwhHu81MsdpAz8UshYqI
	8nU2yY1FjVO0oF76hMCCJ+ps5QypN9scPBywHroVgkOl4O/nyBbdDKQhAqIoczYI
	wBfKKFa0E1ql4IYx9ms/d4jpNUkzBRx/wJA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YUXCnFlFmvHu; Mon, 16 Dec 2024 21:03:06 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBspw2ZsDz6ClL92;
	Mon, 16 Dec 2024 21:03:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/6] Minor improvements for the zoned block storage code
Date: Mon, 16 Dec 2024 13:02:38 -0800
Message-ID: <20241216210244.2687662-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series includes several minor improvements for the zoned block
storage code. None of these patches changes the behavior of that code.

Please consider these patches for the next merge window.

Thanks,

Bart.

Bart Van Assche (6):
  blk-zoned: Minimize #include directives
  blk-zoned: Document the locking order
  blk-zoned: Document locking assumptions
  blk-zoned: Improve the queue reference count strategy documentation
  blk-zoned: Uninline functions that are not in the hot path
  blk-zoned: Split queue_zone_wplugs_show()

 block/blk-zoned.c | 67 +++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

