Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DC33EC
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425095; cv=none; b=TzUwMOpRdVZ182S4f5pJs+qlwpQDk04Nu6+UTBh5Pyss6gF3+x5Vt3mj5Gm5NuBUd+oKYTrEifAbc1fsMAS5hV6uufYFFS8LjuPgDm5krGd1nWes2ctmCzykrn5CpjYTzqOadNn7zZii0jg0JZ5yYV9pRswQRfV2THfufd3vzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425095; c=relaxed/simple;
	bh=OJmYORLMMZRMJy3qBFz7abfIKiTqOE3n7JE5vPpAOOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyPWivYxZnBW2xqMZRjIxdSP+4nFPB7Gnp99H4tbXNWn4vPyIcCydgpwtKqsfJYOzN0fNssgC4ApGwx93y5lsg3FbZRiYg5CGZb32Qz1F9ISsMRKqnrvve8S27fhXJuW8hGpGf9C36R5/7JbO78LF9gtBaxK5FHYLzaj5maCebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXE9zNUQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXE9zNUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2Sk+V83jjilrMDWD2eTDOuwM4QZgZvGdCz5acDjLlQ=;
	b=IXE9zNUQeUQdqqPJyUWeSjIalzFX7gh7lx9O5YZ1e520v+umO05v48z9XRnNGKvlUX5J4/
	crNx4KyNdVO86q1jS2v+Lx7960tudPJX7hPeQ/IJk7tS6OVmok2/8n3C1AeBJZmW9Zj4cy
	OrHpi6WUhn1l0vJv25qAT+ffPX8jKtM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-1Mw4eI-fMDmmmsqsrOWaaQ-1; Fri,
 11 Apr 2025 22:31:27 -0400
X-MC-Unique: 1Mw4eI-fMDmmmsqsrOWaaQ-1
X-Mimecast-MFC-AGG-ID: 1Mw4eI-fMDmmmsqsrOWaaQ_1744425082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E2DC19560BC;
	Sat, 12 Apr 2025 02:31:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 923561801A69;
	Sat, 12 Apr 2025 02:31:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 09/13] selftests: ublk: increase max nr_queues and queue depth
Date: Sat, 12 Apr 2025 10:30:25 +0800
Message-ID: <20250412023035.2649275-10-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Increase max nr_queues to 32, and queue depth to 1024.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 tools/testing/selftests/ublk/kublk.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 1e21e1401a08..5e805d358739 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1203,7 +1203,7 @@ static int cmd_dev_get_features(void)
 static int cmd_dev_help(char *exe)
 {
 	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [backfile1] [backfile2] ...\n", exe);
-	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
+	printf("\t default: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n");
 	printf("%s list [-n dev_id] -a \n", exe);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 85295d3e36cb..9b77137b8700 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -50,8 +50,8 @@
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

