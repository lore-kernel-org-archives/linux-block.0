Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB82D6E69
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927881; cv=none; b=DIl2c5ZvWPmFpfuxIRiENMAJ2mWd2IQp6VSE2soafQ8yHjsvlYVNbIORUuAaOZE5b6jztBZwANpHzWL2RS4iz/Fj1dhXJjszy4VlafCyHJiK9zKNyEFrd0YSKpQ7r+zyqvnHuWUCbFq+3IMe4drxJBJzY7652J8cRYRIeFuTjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927881; c=relaxed/simple;
	bh=RnC+Hmtwok4wNuZc+RDediBi4fEtZfcrSq5OiQ1e7MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIP9yGKNK+UVNiSyWGkfJ8sVJ07AkWV74kxejrPKVjvF0cZjGN3rqQyX4XhUIWJRxsCz6EThAHu/+qpIsvbyod3h5ti7BUyzgSs28nL7pE0vvbTWv0OR3VIqJUb3P3uDcDTyrLFY+hVJ7VeIXp9lhPdQ7VKo8I14P20h4xRfp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wDjmk5W8; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wDjmk5W8"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c0zn32k0Szm0ytT;
	Mon, 11 Aug 2025 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1754927877; x=1757519878; bh=diKaU
	+JCkNow/PFWdsJCY5Z0Llh5vURSyiLVA5qSpWM=; b=wDjmk5W8Avvo8jW602mpo
	BA+NiXNJGuE7nxaSVvpMaSp6ztzXPcnuh7La62Ehnujjmr/iDHcFbDlcrRpGffDV
	pr8b9VmwltB1DfwMzPflKol1qRsnAQ90rTPHnBBfLH6BD3JExVcjiwB4kySR+IQN
	N1yce7vUcWaRiKw1W4drOJVfSKDLSdsDStqHIfCcDGAq35B/W2wR5VbCHOt5YiSv
	CSs+YG5fVRaUnSA6EuMAlwYnI5nOhCVzmYIDtpQSHT6UEeOHFMO9ocUUgbM8Tx7U
	DapVj4+gBh7ctfxmeOSvQN/NMorL74khJQgtnzFq+OLhxhwn6PUszxUhGlpZekFL
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6kooNN8OAtEf; Mon, 11 Aug 2025 15:57:57 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c0zms4Sz8zm0ySJ;
	Mon, 11 Aug 2025 15:57:48 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 5/5] block, tracing: Remove superfluous casts
Date: Mon, 11 Aug 2025 08:56:52 -0700
Message-ID: <20250811155702.401150-6-bvanassche@acm.org>
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

sector_t is a synonym for u64 and all architectures define u64 as unsigne=
d
long long. Hence, it is not necessary to cast type sector_t to unsigned
long long. Remove the superfluous casts to improve compile-time type
checking.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/trace/events/block.h | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6aa79e2d799c..57fcf3d673fd 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -41,7 +41,7 @@ DECLARE_EVENT_CLASS(block_buffer,
=20
 	TP_printk("%d,%d sector=3D%llu size=3D%zu",
 		MAJOR(__entry->dev), MINOR(__entry->dev),
-		(unsigned long long)__entry->sector, __entry->size
+		__entry->sector, __entry->size
 	)
 );
=20
@@ -108,7 +108,7 @@ TRACE_EVENT(block_rq_requeue,
 	TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __entry->sector, __entry->nr_sector,
 		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
 				   IOPRIO_CLASS_STRINGS),
 		  IOPRIO_PRIO_HINT(__entry->ioprio),
@@ -145,7 +145,7 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 	TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __entry->sector, __entry->nr_sector,
 		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
 				   IOPRIO_CLASS_STRINGS),
 		  IOPRIO_PRIO_HINT(__entry->ioprio),
@@ -219,7 +219,7 @@ DECLARE_EVENT_CLASS(block_rq,
 	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __entry->bytes, __get_str(cmd),
-		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __entry->sector, __entry->nr_sector,
 		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
 				   IOPRIO_CLASS_STRINGS),
 		  IOPRIO_PRIO_HINT(__entry->ioprio),
@@ -328,8 +328,7 @@ TRACE_EVENT(block_bio_complete,
=20
 	TP_printk("%d,%d %s %llu + %u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->error)
+		  __entry->sector, __entry->nr_sector, __entry->error)
 );
=20
 DECLARE_EVENT_CLASS(block_bio,
@@ -356,8 +355,7 @@ DECLARE_EVENT_CLASS(block_bio,
=20
 	TP_printk("%d,%d %s %llu + %u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->sector, __entry->nr_sector, __entry->comm)
 );
=20
 /**
@@ -509,9 +507,7 @@ TRACE_EVENT(block_split,
=20
 	TP_printk("%d,%d %s %llu / %llu [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  (unsigned long long)__entry->new_sector,
-		  __entry->comm)
+		  __entry->sector, __entry->new_sector, __entry->comm)
 );
=20
 /**
@@ -549,10 +545,9 @@ TRACE_EVENT(block_bio_remap,
=20
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector,
+		  __entry->sector, __entry->nr_sector,
 		  MAJOR(__entry->old_dev), MINOR(__entry->old_dev),
-		  (unsigned long long)__entry->old_sector)
+		  __entry->old_sector)
 );
=20
 /**
@@ -593,10 +588,9 @@ TRACE_EVENT(block_rq_remap,
=20
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector,
+		  __entry->sector, __entry->nr_sector,
 		  MAJOR(__entry->old_dev), MINOR(__entry->old_dev),
-		  (unsigned long long)__entry->old_sector, __entry->nr_bios)
+		  __entry->old_sector, __entry->nr_bios)
 );
=20
 /**
@@ -630,8 +624,7 @@ TRACE_EVENT(blkdev_zone_mgmt,
=20
 	TP_printk("%d,%d %s %llu + %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sectors)
+		  __entry->sector, __entry->nr_sectors)
 );
=20
 DECLARE_EVENT_CLASS(block_zwplug,
@@ -657,8 +650,7 @@ DECLARE_EVENT_CLASS(block_zwplug,
=20
 	TP_printk("%d,%d zone %u, BIO %llu + %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->zno,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sectors)
+		  __entry->sector, __entry->nr_sectors)
 );
=20
 DEFINE_EVENT(block_zwplug, disk_zone_wplug_add_bio,
