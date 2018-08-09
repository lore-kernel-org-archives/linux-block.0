Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Shenghui Wang <shhuiw@foxmail.com>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 10/10] bcache: trivial - remove tailing backslash in macro BTREE_FLAG
Date: Thu,  9 Aug 2018 15:48:51 +0800
Message-Id: <20180809074851.11027-11-colyli@suse.de>
In-Reply-To: <20180809074851.11027-1-colyli@suse.de>
References: <20180809074851.11027-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Shenghui Wang <shhuiw@foxmail.com>

Remove the tailing backslash in macro BTREE_FLAG in btree.h

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index d211e2c25b6b..68e9d926134d 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -152,7 +152,7 @@ static inline bool btree_node_ ## flag(struct btree *b)			\
 {	return test_bit(BTREE_NODE_ ## flag, &b->flags); }		\
 									\
 static inline void set_btree_node_ ## flag(struct btree *b)		\
-{	set_bit(BTREE_NODE_ ## flag, &b->flags); }			\
+{	set_bit(BTREE_NODE_ ## flag, &b->flags); }
 
 enum btree_flags {
 	BTREE_NODE_io_error,
-- 
2.18.0
