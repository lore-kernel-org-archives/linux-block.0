Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E4C4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E685A214AF
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AVDyhdng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfIQQEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:04:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45970 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfIQQEC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 12:04:02 -0400
Received: by mail-io1-f66.google.com with SMTP id f12so8781759iog.12
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TD+ZcotDGvGiW4zHszJOUePKn0/Z3L3IEkKR0VHh8ec=;
        b=AVDyhdngnDt9y5PSpBQkVS7Y8XjMF9Y/+qD4XMUbTyWO3MRSF14e9CRUG/SkZxByRu
         I+QDmmz7eWtIF/2lX5L+q9E110WK7Hic3yyy5Fwm7rO6MSCF2kF0i7LvXU0hJGO3gws/
         nHfroXrXBK3mzPGdihTyzbKLIqEh7HROYNhTMwRassVfchMOykt8NxSlnRXM/+UpAHs0
         DoZJXvMgtiIgejoupcGkccGvo9KHx6yfPeanez1y2fncExJS+n5QW6ja7x60Ue66CCTN
         muE9Mp2RsyM6wiwrD2rywhyxB0OhZm0pDGPOxRkpvJHkRWijr2VH7wdcy+jrJiKWEu1G
         xrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TD+ZcotDGvGiW4zHszJOUePKn0/Z3L3IEkKR0VHh8ec=;
        b=PjhoGTOjPx+nFQj8kqGJksRPMDRc6hdWmIOqIXsJj5Q4QsE8XJossj4Sf7+szeZVl/
         HD37ameZ0eMWUFqRuoW93s7Lf4yWfJFG0wrTQG3hWn2hJE9ERvJKIz/u3eeYCprJ1o1R
         5iUHtdz3+hHcD0LE/bWukmcV4nhjVNL9WdhyuJ1T8VU0ibOULHuSemMgI1VXVh0h9WrS
         93sYJlBo5DxLL1qf0YgR1xKbskcj1TC14bnuu0uErUpnstHxPhj5nhVTl5Gday1UZAKX
         qj4Q1A7ASJZf3l5bT54QSkhZV99FsvnndKbr7zZ8taq28Wb58um9LJ2waRcqmr0FIDct
         b6vA==
X-Gm-Message-State: APjAAAWGSoa/fXJY1aMKwj/OThgyJ8yLUHN8n75j5+L66j7ZBZdugCuh
        EVoeIyx8DvR9JYdn8zcuP0HRkXXLmzLZ/Q==
X-Google-Smtp-Source: APXvYqykAg2M8PwcMS8qUAlBUAubjR3FdcABjo3oOXJvJLNzGc37l+KJ7f3PtSBxTlJe3beudOjCoQ==
X-Received: by 2002:a6b:5d18:: with SMTP id r24mr4423513iob.285.1568736240557;
        Tue, 17 Sep 2019 09:04:00 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i20sm1991035ioh.77.2019.09.17.09.03.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:03:59 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: IORING_OP_TIMEOUT support
Message-ID: <f0488dd6-c32b-be96-9bdc-67099f1f56f8@kernel.dk>
Date:   Tue, 17 Sep 2019 10:03:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's been a few requests for functionality similar to io_getevents()
and epoll_wait(), where the user can specify a timeout for waiting on
events. I deliberately did not add support for this through the system
call initially to avoid overloading the args, but I can see that the use
cases for this are valid.

This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
when waiting for events, simply submit one of these timeout commands
with your wait call. This ensures that the application sleeping on the
CQ ring waiting for events will get woken. The timeout command is passed
in a pointer to a struct timespec. Timeouts are relative.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

liburing has a test case for this, as well as the helper function to
setup the timeout command.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0dadbdbead0f..e169f5e8cd12 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -283,6 +283,10 @@ struct io_poll_iocb {
 	struct wait_queue_entry		wait;
 };
 
+struct io_timeout {
+	struct hrtimer timer;
+};
+
 /*
  * NOTE! Each of the iocb union members has the file pointer
  * as the first entry in their struct definition. So you can
@@ -294,6 +298,7 @@ struct io_kiocb {
 		struct file		*file;
 		struct kiocb		rw;
 		struct io_poll_iocb	poll;
+		struct io_timeout	timeout;
 	};
 
 	struct sqe_submit	submit;
@@ -1765,6 +1770,35 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return ipt.error;
 }
 
+static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
+{
+	struct io_kiocb *req;
+
+	req = container_of(timer, struct io_kiocb, timeout.timer);
+	io_cqring_add_event(req->ctx, req->user_data, 0);
+	io_put_req(req);
+	return HRTIMER_NORESTART;
+}
+
+static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct timespec ts;
+	ktime_t kt;
+
+	if (sqe->flags || sqe->ioprio || sqe->off || sqe->buf_index)
+		return -EINVAL;
+	if (sqe->len != 1)
+		return -EINVAL;
+	if (copy_from_user(&ts, (void __user *) sqe->addr, sizeof(ts)))
+		return -EFAULT;
+
+	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	req->timeout.timer.function = io_timeout_fn;
+	kt = timespec_to_ktime(ts);
+	hrtimer_start(&req->timeout.timer, kt, HRTIMER_MODE_REL);
+	return 0;
+}
+
 static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			const struct io_uring_sqe *sqe)
 {
@@ -1842,6 +1876,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_RECVMSG:
 		ret = io_recvmsg(req, s->sqe, force_nonblock);
 		break;
+	case IORING_OP_TIMEOUT:
+		ret = io_timeout(req, s->sqe);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 96ee9d94b73e..cf3101dc6b1e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -61,6 +61,7 @@ struct io_uring_sqe {
 #define IORING_OP_SYNC_FILE_RANGE	8
 #define IORING_OP_SENDMSG	9
 #define IORING_OP_RECVMSG	10
+#define IORING_OP_TIMEOUT	11
 
 /*
  * sqe->fsync_flags

-- 
Jens Axboe

