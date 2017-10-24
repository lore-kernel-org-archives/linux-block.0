Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH] nbd: handle interrupted sendmsg with a sndtimeo set
Date: Tue, 24 Oct 2017 15:57:18 -0400
Message-Id: <1508875038-3397-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

If you do not set sk_sndtimeo you will get -ERESTARTSYS if there is a
pending signal when you enter sendmsg, which we handle properly.
However if you set a timeout for your commands we'll set sk_sndtimeo to
that timeout, which means that sendmsg will start returning -EINTR
instead of -ERESTARTSYS.  Fix this by checking either cases and doing
the correct thing.

Cc: stable@vger.kernel.org
Fixes: dc88e34d69d8 ("nbd: set sk->sk_sndtimeo for our sockets")
Reported-and-tested-by: Daniel Xu <dlxu@fb.com>
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 528e6f6951cc..8c3aa7ae79c8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -378,6 +378,15 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 	return result;
 }
 
+/*
+ * Different settings for sk->sk_sndtimeo can result in different return values
+ * if there is a signal pending when we enter sendmsg, because reasons?
+ */
+static inline int was_interrupted(int result)
+{
+	return result == -ERESTARTSYS || result == -EINTR;
+}
+
 /* always call with the tx_lock held */
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
@@ -450,7 +459,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	result = sock_xmit(nbd, index, 1, &from,
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
 	if (result <= 0) {
-		if (result == -ERESTARTSYS) {
+		if (was_interrupted(result)) {
 			/* If we havne't sent anything we can just return BUSY,
 			 * however if we have sent something we need to make
 			 * sure we only allow this req to be sent until we are
@@ -494,7 +503,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 			}
 			result = sock_xmit(nbd, index, 1, &from, flags, &sent);
 			if (result <= 0) {
-				if (result == -ERESTARTSYS) {
+				if (was_interrupted(result)) {
 					/* We've already sent the header, we
 					 * have no choice but to set pending and
 					 * return BUSY.
-- 
2.7.5
