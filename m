Return-Path: <mka@google.com>
Return-Path: <mka@google.com>
From: Matthias Kaehlcke <mka@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/3] cfq-iosched: Delete unused function min_vdisktime()
Date: Fri, 26 May 2017 14:22:37 -0700
Message-Id: <20170526212237.103525-4-mka@chromium.org>
In-Reply-To: <20170526212237.103525-1-mka@chromium.org>
References: <20170526212237.103525-1-mka@chromium.org>
List-ID: <linux-block@vger.kernel.org>

This fixes the following warning when building with clang:

    block/cfq-iosched.c:970:19: error: unused function 'min_vdisktime'
        [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 block/cfq-iosched.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index b23c73db4cc0..61cb45553314 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -981,15 +981,6 @@ static inline u64 max_vdisktime(u64 min_vdisktime, u64 vdisktime)
 	return min_vdisktime;
 }
 
-static inline u64 min_vdisktime(u64 min_vdisktime, u64 vdisktime)
-{
-	s64 delta = (s64)(vdisktime - min_vdisktime);
-	if (delta < 0)
-		min_vdisktime = vdisktime;
-
-	return min_vdisktime;
-}
-
 static void update_min_vdisktime(struct cfq_rb_root *st)
 {
 	struct cfq_group *cfqg;
-- 
2.13.0.219.gdb65acc882-goog
