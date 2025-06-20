Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8952BDC05
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432218; cv=none; b=oWtkVmWcs0kw9pBrI/iMWu2wTOXvyvZtrRsRzKoFQtRYD7Zmz61zjaGxfW0N6G7rolzkLCyEvw9GhNfiTvwsExHtSeKSgQdZAJ1tN/Xxv+soNJkfCIUZ1P62+ylfLyqV7Fl1QXz6X3GQI6tT8bF4405JOeKSDFpVRGbTDFqUxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432218; c=relaxed/simple;
	bh=Y3EP20ja8w5wZ8nghr3XXGIA3j3LnwaEJ4fGymeLhvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIO8jxoJ6pasT9pDpw7mNfl1efHBAWVzP5rSvZ+atBc/ehpbd/8I39gH7e6NoFL+AY6NUUPZyu8rlfnpOsYN+jtiCc4ZoztksNKsE685PPxaNcyi2HR4Xmt1LOii5QMvlqyaWkB/YJcy+dkKyZtHHCblXJvfa8qRXHHUNOQQv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W/URPb8v; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W/URPb8v"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7426c4e3d57so139999b3a.2
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432216; x=1751037016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZNyEN0fUAiYjmUg4yUHifBBownW6GnOmbhDJBa5Eqo=;
        b=W/URPb8v/w3oeicEKitJH6Pg36D+7nat0IosK1Zt24R9UtAHmqgW21NaB0+5olZ/1x
         24C7PppTeC285pZjQfWKw9LgtpaYPImPLC0nn5zfwd6QHYeKpdxCUJY8xTBnf4VCglWY
         stnt5V5iwATcK5wSa/ZKndVxsMlG/jTqdJAr6uF7CmPdUQLnW2AuSUurrSOsuh/3z94d
         a3uizPkvu04BoFBXB8aNrBzRXfeuNZssrUQn7RWjMuTuKOHeA005B6xB7JvdHtlMBLG9
         +ebP/sz6QdkTx4Dfu6uXiV3h0qCy2is+vMPH18oEek8wJPoZHR1qt41fW88azxu8JhZJ
         hCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432216; x=1751037016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZNyEN0fUAiYjmUg4yUHifBBownW6GnOmbhDJBa5Eqo=;
        b=ilSIjUKLZc19mEl72Foaaz0/UUg/x6PEvv8MZ8Id+ArredL4sOxYedr1APUO9hrra2
         8gjaNKdoVCS7NVE27uyCSgwDeHM2TKLzX00+A+7VnF+yRYoEPknWVsxxO1xwhBrJKi7P
         el/jWNzC6LOz5rFBaGB+IOxG6DmIh+0H0cnmGqnpJDiRpecPxu5bUve9U00VhX4err37
         0BIrXzgQ5S/k4Qqy9v/LsqbFqAg3Lv2DB/cz+JDB5VA/sr2I+4Nj1eAeqUfXnh5qHbI6
         Z+7Bdpwep4lPRPRRqCeS2ZW5BS3CeNN2aLwgzQMOoa/outBrNq21EtKebVZgEpCvx1hR
         ipOQ==
X-Gm-Message-State: AOJu0YwYg5L26D9io2Y5mGjYD9Y2wRXPKsi9gvgunEacd3s5IHQOgNrh
	3+3JkVHrvcrVyaYaTfXssVvi9VMBfYji03+1Gw4bjoyn8ZUxnmzBcoN9PuD12ULb2JeI3iQKCdJ
	g6AwsI+prKagxRgenuLkzNP57ZOV0zSgCr5Tc
X-Gm-Gg: ASbGnctrdpgeoXXmehDSk7Mj85wAmWmudqVfprqRhxUpfhayAcRbCrX5RgvLZfm9KA6
	WcoiJYg2wbMGTanJNNujZ8pbELNZAD9ydX39cuprugW56t/plkoZGEk9R78A/pTnTnriDf9O/fE
	J6bsDMpWHHOlYUsbA4oDVIPZZYB7IfMsu35aJqEElMwGGaCLryKnoztOeRCZI4HHVf7gUlNqBMl
	P/HO+jusxcF8VRfBJt3h9dhHRNDJAWN6aLSa1WB05+WYJrMhiuhXKhWA9kaUJ8FBM5DGlDTctE1
	T86TL02OA7I5bfjaQBgWBg1YLTm1mrI57P9v9CeK44Mid/Bxko0SgJo=
X-Google-Smtp-Source: AGHT+IFbAsugtWpCZxD/JDUCm4UJEJiG3LnQNjpt55bb0Lp7UPConPz9EQoeQXLbYiBHWp4j2GGQkOq+m8Vf
X-Received: by 2002:a17:903:11c7:b0:235:225d:308f with SMTP id d9443c01a7336-237d9951846mr19009925ad.4.1750432215530;
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-237d85a017dsm1194175ad.109.2025.06.20.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 086873406C2;
	Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 07B5AE4548E; Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 04/14] ublk: handle UBLK_IO_FETCH_REQ earlier
Date: Fri, 20 Jun 2025 09:09:58 -0600
Message-ID: <20250620151008.3976463-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for UBLK_IO_FETCH_REQ early in __ublk_ch_uring_cmd() and skip the
rest of the checks in this case. This allows removing the checks for
NULL io->task and UBLK_IO_FLAG_OWNED_BY_SRV unset in io->flags, which
are only allowed for FETCH.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index aea2e9200311..8df70a5fb129 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2197,23 +2197,31 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	if (tag >= ubq->q_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
+	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
+	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
+		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
+		if (ret)
+			goto out;
+
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
+		return -EIOCBQUEUED;
+	}
+
 	task = READ_ONCE(io->task);
-	if (task && task != current)
+	if (task != current)
 		goto out;
 
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	/* only UBLK_IO_FETCH_REQ is allowed if io is not OWNED_BY_SRV */
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV) &&
-	    _IOC_NR(cmd_op) != UBLK_IO_FETCH_REQ)
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 		goto out;
 
 	/*
 	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
 	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
@@ -2225,15 +2233,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
-	case UBLK_IO_FETCH_REQ:
-		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
-		if (ret)
-			goto out;
-		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 		break;
-- 
2.45.2

