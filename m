Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BBCA9EAD
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9640821929
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 00:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfJUAXv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 20:23:51 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:46463 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfJUAXv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 20:23:51 -0400
X-QQ-mid: bizesmtp22t1571617416t3le2aei
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 21 Oct 2019 08:23:35 +0800 (CST)
X-QQ-SSF: 00400000002000S0ZT90B00A0000000
X-QQ-FEAT: W55xVYr4Ddbj4RYADDwDUSpBgW4PkbndEs1hiYe/LZ0j/UN4/hGvc3sV+MuyT
        jIBciI+vhI1LNCZ3hg4gKAo272PWJyk5ZX4QEaQzejd8kSHH6ZPmb8mN+K+1fo+IoDWd4BH
        /k1W9RQgywAEgov9hrBEJTPf4/Q95J162sq7HsNmsse2KAl7YSFeyjl0catMpuIW+ZJYLbr
        mir/vcE7VwbVDKfvV7aBegrE7QVBQU0r2s4iMDksvTz72pyKtkiAAuLOeGiuUkEs1pTrOQQ
        wGHxdR7qwdo1WFhxWaPtpYXNOZNpvX1vVTk89HRTVqJ1xZnyUAa3Wl6CtQh8vzYPkxgD37I
        IzWoRKUFA2uNh75QBU=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] io_uring: fix up O_NONBLOCK handling for sockets
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <f999615b-205c-49b7-b272-c4e42e45e09d@kernel.dk>
Date:   Mon, 21 Oct 2019 08:23:35 +0800
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hrvoje Zeba <zeba.hrvoje@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <BCC87FC4-164D-4A28-9C84-24FCC7969AD8@kylinos.cn>
References: <f999615b-205c-49b7-b272-c4e42e45e09d@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3594.4.19)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 2019年10月17日 23:24，Jens Axboe <axboe@kernel.dk> 写道：
> 
> We've got two issues with the non-regular file handling for non-blocking
> IO:
> 
> 1) We don't want to re-do a short read in full for a non-regular file,
>   as we can't just read the data again.
> 2) For non-regular files that don't support non-blocking IO attempts,
>   we need to punt to async context even if the file is opened as
>   non-blocking. Otherwise the caller always gets -EAGAIN.
> 
> Add two new request flags to handle these cases. One is just a cache
> of the inode S_ISREG() status, the other tells io_uring that we always
> need to punt this request to async context, even if REQ_F_NOWAIT is set.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> fs/io_uring.c | 55 +++++++++++++++++++++++++++++++++++----------------
> 1 file changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index d2cb277da2f4..a4ee5436cb61 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -322,6 +322,8 @@ struct io_kiocb {
> #define REQ_F_FAIL_LINK		256	/* fail rest of links */
> #define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
> #define REQ_F_TIMEOUT		1024	/* timeout request */
> +#define REQ_F_ISREG		2048	/* regular file */
> +#define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
> 	u64			user_data;
> 	u32			result;
> 	u32			sequence;
> @@ -914,26 +916,26 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
> 	return ret;
> }
> 
> -static void kiocb_end_write(struct kiocb *kiocb)
> +static void kiocb_end_write(struct io_kiocb *req)
> {
> -	if (kiocb->ki_flags & IOCB_WRITE) {
> -		struct inode *inode = file_inode(kiocb->ki_filp);
> +	/*
> +	 * Tell lockdep we inherited freeze protection from submission
> +	 * thread.
> +	 */
> +	if (req->flags & REQ_F_ISREG) {
> +		struct inode *inode = file_inode(req->file);
> 
> -		/*
> -		 * Tell lockdep we inherited freeze protection from submission
> -		 * thread.
> -		 */
> -		if (S_ISREG(inode->i_mode))
> -			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> -		file_end_write(kiocb->ki_filp);
> +		__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> 	}
> +	file_end_write(req->file);
> }
> 
> static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
> {
> 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
> 
> -	kiocb_end_write(kiocb);
> +	if (kiocb->ki_flags & IOCB_WRITE)
> +		kiocb_end_write(req);
> 
> 	if ((req->flags & REQ_F_LINK) && res != req->result)
> 		req->flags |= REQ_F_FAIL_LINK;
> @@ -945,7 +947,8 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
> {
> 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
> 
> -	kiocb_end_write(kiocb);
> +	if (kiocb->ki_flags & IOCB_WRITE)
> +		kiocb_end_write(req);
> 
> 	if ((req->flags & REQ_F_LINK) && res != req->result)
> 		req->flags |= REQ_F_FAIL_LINK;
> @@ -1059,8 +1062,17 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
> 	if (!req->file)
> 		return -EBADF;
> 
> -	if (force_nonblock && !io_file_supports_async(req->file))
> +	if (S_ISREG(file_inode(req->file)->i_mode))
> +		req->flags |= REQ_F_ISREG;
> +
> +	/*
> +	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
> +	 * we know to async punt it even if it was opened O_NONBLOCK
> +	 */
> +	if (force_nonblock && !io_file_supports_async(req->file)) {
> 		force_nonblock = false;
> +		req->flags |= REQ_F_MUST_PUNT;
> +	}

Hello Jens. that is your new version.

+	/*
+	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
+	 * we know to async punt it even if it was opened O_NONBLOCK
+	 */
+	if (force_nonblock && !io_file_supports_async(req->file)) {
+		req->flags |= REQ_F_MUST_PUNT;
+		return -EAGAIN;
+	}

So, if req->file don't support async, we always return EAGAIN immediately.
 

> 
> 	kiocb->ki_pos = READ_ONCE(sqe->off);
> 	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
> @@ -1081,7 +1093,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
> 		return ret;
> 
> 	/* don't allow async punt if RWF_NOWAIT was requested */
> -	if (kiocb->ki_flags & IOCB_NOWAIT)
> +	if ((kiocb->ki_flags & IOCB_NOWAIT) ||
> +	    (req->file->f_flags & O_NONBLOCK))

I think if we return -EAGAIN immediately, and using the work queue to execute this context, 
this is unnecessary.

> 		req->flags |= REQ_F_NOWAIT;
> 
> 	if (force_nonblock)
> @@ -1382,7 +1395,9 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
> 		 * need async punt anyway, so it's more efficient to do it
> 		 * here.
> 		 */
> -		if (force_nonblock && ret2 > 0 && ret2 < read_size)
> +		if (force_nonblock && !(req->flags & REQ_F_NOWAIT) &&
> +		    (req->flags & REQ_F_ISREG) &&
> +		    ret2 > 0 && ret2 < read_size)
> 			ret2 = -EAGAIN;

This is also unnecessary because force_nonblock is always false.

--
Jackie Liu



