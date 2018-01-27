Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Zhouyi Zhou <yizhouzhou@ict.ac.cn>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Eric Biggers <ebiggers@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "kernel/relay.c: fix potential memory leak"
Date: Fri, 26 Jan 2018 16:47:59 -0800
Message-Id: <20180127004759.101823-1-ebiggers3@gmail.com>
In-Reply-To: <089e082d01d08b36a6055cd763ca@google.com>
References: <089e082d01d08b36a6055cd763ca@google.com>
List-ID: <linux-block@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This reverts commit ba62bafe942b159a6109cbec780d36496e06b6c5.

This commit introduced a double free bug, because 'chan' is already
freed by the line:

    kref_put(&chan->kref, relay_destroy_channel);

This bug was found by syzkaller, using the BLKTRACESETUP ioctl.

Fixes: ba62bafe942b ("kernel/relay.c: fix potential memory leak")
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel/relay.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 39a9dfc69486..55da824f4adc 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -611,7 +611,6 @@ struct rchan *relay_open(const char *base_filename,
 
 	kref_put(&chan->kref, relay_destroy_channel);
 	mutex_unlock(&relay_channels_mutex);
-	kfree(chan);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(relay_open);
-- 
2.16.0.rc1.238.g530d649a79-goog
