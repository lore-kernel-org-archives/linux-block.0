Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ABD296169
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432218; cv=none; b=neZPI6zJpPiP65qcC+1Zi3q1sDjUHJe6wAQvxIs1mK1SJ5JAFE8tkLAsesG4XbG7OKJaq60YX0dDPAgYS8OywWfqqIrGZ7osfdZqwgSdDrMi1JUWhiLC0Y44/IJySAaSAAbxDjzTlxoWKhMQQHT1ZrTclKyCn66wbsptiIjyNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432218; c=relaxed/simple;
	bh=06jO+xneWT4lpvWDZoF+YfkKzDuZsUu+kNszLZWCfg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKDUtAttgXWa+e4q2XVnNYN7/nRgOHdDC+v1scvBa+E555y88wvtFj3GKwmq4rWvaJwLen9gOTBba+KCa519I1TBrj2076ZQy69IPBKZChBuTbXqysDisDKZj39Fu/m8rmjSprQLgr4Nw/mQJSDeSXtEoG+zULeKpHATyzePs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xz8AfLQZ; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xz8AfLQZ"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-748e60725fcso165086b3a.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432216; x=1751037016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEmVpb40k282i4yMFazDj0k4V9k5vwFcJqD8nvii79I=;
        b=Xz8AfLQZs7GNxQX4frAyq38JBiLJJlrMi0v4txz7BJ4+E+qmLi6gZbNAbN6T2SPuFI
         khIf69l3vKp3M293NmowBsUuQk2/cr4Xutixx1LJTLP6IwBvD7QN0xlZ+idqgiBVcXOf
         NktDF141ou/OeN1c+iBhuAPKp4VrxK5aTtaGF8PbJ952IR9d0Y+U3e6/POEDtbGrednv
         yxoIRb/iubZToGboBn49+rKWBsrjLbZXO3yZ/I3+gWux1ElpHaFx/89LJ/mQPCmpl+at
         YI1XVyXGpk5bb/TJ/Fi0f2wmIz4MTjKbnzGxJtG3ZQ4sw73hdDkJj41VmiJ0WTVXmV0C
         MzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432216; x=1751037016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEmVpb40k282i4yMFazDj0k4V9k5vwFcJqD8nvii79I=;
        b=XfD9QlufwONMlRD7lqauuX8cHNGoELabTZkQGRLuj+CkrQ9JyT48eRmvysLMUEMFvx
         MKXP3BbokoIGpBaPugWCUOVUXkZfUM8oRSE8oCLhySTg+NEAR0s8yJgg3yIXs+uQq2Un
         4jER/9G1fzp5MNw+SFb1Aq5JBKojmTOWONOAGHiNCt5aySQVlv1SMv1iAXGgEuyR2Wkn
         ProqMv2jQ3ylc8160yCIANC23hXxW8hA7JoR83BsdPD8HBbsmvhHPYzaJrg4v8JZzpKr
         sowluo0+9ErS49munHpduzlSi2H7HGoaST0Rca8dJ2sTAt6qT8SHPb6kP5JuGYNUWii+
         Tmww==
X-Gm-Message-State: AOJu0YyvaP+YSHkQBuBUMUalZyb37xuZX9mvDI3z649XzVh9EEhRaqX+
	HBU164Vh+PycVxr//zT1Y1QBt2aBtNULBYFot1kmvyVp9WcFwOmj0lM05IzV4EXinecTW/ijmII
	9+oLNS4PPb0aiJcwr7YWijy7NtZDHXw0/oFSs8gzOOhCn1f9YrHcU
X-Gm-Gg: ASbGnctzqnDemll7KRuxC2+5SH2wInUFVGAWMO9R4D4jDT+3OB8pmWWICPGgbyEBZwY
	4s6GUKX4q5sGOynAsBTnUAPPjL24NmC8vQPG0RmdOwTD+7pwvWqUxqbzeKz1rSMa18dHdqW3ujh
	9MqRgKWAJYbJHtvWgm75/+qzJlh6fMT5y1ZKRNM2CnKFYjTWMtapZD7OoZ+XUTCIo3U1/rQCYxh
	WsGBBs3owlxc6Y+QY28W8Dzj3ls1kA31TXUfLkg/H1BImbBOKlfUz1EvtD1snFTSW/TxpOxbci+
	swrvYB8MZQ1QXZaVPdjyNkWy3T3jr7rY2G1a+Bxd
X-Google-Smtp-Source: AGHT+IHUbURKNEvS5J56PE/1c6RsqP5JLLbgbh3AUgifV351kqMs4Hhou5QsPF3B9TseaaYxeoYRYyMjU4TW
X-Received: by 2002:a17:903:11c7:b0:235:225d:308f with SMTP id d9443c01a7336-237d9951846mr19010265ad.4.1750432216402;
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-237d82eb252sm1174415ad.20.2025.06.20.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CAF0E341237;
	Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C9A93E4548E; Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 08/14] ublk: don't take ublk_queue in ublk_unregister_io_buf()
Date: Fri, 20 Jun 2025 09:10:02 -0600
Message-ID: <20250620151008.3976463-9-csander@purestorage.com>
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

UBLK_IO_UNREGISTER_IO_BUF currently requires a valid q_id and tag to be
passed in the ublksrv_io_cmd. However, only the addr (registered buffer
index) is actually used to unregister the buffer. There is no check that
the q_id and tag are for the ublk request whose buffer is registered at
the given index. To prepare to allow userspace to omit the q_id and tag,
check the UBLK_F_SUPPORT_ZERO_COPY flag on the ublk_device instead of
the ublk_queue.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 893519f74625..237d50490923 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2023,14 +2023,14 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 
 	return 0;
 }
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
-				  const struct ublk_queue *ubq,
+				  const struct ublk_device *ub,
 				  unsigned int index, unsigned int issue_flags)
 {
-	if (!ublk_support_zero_copy(ubq))
+	if (!(ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY))
 		return -EINVAL;
 
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
@@ -2227,11 +2227,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
+		return ublk_unregister_io_buf(cmd, ub, ub_cmd->addr, issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 
-- 
2.45.2

