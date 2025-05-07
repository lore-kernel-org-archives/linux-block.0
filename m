Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7A2BB13
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592777; cv=none; b=s5m7WMpH3RgYEC36OBJjPaVkxdFPoRO6apZMVqetSjso/W81140Myr6G//Mvfx1/Zx0c3BD5w/h1XaZJ2QHo7q2q3OEEZHH/XDhmkatJB+RMzn9c9Fi7pV3PHzfjrgSuWjc235i2AZExOinfH+zxF6PD/id6tnZPfKTxo0rWcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592777; c=relaxed/simple;
	bh=LwdaGXT1KG/rZCul2+Q/cyBnRUoVT4uOEmILHzjYjB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er8eyhzwrJlt+GIKbkPCIS6QfHrEkEPjMXPWboUvhdJstH4WEOfLu65GmxW0ZJNtqexwx4Nk8JmG5FOdn6SwtmuFstDmb+ttcNtWUrJtEnvlN9zuCZvPa+mNN2se2+n+zeXm2ll64hmlgVBwcHKCl2XpqrPUMDFzDu52yRQjjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgnyLuho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgnyLuho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746592774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RndyJqP0agyyqUMJXlr/Ufhy8nOey+MiIk6RRudamC8=;
	b=UgnyLuhoUzaQmIDJRKJV7a699ky+mTiSQ41CXp0Vvk4YQ/CWgMh/ACA9DMDWPQ3xmnIsuk
	FKS0R+pIdNvD9Nn3wmeGduqlLOvpdVHoPjUxqVEq4b3nVy3iQhm7SJSFUfrzGXpP8ijvf+
	QWZ9oO9GKKUhSsw3RTcyFfoCCwFQe0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-eV73wE-eN4-CfT2fA7alTA-1; Wed,
 07 May 2025 00:39:25 -0400
X-MC-Unique: eV73wE-eN4-CfT2fA7alTA-1
X-Mimecast-MFC-AGG-ID: eV73wE-eN4-CfT2fA7alTA_1746592764
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0F2D1801BD0;
	Wed,  7 May 2025 04:39:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB9861956094;
	Wed,  7 May 2025 04:39:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/6] ublk: allow io buffer register/unregister command issued from other task contexts
Date: Wed,  7 May 2025 12:38:52 +0800
Message-ID: <20250507043859.2978132-2-ming.lei@redhat.com>
In-Reply-To: <20250507043859.2978132-1-ming.lei@redhat.com>
References: <20250507043859.2978132-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
index 3650bab40dd0..4df0a9052247 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2058,6 +2058,12 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
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
@@ -2077,8 +2083,15 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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

