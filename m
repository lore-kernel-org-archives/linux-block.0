Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105F242D72
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191156; cv=none; b=hoj1EISXeo++skzwgnUXzYimGmXbLg6oUsveHfUtZUueU5coF7o92D+RIuIDdRu1K51xMYPPm8rU6RmBXlflhtz1VHs4D5gc/PypDxoCUISiOP+sC9pqaGIVFs4HSE9Xs2fElCSGbycvfhNPaQkzgs0nClbX6zFZeDLYVNXtG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191156; c=relaxed/simple;
	bh=BZK865e0Wkbi/GuXMzWfSSB5aGiZ+uoZQ1VuPYow+dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBMcleFGkUAmuyc8UkWWJOKMZC+cwHPppS55rVMid1+jPaXhHaticYNcJ41Wpnx+d3bnCHoJQaPEARfeBPJYAgHXfqYwIugN5pA8ZwL1CsEESciabm+M0MMUBbFqdIsN1dHTRj8BBd1W1j19GAybIDGcEqqCQPrYwAj+jHRCVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGzvXP6t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGzvXP6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768191154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DvDbB+Gumxq7+FOhjC5zpfrBkZIH/4Awr1Pdpie75Q=;
	b=hGzvXP6thE0ynLZAzM6vVAQrmcnO/OqZ6OfFhLsxPl6RUSb6gjKcsyaumggFNXbCybbsg6
	Ha0uUCyWQIGeKDvPoRyslD/IE1NqBte3fRTr/MDJTzs3w84x0VfgBrTffIjs30ky6coI3d
	LwtVo8kTW3WFiGcfi/zLoavb3FC9NeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-m6PIPvFFPV21l48CybNQSg-1; Sun,
 11 Jan 2026 23:12:31 -0500
X-MC-Unique: m6PIPvFFPV21l48CybNQSg-1
X-Mimecast-MFC-AGG-ID: m6PIPvFFPV21l48CybNQSg_1768191149
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5395C18005A7;
	Mon, 12 Jan 2026 04:12:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2832230001A2;
	Mon, 12 Jan 2026 04:12:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] selftests/ublk: fix garbage output and cleanup on failure
Date: Mon, 12 Jan 2026 12:12:06 +0800
Message-ID: <20260112041209.79445-3-ming.lei@redhat.com>
In-Reply-To: <20260112041209.79445-1-ming.lei@redhat.com>
References: <20260112041209.79445-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix several issues in kublk:

1. Initialize _evtfd to -1 in struct dev_ctx to prevent garbage output
   in foreground mode. Without this, _evtfd is zero-initialized to 0
   (stdin), and when ublk_send_dev_event() is called on failure, it
   writes binary data to stdin which appears as garbage on the terminal.

2. Move fail label in ublk_start_daemon() to ensure pthread_join() is
   called before queue deinit on the error path. This ensures proper
   thread cleanup when startup fails.

3. Add async parameter to ublk_ctrl_del_dev() and use async deletion
   when the daemon fails to start. This prevents potential hangs when
   deleting a device that failed during startup.

Also fix a debug message format string that was missing __func__ and
had wrong escape character.

Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..0c62a967f2cb 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -153,11 +153,10 @@ static int ublk_ctrl_add_dev(struct ublk_dev *dev)
 	return __ublk_ctrl_cmd(dev, &data);
 }
 
-static int ublk_ctrl_del_dev(struct ublk_dev *dev)
+static int ublk_ctrl_del_dev(struct ublk_dev *dev, bool async)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op = UBLK_U_CMD_DEL_DEV,
-		.flags = 0,
+		.cmd_op = async ? UBLK_U_CMD_DEL_DEV_ASYNC: UBLK_U_CMD_DEL_DEV,
 	};
 
 	return __ublk_ctrl_cmd(dev, &data);
@@ -1063,11 +1062,11 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	else
 		ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
 
+ fail:
 	/* wait until we are terminated */
 	for (i = 0; i < dev->nthreads; i++)
 		pthread_join(tinfo[i].thread, &thread_ret);
 	free(tinfo);
- fail:
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
 		ublk_queue_deinit(&dev->q[i]);
 	ublk_dev_unprep(dev);
@@ -1272,9 +1271,9 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	}
 
 	ret = ublk_start_daemon(ctx, dev);
-	ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\b", ret);
+	ublk_dbg(UBLK_DBG_DEV, "%s: daemon exit %d\n", __func__, ret);
 	if (ret < 0)
-		ublk_ctrl_del_dev(dev);
+		ublk_ctrl_del_dev(dev, true);
 
 fail:
 	if (ret < 0)
@@ -1371,7 +1370,7 @@ static int __cmd_dev_del(struct dev_ctx *ctx)
 	if (ret < 0)
 		ublk_err("%s: stop daemon id %d dev %d, ret %d\n",
 				__func__, dev->dev_info.ublksrv_pid, number, ret);
-	ublk_ctrl_del_dev(dev);
+	ublk_ctrl_del_dev(dev, false);
 fail:
 	ublk_ctrl_deinit(dev);
 
@@ -1622,6 +1621,7 @@ int main(int argc, char *argv[])
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
+		._evtfd		=	-1,
 	};
 	int ret = -EINVAL, i;
 	int tgt_argc = 1;
-- 
2.47.0

