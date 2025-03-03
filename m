Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFD20E6E3
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005838; cv=none; b=DGzQSwcR3owlqUJwiAlESg0j0GRKD1p/nJSWh0cbj7fNN0pfUTjQ9fSJBJBaUiw9cziZ7FwXoDzhaq3jEEuEk0PPIderRPYxMzXjbbpkmfZIVQNIncWmDt/19QUBIUd1/Cl9fOFkYneubL1LhvG0NAD8WMAteXjQezxmKIfjlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005838; c=relaxed/simple;
	bh=PALAmA07A0ocsHQIxyxYGhUW2CaWEXY/6wTWSrf84Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rak8d/0NNxk+EkaBcfILEAhByH19O3Zdl7W/fa2P1ehv4+f734Yjbu7I+zjtQJGODQUrW9/9vCzcp4LMv3/MACYGjaRLZosISmHwM4WXRxfqoqeUtgIXUbuferwWCWucmASY2N+zi/rHEzpS7q4ihlhL2PrFWArj/AWs3YscHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXk2qSjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXk2qSjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgHwoN4FkuivIO+yjtqGfA61kFi7hVKtRpikbqGM3uU=;
	b=QXk2qSjdoQ2ZfHXS3xsoDgxCrB9/cp6jAFtOwKIUQ7xRXIIDxW3Rq6+oARWFToi5UDxboH
	heMKlCYvGxWsl5FH7vQ+n1twm0QoiYvzUImfwZXmGY2EvkJZug3JZccdjN0AeIYgF0ER0q
	D6O3ewBfHXWN0fKeE8Yz1D99bTlWu/E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-tLrZL-b_N5ScaYPRjuEREA-1; Mon,
 03 Mar 2025 07:43:54 -0500
X-MC-Unique: tLrZL-b_N5ScaYPRjuEREA-1
X-Mimecast-MFC-AGG-ID: tLrZL-b_N5ScaYPRjuEREA_1741005833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5142D1944D03;
	Mon,  3 Mar 2025 12:43:53 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3CA0180087D;
	Mon,  3 Mar 2025 12:43:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/11] selftests: ublk: add --foreground command line
Date: Mon,  3 Mar 2025 20:43:13 +0800
Message-ID: <20250303124324.3563605-4-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add --foreground command for helping to debug.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 17 +++++++++++++----
 tools/testing/selftests/ublk/kublk.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2072d880fdc4..24557a3e5508 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -679,7 +679,10 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	}
 
 	ublk_ctrl_get_info(dev);
-	ublk_send_dev_event(ctx, dev->dev_info.dev_id);
+	if (ctx->fg)
+		ublk_ctrl_dump(dev);
+	else
+		ublk_send_dev_event(ctx, dev->dev_info.dev_id);
 
 	/* wait until we are terminated */
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
@@ -867,6 +870,9 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 {
 	int res;
 
+	if (ctx->fg)
+		goto run;
+
 	ctx->_evtfd = eventfd(0, 0);
 	if (ctx->_evtfd < 0) {
 		ublk_err("%s: failed to create eventfd %s\n", __func__, strerror(errno));
@@ -876,8 +882,9 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 	setsid();
 	res = fork();
 	if (res == 0) {
-		__cmd_dev_add(ctx);
-		exit(EXIT_SUCCESS);
+run:
+		res = __cmd_dev_add(ctx);
+		return res;
 	} else if (res > 0) {
 		uint64_t id;
 
@@ -1044,6 +1051,7 @@ int main(int argc, char *argv[])
 		{ "debug_mask",		1,	NULL,  0  },
 		{ "quiet",		0,	NULL,  0  },
 		{ "zero_copy",          1,      NULL, 'z' },
+		{ "foreground",		0,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1087,7 +1095,8 @@ int main(int argc, char *argv[])
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
 			if (!strcmp(longopts[option_idx].name, "quiet"))
 				ublk_dbg_mask = 0;
-			break;
+			if (!strcmp(longopts[option_idx].name, "foreground"))
+				ctx.fg = 1;
 		}
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8f48eb8568ab..26d9aa9c5ca2 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -67,6 +67,7 @@ struct dev_ctx {
 	char *files[MAX_BACK_FILES];
 	unsigned int	logging:1;
 	unsigned int	all:1;
+	unsigned int	fg:1;
 
 	int _evtfd;
 };
-- 
2.47.0

