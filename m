Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D17CA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4191217F9
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451218;
	bh=O37oz6DKm5IliPnCKePhj9zkq9haAZtxQkI2h/c4NgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0/Nto5Jb6JmWYqVzhZ+WTjnW2ME8WJapCE7wbRJNoB5FMdWTRPBQ07XN7JXq37Vyo
	 /o6cjSPM384mKmhz2UraVwa4mvAPe0ULcSGSYJAEZsE1w46M069UlQzv36tYPoh2zT
	 wTpBwfLMhzxda03HaJRdsLlCDNkMoIb2baU2wItI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfJ3Pz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfJ3Pzx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 11:55:53 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC9421734;
        Wed, 30 Oct 2019 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450952;
        bh=O37oz6DKm5IliPnCKePhj9zkq9haAZtxQkI2h/c4NgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tw+xsKQDhH/1z9PYI250eI5sEFgfbtM7OzhgoMk7mrIOwHbDZnkAo4pQTyctWDqN5
         iW4vBU6bTS9vREHYH5vqONrSgWvudogb7l3uXTrpiFr3HOP434XkzL2ND4UNh2LvGM
         62MeFXHfq6yWzwkiNEfpwtEwv9fqY8o3YzjoJis8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>,
        syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.19 38/38] nbd: verify socket is supported during setup
Date:   Wed, 30 Oct 2019 11:54:06 -0400
Message-Id: <20191030155406.10109-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155406.10109-1-sashal@kernel.org>
References: <20191030155406.10109-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit cf1b2326b734896734c6e167e41766f9cee7686a ]

nbd requires socket families to support the shutdown method so the nbd
recv workqueue can be woken up from its sock_recvmsg call. If the socket
does not support the callout we will leave recv works running or get hangs
later when the device or module is removed.

This adds a check during socket connection/reconnection to make sure the
socket being passed in supports the needed callout.

Reported-by: syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index dd67a3dff93b1..cc4a642b942b2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -932,6 +932,25 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
+				     int *err)
+{
+	struct socket *sock;
+
+	*err = 0;
+	sock = sockfd_lookup(fd, err);
+	if (!sock)
+		return NULL;
+
+	if (sock->ops->shutdown == sock_no_shutdown) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	return sock;
+}
+
 static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 			  bool netlink)
 {
@@ -941,7 +960,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct nbd_sock *nsock;
 	int err;
 
-	sock = sockfd_lookup(arg, &err);
+	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
 
@@ -993,7 +1012,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	int i;
 	int err;
 
-	sock = sockfd_lookup(arg, &err);
+	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
 
-- 
2.20.1

