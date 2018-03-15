Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23307 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbeCOPIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:31 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 13/16] bcache: Make bch_dump_read() fail if copying to user space fails
Date: Thu, 15 Mar 2018 08:08:11 -0700
Message-Id: <20180315150814.9412-14-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

copy_to_user() returns the number of remaining bytes. Avoid that
a larger value is returned than the number of bytes that have
been copied by returning -EFAULT if not all bytes have been copied.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/debug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index af89408befe8..376899cfcbf1 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -175,9 +175,8 @@ static ssize_t bch_dump_read(struct file *file, char __user *buf,
 		struct keybuf_key *w;
 		unsigned bytes = min(i->bytes, size);
 
-		int err = copy_to_user(buf, i->buf, bytes);
-		if (err)
-			return err;
+		if (copy_to_user(buf, i->buf, bytes))
+			return -EFAULT;
 
 		ret	 += bytes;
 		buf	 += bytes;
-- 
2.16.2
