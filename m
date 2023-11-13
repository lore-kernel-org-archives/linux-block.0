Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8791CA9F
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQTJjxXD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F672132
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 05:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699882516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rd5wXFKP5VvBWNnRMv+X+RHVBl1lZC+yFCwFPEe09FU=;
	b=CQTJjxXDTDs6NpwYqz8jKKQnYMaNZbO7t1ay7a4qJK0bELFQpcAggHNBd7akQ4SzapvmhC
	BCpHY3dRwuEUTlKmEEfF6QEjPG76/8qlCOFBTe5I9rl70Fuzfw9f08f7Bu0nJ/SjSH3TTf
	2RRDl9TOG0oSLaY/HtJwA2xoe6aJezs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-ftAaGknRNRqN_dfulxl5Ag-1; Mon,
 13 Nov 2023 08:35:15 -0500
X-MC-Unique: ftAaGknRNRqN_dfulxl5Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31B7F3C14909;
	Mon, 13 Nov 2023 13:35:15 +0000 (UTC)
Received: from localhost (unknown [10.72.120.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53E79C15881;
	Mon, 13 Nov 2023 13:35:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] common/ublk: allow to run ublk test without building miniublk
Date: Mon, 13 Nov 2023 21:35:03 +0800
Message-ID: <20231113133503.2768452-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Now `rublk` is enough for supporting ublk test, not necessary to build
miniublk any more.

Convert ublk common helpers into ${UBLK_PROG}.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 common/ublk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/ublk b/common/ublk
index 8278d56..5ccbb50 100644
--- a/common/ublk
+++ b/common/ublk
@@ -8,19 +8,19 @@
 
 _have_ublk() {
 	_have_driver ublk_drv
-	_have_src_program miniublk
+	_have_program ${UBLK_PROG}
 }
 
 _remove_ublk_devices() {
-	src/miniublk del -a
+	${UBLK_PROG} del -a
 }
 
 _get_ublk_dev_state() {
-	src/miniublk list -n "$1" | grep "state" | awk '{print $11}'
+	${UBLK_PROG} list -n "$1" | grep "state" | awk '{print $11}'
 }
 
 _get_ublk_daemon_pid() {
-	src/miniublk list -n "$1" | grep "pid" | awk '{print $7}'
+	${UBLK_PROG} list -n "$1" | grep "pid" | awk '{print $7}'
 }
 
 _init_ublk() {
-- 
2.41.0

