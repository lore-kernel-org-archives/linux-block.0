Return-Path: <SRS0=UHms=TL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16FC04AB4
	for <linux-block@archiver.kernel.org>; Sat, 11 May 2019 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E6E2183F
	for <linux-block@archiver.kernel.org>; Sat, 11 May 2019 16:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="MCpeJayE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfEKQ5b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 May 2019 12:57:31 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:54232 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfEKQ5a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 May 2019 12:57:30 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 03623C030C3;
        Sat, 11 May 2019 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557593849;
        bh=u5ZDNi+s7yZ4UvB+sA1PHHntIcDOLPWNW2D1Vl08doo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MCpeJayEpS4qKzxXEuDADy/+o5TFX6r5gO2MKltaTnCXyJcGl2vexaKbJPKoACuwP
         DkF29bNDkbx6XfpCoAMkuFcQZ6LsB4yYldngwuCph4HboQGAbP0Dh5PoqDWA1X4MoP
         QkUXPioHWQrtUnIMKoayzi4I/DTFJBxe1s2TIzfw=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] socket: use IOCB_NOWAIT instead of O_NONBLOCK
Date:   Sat, 11 May 2019 18:57:26 +0200
Message-Id: <20190511165727.31599-4-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190511165727.31599-1-source@stbuehler.de>
References: <e2bf63a3-703b-9be2-c171-5dcc1797d2b1@stbuehler.de>
 <20190511165727.31599-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix socket read_iter/write_iter implementations to handle IOCB_NOWAIT;
for simple reads IOCB_NOWAIT will be set if O_NONBLOCK was set.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 net/socket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 8255f5bda0aa..1e2f6819ea2b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -410,6 +410,7 @@ struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname)
 		sock_release(sock);
 		return file;
 	}
+	file->f_mode |= FMODE_NOWAIT;
 
 	sock->file = file;
 	file->private_data = sock;
@@ -954,7 +955,7 @@ static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			     .msg_iocb = iocb};
 	ssize_t res;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (iocb->ki_flags & IOCB_NOWAIT)
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (iocb->ki_pos != 0)
@@ -979,7 +980,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos != 0)
 		return -ESPIPE;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (iocb->ki_flags & IOCB_NOWAIT)
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (sock->type == SOCK_SEQPACKET)
-- 
2.20.1

