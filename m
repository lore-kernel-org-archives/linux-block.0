Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B87C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4909420879
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfCYKQ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:16:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:57948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729935AbfCYKQ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 06:16:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9024FAF50;
        Mon, 25 Mar 2019 10:16:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Mar 2019 11:16:28 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: io_uring: -EAGAIN on write path in case of O_DIRECT
Message-ID: <bda877db6c5bcd62885e79f0bed7ca57@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I gave a try to use io_uring and stumbled upon -EAGAIN on write path
in direct mode if page cache is already populated or has been populated
in-between by some buffered read. I'am talking about
generic_file_direct_write() call, which checks filemap_range_has_page()
on IOCB_NOWAIT path.

To proceed further with tests I simply did the same thing, like you did
in io_read(), and in case of -EAGAIN async worker does the rest.  So the
following chunk works well:

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6aaa30580a2b..ccb656168ae4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1022,6 +1022,8 @@ static int io_write(struct io_kiocb *req, const 
struct sqe_submit *s,

         ret = rw_verify_area(WRITE, file, &kiocb->ki_pos, iov_count);
         if (!ret) {
+               ssize_t ret2;
+
                 /*
                  * Open-code file_start_write here to grab freeze 
protection,
                  * which will be released by another thread in
@@ -1036,7 +1038,19 @@ static int io_write(struct io_kiocb *req, const 
struct sqe_submit *s,
                                                 SB_FREEZE_WRITE);
                 }
                 kiocb->ki_flags |= IOCB_WRITE;
-               io_rw_done(kiocb, call_write_iter(file, kiocb, &iter));
+
+               ret2 = call_write_iter(file, kiocb, &iter);
+               if (!force_nonblock || ret2 != -EAGAIN) {
+                       io_rw_done(kiocb, ret2);
+               } else {
+                       /*
+                        * If ->needs_lock is true, we're already in 
async
+                        * context.
+                        */
+                       if (!s->needs_lock)
+                               io_async_list_note(WRITE, req, 
iov_count);
+                       ret = -EAGAIN;
+               }


Does it make sense?

--
Roman
