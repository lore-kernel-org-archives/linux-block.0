Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC236AB58
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294712; cv=none; b=GrwUZ+2iyPt/YAkWLktb0IPx3v2jILrSxnDGoK9Ycw5AtguakJsQWnqYdFWYdn70PrEalnahgoQZ+SMJZfIsg1pkTlvpZRAydz/XYY71TI5OZI9BoFgblmoN5cGyDtLAPsFBdWuWI9Z44Ht7WV4ih2eD0n5JmjgNBxD/ku3hVIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294712; c=relaxed/simple;
	bh=Phmx/nUdyrJ/pu7OOsJfsNxN7xsOHbWh1KpKGgJxaAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM3U74ffuk0R/YgT4hg/ywVnSyxYVbXZ+EzTHNPmvI5XSwdZ565FYveYICMhAmoSDjBnVJ056mC+NHipy4pmPGlIqnKEhpBNWpOXDfT90kMAhX33G+eQTWNN5v0r9qst3aMwPmn4t5nRj/Grj6whfsJzIxaYL4t7mcgidUTm2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvPzyvF5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvPzyvF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768294710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h22KtsdJfRVqaeML42gMx3TL345L6YjAt077NGpeL/o=;
	b=HvPzyvF5EslT8kuni8BgEzX2t/EzX8fkhO7BBr5y5N4REOJ+fuR037wQFg6yHkM2n0NOZY
	pIUVyAvcUgH0V/iPXiS+F7EsirgvnVBlqtgkuFzckndBhFLrDH0+5SC6T3yJpiVMTHMZJO
	rs5kJXUyrLBZIBHnVtvvoebINZpTLjI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-M0RLgm53O9yn50JiSbUW5w-1; Tue,
 13 Jan 2026 03:58:26 -0500
X-MC-Unique: M0RLgm53O9yn50JiSbUW5w-1
X-Mimecast-MFC-AGG-ID: M0RLgm53O9yn50JiSbUW5w_1768294705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 936731955E77;
	Tue, 13 Jan 2026 08:58:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 867CA19560B2;
	Tue, 13 Jan 2026 08:58:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] selftests/ublk: fix garbage output in foreground mode
Date: Tue, 13 Jan 2026 16:58:02 +0800
Message-ID: <20260113085805.233214-4-ming.lei@redhat.com>
In-Reply-To: <20260113085805.233214-1-ming.lei@redhat.com>
References: <20260113085805.233214-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Initialize _evtfd to -1 in struct dev_ctx to prevent garbage output
when running kublk in foreground mode. Without this, _evtfd is
zero-initialized to 0 (stdin), and ublk_send_dev_event() writes
binary data to stdin which appears as garbage on the terminal.

Also fix debug message format string.

Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 65f59e7b6972..f197ad9cc262 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1274,7 +1274,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	}
 
 	ret = ublk_start_daemon(ctx, dev);
-	ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\b", ret);
+	ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\n", __func__, ret);
 	if (ret < 0)
 		ublk_ctrl_del_dev(dev);
 
@@ -1620,6 +1620,7 @@ int main(int argc, char *argv[])
 	int option_idx, opt;
 	const char *cmd = argv[1];
 	struct dev_ctx ctx = {
+		._evtfd         =       -1,
 		.queue_depth	=	128,
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
-- 
2.47.0

