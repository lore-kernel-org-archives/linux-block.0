Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Stephen Bates <sbates@raithlin.com>
To: linux-nvme@lists.infradead.org, keith.busch@intel.com, axboe@fb.com,
 linux-block@vger.kernel.org
Subject: [TRIVIAL PATCH] nvme : trivial whitespace fix in pci.c
Date: Mon, 17 Oct 2016 17:24:19 -0600
Message-Id: <1476746659-24663-1-git-send-email-sbates@raithlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Stephen Bates <sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Remove annoying white space damage in pci.c.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7c6e9d..e2b3243 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -50,7 +50,7 @@
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
-
+
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
--
2.1.4

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
