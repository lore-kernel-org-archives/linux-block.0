Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108DFC4CEC7
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD38820856
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 20:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfILUNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:13:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfILUNi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 16:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9D1C10DCC80;
        Thu, 12 Sep 2019 20:13:37 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83099100194E;
        Thu, 12 Sep 2019 20:13:37 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] io_uring: extend async work merging
References: <0b62fee7-d3bd-f60e-ae81-27880f42d508@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 12 Sep 2019 16:13:36 -0400
In-Reply-To: <0b62fee7-d3bd-f60e-ae81-27880f42d508@kernel.dk> (Jens Axboe's
        message of "Wed, 11 Sep 2019 10:15:38 -0600")
Message-ID: <x49o8zptgr3.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 12 Sep 2019 20:13:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> We currently merge async work items if we see a strict sequential hit.
> This helps avoid unnecessary workqueue switches when we don't need
> them. We can extend this merging to cover cases where it's not a strict
> sequential hit, but the IO still fits within the same page. If an
> application is doing multiple requests within the same page, we don't
> want separate workers waiting on the same page to complete IO. It's much
> faster to let the first worker bring in the page, then operate on that
> page from the same worker to complete the next request(s).
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Minor nit below.

> @@ -1994,7 +2014,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>   */
>  static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
>  {
> -	bool ret = false;
> +	bool ret;
>  
>  	if (!list)
>  		return false;

This hunk looks unrelated.  Also, I think you could actually change that
to be initialized to true, and get rid of the assignment later:

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 03fcd974fd1d..a94c8584c480 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1994,7 +1994,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
  */
 static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 {
-	bool ret = false;
+	bool ret = true;
 
 	if (!list)
 		return false;
@@ -2003,7 +2003,6 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 	if (!atomic_read(&list->cnt))
 		return false;
 
-	ret = true;
 	spin_lock(&list->lock);
 	list_add_tail(&req->list, &list->list);
 	/*

Cheers,
Jeff
