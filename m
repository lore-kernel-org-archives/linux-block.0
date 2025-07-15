Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7840279787
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598396; cv=none; b=mFMda7RViVMaOvJbQgF0tMDOWUlQaA8RHDABBmaTGeunbqRs21WvBpEnCognUCHa1d+g25LDcbPPqfDA7nPaDHJvakv3fhHFdneQO3W7NTzn6Lhk2Rwjij1I24goMlKRZFJfBM3nqcR6dUXKLbmsk7LVckbyH3XgBQUvrf9EonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598396; c=relaxed/simple;
	bh=fP8jbWcZ+weNBOlB/iTKobwuE9L+6zS/ZUz3bvmwAls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGgpzPBBl8jcgh7oom7ibZPmHH2ujR8Q26mev4ybij/4qw44Qh6w7/2qGmilSco3VQadSV9Afofo6kqLLUEhPzBhKFv5OpsrbNjUvB28KnjkNzfyj6z99B//YlILqToUNCcY6wPzZJb3UeBtJIitJICQinxLlMat5PdL5gFCnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BkR39OSG; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BkR39OSG"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhQHC4C9Wzm175C;
	Tue, 15 Jul 2025 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752598390; x=1755190391; bh=qtcVF
	oR82jV9IHlzS2C260kCLX/6ViJI7gx3OUhMUXk=; b=BkR39OSG8HwsHLyEz83L4
	71XMQSdihM6Zfr2OYXMie+xuHtXtroMHon/xNpGVm+rGimzsdwGQtIuovDtj2V+F
	LW9mrH3OAV6eXy1pViPhwC6HzxweysEVu7fuqAW1V+hhODGjWmJKGNBU0Ah6Hr/c
	O4g0qxlqF9wwMS3S1Si3CTmJWvoBjWbkaZELQnizPTRY4L9ImGBfiZBzn3YwZSOF
	/Cy7Zxc2NH3IWI26WnHqPZkqcICnXkTNjqYFpXqixEaRN5wgb8+8zdTjb5Mo55ty
	RtEpnCiTD5Xun6oBhbaJPVcKhv/7SqqGFY0sTR5uRwXZoaZx//rnn+c7nKHPso06
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AT_8gwqMby8D; Tue, 15 Jul 2025 16:53:10 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhQH81FMxzm0jw3;
	Tue, 15 Jul 2025 16:53:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/5] block, genhd: Remove disk_stats.sectors casts
Date: Tue, 15 Jul 2025 09:52:36 -0700
Message-ID: <20250715165249.1024639-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250715165249.1024639-1-bvanassche@acm.org>
References: <20250715165249.1024639-1-bvanassche@acm.org>
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/genhd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c26733f6324b..bb78a2eb395e 100644
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
