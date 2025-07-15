Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F152741A1
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598411; cv=none; b=lxskTLgduzJ0cbkFCJ558HFp+FAdQh58bNJDhIQoCtIuDitrge1oZCk/e11Fv//lTUTVwTUEtsablTAFYCyYL9jPWBBY5cFLSYNQOHUHZrGfwqJZhBVFrZ8d8UvYwTAlG3m7Vx4y9oaiS/4FDwZQiB93a0g0IQO/8DZkgXUGeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598411; c=relaxed/simple;
	bh=qdC5+lfymLGSUxXiQz84gD7bBhnWsfd7FlMNR1ldseU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvI4Ss5skLfd7VUGefatt7k26H1OCVBNha2Y0xABeyLMrmep8iBMPs0G4X2fRHJlB0XGkE5R5kkLcOl0yseedt5QlQM1gGQPS2UOV6uPELdqeoWRkMapNHfcTj71OFmtaNxbkDARoBqjccMcHtaSiI3EVq6uo/lDmoY8XrFrxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=su+P2i3f; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="su+P2i3f"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhQHY1q4qzm0yQW;
	Tue, 15 Jul 2025 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752598407; x=1755190408; bh=TY7O4
	VgACkdyrDH/E4W4/BnJWFxnED8U6QBDLF/O5/Y=; b=su+P2i3fbJnP1GYFlwOYY
	Cnyr0axbGPjZoPiXf0A94TGD/E3ChOhGmHPYE+9doYp3cHTxu0/sBEAG6L5McCHf
	sVFWdALsOlaARtj0EADO0P8HyPBi04hy80p/oPZimQ4qnNAoZn/nw3aFnSzjDpg8
	mRHVvdhoqXhv6noH/kcRXWjTaF9WHEGJLXkYgu/nhSIrDBcOzQAghRwAHSG0jIuN
	BgiZLk1olOK4IGokRWfWhZxG9f7v6uyR2UDOYRBK9ZZFweGAeLOZ/qk5cBS8cZyn
	k0kMIXMYtML9uS5CXgABhIHrWTfoBspWOApg27rx06TH8XfMci4lxhag9Tlr9zGo
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MB9C5zyHZPWK; Tue, 15 Jul 2025 16:53:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhQHS0X4Jzm0ytk;
	Tue, 15 Jul 2025 16:53:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/5] bcache, tracing: Remove superfluous casts
Date: Tue, 15 Jul 2025 09:52:38 -0700
Message-ID: <20250715165249.1024639-5-bvanassche@acm.org>
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

sector_t is a synonym for u64 and all architectures define u64 as unsigne=
d
long long. Hence, it is not necessary to cast type sector_t to unsigned
long long. Remove the superfluous casts to improve compile-time type chec=
king.

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
