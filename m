Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3E2E5D01
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276944; cv=none; b=YJz4SH7v003XyBRa50LDsJtcM3XL4qnuJ/uZytenGwSATbmgyz+376Zajr5xrp2NjAFLks+5NX0toGs8TIFsDggp8wwsQVzZpEODpthGbSib6bY4UUABtfKgNzeP8pFm2hHso/M3HzP4xtNWSMteoGMNas2t6gpqMnKiChoypOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276944; c=relaxed/simple;
	bh=MeXOF3TcccyOBx/WsvKTF+TK93279F9HEDhU6npYkUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbRtObSCfLDITIrN+A0b1MGB7ewrwzvINmZvHMhPuo8DamLVGO8t1iOZj7FIuVqLqiThazUouRVSFuY3TNeFfbbUsdNW2D5gZLF1Ux2xgimva7EjTNOJQTRa4Ba1y+3a7QIf4GOcMp1l6qWHSD4KjwC06QzVaq3tK9X6fQ97kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jbRqN7a2; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jbRqN7a2"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c3Ssn0VD6zltQmY;
	Fri, 15 Aug 2025 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1755276939; x=1757868940; bh=T3sZk
	+79a0VOCY4hn3ahHJyl8TCL0dpPbMMAzytK35I=; b=jbRqN7a24xpPrUKZkfiES
	7K2x9nr9iYuQYD9Pm2jXbQj70LX87YF4DIFzXYtyVVrYJBN/2JPsgjdpkQPtgovh
	JTK0kDLcrNmung5MhPfLeOyDEIoecl9voH5U0NpeCapQ/hCNaeuAumvwOtg3ZdbO
	BU7o4gLTgrgsbe/ksCqFohmjLCcLYn7gCm+ypgprKXrexyOL6uOj6THKKDOJ9r62
	ZkeJ2s63y1UKQrYuvCJg4cU3Men860vQgdGA+NTjOY6lHVLzdId/7g71YsWVdr3R
	E7klu9S/6rVrsJ3qXUQYrUi9iI99Kw0MZXxV6jLdF8K08n1eGh83cpwXM3HI4OKZ
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cun320OmHT4A; Fri, 15 Aug 2025 16:55:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c3Ssd2PgMzlgqVr;
	Fri, 15 Aug 2025 16:55:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Coly Li <colyli@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 4/5] bcache, tracing: Remove superfluous casts
Date: Fri, 15 Aug 2025 09:54:42 -0700
Message-ID: <20250815165453.540741-5-bvanassche@acm.org>
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

sector_t is a synonym for u64 and all architectures define u64 as unsigne=
d
long long. Hence, it is not necessary to cast type sector_t to unsigned
long long. Remove the superfluous casts to improve compile-time type
checking.

Acked-by: Coly Li <colyli@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/trace/events/bcache.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.=
h
index d0eee403dc15..697e0f80d17c 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -33,9 +33,9 @@ DECLARE_EVENT_CLASS(bcache_request,
=20
 	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->rwbs, (unsigned long long)__entry->sector,
+		  __entry->rwbs, __entry->sector,
 		  __entry->nr_sector, __entry->orig_major, __entry->orig_minor,
-		  (unsigned long long)__entry->orig_sector)
+		  __entry->orig_sector)
 );
=20
 DECLARE_EVENT_CLASS(bkey,
@@ -107,7 +107,7 @@ DECLARE_EVENT_CLASS(bcache_bio,
=20
 	TP_printk("%d,%d  %s %llu + %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector, __entry->nr_sector)
+		  __entry->sector, __entry->nr_sector)
 );
=20
 DEFINE_EVENT(bcache_bio, bcache_bypass_sequential,
@@ -144,7 +144,7 @@ TRACE_EVENT(bcache_read,
=20
 	TP_printk("%d,%d  %s %llu + %u hit %u bypass %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->rwbs, (unsigned long long)__entry->sector,
+		  __entry->rwbs, __entry->sector,
 		  __entry->nr_sector, __entry->cache_hit, __entry->bypass)
 );
=20
@@ -175,7 +175,7 @@ TRACE_EVENT(bcache_write,
=20
 	TP_printk("%pU inode %llu  %s %llu + %u hit %u bypass %u",
 		  __entry->uuid, __entry->inode,
-		  __entry->rwbs, (unsigned long long)__entry->sector,
+		  __entry->rwbs, __entry->sector,
 		  __entry->nr_sector, __entry->writeback, __entry->bypass)
 );
=20
@@ -243,8 +243,7 @@ TRACE_EVENT(bcache_journal_write,
=20
 	TP_printk("%d,%d  %s %llu + %u keys %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector, __entry->nr_sector,
-		  __entry->nr_keys)
+		  __entry->sector, __entry->nr_sector, __entry->nr_keys)
 );
=20
 /* Btree */
