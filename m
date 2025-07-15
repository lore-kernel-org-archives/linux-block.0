Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9EF50F
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598404; cv=none; b=k1BiyaDbYMf+Hes6Sv4PYL1542w9uJq3yhge4ntJbBwQlYYxdDN+ZViuhO0YJfHTPHnuR+qGHnzQjKFByd2OW7NWTcVJhvGMbRSHjQe+zNlWy63Ge6EcECs37CtzdxD3S5aSbDkjHjgCPDwjVpu0cd+bNUubHycSyIMNU88Ibko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598404; c=relaxed/simple;
	bh=HUryShE7sGe2I8YhhXT7mosW6MV8X4k+qIkP9L7Ya+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoPe7972XY7GmLayjTrWKDpnJSKzeVeOjY/sQ7BsvVFvEK+nKyWQ55CRn86TUOMagOF/BJ3j8R20wUxtxnyVVlzHT3xGKsW93s9SA23v/1pbRh0FAGlCSewyriBeJz1jpHoLDOd4EStqoa6Rr76E5P/pLtGb8KWnYB3YTTNqVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=f6D5MNJ6; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="f6D5MNJ6"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhQHP6CFkzm0ySh;
	Tue, 15 Jul 2025 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752598400; x=1755190401; bh=1Y2ez
	rP44e7E6Njm7//Qe8O/uPZ7GLwcLy+k8kimP8o=; b=f6D5MNJ6N0QNZ8DTlDwNx
	JrgTyb8Ht0BPo33RjCOyUv9vHVsoPT+t5TZ+IdYJ6zuFI8q4+F7a9p1zK2DBngl0
	Qme3dKMSBGj2SoiCW6+quDGGwOQxvJpdRiVl720i0dTpG381fsDAG/UaUN12/BxL
	Q3dOY1O3ZD/dVN/44ZEaKUBObziNktTT4J+aGOhIzbiL77STjSZiz+SLxgcbvieO
	pZOR+QmHK6EY1Tr21cjmZrQdRp7RZPioj1AZmxURt9dpPJzQ1W4YtNQXGGRb9Cjp
	gaogmzIYyPJvQNlSIE3hZjgf6enwkwXBRvydRvQaqUNuLrX1gcEbDkYmNe5kHi+8
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UJRj9XLJfIH9; Tue, 15 Jul 2025 16:53:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhQHG20Flzm0yR0;
	Tue, 15 Jul 2025 16:53:13 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kent Overstreet <koverstreet@google.com>
Subject: [PATCH 3/5] bcache, tracing: Do not truncate orig_sector
Date: Tue, 15 Jul 2025 09:52:37 -0700
Message-ID: <20250715165249.1024639-4-bvanassche@acm.org>
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

Change the type of orig_sector from dev_t (unsigned int) into sector_t (u=
64)
to prevent truncation of orig_sector by the tracing code.

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Fixes: cafe56359144 ("bcache: A block layer cache")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/trace/events/bcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.=
h
index 899fdacf57b9..d0eee403dc15 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -16,7 +16,7 @@ DECLARE_EVENT_CLASS(bcache_request,
 		__field(unsigned int,	orig_major		)
 		__field(unsigned int,	orig_minor		)
 		__field(sector_t,	sector			)
-		__field(dev_t,		orig_sector		)
+		__field(sector_t,	orig_sector		)
 		__field(unsigned int,	nr_sector		)
 		__array(char,		rwbs,	6		)
 	),
