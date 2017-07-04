Return-Path: <su@seds.nl>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Ben Mezger <su@seds.nl>
Subject: [PATCH] block/Kconfig.iosched: Indent help text with 2 spaces.
Message-ID: <6b1fb415-92f1-805d-82d2-049a40155fc9@seds.nl>
Date: Tue, 4 Jul 2017 13:38:18 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This patch adds two spaces in the help section, following the Kconfig indentation guideline.

Signed-off-by: Ben Mezger <me@benmezger.nl>
---
 block/Kconfig.iosched | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 5be248ce447c..90e6e7c65c92 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -87,12 +87,12 @@ config IOSCHED_BFQ
        tristate "BFQ I/O scheduler"
        default n
        ---help---
-       BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
-       of the device among all processes according to their weights,
-       regardless of the device parameters and with any workload. It
-       also guarantees a low latency to interactive and soft
-       real-time applications.  Details in
-       Documentation/block/bfq-iosched.txt
+         BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
+         of the device among all processes according to their weights,
+         regardless of the device parameters and with any workload. It
+         also guarantees a low latency to interactive and soft
+         real-time applications.  Details in
+         Documentation/block/bfq-iosched.txt

 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
--
2.13.2


-- 
- seds
https://seds.nl
