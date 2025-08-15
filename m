Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B592E5D01
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276933; cv=none; b=eLTuFLGbUzMEzAg1wW2iE48j24uTRuWwEu34u9yYNgoulLoPbn8WhJQXNMuxkjZLYME8kfg6AOvm0nM1U2pN+Jq8Ug7g99WeOl9WoekggmqXH1KUCu1SqBx1gVdL2DEpsw6jO+r8mAIcr6AK6U3rnwNExDr1sZaZi8Ormy2Tfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276933; c=relaxed/simple;
	bh=WyujT6t8+wFo5KWA+dj87nmleNSyhfjHYeCEMBJe7jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDval+2laPbd9f5ofiJDaxPv9KzOQHeJB4z0WXb3PBrlEI+SLoAJTLw76pwLANJ/NcKoBmI4mYzaeDj+iq9LkOUHvvxuMahJoxHkc9yZNcyLuOovR5mGl2FgLbfsv0o1iNIPJjszB0cDg2t+2lkNcuIzlUU5UmpjEBTG1fxDEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Zv8/Ez56; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Zv8/Ez56"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c3Ssb0BFczltBDb;
	Fri, 15 Aug 2025 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1755276929; x=1757868930; bh=RoUfp
	OLwiVarujsHUJikUOw5XcHTa9UCpbc188nlx8s=; b=Zv8/Ez56AM6QvRmHqkt0b
	Sy1Q4qsuESURXdPsQxnQsLaBSg3Itx0BhHjrPQ70zVmGhwqmPGazNAZlTQdQ1Ixy
	N/DDVDbiOiFSaqSb0u5RQAh6yi8GXUEkYVo76Bmwa3Qz2C+pvyESfiw+/DYx93q5
	/9VTqXmeFkl3+vY62SQxnE2PJNjFuj5nkexF42zpMg5j1rYcM4TzhDKgOz2zRCa5
	naJ/p71WMCcB4aOFxlxaZqfPwRBjBrKlg8MxDuZ3RKyRr3h6oazVMYVmri5YCwOt
	dfg5djtRWJyY+8dE9m2gPA8xHffGiINBHgyPNiif5yYMrKPw4JLfnQLY/Tw2/W69
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Gs_I6Dz6pXDC; Fri, 15 Aug 2025 16:55:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c3SsQ2VRhzltQmP;
	Fri, 15 Aug 2025 16:55:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Coly Li <colyli@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 3/5] bcache, tracing: Do not truncate orig_sector
Date: Fri, 15 Aug 2025 09:54:41 -0700
Message-ID: <20250815165453.540741-4-bvanassche@acm.org>
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

Change the type of orig_sector from dev_t (unsigned int) into sector_t
(u64) to prevent truncation of orig_sector by the tracing code.

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Acked-by: Coly Li <colyli@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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
