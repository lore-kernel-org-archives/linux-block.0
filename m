Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DC234973
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401138; cv=none; b=lBW7SwPxJKj9j0XPCnKJS3FD4s5HRrBn8aGaBZCvUL7QdJKyGsWiCaqcSX4jaMfGBbgfFm9/kGCfOnVRBKgh/kolOJfyzQF6sM1YCOZfmRvGDOhE6tcKdd8B623aNyGBrxZrtMzrAXoTpztLTnHOXvIc9bD+tPl/p2QDMO5ND2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401138; c=relaxed/simple;
	bh=5ZbhlwdJGs2ocx8rdiMdEFmrOh3BfoureZRS1/aRzms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKaIgQpdv/P3CEpSZZoyRK4anYJOiLvcAJBvDtZ0y04k6GuxQI0YvR302TFKTzPpdjLRk9uvQiCk02vvRB9EbggP+ZNeScC91vBYNafoX8iKeqPKyIUlwudoZf9EpCq1EanHv9nOm/rmc5amTXLAKIwMy5UcTpJiygE6wSDLWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=INLMepEP; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="INLMepEP"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a07fb1527cso31989675ad.3
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVsMc3vMt4H+YWE9AtvMgTt+thJkmCxQ0FHNoV75l2U=;
        b=INLMepEP6YjbBQz3CsZscUBrc3UgwsGiZP+qpjN9GG1/9LLyxWzJml57Lwlo8GKzPu
         qPun7x3/CRyfU9qyHSLCmODpXD6pi1aQSbyJ3gCk1LILQu7/ESXOsp1BNFNNyCQvCfz9
         XTjcWEw4zGzxEIYWBsgio0kNGv42JWOMEOaMpgfLR1AvmBa75Hws9LkwAQlxZ0TCdJRU
         2/Dyg3aDUwvlUe9dL1zM1/Pmaxum1juAT9JDuwe9b4FQebqdCJs1Qqr6QdKr6NDXr2fz
         8rJ1wRy+hc4/at7IJGSAIPKw2TofzSHE0Mf2ADoNjac/u5fG2ViWOepG5IuoTypZ7I9S
         o+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVsMc3vMt4H+YWE9AtvMgTt+thJkmCxQ0FHNoV75l2U=;
        b=ao/wzy86Lk+yrlbjY0+JoBmwD/01wGHKC/20xD19reXLyTZ6FAd/2xC7vuh5Ms6bNt
         +oXOuZEmUHPVPwSjNOFEvQUvxepJhL/ATCw6WQxCvRg7gbJyG1XxbarEJKTMzuzaqFNJ
         n6UrQ/1CwGQIHYdYZqh8a4YQqwRLea8/fbFpffy+Tip4MmGyENqydUsARf+Bick1xWwX
         zO0oV9RqnSSo3FZXz8gqEyR5k7eev9M9QtrMey8HeGCgyFdHa2XzHFHu+WV6qrOHjkED
         8tfc9YC3+MoTetSmcbBtsOyNQWs0S7G4+4slW1V4x/4euzn3NQJxgRAdwhhzOvi1FHhz
         VMfg==
X-Gm-Message-State: AOJu0Yw8R3uauSEFxRIX77zIMFbmajnR8WH7Bdj3X3TlegU/l3UuPKFj
	FSacRHH+UTMEv+mm98R1fI5Y7iNOqfccSZVun7j4oOfs/Ga24d43GzD/6WUtAryrFpmtv0QpraZ
	rMZIX2XTVrLKhu+fOCWkKZVUy93DZN7seaDXk
X-Gm-Gg: AY/fxX4goYmeVlni+cBG9hdLvWgmnhZD25oJzile939s/FpKioaRv+JycjDf0NZk+l0
	KGFLvBbs+l2YleRM/YORwWgvM2LScGoMukDlaHPxU5hGJPaewQsywoawVTpPmQ8YqtSsn3Aj5Sf
	gth1C+N459Y1UWFRBEIjwpeGi8cEqtaxegrtXyG9cjzS4rrwJjBC4zx30B6aIQ2tsmrD9o8iyC4
	OL9TxvLNALjwk9jrzn0D/BgPypXusZLBmLdqmtZ0ngTi206AdyJBBW21AFkmZ5h5G2iUyIYihOG
	6MhFz6VmFMQ2OU648qBP5IPS0uYmpKvnYnl12+WQqSXB8T8TyU/tFe0jcUXZyWu1p4WnimC3cRS
	Hl8jjA6mBxLRMKy9hQdp71oLOChKgvcMf8qqgFgdlSw==
X-Google-Smtp-Source: AGHT+IEsDo8UYO1hwGaARm6NPNqEWHL/GaiHYG082SNQvgge6Pe4hDg9H7li1KCyXrHUdfe7Aqai4q4oPqI5
X-Received: by 2002:a05:6a20:c916:b0:35d:3b70:7635 with SMTP id adf61e73a8af0-376a583266cmr29062142637.0.1767401133655;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c1e7b68fbe0sm3104866a12.10.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E5A30341C73;
	Fri,  2 Jan 2026 17:45:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E10B3E4426F; Fri,  2 Jan 2026 17:45:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 06/19] ublk: split out ublk_user_copy() helper
Date: Fri,  2 Jan 2026 17:45:16 -0700
Message-ID: <20260103004529.1582405-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_read_iter() and ublk_ch_write_iter() are nearly identical except
for the iter direction. Split out a helper function ublk_user_copy() to
reduce the code duplication as these functions are about to get larger.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 811a125a5b04..73547ecf14cd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2727,42 +2727,36 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 fail:
 	ublk_put_req_ref(*io, req);
 	return ERR_PTR(-EACCES);
 }
 
-static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t
+ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct request *req;
 	struct ublk_io *io;
 	size_t buf_off;
 	size_t ret;
 
-	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST, &io);
+	req = ublk_check_and_get_req(iocb, iter, &buf_off, dir, &io);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = ublk_copy_user_pages(req, buf_off, to, ITER_DEST);
+	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 	ublk_put_req_ref(io, req);
 
 	return ret;
 }
 
-static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct request *req;
-	struct ublk_io *io;
-	size_t buf_off;
-	size_t ret;
-
-	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE, &io);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = ublk_copy_user_pages(req, buf_off, from, ITER_SOURCE);
-	ublk_put_req_ref(io, req);
+	return ublk_user_copy(iocb, to, ITER_DEST);
+}
 
-	return ret;
+static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return ublk_user_copy(iocb, from, ITER_SOURCE);
 }
 
 static const struct file_operations ublk_ch_fops = {
 	.owner = THIS_MODULE,
 	.open = ublk_ch_open,
-- 
2.45.2

