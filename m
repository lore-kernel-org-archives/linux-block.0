Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7212E5D3B
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276921; cv=none; b=MnXzq4dPQXLxUXi2mSDm44IQsEW/lUNs3HB5r5iCwZ83IZ8C8TAqQgc54Pgr3o0yxiOowprv4QItaW5iclxuX7DGbYNPbQmq/4ObxCQ396yX+iLgTOR9U4YuFyO5FgnDyAIsVh655Gw5ROABgjVTYpjm+YvpmUrdZpHRT8M9eJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276921; c=relaxed/simple;
	bh=/7vAfKQ21uVJX4bb9D7qxgBPhUd6eFOUYku5Ybm8oLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc6oEOBIXaYZKUcq9MWnljP/+UIxZyNO7+fLZpE3lucSWh2A5+bbkEDY7QqlhExI7Df5NAHsJMvr+Nyl278rvc3Lp8LT7Wv3CodukJHjJ9cuQH1iIPYv+GtnltG1SSi2CnlS+W0luCYWGK6LSCyVRDBaAa6tHf40wiJd7OkHdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=e16z9evx; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="e16z9evx"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c3SsM2Q8Jzlssxn;
	Fri, 15 Aug 2025 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1755276918; x=1757868919; bh=bI/jD
	0v++vk3p8+M7vNJ00gGanHhZeMPR8pRZJOELlY=; b=e16z9evxT9atKW15NKPge
	LgoM3cScueFH2xoJemRFWFLgMubkwbz4HR3OM4RnZK6P1KcEZHIDV3PCpzFLjbRS
	PXO8RlSkxGmO8n4TSu8dOjey/sIlNbhEyLCevYGdcnWPbSgqE8IpVAOPFvlSCKNL
	XxfK8AzdYgPC3acAGZAYIsk7v89e2mXypSu5fV5nojO7H2IsJ7D0n6GLXkmGYXuN
	PcRmqQ32mDpXk2thOkaV5qdZtbmHnRE6l61NhhF4/nJ3OFFlYwzxOv2wJYP9LMHM
	q/6yuImJArdT1Inr62rZjjt5h9+ZYxq5s3RLVU/1+/4HPMrpH3fRgMRKBh2+l7v3
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xRaDGsbpzho9; Fri, 15 Aug 2025 16:55:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c3SsG6j3kzlgqVX;
	Fri, 15 Aug 2025 16:55:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 2/5] block, genhd: Remove disk_stats.sectors casts
Date: Fri, 15 Aug 2025 09:54:40 -0700
Message-ID: <20250815165453.540741-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250815165453.540741-1-bvanassche@acm.org>
References: <20250815165453.540741-1-bvanassche@acm.org>
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
