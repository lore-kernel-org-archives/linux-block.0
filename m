Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 26/55] skd: Use __packed only when needed
Date: Thu, 17 Aug 2017 13:13:09 -0700
Message-Id: <20170817201338.16537-27-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since needless use of __packed slows down access to data structures,
only use __packed when needed.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_s1120.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/skd_s1120.h b/drivers/block/skd_s1120.h
index 8044705cbbf9..de35f47e953c 100644
--- a/drivers/block/skd_s1120.h
+++ b/drivers/block/skd_s1120.h
@@ -10,8 +10,6 @@
 #ifndef SKD_S1120_H
 #define SKD_S1120_H
 
-#pragma pack(push, s1120_h, 1)
-
 /*
  * Q-channel, 64-bit r/w
  */
@@ -276,7 +274,7 @@ struct fit_comp_error_info {
 	uint16_t	sks_low; /* 10: Sense Key Specific (LSW) */
 	uint16_t	reserved3; /* 12: Part of additional sense bytes (unused) */
 	uint16_t	uec; /* 14: Additional Sense Bytes */
-	uint64_t	per; /* 16: Additional Sense Bytes */
+	uint64_t	per __packed; /* 16: Additional Sense Bytes */
 	uint8_t		reserved4[2]; /* 1E: Additional Sense Bytes (unused) */
 };
 
@@ -323,6 +321,4 @@ struct driver_inquiry_data {
 	uint8_t		driver_version[0x14];
 };
 
-#pragma pack(pop, s1120_h)
-
 #endif /* SKD_S1120_H */
-- 
2.14.0
