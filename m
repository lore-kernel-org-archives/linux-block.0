Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4C254B13
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031801; cv=none; b=J89h2C668bJOw/euZD08xAFiBawSBeuusX43XYRuG7D1ZJ/qayd0e8WpWcMt1ElT2wbs6z0hWJx2qWzHYlMCfFyyyHjKNdU8rmyQx+nq8C3T0NB7ud5tPKVZC8J9ZzcqV8mFbf5QnVkPpoqmokPcQrCgHJH6mQVCgZWU7aYPD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031801; c=relaxed/simple;
	bh=fgiKcRcJapD4jX9lV1y2DRRxJV8ukyKoKH7hxLO4YXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GT56kT5jYCtZAkMc2xUW3ZA+a4xOpVy8/okhVc/DdNvqqD6a7AZlNeXQ8gFxcJ+M8nTsqTHTNJ+oS2rudzrcnv19fa6r9JrpIg3qY55dTHe8WVsRPRsDMT/uKLPmj0XAUnzI0KVpgG3PtnXhq+wntHE7bme80afO/wbCA5KAczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kipgn1s9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kipgn1s9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEIpbCPqfekC0sr2spoqX/9oM+Ec7lAIP6js5iogx/I=;
	b=Kipgn1s9g6IwYC7MwZWMyaLcOSqVDeDdRbVh3S0nq28G12bmUdjPlhy1GsZ3uF6qr9vyEo
	qZuuZ5c8h0ObWiR7tqYsc5Z3cjkNjuJwuzGxJ3j5ZN68MQG/etKyCzRvjRb1yequefmeBj
	BK4RtcSTyPvTHQAmVCtvVhMdJfyE+4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-ZdTRTqGEMyigdsDSdUB7jg-1; Mon,
 07 Apr 2025 09:16:36 -0400
X-MC-Unique: ZdTRTqGEMyigdsDSdUB7jg-1
X-Mimecast-MFC-AGG-ID: ZdTRTqGEMyigdsDSdUB7jg_1744031795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B55AF180025C;
	Mon,  7 Apr 2025 13:16:35 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C7993001D0E;
	Mon,  7 Apr 2025 13:16:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 10/13] selftests: ublk: increase max nr_queues and queue depth
Date: Mon,  7 Apr 2025 21:15:21 +0800
Message-ID: <20250407131526.1927073-11-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Increase max nr_queues to 32, and queue depth to 1024.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 tools/testing/selftests/ublk/kublk.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 464abacdbbcb..11cc8a1df2b8 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1204,7 +1204,7 @@ static int cmd_dev_get_features(void)
 static int cmd_dev_help(char *exe)
 {
 	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [backfile1] [backfile2] ...\n", exe);
-	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
+	printf("\t default: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n");
 	printf("%s list [-n dev_id] -a \n", exe);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 526b55bceb27..5b6b473e1c9a 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -48,8 +48,8 @@
 #define UBLKSRV_IO_IDLE_SECS		20
 
 #define UBLK_IO_MAX_BYTES               (1 << 20)
-#define UBLK_MAX_QUEUES                 4
-#define UBLK_QUEUE_DEPTH                128
+#define UBLK_MAX_QUEUES                 32
+#define UBLK_QUEUE_DEPTH                1024
 
 #define UBLK_DBG_DEV            (1U << 0)
 #define UBLK_DBG_QUEUE          (1U << 1)
-- 
2.47.0

