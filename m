Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Petr Vandrovec <petr@vandrovec.name>
Subject: [PATCH 20/24] ncpfs: Convert to separately allocated bdi
Date: Thu,  2 Feb 2017 18:34:18 +0100
Message-Id: <20170202173422.3240-21-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Allocate struct backing_dev_info separately instead of embedding it
inside the superblock. This unifies handling of bdi among users.

CC: Petr Vandrovec <petr@vandrovec.name>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ncpfs/inode.c     | 8 ++------
 fs/ncpfs/ncp_fs_sb.h | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
index 7eb89c23c847..245c23d516a4 100644
--- a/fs/ncpfs/inode.c
+++ b/fs/ncpfs/inode.c
@@ -553,12 +553,11 @@ static int ncp_fill_super(struct super_block *sb, void *raw_data, int silent)
 	sb->s_magic = NCP_SUPER_MAGIC;
 	sb->s_op = &ncp_sops;
 	sb->s_d_op = &ncp_dentry_operations;
-	sb->s_bdi = &server->bdi;
 
 	server = NCP_SBP(sb);
 	memset(server, 0, sizeof(*server));
 
-	error = bdi_setup_and_register(&server->bdi, "ncpfs");
+	error = super_setup_bdi(sb);
 	if (error)
 		goto out_fput;
 
@@ -567,7 +566,7 @@ static int ncp_fill_super(struct super_block *sb, void *raw_data, int silent)
 	if (data.info_fd != -1) {
 		struct socket *info_sock = sockfd_lookup(data.info_fd, &error);
 		if (!info_sock)
-			goto out_bdi;
+			goto out_fput;
 		server->info_sock = info_sock;
 		error = -EBADFD;
 		if (info_sock->type != SOCK_STREAM)
@@ -745,8 +744,6 @@ static int ncp_fill_super(struct super_block *sb, void *raw_data, int silent)
 out_fput2:
 	if (server->info_sock)
 		sockfd_put(server->info_sock);
-out_bdi:
-	bdi_destroy(&server->bdi);
 out_fput:
 	sockfd_put(sock);
 out:
@@ -787,7 +784,6 @@ static void ncp_put_super(struct super_block *sb)
 	kill_pid(server->m.wdog_pid, SIGTERM, 1);
 	put_pid(server->m.wdog_pid);
 
-	bdi_destroy(&server->bdi);
 	kfree(server->priv.data);
 	kfree(server->auth.object_name);
 	vfree(server->rxbuf);
diff --git a/fs/ncpfs/ncp_fs_sb.h b/fs/ncpfs/ncp_fs_sb.h
index 55e26fd80886..366fd63cc506 100644
--- a/fs/ncpfs/ncp_fs_sb.h
+++ b/fs/ncpfs/ncp_fs_sb.h
@@ -143,7 +143,6 @@ struct ncp_server {
 		size_t len;
 		__u8 data[128];
 	} unexpected_packet;
-	struct backing_dev_info bdi;
 };
 
 extern void ncp_tcp_rcv_proc(struct work_struct *work);
-- 
2.10.2
