Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3023242D7
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786743; cv=none; b=iFdXGj9jx73Z+R6ZDFFH1yKfoYy6V0mDd20Xlf6zBsqbnzkxgm2Gel2c2PtjyL5XqciKwGl6QOO1oC4u2G21/RqqREg4lCsVG0FJH1M4kaUjoZpLabAU/f+VqnmXrWJvi/tPaiA2H8CpQbt9wuAxCxuHjjrSOEa5nKuj8kC10NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786743; c=relaxed/simple;
	bh=wKqc5wL6bmJmWU1bp7rBaZXhIYlpKw54rXza8d084hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmWV0OpZ/yqMnANkE1Kqcje0uHwRV4XKG7+nmbDYaTiVAznmD/EXI/Lqzj/Z0/gaex1MtW9EHHeIA2gc5S470WZiuH1EvwuMmFj2QzQcziCLlnxbBGOlLGG8/odW5YvFaKTKA1qbl4ULa29Keccj4ghm12X8oPg4UwTojFrpdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TQfg0XC/; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TQfg0XC/"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-352de4c94adso251652a91.3
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769786741; x=1770391541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22ajtlAGYSup+nUm/O6p4DsQdEeWGvJ4Xo9qaGa5Z+U=;
        b=TQfg0XC/Vwwm1/MyMQXRDfNmUznAlCbYpTJ8PonfsHn3I9omqNHnSVGSVFN8L/VwFK
         J/FgZWk/tbxjAyYvK4GktNEhFvzoO+NkM+ify5d40rQCjUxc6SwLDft2aojoAVu8MxxT
         bX8DIM3GOSe6k31igeL5Zi+mU1VYAiKDuj4Opw1ft+6Q7b695j3eQHsMj2f1iXayjTy6
         38daDy6VeotU1bebvFE9HrqCrd5qkKKhT6JkWywA8YjW19GRcN1bQwW4WbSE3r6qsUlT
         3P2U8uVAwwzL+KsJtaSIu0A/tJZOFi+R3XyfhUUE/qQds5E6/BJXIBeSq+VjDBsDNhtd
         g4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786741; x=1770391541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22ajtlAGYSup+nUm/O6p4DsQdEeWGvJ4Xo9qaGa5Z+U=;
        b=S/uQfgDJVDh7AzewJzpqFsoyrycFCmS9FRKUJihIVu4ZfZAFZpKyUgzvI2WMbtBV5E
         x5KFS/SXiF8BRJtCQXeVciamXos7JB+EYu2ku1+w/519ajsWm0vd7/PVFZoIOFiXCimJ
         CvpmDqPZQue10oiCMiLuW6qlcQQM+BgCa90IrjJQjXNdShJlO1/agKA7TXioxdWJyRRx
         DC5TnJiurJqcccOxOfHqemnKieWkvt4PMg6RK+J6Ssw96SRTNfJYCWROM2/JPk+98WR0
         OKMZ9Ze6f6sT3WoNuV4vdVwuXeU0U/iQNhets9zCBvuDK4MJGmIpnE/e0pDuzAjVi/7C
         2oVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwtxYtfccBbIEzizDohZGW6ublGLOrxz0MVKCfrsBntk9DCBm2HktGOTkfU+/qspIeNS9lm4P5ES9NxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwquxKNwTWZxmm7sO7myBu1jp/uSfN6a+59hvi6+M4M61GrMd
	0IjB0CnQl8NE6OpQ77hr4jT1huitxe3a+d4s1gVaYPVkAFZlI/ZCiyALqdn+7tufNjX4VL5CJlB
	0XqDvxO1B5Cw7sQQRvClmgCvuAHQ8cSpWWap9W+zq6Vles58Ce9Ub
X-Gm-Gg: AZuq6aJ0fIUM68Q5t9mSLWqdeRISaSWgwBgb8kTWa238Z1bjMjPF+YuBFor2PxawaW2
	RM95wPX+PId5lw0tebKtTmdbJdGTokYRUPNwrYf+HitQM0BkIIjI8Dj8PiCkMPAKHZLSyTRUYEl
	jO+VyelungGcu37r5tmJMNf9Hx5SeCKw4CpSZLifDqCmbCvzL4FiY77gASwKgk6WgssxBzN4FCb
	ZwjfuiHVvUoDgNK3Dx6fOf1jyrsJ/w84LaIoJqbjONSstPDMmcVJutkSwVPqp1wA9+E/WuT9H5G
	zDSGrkNx0tcA/TPypnzuQy/Yh/jeFIc7TXPQ3BEnu/kUkz8ZhySq5DJmXV/pncEGw4rIVUeqif/
	pAsY+ynToWH0w8Jd8IOKgjKneaOQ=
X-Received: by 2002:a17:90b:3ccc:b0:34c:2db6:57e8 with SMTP id 98e67ed59e1d1-3543b2efe3amr2777148a91.1.1769786740685;
        Fri, 30 Jan 2026 07:25:40 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3540f3b5f8fsm1166983a91.7.2026.01.30.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:25:40 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E3765340603;
	Fri, 30 Jan 2026 08:25:39 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D42EEE40A28; Fri, 30 Jan 2026 08:25:39 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove "can't touch 'ublk_io' any more" comments
Date: Fri, 30 Jan 2026 08:25:30 -0700
Message-ID: <20260130152531.1274646-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct ublk_io is in fact accessed in __ublk_complete_rq() after the
comment. But it's not racy to access the ublk_io between clearing its
UBLK_IO_FLAG_OWNED_BY_SRV flag and completing the request, as no other
thread can use the ublk_io in the meantime.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5efaf53261ce..1c8699ea7abd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3336,11 +3336,10 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		compl = ublk_need_complete_req(ub, io);
 
-		/* can't touch 'ublk_io' any more */
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
 			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 
@@ -3668,11 +3667,10 @@ static int ublk_batch_commit_io(struct ublk_queue *ubq,
 			__func__, data->ub->dev_info.dev_id, ubq->q_id,
 			elem->tag, ret);
 		return ret;
 	}
 
-	/* can't touch 'ublk_io' any more */
 	if (buf_idx != UBLK_INVALID_BUF_IDX)
 		io_buffer_unregister_bvec(data->cmd, buf_idx, data->issue_flags);
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ublk_batch_zone_lba(uc, elem);
 	if (compl)
-- 
2.45.2

