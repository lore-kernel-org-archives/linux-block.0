Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809F2D47F9
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927846; cv=none; b=K6uUOko/WO3XhbDoSHxoB79bsDLBqZkkHiuG2NXyBnWO4vOXRNL3oArO3c+OUoas+d+jnqIwpHSWi2Qf1dHnQR0TVNxEopqYK9RArsq+LiB/LLw9sfHpw2GsPIAis56srTGP0LivfgUKB1CV4ovQFJrKYrTXwBNcTd5m69JhAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927846; c=relaxed/simple;
	bh=/7vAfKQ21uVJX4bb9D7qxgBPhUd6eFOUYku5Ybm8oLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvVOHAC0aXDyCMsK05kVwuqvzvW0yqV3ft3d6Jmr1XBfWnCVKerQ91Ftlsd3FWneE6rp4icUAipR4/I1KqLQ10G9My0UIJgqsFb9nvpcGvrw6i69RLm9tKAZCFvXCNx4OVQSzu8cwKS1BjW1gN+WXEvHKZv008R5ABbXonxaJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OYETX48H; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OYETX48H"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c0zmN1Zjqzm0ySS;
	Mon, 11 Aug 2025 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1754927843; x=1757519844; bh=bI/jD
	0v++vk3p8+M7vNJ00gGanHhZeMPR8pRZJOELlY=; b=OYETX48H2TXCM3ufm2Vsq
	bIfGp6HijVygDeWfAMR/QUd857B1hOauZERIcX5iVybw0ysiv+sAcSNzLntS1OHM
	cm7HGsKFlulaiajda3NcgnVcqg8SINguB68V0tVzeBFUO239bVEu2kakeYDfBgZE
	h1MLGbdYu5wFXhr7KuQLxneMuFac/50ly80nWRi52LBulFletSNbOZK85fIoupiP
	wICaPtVhWPdylZsagdjQnfdrMopD3PVGoxD4rnSo7SbCiMNnNuvOFsNqIgVNe60W
	sfJxMS7miVXnP3kcPdzXsD13Y1xz3Xdg4o2QoGcY8bqbJdbtAU0Oe9rm99ZOZcG/
	g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QAEk7IeNP8e6; Mon, 11 Aug 2025 15:57:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c0zmH3rMrzm0yVT;
	Mon, 11 Aug 2025 15:57:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 2/5] block, genhd: Remove disk_stats.sectors casts
Date: Mon, 11 Aug 2025 08:56:49 -0700
Message-ID: <20250811155702.401150-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250811155702.401150-1-bvanassche@acm.org>
References: <20250811155702.401150-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In include/linux/part_stat.h, disk_stats.sectors is declared as
unsigned long[]. Instead of casting disk_stats.sectors to unsigned long
long and formatting it with %llu, remove the cast and format these number=
s
with %lu. No functionality has been changed.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/genhd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9bbc38d12792..31cff7980f70 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1074,19 +1074,19 @@ ssize_t part_stat_show(struct device *dev,
 	}
 	part_stat_read_all(bdev, &stat);
 	return sysfs_emit(buf,
-		"%8lu %8lu %8llu %8u "
-		"%8lu %8lu %8llu %8u "
+		"%8lu %8lu %8lu %8u "
+		"%8lu %8lu %8lu %8u "
 		"%8u %8u %8u "
-		"%8lu %8lu %8llu %8u "
+		"%8lu %8lu %8lu %8u "
 		"%8lu %8u"
 		"\n",
 		stat.ios[STAT_READ],
 		stat.merges[STAT_READ],
-		(unsigned long long)stat.sectors[STAT_READ],
+		stat.sectors[STAT_READ],
 		(unsigned int)div_u64(stat.nsecs[STAT_READ], NSEC_PER_MSEC),
 		stat.ios[STAT_WRITE],
 		stat.merges[STAT_WRITE],
-		(unsigned long long)stat.sectors[STAT_WRITE],
+		stat.sectors[STAT_WRITE],
 		(unsigned int)div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
 		inflight,
 		jiffies_to_msecs(stat.io_ticks),
@@ -1097,7 +1097,7 @@ ssize_t part_stat_show(struct device *dev,
 						NSEC_PER_MSEC),
 		stat.ios[STAT_DISCARD],
 		stat.merges[STAT_DISCARD],
-		(unsigned long long)stat.sectors[STAT_DISCARD],
+		stat.sectors[STAT_DISCARD],
 		(unsigned int)div_u64(stat.nsecs[STAT_DISCARD], NSEC_PER_MSEC),
 		stat.ios[STAT_FLUSH],
 		(unsigned int)div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC));
