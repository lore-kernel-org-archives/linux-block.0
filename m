Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FC37BE84
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294709; cv=none; b=NNOu9iWRYZq+ADJHZhK8/7KYulmzm7AuuU1zVLTMiqzzj4HtAl4pWaM7OTVUlswgOetWVTc33cbMCHdv/rlQ9L0SLUkB2NvPPVvaTxahlGg+j5/pNp3/rXX9pfP8Vssa+FA4yF2Yr+4bjfI8qn6niKlSknduXza13kccpHVtEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294709; c=relaxed/simple;
	bh=DmeqXNz6f9PnFLXmYgX5DErM0D7ljcl8fEQY9uGFKPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGGeDbTpWccfLYqNzdMwJ25T1Qvpqr8LwPtlhauRLmzwWdsb2/LMsipzQQN25ax3+FhfK4SzwKvK8IkhUcqBbQq0sxI4bokk6qT5xAQaFqOP9FPGiNkBxittEm6JTRiXJtBqW9HSQWZxS6yURu/Zt0xnwE29mXa3ItfFv8p3Bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNIJeUiX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNIJeUiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768294707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUphs3s7jfuNUb1sCxnMj4xrP3T931Fq0wEv2JNyfEI=;
	b=CNIJeUiXoICpGzwuyG9AL/G45ZarUbqwydBgzv0CGhM9BLcZ92zG2tPkn7T4Soy6TGHahp
	G8aBOcM3sixv7d1CEfhRJDQo09YTTjgOEc1+LM8cVw/Xa1D9rRTz+fuBOk9MmHP4NW3pki
	wgjdF1SRQQzk0Vrrd/bDHTV/6UbJNic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-0hn03bsmOxG5z-NpKUvNvg-1; Tue,
 13 Jan 2026 03:58:23 -0500
X-MC-Unique: 0hn03bsmOxG5z-NpKUvNvg-1
X-Mimecast-MFC-AGG-ID: 0hn03bsmOxG5z-NpKUvNvg_1768294702
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C929A18003FD;
	Tue, 13 Jan 2026 08:58:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E794630001A2;
	Tue, 13 Jan 2026 08:58:20 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] selftests/ublk: fix error handling for starting device
Date: Tue, 13 Jan 2026 16:58:01 +0800
Message-ID: <20260113085805.233214-3-ming.lei@redhat.com>
In-Reply-To: <20260113085805.233214-1-ming.lei@redhat.com>
References: <20260113085805.233214-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix error handling in ublk_start_daemon() when start_dev fails:

1. Call ublk_ctrl_stop_dev() to cancel inflight uring_cmd before
   cleanup. Without this, the device deletion may hang waiting for
   I/O completion that will never happen.

2. Add fail_start label so that pthread_join() is called on the
   error path. This ensures proper thread cleanup when startup fails.

Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f52431fe9b6c..65f59e7b6972 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1054,7 +1054,9 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	}
 	if (ret < 0) {
 		ublk_err("%s: ublk_ctrl_start_dev failed: %d\n", __func__, ret);
-		goto fail;
+		/* stop device so that inflight uring_cmd can be cancelled */
+		ublk_ctrl_stop_dev(dev);
+		goto fail_start;
 	}
 
 	ublk_ctrl_get_info(dev);
@@ -1062,7 +1064,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		ublk_ctrl_dump(dev);
 	else
 		ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
-
+fail_start:
 	/* wait until we are terminated */
 	for (i = 0; i < dev->nthreads; i++)
 		pthread_join(tinfo[i].thread, &thread_ret);
-- 
2.47.0

