Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB1244675
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160243; cv=none; b=mGzlnEgABRoiW9DQn0YMF8bdrhviMTydTmZZSiLA/lg4myiiBtLUtNw8JouyrEMK/XniflnVhL4Z4VtrL1xBhaqMN/bv2Dkr4HpYvJdCmHc9uRzynQ9yfQXJ7h5AcKYoneX6JGQIKh8Eky/lysRv5lFi31ePi4LR9bn2n7hEQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160243; c=relaxed/simple;
	bh=LD7GxM+gs4J06+KO3s9XTbtrptCvgiR0GxZpayLPnFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UybhUlDWb4I6w89t0mV7MLM1go6bROCI1vWdPXswaMWn4mF+oHE/IJH48qS74Va2ySerBXwBNwQtPxrmYiyb9SYYZYLekqSuc77POcbQ/NEbL2z6b0pfRFvH+RUIkj/MLUJ5I2P7GgNCYGLO+zpnSKLKT/8dGhd+OboWPzDB5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UgRFZb/p; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UgRFZb/p"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-24602f6d8b6so756335ad.1
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160240; x=1758765040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLvUwZyV+8EMwdu5ifCxWRlG+h61DttvJKRFa51Lsvk=;
        b=UgRFZb/pdGRaW0LOZHE8ONwtJbRues/Nb/yzqiCcn0ByudEPk0PFxO3f1DpRXeV36e
         KAgtVWTA28l7/+drQqBTpheZ/2nBKZFqb285xDFCQwM7fO8cde3TvwUHQCzNer9nWKkN
         g/RP4xqK+oKd0XNOEsDdyOVXdqyadituRm/uIf1Bkx3uGmU8PtzpUQtVbJznfNzoMDyb
         GwcMwX2jQeKHKeZLk0QqSLTlDsxoD8hWsWgp+w/FakHuGwoF35Avsju/x1XEqQ5J7SVg
         C9lHCugB4nJwC8QbW6ZxUKyJX06lBJq+5MMjvIXay1Ce9cNZ24aPHH8HZXtq4MH4r8Bt
         D3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160240; x=1758765040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLvUwZyV+8EMwdu5ifCxWRlG+h61DttvJKRFa51Lsvk=;
        b=oM4MWB6THFF7ZLJQbyTX82NTwImMbSfJSYCgPMswROVkQaPZprlLERQQcbRMGgENvJ
         CzCgOdQNqifKTUY5zyDweBGNZ84m7ep0ijDaVcUT55C5TbnNgfvcfQ5TfGqK6e60zC1g
         IiCqYSohCmPmgG53025v+ZZm19kiKrhGtZ9G9R3gOASkIKujEZuMs4V1b1/sqCwTEdkL
         LrIcD03UpVuDwldjFSjqPvOKG+/1KCGEc7PtZwk/iGIEsZTA+QCQF406QaGKROCLkAiq
         eRLAaqAxydBf1Ahh9Ua1coIu0qxDsM1cYKdlOzATfM/SxBA6+Pzndk097DejkBa0L0I8
         v9yA==
X-Gm-Message-State: AOJu0Yw4HEZV8c098wckW5xd0ZKU+KDFJpReVl2yPxZA/x2E+2SOVD1y
	hYweK5f1aTz80uhVycAVln1Y+ewrqNmeTIXqh7/zStg5EY1s0W4cwItwY9K/Tx1trAEXVgUziuJ
	BxB6QPQhNmjnK7F0guRpWFq7+d/z1xa6MTCr9ZFr7p1wuAtHPGQS/
X-Gm-Gg: ASbGncvzAMMdEDEbuKW85MdWjnCm3+S37Si3+n2Fif4U8oeDqnzJPrkoMjveWeRQA13
	foLIpW8/jT+mN1KKttUHK7I8pzFXCGUGQgPlYNzCYK2GyEw7Bz4q0TZLiubdgNMubFjjFJmCpfE
	6cOs+8Pq2ZpnH/0yIOlD5bhLhXqolNhs5PUxFaOXnDhFW+H2Jz6LHab/WC5Y/TMWXTN0Sg39G0u
	DZdyBSCQAyo1+JGAwj3X4+HH72AxY/junxoqujpPOBENLBd1jDt+g2VobFwoJcJCR8wxRLn6kqJ
	H8KfH0548zK75M2v1KoNqa60R0m1k5IuYn2G8pzpvYTNC9b5wtClMoGlsA==
X-Google-Smtp-Source: AGHT+IHCEBoO6OLU4h4cYGIpLzWIYjmrj0U3ugMHZdnN0J1WdoYG6DckBfrtzA7YdToV4/Q++JWt6zQbxeOj
X-Received: by 2002:a17:902:e34b:b0:269:8809:99ad with SMTP id d9443c01a7336-26988099c2bmr3984055ad.3.1758160240107;
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269801630a9sm937265ad.23.2025.09.17.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 78FD1340325;
	Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 73DE8E41B42; Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 15/17] ublk: don't access ublk_queue in ublk_need_complete_req()
Date: Wed, 17 Sep 2025 19:49:51 -0600
Message-ID: <20250918014953.297897-16-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_need_complete_req() is a frequent cache miss. Get the flags from
the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b92b7823005d..750d0a332685 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2265,14 +2265,14 @@ static int ublk_check_commit_and_fetch(const struct ublk_device *ub,
 	}
 
 	return 0;
 }
 
-static bool ublk_need_complete_req(const struct ublk_queue *ubq,
+static bool ublk_need_complete_req(const struct ublk_device *ub,
 				   struct ublk_io *io)
 {
-	if (ublk_need_req_ref(ubq))
+	if (ublk_dev_need_req_ref(ub))
 		return ublk_sub_req_ref(io);
 	return true;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
@@ -2385,11 +2385,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
-		compl = ublk_need_complete_req(ubq, io);
+		compl = ublk_need_complete_req(ub, io);
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
-- 
2.45.2

