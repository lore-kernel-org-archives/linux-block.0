Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2620F070
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745279204; cv=none; b=XbyaoCq/YL5CTOvOZN/OW9Plt1IPCEzhkUpzeuVqfypBeQ/HsBrbYl6sOEsL1C+ihmm6B0E/fNz1ukKaKHO2ehby2GwnAslUj+O083TRLTHniG8AKTTS1Gyxen4+2zwsOzm1sVAqBw6KJEQCZHktHOJdZeuG2vsHvos8csoTh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745279204; c=relaxed/simple;
	bh=9wYTE2oUOZnepQcf2ivxa7wZGzMC5FJ5XGr4yhpuPBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhDRznBTBF9N4JcHU46kEFZMwUfF7Z6qT/GzgIj21UpRcIUdIopWLYy54WPfZSN8OKVPK+ngnmmPIcU51vSssCSWhf27kPDNIdODhqLwgDBZTt2WNZ97K4K0pTN4GCOF9J1MzXff1c/Her8Ewv+vB+xh+bzTe2XGuyJr9DX2rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YfD+5mqj; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YfD+5mqj"
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-7020d8b110aso33517997b3.1
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745279201; x=1745884001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S334cfNZ8ng81OQZat982Z13jweFHj6DzVSGbLAV/C0=;
        b=YfD+5mqjGmtw1FimGDdBi26EycM0u/es7JgOiEWX7SEGHidzvx2ugEGs6bLRv9qzI7
         bpPL+9MYHjhxGAEI8np1NYd72JMScg2f1NDaMBIiwr3bmeWVei1pjAYe+x7az/oiqC1q
         Z6mdNeHVQZ0HPGV4lgQkR5M3MaKqx2AlK+KkJ3YZzUl0gJB0YJGIPSHcISAJwpxQegYf
         SPVim2wtlPt62UUtb5OnDoLkW8OPfhACekmFbMU22AP/fRJfas7q9iXgMievAXz4UfUX
         MHYbud/ySpSr+H66zNJ1lyuSms9KoGyVWx8pAccMKuJn8BxL+9mS5EdBF/Q0hPvelCke
         sKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745279201; x=1745884001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S334cfNZ8ng81OQZat982Z13jweFHj6DzVSGbLAV/C0=;
        b=bUM0d/ugoQgPt+m+u4EBWjxzBPSQCWzrOp2RG2ubUjI3ryq4Y2rSmVc22FE9wAngH9
         RyHKUc1AVjzMwKDVBcK9mdAeR4/nE+tn77Y9QLWsnuJfgbYHfOxuya0gE0TbDnahT6rb
         Psw9ItSwRFVXOGKvwz2CDNgDfU9bYlkztMPuFDQ8PfYudWGJ+1yVvjeBuWIJ7/HrzMQz
         TNe1EkVCWSrNxBYi/RJk5I2dkEDQbku/97Bv5xK/G3u2UlJj5UXlkaj0isCwpVDjuC2N
         vDLQKXv1SxrGJMfVUrjarCLKXPyatXvb8BNdJh4cPAVFQ/j0vh/m/AStHP1bpvM/FUhI
         W5OA==
X-Gm-Message-State: AOJu0YxV4pDZzZjh1iRkfNc/g+txEEoznoXck2BEMthxemskZjA7TPHl
	t3Ti6iV1N65sn99Ji9m9gBYI1N6TUS/jX9wIhuf0Y9HhQMBJx+P5l4nzEWLktzvwU2J/mSEf1lA
	MoiMC+lrPdUPunhT4rYFifq4ZkebOqRc0NktV50i9x6c8jRpm
X-Gm-Gg: ASbGncv/nt2ZI8icED+D2ojAEF0zBdM+KjmUEpiV1cXUzezT6jAhnN1e0pPCMLvUuo4
	lA6KFwGecj51AHVNalk7PYtFDt31U0psFVjZW7NKBZ6BFkgBVP5UgmheV5vUonrERlURLyDQAO/
	quYcjVYkZHWRm4slNDdPXTmXFJOBvkAk4dGIyajpnbh4Kf6pPf34WxZQR+l0QinGlh1aI3K/5Q5
	Crx8q3L11R6aDq8BJlyvV/aYd7lXRSJ2o0/XHvkaO82GgwFebP24sKgETe/HfQFouvB0DZD
X-Google-Smtp-Source: AGHT+IGE70iqEkSb2dbHKBgNbWem7kWn1HTfbtQyVZARzXMhUmFeRE9Z47t00fcIecFXCZ0XaQt/m3JWgTTO
X-Received: by 2002:a05:690c:4989:b0:703:b5ae:a3da with SMTP id 00721157ae682-706cce10199mr203124197b3.32.1745279201573;
        Mon, 21 Apr 2025 16:46:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-706ca5ba988sm2644947b3.45.2025.04.21.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 16:46:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EA6A93405BC;
	Mon, 21 Apr 2025 17:46:40 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DBC8EE40371; Mon, 21 Apr 2025 17:46:40 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 21 Apr 2025 17:46:40 -0600
Subject: [PATCH 1/4] ublk: factor out ublk_commit_and_fetch
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-ublk_constify-v1-1-3371f9e9f73c@purestorage.com>
References: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
In-Reply-To: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

Move the logic for the UBLK_IO_COMMIT_AND_FETCH_REQ opcode into its own
function. This also allows us to mark ublk_queue pointers as const for
that operation, which can help prevent data races since we may allow
concurrent operation on one ublk_queue in the future. Also open code
ublk_commit_completion in ublk_commit_and_fetch to reduce the number of
parameters/avoid a redundant lookup.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 91 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 03653bd7a1dfd69f5545a580dbc74de9d850c0ae..57b8625ae64232a750d4f94e76aaf119c28f9450 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1589,30 +1589,6 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
-static void ublk_commit_completion(struct ublk_device *ub,
-		const struct ublksrv_io_cmd *ub_cmd)
-{
-	u32 qid = ub_cmd->q_id, tag = ub_cmd->tag;
-	struct ublk_queue *ubq = ublk_get_queue(ub, qid);
-	struct ublk_io *io = &ubq->ios[tag];
-	struct request *req;
-
-	/* now this cmd slot is owned by nbd driver */
-	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
-	io->res = ub_cmd->result;
-
-	/* find the io request and complete */
-	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
-	if (WARN_ON_ONCE(unlikely(!req)))
-		return;
-
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = ub_cmd->zone_append_lba;
-
-	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, req);
-}
-
 static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 		struct request *req)
 {
@@ -2015,6 +1991,47 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	return ret;
 }
 
+static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 const struct ublksrv_io_cmd *ub_cmd)
+{
+	struct blk_mq_tags *tags = ubq->dev->tag_set.tags[ub_cmd->q_id];
+	struct request *req = blk_mq_tag_to_rq(tags, ub_cmd->tag);
+
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
+		 * NEED GET DATA is not enabled or it is Read IO.
+		 */
+		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
+					req_op(req) == REQ_OP_READ))
+			return -EINVAL;
+	} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+		/*
+		 * User copy requires addr to be unset when command is
+		 * not zone append
+		 */
+		return -EINVAL;
+	}
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+
+	/* now this cmd slot is owned by ublk driver */
+	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+	io->res = ub_cmd->result;
+
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = ub_cmd->zone_append_lba;
+
+	if (likely(!blk_should_fake_timeout(req->q)))
+		ublk_put_req_ref(ubq, req);
+
+	return 0;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -2025,7 +2042,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret = -EINVAL;
-	struct request *req;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -2076,30 +2092,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
-			 * NEED GET DATA is not enabled or it is Read IO.
-			 */
-			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
-						req_op(req) == REQ_OP_READ))
-				goto out;
-		} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
-			/*
-			 * User copy requires addr to be unset when command is
-			 * not zone append
-			 */
-			ret = -EINVAL;
+		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd);
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))

-- 
2.34.1

