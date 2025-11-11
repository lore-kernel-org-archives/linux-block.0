Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041582F39C5
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903770; cv=none; b=m2lVfaLlqoc52D2lihw/lP9LrGvl+Q62HdaEaQYojFICvG8ms8gszHoYAsDyPwzLFv8YtA6xhTTMEbCSFWNPJKzXD87ZKj8azC948ww+/aFTtbCJIpApO4MMDkmEHBULCYkqn1lbPnuu8vCS3WmntpdoT6kRvqCgP5jIqLSDZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903770; c=relaxed/simple;
	bh=mS6wigkQ+U6OXCvvldfQxi8FdkXq/nn2p1OjcwwPINU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwShz5pEkfY21x+beKQdBU1d+9hfC9En8d4WrLoDkKquoXdBCRbwY7w8IxfBpUz3q2p0joc8LMHwLF5dehKvJKN/2Pligu66k7qfT7HtwjxMOHksMiidhmPZMA7cRtUa/6fQ9hFw6R3bdPEdwlyGmmR1egoUi5gT3m/rtR4Qz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cDH6facS; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cDH6facS"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d5jRX0klqzltKNV;
	Tue, 11 Nov 2025 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1762903766; x=1765495767; bh=dzT4N
	1IhUtGwYn0VFk500z953Ex2t2XmzKLJiKJxzpw=; b=cDH6facSpc4NoY0clC9NU
	WFAYYcNXMK5G2znKFsor223c6/GlouatrWQG73MgTBN+5IbE8hJx1Nd8jS4G2DdZ
	uR0X3oY132JgroXuNJJHOJ65gVJvdtZiAiD3J6HnVuoPYyv+vD75+n5LAjvjzO04
	GOyn0Iud0kvAtsTl4aaP2jzN6nWzrDyAzOaeV2VXEjrS6uenj345R4ibUrbGn/wV
	mb5ZuRd4Zyaxq0AinyH7dVUNWqDRQK/jEAA9MvUEo/dpbWo9jov1qSGUTRITsv0E
	QT+XUwaNhRG0626NSF8+vXYF9KZ21VIfSxBEaiMJhRjUIM2oR3byb3NM9pd/WxEU
	w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bJo4XJ5_YOWT; Tue, 11 Nov 2025 23:29:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d5jRR1dH9zlgqyc;
	Tue, 11 Nov 2025 23:29:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v2 2/3] blk-zoned: Document disk_zone_wplug_schedule_bio_work() locking
Date: Tue, 11 Nov 2025 15:29:01 -0800
Message-ID: <20251111232903.953630-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251111232903.953630-1-bvanassche@acm.org>
References: <20251111232903.953630-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document that all callers hold this lock because the code in
disk_zone_wplug_schedule_bio_work() depends on this.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 57ab2b365c2d..5487d5eb2650 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1188,6 +1188,8 @@ void blk_zone_mgmt_bio_endio(struct bio *bio)
 static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
 					      struct blk_zone_wplug *zwplug)
 {
+	lockdep_assert_held(&zwplug->lock);
+
 	/*
 	 * Take a reference on the zone write plug and schedule the submission
 	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
