Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413652D6E50
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927870; cv=none; b=Z30DTbJ1m0XS/I/LDwL869Oq2r4cK87Ne8PYPHeAXIuM0BPgg5HyM5pN0PgRjabqH1g59SJCCI1O360wGHgaFRH0PWRYNdUEAwDUTO3GLnOxUcippRzrqyT+ldazt8exfPGIAY5rGYXpdjVvgd2PjtP2cOH7t/Bz8otSEm74TtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927870; c=relaxed/simple;
	bh=MeXOF3TcccyOBx/WsvKTF+TK93279F9HEDhU6npYkUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIODyLNVa51sAYEbjWFuNKzX7VPDn4krwvhjei01e2XG8Y27sXaza1Al1+9DLY8NFaO6NAB4SOJxzgagasAjLI5/uSxdmcX5cM4eRmZjCMfdxWsrkqBFC/ZLTr7ZMYrXxOfHYj3R+Pm6NfCe02tJLNdwpEMh+iYU67okUto6nKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nmnZ6cls; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nmnZ6cls"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c0zmq1Byqzm0ySS;
	Mon, 11 Aug 2025 15:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1754927865; x=1757519866; bh=T3sZk
	+79a0VOCY4hn3ahHJyl8TCL0dpPbMMAzytK35I=; b=nmnZ6cls09tFOGq13YnT0
	qBtHQvEyzZ157Kq+FdQB/cw6eBV+DCIT0g5J3wj340RMZNHT5UiVJCa8CadDII2K
	TrwsHGzo+oDwSBcJ5RcF3kFVHoTUoxP4YjS4i/EZm0gIytcI+SVOoec3t3bfkTkg
	d+ge6dUATt1SdnaYvgNS8Qmo1XbLtCGprSSw6i9ffXICWFuX7kppAXOF2LkIVpDC
	u1bwPY4d+6bS4p91A9erydyX+fMx2kbbljSvkWejl1i+MTP6jaoFSE0fmDr3ntNm
	liuAAY60BkDWZsq/Fg8CO7oiWrrQzUpVldhd8cQDPzwH+yp9l3BJzRv2yROz2jxI
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QeLZDXhviAdD; Mon, 11 Aug 2025 15:57:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c0zmg5mf4zm0yVH;
	Mon, 11 Aug 2025 15:57:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Coly Li <colyli@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 4/5] bcache, tracing: Remove superfluous casts
Date: Mon, 11 Aug 2025 08:56:51 -0700
Message-ID: <20250811155702.401150-5-bvanassche@acm.org>
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
