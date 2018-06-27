Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Document how blk_update_request() handles RQF_SPECIAL_PAYLOAD requests
Date: Wed, 27 Jun 2018 13:09:05 -0700
Message-Id: <20180627200905.15226-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The payload of struct request is stored in the request.bio chain if
the RQF_SPECIAL_PAYLOAD flag is not set and in request.special_vec if
RQF_SPECIAL_PAYLOAD has been set. However, blk_update_request()
iterates over req->bio whether or not RQF_SPECIAL_PAYLOAD has been
set. Additionally, the RQF_SPECIAL_PAYLOAD flag is ignored by
blk_rq_bytes() which means that the value returned by that function
is incorrect if the RQF_SPECIAL_PAYLOAD flag has been set. It is not
clear to me whether this is an oversight or whether this happened on
purpose. Anyway, document that it is known that both functions ignore
RQF_SPECIAL_PAYLOAD. See also commit f9d03f96b988 ("block: improve
handling of the magic discard payload").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5ac03e3ab786..f1e07ed1513c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3098,6 +3098,10 @@ EXPORT_SYMBOL_GPL(blk_steal_bios);
  *     Passing the result of blk_rq_bytes() as @nr_bytes guarantees
  *     %false return from this function.
  *
+ * Note:
+ *	The RQF_SPECIAL_PAYLOAD flag is ignored on purpose in both
+ *	blk_rq_bytes() and in blk_update_request().
+ *
  * Return:
  *     %false - this request doesn't have any more data
  *     %true  - this request has more data
-- 
2.17.1
