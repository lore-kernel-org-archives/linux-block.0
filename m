Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH rfc 09/10] nvmet: Use non-selective polling
Date: Thu,  9 Mar 2017 15:16:41 +0200
Message-Id: <1489065402-14757-10-git-send-email-sagi@grimberg.me>
In-Reply-To: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

It doesn't really make sense to do selective polling
because we never care about specific IOs. Non selective
polling can actually help by doing some useful work
while we're submitting a command.

We ask for a batch of (magic) 4 completions which looks
like a decent network<->backend proportion, if less are
available we'll see less.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/io-cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4195115c7e54..8e4fd7ca4a8a 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -46,7 +46,6 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	struct scatterlist *sg;
 	struct bio *bio;
 	sector_t sector;
-	blk_qc_t cookie;
 	int op, op_flags = 0, i;
 
 	if (!req->sg_cnt) {
@@ -85,16 +84,17 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 			bio_set_op_attrs(bio, op, op_flags);
 
 			bio_chain(bio, prev);
-			cookie = submit_bio(prev);
+			submit_bio(prev);
 		}
 
 		sector += sg->length >> 9;
 		sg_cnt--;
 	}
 
-	cookie = submit_bio(bio);
+	submit_bio(bio);
 
-	blk_mq_poll(bdev_get_queue(req->ns->bdev), cookie);
+	/* magic 4 is what we are willing to grab before we return */
+	blk_mq_poll_batch(bdev_get_queue(req->ns->bdev), 4);
 }
 
 static void nvmet_execute_flush(struct nvmet_req *req)
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
