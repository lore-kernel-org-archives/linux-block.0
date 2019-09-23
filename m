Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C80DC4CEC4
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405D720882
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 17:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q58ijirV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390958AbfIWRA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:00:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33520 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440098AbfIWRA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 13:00:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so9509958pfl.0
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2019 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=T5PjWuh/3+uCgfAb4MAkJ3edeLx6bWJ3UjGtTlwmi5U=;
        b=q58ijirV84c772KsqSzheBMGqR+zRjozrbWTEpBjo+ChcLK0Dm9BM2de7DgPSVEX0i
         NmZGjScBEpH13NIq6p3OugQF1938pYC/wJH4sQ2/XisWvXEuSdzsmK013RtyapbT0FrZ
         UgvONdanYSNEOABH5n7/kUcokXLNA0etnnF7ImJXW2/sy9za/JaedWAuhN+sd9Scx/bX
         fGMs4ATxw5zSPVU/OZ+l0xnP0MJHqyqAHmyYO+HXp6YoV24dH7fsUfXVUcz3QJacCRW4
         +sAJs2QxyOGZEgQGwv8V2s3CAD0xjNg0BYqZfvCOuZZlxtuM8yvqldWD2qaP/T3qjFl0
         x1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=T5PjWuh/3+uCgfAb4MAkJ3edeLx6bWJ3UjGtTlwmi5U=;
        b=LlOVtQHMVbSNpjM5aoo7qC7JfQiA3mnYpc6nvfwT6t8uDcHWSxk10KWCqA91PEywqE
         9WQl4XbisJiT1FbWLAVwEPSOxf/f5LQrmDoW+zsmIMJOAatG2Kxa6OpIwOcWXIWCDiIt
         0Zh9w1SwflILhEOPh7gMmU63gZYVsEBkzI5eoHO6/PJtYC86K6z49GaH3LiWHSVeaSA5
         5sDsCLyvgwcRzuKBYjzDnrVuWwQ1r9Y87hzvA07sQO8QwmDsc5Nuza+JcAla2/hc+G2Q
         bXtGeB0pdpFYLyz/fSZcyHnIVXJbceVs7xVpr1dxIxLKOM6cZhOYBrJ4CWpBdc+uqcNt
         0KGQ==
X-Gm-Message-State: APjAAAXTfT34trWOpCf/MjoNLlGSzZtWtUva7AuOl72SYfTKI8z9DvV7
        zUOoUs7wHPbCcFf3nsP5t1f+LTPMGams5w==
X-Google-Smtp-Source: APXvYqwabRsR6zPmnidXIdTCxjhpkzfjHLGAwQrKFVbfah4ueFLaY73HL/fkuvzT3mMK78QkuyLzKQ==
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr451149pje.93.1569258023868;
        Mon, 23 Sep 2019 10:00:23 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f12sm11446707pgo.85.2019.09.23.10.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:00:22 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     carter.li@eoitek.com
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: handle non ->{read,write}_iter() file_operations
Message-ID: <6e9531fe-9047-7005-4625-652490419cc3@kernel.dk>
Date:   Mon, 23 Sep 2019 11:00:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we just -EINVAL a read or write to an fd that isn't backed
by ->read_iter() or ->write_iter(). But we can handle them just fine,
as long as we punt fo async context first.

Implement a simple loop function for doing ->read() or ->write()
instead, and ensure we call it appropriately.

Reported-by: 李通洲 <carter.li@eoitek.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9d8e703bc851..ca7570aca430 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1298,6 +1298,51 @@ static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
 	}
 }
 
+/*
+ * For files that don't have ->read_iter() and ->write_iter(), handle them
+ * by looping over ->read() or ->write() manually.
+ */
+static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
+			   struct iov_iter *iter)
+{
+	ssize_t ret = 0;
+
+	/*
+	 * Don't support polled IO through this interface, and we can't
+	 * support non-blocking either. For the latter, this just causes
+	 * the kiocb to be handled from an async context.
+	 */
+	if (kiocb->ki_flags & IOCB_HIPRI)
+		return -EOPNOTSUPP;
+	if (kiocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
+	while (iov_iter_count(iter)) {
+		struct iovec iovec = iov_iter_iovec(iter);
+		ssize_t nr;
+
+		if (rw == READ) {
+			nr = file->f_op->read(file, iovec.iov_base,
+					      iovec.iov_len, &kiocb->ki_pos);
+		} else {
+			nr = file->f_op->write(file, iovec.iov_base,
+					       iovec.iov_len, &kiocb->ki_pos);
+		}
+
+		if (nr < 0) {
+			if (!ret)
+				ret = nr;
+			break;
+		}
+		ret += nr;
+		if (nr != iovec.iov_len)
+			break;
+		iov_iter_advance(iter, nr);
+	}
+
+	return ret;
+}
+
 static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		   bool force_nonblock)
 {
@@ -1315,8 +1360,6 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
-	if (unlikely(!file->f_op->read_iter))
-		return -EINVAL;
 
 	ret = io_import_iovec(req->ctx, READ, s, &iovec, &iter);
 	if (ret < 0)
@@ -1331,7 +1374,11 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	if (!ret) {
 		ssize_t ret2;
 
-		ret2 = call_read_iter(file, kiocb, &iter);
+		if (file->f_op->read_iter)
+			ret2 = call_read_iter(file, kiocb, &iter);
+		else
+			ret2 = loop_rw_iter(READ, file, kiocb, &iter);
+
 		/*
 		 * In case of a short read, punt to async. This can happen
 		 * if we have data partially cached. Alternatively we can
@@ -1376,8 +1423,6 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	file = kiocb->ki_filp;
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
-	if (unlikely(!file->f_op->write_iter))
-		return -EINVAL;
 
 	ret = io_import_iovec(req->ctx, WRITE, s, &iovec, &iter);
 	if (ret < 0)
@@ -1415,7 +1460,10 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		}
 		kiocb->ki_flags |= IOCB_WRITE;
 
-		ret2 = call_write_iter(file, kiocb, &iter);
+		if (file->f_op->write_iter)
+			ret2 = call_write_iter(file, kiocb, &iter);
+		else
+			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
 		if (!force_nonblock || ret2 != -EAGAIN) {
 			io_rw_done(kiocb, ret2);
 		} else {

-- 
Jens Axboe

