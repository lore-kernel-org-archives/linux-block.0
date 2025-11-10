Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E93043BE
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813831; cv=none; b=tbKy2aiYfCIKgC/V57jy2MvcLMSqolycUQ9dr0CErrH/foM1t46exTCEgIB67lHo3x1A9e1lMRSBRkgczy5/0HWIme0xp6PAeijSQIhVCm2DOJrAJc/yAzoZcjVoOqHXtMOZiPx5sS6F61gtNglkNLd4+iSALJykslKBFr41+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813831; c=relaxed/simple;
	bh=IxvjIw+Qhd3YNnhCvdPZgYYLNvKEdhbUuK3AgBWywWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLVsqiJjaha/cx0upcJ5m69eA/7RhVFWIKEhezKzBk65xe1ovqPY3WRbmrKDA8BsgZtLsyecqx1Qw6jNl2JHYkzRBrZhVL3cRGxGNwXL3KTpcjMiMDKvDwR9Kkei7A6GNZSxpL7Qkn2h+k61mumiE6S32L/DTAO2yIfOH931dRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xeFUk8/I; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xeFUk8/I"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d549w5h3XzltH96;
	Mon, 10 Nov 2025 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1762813827; x=1765405828; bh=7/jyi
	Uh47LI3iWKiTHiRvlrvFQBkTCLYQ5kSvNw0Sfg=; b=xeFUk8/IlMbkffAiHmfVD
	sj3P8vrM06eYXF8b87/rX665YqBcwnelRU/gk14xIe7ZpZ27Nr01QbMKGSULLtUq
	aem7s42kRjj3Ibpe1gkAKNMZuM4Vtw8LWvonniZ2miKrdkctIN5LQEC/8FK8Yvdx
	xBwGHQ/3XM6yAj6caZs6L9czSq4tijTKQqhpIv5aMwSrMUwpreKu0QWRIkBNMgAh
	xfMs/za8sqnCpgJBxBRQHfAWB/swUfkAMDLhrwvPg1bLV695G35BoebfgtZ0Mi8A
	buvirxfVBQ3CtYyQslCABc5LXK3ihpEbAe4kEfRwEXSoYrLNcPUP3ZsxjjQ3zKFG
	g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h-FQ25RLxZiG; Mon, 10 Nov 2025 22:30:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d549r4RhKzlgqjP;
	Mon, 10 Nov 2025 22:30:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 2/4] blk-zoned: Document disk_zone_wplug_schedule_bio_work() locking
Date: Mon, 10 Nov 2025 14:30:00 -0800
Message-ID: <20251110223003.2900613-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251110223003.2900613-1-bvanassche@acm.org>
References: <20251110223003.2900613-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document that all callers hold this lock because the code in
disk_zone_wplug_schedule_bio_work() depends on this.

Cc: Damien Le Moal <dlemoal@kernel.org>
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
