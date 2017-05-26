Return-Path: <mka@google.com>
Return-Path: <mka@google.com>
From: Matthias Kaehlcke <mka@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/3] cfq-iosched: Mark cfq_clear_cfqq_*() as __maybe_unused
Date: Fri, 26 May 2017 14:22:35 -0700
Message-Id: <20170526212237.103525-2-mka@chromium.org>
In-Reply-To: <20170526212237.103525-1-mka@chromium.org>
References: <20170526212237.103525-1-mka@chromium.org>
List-ID: <linux-block@vger.kernel.org>

This fixes the following warning when building with clang:

    block/cfq-iosched.c:449:1: error: unused function 'cfq_clear_cfqq_sync'
        [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 block/cfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index da69b079725f..36ab3645effc 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -431,7 +431,8 @@ static inline void cfq_mark_cfqq_##name(struct cfq_queue *cfqq)		\
 {									\
 	(cfqq)->flags |= (1 << CFQ_CFQQ_FLAG_##name);			\
 }									\
-static inline void cfq_clear_cfqq_##name(struct cfq_queue *cfqq)	\
+static inline void __maybe_unused					\
+cfq_clear_cfqq_##name(struct cfq_queue *cfqq)				\
 {									\
 	(cfqq)->flags &= ~(1 << CFQ_CFQQ_FLAG_##name);			\
 }									\
-- 
2.13.0.219.gdb65acc882-goog
