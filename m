Return-Path: <su@seds.nl>
From: Ben Mezger <su@seds.nl>
Subject: [PATCH] block/Kconfig.iosched: Enable BFQ on DEFAULT_IOSCHED
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Message-ID: <26128c0d-7607-05e7-acb3-4a52139c232d@seds.nl>
Date: Tue, 4 Jul 2017 13:35:18 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This patch, allows BFQ to be chosen in the Default I/O scheduler prompt.

Signed-off-by: Ben Mezger <me@benmezger.nl>
---
 block/Kconfig.iosched | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index fd2cefa47d35..5be248ce447c 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -56,6 +56,9 @@ choice
        config DEFAULT_NOOP
                bool "No-op"

+       config DEFAULT_BFQ
+               bool "BFQ" if IOSCHED_BFQ=y
+
 endchoice

 config DEFAULT_IOSCHED
@@ -63,6 +66,7 @@ config DEFAULT_IOSCHED
        default "deadline" if DEFAULT_DEADLINE
        default "cfq" if DEFAULT_CFQ
        default "noop" if DEFAULT_NOOP
+       default "bfq" if DEFAULT_BFQ

 config MQ_IOSCHED_DEADLINE
        tristate "MQ deadline I/O scheduler"
--
2.13.2

-- 
- seds
https://seds.nl
