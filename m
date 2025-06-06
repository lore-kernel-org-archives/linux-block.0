Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DF1A9B3D
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246059; cv=none; b=rty4NVHW+0X8n/ogoZpjFLjp6gk0L0HPVu5RDisnVEGSeSA9atDRxR9iHjObf858dA06qZYrQqsKz7pexj4cvsWPN9RGxs7JZ4QgFNYbgvHTvG/F1ApCOTJr9Wx8fhRuVzMijN+hYjQzMRwXcpD822X5FHBoxZUKHtHQUMH16MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246059; c=relaxed/simple;
	bh=SWh42KMper6sprxxIYW44xHfOnFWvIgrIVCi4Mo5fwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGx8UR6Yq6F4pqYPiOrq6lizd+hFaYDmIJcoql7d/V6tnn8bVB5sbtPYhLca1A30o1Dx5Q22yU91ozSL0HDVWPVk4F30evbRIA5jZZgvRomwbK7seefdMARPM8e6N1mHuBwbAiKneTuXrMrz3ugtw3pfnUbBPeWye/NBfV8I8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KIQnK4zp; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KIQnK4zp"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-234949fd425so3780705ad.2
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246057; x=1749850857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ2taOAubkjBBb0Zholq+uF7AaW+J7M/foY/a5BCdM0=;
        b=KIQnK4zpT065PZJaajnnNjrmJFrgmrV18i3vhL+FR0/owb7MJ/IaRE5ZDCMwgtj1Ly
         Vl/VrlOWHJntaZOcAW0wLOQRfKulfV4sZ1qmdtWf2Rszpzxz/Y+5I1WgNLb04Art8Kwt
         7I+qIohzsjSbHv/0dvLQCOgtmZFPQk/k8mlrTaS9G66ac0vBcuPM0N1Jwi06DTbVpLZ8
         Q1E21derulm1VBcsSYSOAsgydLScDNzIOOwvizw3MR1kgk+JToDXkVhPjlgEwip0rh45
         KdnH+4TWXrEYFWGYxKzyrxQCa8ZEFDtSMrOYmJlvJ1tvgxihUrmM17PoCKQkeBlQKgIR
         urwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246057; x=1749850857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ2taOAubkjBBb0Zholq+uF7AaW+J7M/foY/a5BCdM0=;
        b=vaqJUD19F6K7NGX+PgqkhvoDb1lpQ++Exgsd+n3rEE7i3lWeBsyk9jvHDYZ2oG/e8E
         zjOyQiARP/+DmDkKo1zYZfEnOSZobDscXrLC1pZVX1TV3BCQM/HnMxXqzlnAi/y/gO64
         bb/MobrI0cv6jjbJGUFEhLCXv4SShUVqtBfzYyLUjTLfqGM6E2tb+K3ZB/UYKOC9GZ/T
         21TbDxmj0ceUzRkzh0eZArJy1bjKjnMisOu+nZeSdpVmDdGsIjKasqS9RS9BTQLgl4MR
         Gc3HjpJslGPVnxdTOeYiWeYWTYura/40XJ4b7vy6d6amUjTzTvNByivsmlJOUtGcmAmo
         QLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmXnu4B5bFgKw5OBzweeZ7XXtTleinJ49TZ8WAFMr75rRsfFnmMnl53MG85Hen11TIwlSxgXf4/6DTwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7S2shdkZuot1/Mi5W9FWkAYtB8UAi9JvDhN4id0YykATfEiL
	1gOHDNZooVXgiZVZGzI9tTD9jTjdB/i9PQEiO3KTYCCfaWOKFPI+khp/5rOOcv69NujNTC5IvAC
	czU/2z/8ylnERrQIejxCfulMPO+baI82aia6O
X-Gm-Gg: ASbGnctiFzxkld95Rwg+CU8I1JyR9dnn3jCMrDXuY2AybpAsB2fns3tbPSyE8OGiK7H
	iiLXyL6ed5B+d7mma9gLyujoL6suVeLKQVownS4lAizTveEkHEbpaK86Xu6S5Rs9LI0/2B0jZ/4
	fhCIYCq6FNnz2ZJXaFnw0xv9dyNYivGxyvFiR4pt11jHQ5Iu+/hVcPGBHDR8zMY1lcpe3YwB1ML
	Ghjt3ojirueZFxKg9irk9X8unPAnKyvx0j6a+Zr/84mziHe0eUAKufJrGrtJS/YagTuS0A92kRa
	sPPMexCHKdhkbDbOnpO7eIDNQfOvUxo9Wni2ACX8RvG8
X-Google-Smtp-Source: AGHT+IFVxwotxYgXOUvX0a2SvwQuwHUk0I0mSxnFSMv7/lFsTsKczkMYZKcujkLD8acoSIIpq/26QyPvSjro
X-Received: by 2002:a17:90b:2886:b0:312:e9d:4001 with SMTP id 98e67ed59e1d1-3134e4531e8mr2194784a91.8.1749246057267;
        Fri, 06 Jun 2025 14:40:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-23603091679sm1276355ad.45.2025.06.06.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 04F1F340332;
	Fri,  6 Jun 2025 15:40:56 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E7A29E41B63; Fri,  6 Jun 2025 15:40:25 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/8] ublk: check cmd_op first
Date: Fri,  6 Jun 2025 15:40:04 -0600
Message-ID: <20250606214011.2576398-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250606214011.2576398-1-csander@purestorage.com>
References: <20250606214011.2576398-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for skipping some of the other checks for certain IO
opcodes, move the cmd_op check earlier.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c637ea010d34..e7e2163dcb3b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2175,16 +2175,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
-	int ret = -EINVAL;
+	int ret;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
 			ub_cmd->result);
 
+	ret = ublk_check_cmd_op(cmd_op);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
 	ubq = ublk_get_queue(ub, ub_cmd->q_id);
 
@@ -2213,15 +2218,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	 */
 	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
-	ret = ublk_check_cmd_op(cmd_op);
-	if (ret)
-		goto out;
-
-	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
-- 
2.45.2

