Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56C2BDC0A
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432221; cv=none; b=N5qQp2SQ5t49CtkalxZvA2QBZnMEjH6VNrf8ec2LWATYlDH9EjIGPZq6/HcXXEWSmSjGkRgPbtBIhTJGqOftsbVeetlg4OfqzY1hf+W7AC/YU93tTl1o3GQBXaI/6iLNB/k9xpCkkWwo95IB25KzfnqBWqV9W6sDeQ/JXMzYhCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432221; c=relaxed/simple;
	bh=O40UOqFTCrkBURI0ChAMn5y0WF2s2tRY0UNcvaUtbtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzbtvRV55bcgk1NrRyJLMkfLAZDH5wJSfvf8q/GgkNKrMifN1PUxj+I19xXLTYujaS/ruilspz/Do1ODlftHCjS+lE7w+fNanT8DaKk4XQImG0Ca/Jfd0DftL0/5EAfYahZzwuArkbN8Dx3xg9XMJYBtnRRWRisXy3cI9yByZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fi6/QII2; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fi6/QII2"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-531618a6023so82929e0c.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432219; x=1751037019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3UWa2lAIILllH4GbKNaBWHGkAbq2xR+lFp7v8Tz9vY=;
        b=fi6/QII28fB0BVnjjoI5cHj8jf8VZ3cDrl5YRS45g0+wEQLU3n6/e7+o97N3zZ355u
         Sg0yiq+nrPP6DExpDRF1MJ7dVJfKBt20CBITZpGWCOEpAcgjWg9/lfZdSpDbR48sxpb4
         1pKmP+Ogirg6MaJQBRp3m+UhmQjlwF4Dg+bxaEdpdXFvbBT69LV3uutil+TIFLYSBUHX
         SJAdx3kwdgYpc47WKrxngD/UG9Z8BQgLTuwlYwPXmporct6+ctMH7tpObavMis4pzPfP
         B5GkFr7iVXEQ2WAe1L63hDgXA1DE14vc76m0LZUreo78dnQ05UzaRpXVJENTWp6yShlA
         T0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432219; x=1751037019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3UWa2lAIILllH4GbKNaBWHGkAbq2xR+lFp7v8Tz9vY=;
        b=X4+ikQV9JKhLvJwEpTehiMWSGpxYcb+Q1LitOLtzy0zShpDz9UvlfoChAsryTxmm2m
         LAb57YfaKXNKQpyj3YSCPLKK1Ah3AYuoul2Oej+Zp4aMhD7bQG8K5htdnzwNQySkBI95
         k3hTV2/Lfyjr11jVqvUzJoJpsaTNmwX4JhIE3rhHo+oM8eP0eHzmyL8KAoVbJgQuA+8c
         M8bLfvquT5NjW+sgNH7LOooPK/nWzYRRSCXg+lXVPMOadK6KjmsNx8HrnOHyvDdHz7SN
         qOcNHjYqcOW+76H9GnEDFIvzd4bVn3mzJ/VztY4JBjRyJhKFBCoOGOx+spkDo4q6Nke6
         bVfA==
X-Gm-Message-State: AOJu0YxykZF9YgkLi0PeLlqvNyVU0HaCZAI4tyW/tZKAyXMXpE9OnqXY
	xffAXx0X982QbmPeg4I/MtIT16J/NDyLenERYeJH4hVJLjsLCySOn2QcK0AHBRst1AfuVpBjYfX
	sute7TquaBikmXX8fk/TlyKWDwNrScMLD4ANgY2AuOwtMV8vnnWmr
X-Gm-Gg: ASbGncunP9tmOhuaU1C9RfTfK/d+IK4smulEz86lHh4NrRVDTzMU9kL9wk5ajQuipJs
	PPF82oioTmcV10q1yGApqTQ9GtjM7T1J5cTdmbjA36itzqlc01Xue4pCTlOdxgVnrwnQdO0bkiU
	0MHImxgq8LXd8BLRVw2sEatPYN5MnaWBxUDec4FZWyG5tO/FXOrRohmFpx8fh80ECU3Hvgde/KC
	og0JiC1zOJd+RTSQsJv1WfRxcRLxERtC9mc1ZKi5J+SbF43OjZhwcED44F9gKB6pHTgNxHz9KXE
	UF+24Gf8FpjOM9BWUmEXkuuRku/I5XtQbGDyPqjJ
X-Google-Smtp-Source: AGHT+IH3CKXKHwhMsjGTTsRR0g9Z4ILQOrJnP+cUfDJs5r10Mo0fQeXS9yik1VEqVwfHh2FruWZCgOIMnyKg
X-Received: by 2002:a05:6122:549:b0:531:9088:8d57 with SMTP id 71dfb90a1353d-531ad6f97eamr624695e0c.3.1750432218216;
        Fri, 20 Jun 2025 08:10:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-531ab25134asm145005e0c.9.2025.06.20.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D0312340D6A;
	Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CEC9FE4548E; Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 13/14] ublk: remove ubq checks from ublk_{get,put}_req_ref()
Date: Fri, 20 Jun 2025 09:10:07 -0600
Message-ID: <20250620151008.3976463-14-csander@purestorage.com>
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

ublk_get_req_ref() and ublk_put_req_ref() currently call
ublk_need_req_ref(ubq) to check whether the ublk device features require
reference counting of its requests. However, all callers already know
that reference counting is required:
- __ublk_check_and_get_req() is only called from
  ublk_check_and_get_req() if user copy is enabled, and from
  ublk_register_io_buf() if zero copy is enabled
- ublk_io_release() is only called for requests registered by
  ublk_register_io_buf(), which requires zero copy
- ublk_ch_read_iter() and ublk_ch_write_iter() only call
  ublk_put_req_ref() if ublk_check_and_get_req() succeeded, which
  requires user copy to be enabled

So drop the ublk_need_req_ref() check and the ubq argument in
ublk_get_req_ref() and ublk_put_req_ref().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 199028f36ec8..ebc56681eb68 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -697,28 +697,19 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 {
 	if (ublk_need_req_ref(ubq))
 		refcount_set(&io->ref, UBLK_REFCOUNT_INIT);
 }
 
-static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
-		struct ublk_io *io)
+static inline bool ublk_get_req_ref(struct ublk_io *io)
 {
-	if (ublk_need_req_ref(ubq))
-		return refcount_inc_not_zero(&io->ref);
-
-	return true;
+	return refcount_inc_not_zero(&io->ref);
 }
 
-static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
-		struct ublk_io *io, struct request *req)
+static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 {
-	if (ublk_need_req_ref(ubq)) {
-		if (refcount_dec_and_test(&io->ref))
-			__ublk_complete_rq(req);
-	} else {
+	if (refcount_dec_and_test(&io->ref))
 		__ublk_complete_rq(req);
-	}
 }
 
 static inline void ublk_sub_req_ref(struct ublk_io *io, struct request *req)
 {
 	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
@@ -2019,11 +2010,11 @@ static void ublk_io_release(void *priv)
 	 * but unregistered on task. Or after UBLK_IO_COMMIT_AND_FETCH_REQ.
 	 */
 	if (current == io->task && io->task_registered_buffers)
 		io->task_registered_buffers--;
 	else
-		ublk_put_req_ref(ubq, io, rq);
+		ublk_put_req_ref(io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				const struct ublk_queue *ubq,
 				struct ublk_io *io,
@@ -2041,11 +2032,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
 	if (ret) {
-		ublk_put_req_ref(ubq, io, req);
+		ublk_put_req_ref(io, req);
 		return ret;
 	}
 
 	return 0;
 }
@@ -2338,11 +2329,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 	 */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
 	if (!req)
 		return NULL;
 
-	if (!ublk_get_req_ref(ubq, io))
+	if (!ublk_get_req_ref(io))
 		return NULL;
 
 	if (unlikely(!blk_mq_request_started(req) || req->tag != tag))
 		goto fail_put;
 
@@ -2352,11 +2343,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 	if (offset > blk_rq_bytes(req))
 		goto fail_put;
 
 	return req;
 fail_put:
-	ublk_put_req_ref(ubq, io, req);
+	ublk_put_req_ref(io, req);
 	return NULL;
 }
 
 static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -2468,48 +2459,44 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 		goto fail;
 
 	*off = buf_off;
 	return req;
 fail:
-	ublk_put_req_ref(ubq, *io, req);
+	ublk_put_req_ref(*io, req);
 	return ERR_PTR(-EACCES);
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
 	size_t buf_off;
 	size_t ret;
 
 	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST, &io);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	ret = ublk_copy_user_pages(req, buf_off, to, ITER_DEST);
-	ubq = req->mq_hctx->driver_data;
-	ublk_put_req_ref(ubq, io, req);
+	ublk_put_req_ref(io, req);
 
 	return ret;
 }
 
 static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
 	size_t buf_off;
 	size_t ret;
 
 	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE, &io);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	ret = ublk_copy_user_pages(req, buf_off, from, ITER_SOURCE);
-	ubq = req->mq_hctx->driver_data;
-	ublk_put_req_ref(ubq, io, req);
+	ublk_put_req_ref(io, req);
 
 	return ret;
 }
 
 static const struct file_operations ublk_ch_fops = {
-- 
2.45.2

