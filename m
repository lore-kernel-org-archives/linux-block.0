Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EDC31E47
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF58215EA
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="RUC+EYhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440276AbfFLQb6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:31:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35434 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406775AbfFLQb5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 12:31:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so11072501ljh.2
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2019 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HGZCcHNEAujaoQpz7hTvgflL6M87QkjZmmLX2/Xue6Q=;
        b=RUC+EYhpraNYK/Rlf/N0BEPsjELRPixbnog9GgyvTc++6Ug0xNyEsE2eHaMcUEVDgM
         +acMFdIzEEgOiWP773/EGircb6ihqaea5gRG8vNyaejkh7Lu2boHJEbSjFNJS8rd2Pmm
         qzV08oC0SnNpSLHcHYuzNE5FcrLKThcMbut26fiDnH0r+f0XjFlozDHl3y5dCJ13LIGo
         QWuQJLkIfbGRxuQc48ae2Huyxk+kGChEvj74I/YadPtiUbYDVudqP+MdBm75n6UEQkpv
         wVTEg7CzA0tIa661hPzkvJA6K/K3QbGDe2P3VBx6XeL4j/2zQF9tKUYbui3NL8kIbA4u
         KqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HGZCcHNEAujaoQpz7hTvgflL6M87QkjZmmLX2/Xue6Q=;
        b=ZGS6nxkAO2PiOOqtkF3Hlfgc8EFAy5EPmvw/8PBaMi6jTlNhyYhp4nJzP68bxUGjBo
         1frmnVCI3YlT1QRRuis1djc8Sm1Ax0d62XlT4kiIKOf3ceLLEes6TQ/L6Qb0xk/75UhN
         nkjS4WslYexmnwE0MiwvCmOnO6pyOMuy9Yx3/zeq0GzMrNKuQiXE+ncLvkLQCQo2tUyk
         +kE9+2x1bf2DJQpGtlDe+HsyGP7ZsjYo9wt+6l1r3ZBQ65NWWPsIw6hHPkcm26cbyyoW
         ZMNCaYUXEWaCWuDzngnazYQGXnNtX1FIC0cPX3QOkVbPk2kkFEUkCxgsI9svkpN+8N1o
         URIQ==
X-Gm-Message-State: APjAAAWN8Fc6xgK233y7ef4C4zQb6ei2v9B8iaVvJBdvhUJEDi0LQTmE
        dw1mkLnOHRLH5U71Pimt2mlLMQ==
X-Google-Smtp-Source: APXvYqylIJwYaB2IbLbaiDOpf7UoxWY9LigMZytt9CrNcVDG0hk9EVsNyJIyC59DZWUEwIBD1AmV/A==
X-Received: by 2002:a2e:12c8:: with SMTP id 69mr33409068ljs.189.1560357114332;
        Wed, 12 Jun 2019 09:31:54 -0700 (PDT)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id e26sm54358ljl.33.2019.06.12.09.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:31:53 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        nbd@other.debian.org, A.Bulyshchenko@globallogic.com,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH 2/2] nbd: add support for nbd as root device
Date:   Wed, 12 Jun 2019 19:31:44 +0300
Message-Id: <20190612163144.18486-2-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Adding support to nbd to use it as a root device. This code essentially
provides a minimal nbd-client implementation within the kernel. It opens
a socket and makes the negotiation with the server. Afterwards it passes
the socket to the normal nbd-code to handle the connection.

The arguments for the server are passed via kernel command line.
The kernel command line has the format
'nbdroot=[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>'.
SERVER_IP is optional. If it is not available it will use the
root_server_addr transmitted through DHCP.

Based on those arguments, the connection to the server is established
and is connected to the nbd0 device. The rootdevice therefore is
root=/dev/nbd0.

Patch was initialy posted by Markus Pargmann <mpa@pengutronix.de>
and can be found at https://lore.kernel.org/patchwork/patch/532556/

Change-Id: I78f7313918bf31b9dc01a74a42f0f068bede312c
Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
Reviewed-by: Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>
---
 drivers/block/Kconfig |  19 +++
 drivers/block/nbd.c   | 294 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 313 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 20bb4bfa4be6..e17f2376de60 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -273,6 +273,25 @@ config BLK_DEV_NBD
 
 	  If unsure, say N.
 
+config BLK_DEV_NBDROOT
+	bool "Early network block device client support"
+	depends on BLK_DEV_NBD=y
+	---help---
+	  Saying yes will enable kernel NBD client support. This allows to
+	  connect entire disk with multiple partitions before mounting rootfs.
+
+	  The arguments for the server are passed via kernel command line.
+	  The kernel command line has the format
+	  'nbdroot=[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>'.
+	  SERVER_IP is optional. If it is not available it will use the
+	  root_server_addr transmitted through DHCP.
+
+	  Based on those arguments, the connection to the server is established
+	  and is connected to the nbd0 device. The rootdevice therefore is
+	  root=/dev/nbd0.
+
+	  If unsure, say N.
+
 config BLK_DEV_SKD
 	tristate "STEC S1120 Block Driver"
 	depends on PCI
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 63fcfb38e640..cb5e60419e07 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -46,6 +46,35 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/nbd.h>
 
+#include <net/ipconfig.h>
+#include <linux/in.h>
+#include <linux/tcp.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs.h>
+
+#define ADDR_NONE cpu_to_be32(INADDR_NONE)
+
+static const char nbd_magic[] = "NBDMAGIC";
+static const u64 nbd_opts_magic = 0x49484156454F5054LL;
+
+/* Options used for the kernel driver */
+#define NBD_OPT_EXPORT_NAME 1
+
+#define NBD_DEFAULT_BLOCKSIZE 512 /* bytes */
+
+#define NBD_DEFAULT_TIMEOUT 2 /* seconds */
+
+#define NBD_MAXPATHLEN  NFS_MAXPATHLEN
+
+struct nbdroot {
+	const char *bdev;
+	__be32 server_addr;
+	__be32 server_port;
+	loff_t block_size;
+	int timeout;
+	char server_export[NBD_MAXPATHLEN + 1];
+};
+
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static int nbd_total_devices = 0;
@@ -441,6 +470,16 @@ static int sock_xmit(struct socket *sock, int send,
 	return result;
 }
 
+static int sock_xmit_buf(struct socket *sock, int send,
+			 void *buf, size_t size)
+{
+	struct iov_iter iter;
+	struct kvec iov = {.iov_base = buf, .iov_len = size};
+
+	iov_iter_kvec(&iter, WRITE | ITER_KVEC, &iov, 1, size);
+	return sock_xmit(sock, send, &iter, 0, 0);
+}
+
 static int nbd_xmit(struct nbd_device *nbd, int index, int send,
 		     struct iov_iter *iter, int msg_flags, int *sent)
 {
@@ -2301,6 +2340,261 @@ static void __exit nbd_cleanup(void)
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
 
+#ifdef CONFIG_BLK_DEV_NBDROOT
+
+struct nbdroot nbdroot_0 = {.bdev = "nbd0",
+			    .server_export = "",
+			    .server_addr = ADDR_NONE,
+			    .timeout = NBD_DEFAULT_TIMEOUT,
+			    .block_size = NBD_DEFAULT_BLOCKSIZE};
+
+static int nbd_connect(struct nbdroot *nbdroot, struct socket **socket)
+{
+	struct socket *sock;
+	struct sockaddr_in sockaddr;
+	int err;
+	char val;
+
+	err = sock_create_kern(&init_net, AF_INET, SOCK_STREAM,
+			       IPPROTO_TCP, &sock);
+	if (err < 0)
+		return err;
+
+	sockaddr.sin_family = AF_INET;
+	sockaddr.sin_addr.s_addr = nbdroot->server_addr;
+	sockaddr.sin_port = nbdroot->server_port;
+
+	val = 1;
+	sock->ops->setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, &val,
+			      sizeof(val));
+
+	err = sock->ops->connect(sock, (struct sockaddr *)&sockaddr,
+				 sizeof(sockaddr), 0);
+	if (err < 0)
+		return err;
+
+	*socket = sock;
+
+	return 0;
+}
+
+static int nbd_connection_negotiate(struct socket *sock, char *export_name,
+				    size_t *rsize, u16 *nflags)
+{
+	char buf[256];
+	int ret;
+	u64 magic;
+	u16 flags;
+	u32 client_flags;
+	u32 opt;
+	u32 name_len;
+	u64 nbd_size;
+
+	ret = sock_xmit_buf(sock, 0, buf, 8);
+	if (ret < 0)
+		return ret;
+
+	if (strncmp(buf, nbd_magic, 8))
+		return -EINVAL;
+
+	ret = sock_xmit_buf(sock, 0, &magic, sizeof(magic));
+	if (ret < 0)
+		return ret;
+	magic = be64_to_cpu(magic);
+
+	if (magic != nbd_opts_magic)
+		return -EINVAL;
+
+	ret = sock_xmit_buf(sock, 0, &flags, sizeof(flags));
+	if (ret < 0)
+		return ret;
+
+	*nflags = ntohs(flags);
+
+	client_flags = 0;
+
+	ret = sock_xmit_buf(sock, 1, &client_flags, sizeof(client_flags));
+	if (ret < 0)
+		return ret;
+
+	magic = cpu_to_be64(nbd_opts_magic);
+	ret = sock_xmit_buf(sock, 1, &magic, sizeof(magic));
+	if (ret < 0)
+		return ret;
+
+	opt = htonl(NBD_OPT_EXPORT_NAME);
+	ret = sock_xmit_buf(sock, 1, &opt, sizeof(opt));
+	if (ret < 0)
+		return ret;
+
+	name_len = strlen(export_name) + 1;
+	name_len = htonl(name_len);
+	ret = sock_xmit_buf(sock, 1, &name_len, sizeof(name_len));
+	if (ret < 0)
+		return ret;
+
+	ret = sock_xmit_buf(sock, 1, export_name, strlen(export_name) + 1);
+	if (ret < 0)
+		return ret;
+
+	ret = sock_xmit_buf(sock, 0, &nbd_size, sizeof(nbd_size));
+	if (ret < 0)
+		return ret;
+	nbd_size = be64_to_cpu(nbd_size);
+
+	ret = sock_xmit_buf(sock, 0, &flags, sizeof(flags));
+	if (ret < 0)
+		return ret;
+	*nflags = ntohs(flags);
+
+	ret = sock_xmit_buf(sock, 0, buf, 124);
+	if (ret < 0)
+		return ret;
+
+	*rsize = nbd_size;
+
+	return 0;
+}
+
+static int nbd_bind_connection(struct nbdroot *nbdroot, struct nbd_device *nbd,
+			       struct socket *sock, size_t rsize, u32 flags)
+{
+	int conn, ret;
+	struct block_device *bdev = blkdev_get_by_dev(disk_devt(nbd->disk),
+					FMODE_READ | FMODE_WRITE, 0);
+
+	if (IS_ERR(bdev)) {
+		pr_err("nbdroot: blkdev_get_by_dev failed %ld\n",
+		       PTR_ERR(bdev));
+		return PTR_ERR(bdev);
+	}
+
+	conn = nbd->config->num_connections;
+	ret = nbd_add_socket(nbd, sock, false);
+	if (ret) {
+		pr_err("nbdroot: add socket failed %d\n", ret);
+		return ret;
+	}
+
+	mutex_lock(&nbd->config->socks[conn]->tx_lock);
+
+	nbd->config->flags = flags;
+
+	nbd_size_set(nbd, nbdroot->block_size,
+		     div_s64(rsize, nbdroot->block_size));
+
+	nbd->tag_set.timeout = nbdroot->timeout * HZ;
+	blk_queue_rq_timeout(nbd->disk->queue, nbdroot->timeout * HZ);
+
+	mutex_unlock(&nbd->config->socks[conn]->tx_lock);
+
+	ret = nbd_start_device_ioctl(nbd, bdev);
+	if (ret) {
+		pr_err("nbdroot: start device ioctl failed %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int nbdroot_thread(void *arg)
+{
+	struct nbdroot *nbdroot = (struct nbdroot *)arg;
+	struct socket *sock = 0;
+	size_t rsize;
+	u16 nflags;
+	int ret;
+	dev_t devt = blk_lookup_devt(nbdroot->bdev, 0);
+	struct gendisk *disk = get_gendisk(devt, &ret);
+	struct nbd_device *nbd = (struct nbd_device *)disk->private_data;
+
+	ret = nbd_connect(nbdroot, &sock);
+	if (ret) {
+		pr_err("nbdroot: connect failed %d\n", ret);
+		goto err;
+	}
+
+	ret = nbd_connection_negotiate(sock, nbdroot->server_export,
+				       &rsize, &nflags);
+	if (ret) {
+		pr_err("nbdroot: negotiation failed %d\n", ret);
+		goto err;
+	}
+
+	ret = nbd_bind_connection(nbdroot, nbd, sock, rsize, nflags);
+	if (ret) {
+		pr_err("nbdroot: nbd_bind_connection failed %d\n", ret);
+		goto err;
+	}
+	return 0;
+
+err:
+	pr_err("nbdroot: %s init failed, IP: %pI4, port: %i, export: %s\n",
+	       nbdroot->bdev, &nbdroot->server_addr,
+	       ntohs(nbdroot->server_port), nbdroot->server_export);
+
+	if (sock)
+		sock_release(sock);
+
+	return ret;
+}
+
+static int __init nbdroot_init(void)
+{
+	if (nbdroot_0.server_port != 0)
+		kthread_run(nbdroot_thread, &nbdroot_0, "nbdroot_0");
+
+	return 0;
+}
+
+/* We need this in late_initcall_sync to be sure that the network is setup */
+late_initcall_sync(nbdroot_init);
+
+/*
+ * Parse format "[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>"
+ */
+static int __init nbdroot_setup(char *line)
+{
+	struct nbdroot *nbdroot = &nbdroot_0;
+	char *export;
+	u16 port;
+	int ret;
+	char buf[NBD_MAXPATHLEN + 1];
+
+	strlcpy(buf, line, sizeof(buf) - 1);
+
+	nbdroot->server_addr = root_nfs_parse_addr(buf);
+
+	if (*buf == '\0')
+		return -EINVAL;
+
+	if (nbdroot->server_addr == ADDR_NONE) {
+		if (root_server_addr == ADDR_NONE) {
+			pr_err("nbdroot: Failed to find server address\n");
+			return -EINVAL;
+		}
+		nbdroot->server_addr = root_server_addr;
+	}
+
+	export = strchr(buf, '/');
+	*export = '\0';
+	++export;
+
+	ret = kstrtou16(buf, 10, &port);
+	if (ret)
+		return ret;
+
+	nbdroot->server_port = htons(port);
+	strlcpy(nbdroot->server_export, export,
+		sizeof(nbdroot->server_export) - 1);
+
+	return 0;
+}
+
+__setup("nbdroot=", nbdroot_setup);
+
+#endif /* CONFIG_BLK_DEV_NBDROOT */
+
 module_init(nbd_init);
 module_exit(nbd_cleanup);
 
-- 
2.17.1

