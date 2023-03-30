Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59089C761AF
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjC3Lja (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjC3LjK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 07:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF96E185
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680176255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRW9a0ZHd+MGeZHqXvtwA5Cp/cxaEC4LxuKjGisTMi4=;
        b=JNbNt4+4j7uotteDVresqW1K7F7sRH7gkel0Q5ckrba/xA+ucqprJ4/5RgDi+vdGkoZ3kB
        ZNmTnkYn1TD+E86CSrA19JaDnsInq7Dc1soHgL0+e0GCDbqHIIV6sws6uD3kCc4FxUX+4f
        jvQLDieVw7O631Z9+psW68rQMh+Of4s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-d9eIhHUuNxuCqp6OWPS7FQ-1; Thu, 30 Mar 2023 07:37:31 -0400
X-MC-Unique: d9eIhHUuNxuCqp6OWPS7FQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 669CB3815EF1;
        Thu, 30 Mar 2023 11:37:29 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F3811121330;
        Thu, 30 Mar 2023 11:37:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 11/17] block: ublk_drv: cleanup 'struct ublk_map_data'
Date:   Thu, 30 Mar 2023 19:36:24 +0800
Message-Id: <20230330113630.1388860-12-ming.lei@redhat.com>
In-Reply-To: <20230330113630.1388860-1-ming.lei@redhat.com>
References: <20230330113630.1388860-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'struct ublk_map_data' is passed to ublk_copy_user_pages()
for copying data between userspace buffer and request pages.

Here what matters is userspace buffer address/len and 'struct request',
so replace ->io field with user buffer address, and rename max_bytes
as len.

Meantime remove 'ubq' field from ublk_map_data, since it isn't used
any more.

Then code becomes more readable.

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1c057003a40a..fdccbf5fdaa1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -420,10 +420,9 @@ static const struct block_device_operations ub_fops = {
 #define UBLK_MAX_PIN_PAGES	32
 
 struct ublk_map_data {
-	const struct ublk_queue *ubq;
 	const struct request *rq;
-	const struct ublk_io *io;
-	unsigned max_bytes;
+	unsigned long	ubuf;
+	unsigned int	len;
 };
 
 struct ublk_io_iter {
@@ -483,14 +482,14 @@ static inline unsigned ublk_copy_io_pages(struct ublk_io_iter *data,
 static int ublk_copy_user_pages(struct ublk_map_data *data, bool to_vm)
 {
 	const unsigned int gup_flags = to_vm ? FOLL_WRITE : 0;
-	const unsigned long start_vm = data->io->addr;
+	const unsigned long start_vm = data->ubuf;
 	unsigned int done = 0;
 	struct ublk_io_iter iter = {
 		.pg_off	= start_vm & (PAGE_SIZE - 1),
 		.bio	= data->rq->bio,
 		.iter	= data->rq->bio->bi_iter,
 	};
-	const unsigned int nr_pages = round_up(data->max_bytes +
+	const unsigned int nr_pages = round_up(data->len +
 			(start_vm & (PAGE_SIZE - 1)), PAGE_SIZE) >> PAGE_SHIFT;
 
 	while (done < nr_pages) {
@@ -503,13 +502,13 @@ static int ublk_copy_user_pages(struct ublk_map_data *data, bool to_vm)
 				iter.pages);
 		if (iter.nr_pages <= 0)
 			return done == 0 ? iter.nr_pages : done;
-		len = ublk_copy_io_pages(&iter, data->max_bytes, to_vm);
+		len = ublk_copy_io_pages(&iter, data->len, to_vm);
 		for (i = 0; i < iter.nr_pages; i++) {
 			if (to_vm)
 				set_page_dirty(iter.pages[i]);
 			put_page(iter.pages[i]);
 		}
-		data->max_bytes -= len;
+		data->len -= len;
 		done += iter.nr_pages;
 	}
 
@@ -538,15 +537,14 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 	 */
 	if (ublk_need_map_req(req)) {
 		struct ublk_map_data data = {
-			.ubq	=	ubq,
 			.rq	=	req,
-			.io	=	io,
-			.max_bytes =	rq_bytes,
+			.ubuf	=	io->addr,
+			.len	=	rq_bytes,
 		};
 
 		ublk_copy_user_pages(&data, true);
 
-		return rq_bytes - data.max_bytes;
+		return rq_bytes - data.len;
 	}
 	return rq_bytes;
 }
@@ -559,17 +557,16 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 
 	if (ublk_need_unmap_req(req)) {
 		struct ublk_map_data data = {
-			.ubq	=	ubq,
 			.rq	=	req,
-			.io	=	io,
-			.max_bytes =	io->res,
+			.ubuf	=	io->addr,
+			.len	=	io->res,
 		};
 
 		WARN_ON_ONCE(io->res > rq_bytes);
 
 		ublk_copy_user_pages(&data, false);
 
-		return io->res - data.max_bytes;
+		return io->res - data.len;
 	}
 	return rq_bytes;
 }
-- 
2.39.2

