Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C37CC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 00:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C8420657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 00:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfAQAuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:50:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfAQAuN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 19:50:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A35578666E;
        Thu, 17 Jan 2019 00:50:13 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.18.25.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 035BC608E0;
        Thu, 17 Jan 2019 00:50:12 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Subject: [patch] io_uring: don't allow duplicate registrations
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 16 Jan 2019 19:50:12 -0500
Message-ID: <x497ef4hzuj.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 17 Jan 2019 00:50:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jens,

It looks to me like calling io_uring_register more than once (for either
IORING_REGISTER_BUFFERS or IORING_REGISTER_FILES) will leak the
references taken in previous calls.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

---

If this makes sense to you, feel free to just fold this into your
patches w/o any attribution.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3650e8b63a32..f0492b0e23a0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1399,6 +1399,9 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	if (!nr_args)
 		return -EINVAL;
 
+	if (ctx->user_files)
+		return -EINVAL;
+
 	ctx->user_files = kcalloc(nr_args, sizeof(struct file *), GFP_KERNEL);
 	if (!ctx->user_files)
 		return -ENOMEM;
@@ -1580,6 +1583,9 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 	if (!nr_args || nr_args > UIO_MAXIOV)
 		return -EINVAL;
 
+	if (ctx->user_bufs)
+		return -EINVAL;
+
 	ctx->user_bufs = kcalloc(nr_args, sizeof(struct io_mapped_ubuf),
 					GFP_KERNEL);
 	if (!ctx->user_bufs)
