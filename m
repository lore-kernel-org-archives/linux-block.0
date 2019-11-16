Return-Path: <SRS0=wO3m=ZI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D43CC432C3
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 05:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9ED20729
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 05:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg/3/2uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfKPFu0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:50:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46632 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbfKPFu0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 00:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573883425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWCzOv0VBjMgkh4rUt0nWsW8m3HZYi+cHVTst6osn+A=;
        b=Tg/3/2uvRgztSU3ORynwNv0aAwg7YBuptXMmesLWP0tQbFMiz02jMhJE0sWPHVrKMlXKAJ
        62eLkJMnpbXjcqpaYy2Xq+90krWFwchVeeM6Dn++01POAWCGP4KHSANv0mMiGiq4ThqKxz
        rym2xjRGmnrUjhSQwvumoiMN5BeUChA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-8MAfIB3bMjuQlUmWmPz34A-1; Sat, 16 Nov 2019 00:50:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D98921802CE1;
        Sat, 16 Nov 2019 05:50:20 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-253.rdu2.redhat.com [10.10.125.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31864608BF;
        Sat, 16 Nov 2019 05:50:20 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     nbd@other.debian.org, axboe@kernel.dk, josef@toxicpanda.com,
        linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 2/2] nbd: add support to replace running daemon
Date:   Fri, 15 Nov 2019 23:50:17 -0600
Message-Id: <20191116055017.6253-3-mchristi@redhat.com>
In-Reply-To: <20191116055017.6253-1-mchristi@redhat.com>
References: <20191116055017.6253-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8MAfIB3bMjuQlUmWmPz34A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch allows userspace to switch daemons while IO is running or
to recovery from a crashed daemon. With the patch when using AF_UNIX
sockets and a local running daemon, the new daemon can perform a
NBD_CMD_RECONFIGURE nl command with the NBD_ATTR_SWAP_SOCKETS attr
set to 0. The kernel will then switch over to using the new socket
similar to how we handle failing over from a dead socket.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c              | 44 +++++++++++++++++++++++++++++---
 include/uapi/linux/nbd-netlink.h |  1 +
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 06b63c11ae50..6aa396bea401 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1076,7 +1076,14 @@ static int nbd_add_socket(struct nbd_device *nbd, un=
signed long arg,
 =09return 0;
 }
=20
-static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
+static bool nbd_requeue_req(struct request *req, void *data, bool reserved=
)
+{
+=09nbd_requeue_cmd(blk_mq_rq_to_pdu(req));
+=09return true;
+}
+
+static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg,
+=09=09=09=09u8 swap_socks)
 {
 =09struct nbd_config *config =3D nbd->config;
 =09struct socket *sock, *old;
@@ -1094,6 +1101,16 @@ static int nbd_reconnect_socket(struct nbd_device *n=
bd, unsigned long arg)
 =09=09return -ENOMEM;
 =09}
=20
+=09if (swap_socks) {
+=09=09dev_dbg(disk_to_dev(nbd->disk), "stopping queue\n");
+
+=09=09blk_mq_quiesce_queue(nbd->disk->queue);
+=09=09send_disconnects(nbd);
+=09=09sock_shutdown(nbd);
+=09=09flush_workqueue(nbd->recv_workq);
+=09=09blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_requeue_req, NULL);
+=09}
+
 =09for (i =3D 0; i < config->num_connections; i++) {
 =09=09struct nbd_sock *nsock =3D config->socks[i];
=20
@@ -1130,11 +1147,20 @@ static int nbd_reconnect_socket(struct nbd_device *=
nbd, unsigned long arg)
=20
 =09=09atomic_inc(&config->live_connections);
 =09=09wake_up(&config->conn_wait);
-=09=09return 0;
+=09=09err =3D 0;
+=09=09goto start_queue;
 =09}
 =09sockfd_put(sock);
 =09kfree(args);
-=09return -ENOSPC;
+=09err =3D -ENOSPC;
+
+start_queue:
+=09if (swap_socks) {
+=09=09nbd->task_recv =3D current;
+=09=09blk_mq_unquiesce_queue(nbd->disk->queue);
+=09=09dev_dbg(disk_to_dev(nbd->disk), "queue restarted\n");
+=09}
+=09return err;
 }
=20
 static void nbd_bdev_reset(struct block_device *bdev)
@@ -2027,6 +2053,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, =
struct genl_info *info)
 {
 =09struct nbd_device *nbd =3D NULL;
 =09struct nbd_config *config;
+=09u8 swap_socks =3D 0;
 =09int index;
 =09int ret =3D 0;
 =09bool put_dev =3D false;
@@ -2107,6 +2134,15 @@ static int nbd_genl_reconfigure(struct sk_buff *skb,=
 struct genl_info *info)
 =09=09}
 =09}
=20
+=09if (info->attrs[NBD_ATTR_SWAP_SOCKETS]) {
+=09=09swap_socks =3D nla_get_u8(info->attrs[NBD_ATTR_SWAP_SOCKETS]);
+=09=09if (swap_socks !=3D 1 && swap_socks !=3D 0) {
+=09=09=09printk(KERN_ERR "nbd: NBD_SOCK_SWAP must be 0 or 1\n");
+=09=09=09ret =3D -EINVAL;
+=09=09=09goto out;
+=09=09}
+=09}
+
 =09if (info->attrs[NBD_ATTR_SOCKETS]) {
 =09=09struct nlattr *attr;
 =09=09int rem, fd;
@@ -2132,7 +2168,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, =
struct genl_info *info)
 =09=09=09if (!socks[NBD_SOCK_FD])
 =09=09=09=09continue;
 =09=09=09fd =3D (int)nla_get_u32(socks[NBD_SOCK_FD]);
-=09=09=09ret =3D nbd_reconnect_socket(nbd, fd);
+=09=09=09ret =3D nbd_reconnect_socket(nbd, fd, swap_socks);
 =09=09=09if (ret) {
 =09=09=09=09if (ret =3D=3D -ENOSPC)
 =09=09=09=09=09ret =3D 0;
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netl=
ink.h
index c5d0ef7aa7d5..0e406445f06c 100644
--- a/include/uapi/linux/nbd-netlink.h
+++ b/include/uapi/linux/nbd-netlink.h
@@ -35,6 +35,7 @@ enum {
 =09NBD_ATTR_SOCKETS,
 =09NBD_ATTR_DEAD_CONN_TIMEOUT,
 =09NBD_ATTR_DEVICE_LIST,
+=09NBD_ATTR_SWAP_SOCKETS,
 =09__NBD_ATTR_MAX,
 };
 #define NBD_ATTR_MAX (__NBD_ATTR_MAX - 1)
--=20
2.21.0

