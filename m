Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C02185BC
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803190; cv=none; b=Yw+0FYuvqFNX2H07bLOtGR4GRgQCZfGWbNPshs45ssCxU3OxpHshN7JM/qF2z/5pomk/pXudozdbDiWqHoUZ9s5o9UFxfVY4AaIymoqEe/Ll6Ff/Dgq0cBKxD9gQs2MGHjl/YqVwZ28/X1L1pq4HX/eVTcSW9H0P6QcuUgHuIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803190; c=relaxed/simple;
	bh=eXF8/XD01j2Ty9XvOcoySCOWkduVltm1ZqzpzJOWYrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1nuUiJaeBtsoSUAH9NSFASv4vR4iK8OiNBlge09wemZv0liokD9MLJ0LOsQ6pVdnHNZ+8TRo7SMa2ufeLFlnwAsnih6/msmgt0RCkS6hi1qvXT6cSQsarHDy4E4RqtCLLiry3e0VIpkAEUtNNJaeoc2l8wcI6zcQ4ve2vVkzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTwpEul/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTwpEul/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgSHXNDB26taU8EQAYo/AJdP3xa4h4q4NPUlH+u3ktQ=;
	b=MTwpEul/IShdUJ9l9Koni1uFRcsQzQS7W3yT0cUZ7jIf0pnPLAuTW8G+o8ZOCR1APdS/Sz
	083W1otG8Bx2MUO1pM6ilqT+twN0L7LhgVg7rj0+jFm3nsoSEsIUG2lx+vwHgBe6mzhlF8
	hMvofLkvBgIVDf5F9+TyDbPfdIUghaE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-uDj1HI9xP7-VmiwxVgik4g-1; Fri,
 09 May 2025 11:06:26 -0400
X-MC-Unique: uDj1HI9xP7-VmiwxVgik4g-1
X-Mimecast-MFC-AGG-ID: uDj1HI9xP7-VmiwxVgik4g_1746803185
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B3FC195608E;
	Fri,  9 May 2025 15:06:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A90618018B5;
	Fri,  9 May 2025 15:06:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/6] ublk: allow io buffer register/unregister command issued from other task contexts
Date: Fri,  9 May 2025 23:06:04 +0800
Message-ID: <20250509150611.3395206-2-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-1-ming.lei@redhat.com>
References: <20250509150611.3395206-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

`ublk_queue` is read only for io buffer register/unregister command. Both
`ublk_io` and block layer request are read-only for IO buffer register/
unregister command.

So the two command can be issued from other task contexts.

Not same with other three ublk commands, these two are for handling target
IO only, we shouldn't limit their issue task context, otherwise it becomes
hard for ublk server(backend) to use zero copy feature.

Reported-by: Uday Shankar <ushankar@purestorage.com>
Closes: https://lore.kernel.org/linux-block/20250410-ublk_task_per_io-v3-2-b811e8f4554a@purestorage.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb612151e9a1..31f06e734250 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2057,6 +2057,12 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 	return ublk_start_io(ubq, req, io);
 }
 
+static bool is_io_buf_reg_unreg_cmd(unsigned int cmd_op)
+{
+	return _IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF ||
+		_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -2076,8 +2082,15 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	ubq = ublk_get_queue(ub, ub_cmd->q_id);
-	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
-		goto out;
+	/*
+	 * Both `ublk_io` and block layer request are read-only for IO
+	 * buffer register/unregister command, so the two are allowed to be
+	 * issued from other task contexts
+	 */
+	if (!is_io_buf_reg_unreg_cmd(cmd_op)) {
+		if (ubq->ubq_daemon && ubq->ubq_daemon != current)
+			goto out;
+	}
 
 	if (tag >= ubq->q_depth)
 		goto out;
-- 
2.47.0

