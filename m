Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 01/10] nvme: report more detailed status codes to the block layer
Date: Wed, 23 Aug 2017 19:58:06 +0200
Message-Id: <20170823175815.3646-2-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1db8de0bee87..b8ecd155be19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -113,7 +113,16 @@ static blk_status_t nvme_error_status(struct request *req)
 	case NVME_SC_WRITE_FAULT:
 	case NVME_SC_READ_ERROR:
 	case NVME_SC_UNWRITTEN_BLOCK:
+	case NVME_SC_ACCESS_DENIED:
+	case NVME_SC_READ_ONLY:
 		return BLK_STS_MEDIUM;
+	case NVME_SC_GUARD_CHECK:
+	case NVME_SC_APPTAG_CHECK:
+	case NVME_SC_REFTAG_CHECK:
+	case NVME_SC_INVALID_PI:
+		return BLK_STS_PROTECTION;
+	case NVME_SC_RESERVATION_CONFLICT:
+		return BLK_STS_NEXUS;
 	default:
 		return BLK_STS_IOERR;
 	}
-- 
2.11.0
