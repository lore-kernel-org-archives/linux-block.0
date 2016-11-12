Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] irq-poll: Remove redundant include
Date: Sun, 13 Nov 2016 01:02:33 +0200
Message-Id: <1478991755-28153-2-git-send-email-sagi@grimberg.me>
In-Reply-To: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
References: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 lib/irq_poll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 1d6565e81030..22d033e6ded2 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -5,7 +5,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/bio.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/irq_poll.h>
-- 
2.7.4
