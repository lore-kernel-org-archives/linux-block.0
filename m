Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: y2038@lists.linaro.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jeff Moyer <jmoyer@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Mike Christie <mchristi@redhat.com>,
	Shaohua Li <shli@fb.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blktrace: reword comment about time overflow
Date: Mon, 20 Jun 2016 22:00:12 +0200
Message-Id: <20160620200040.2813298-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

Jeff Moyer looked up the blktrace source to see if an overflow might
happen. The situation is as follows:

- The time stamp is not used by the program itself, only for
  printing human-readable output.
- We normally don't print the timestamp at all, except when an
  undocumented format option is given to blkparse.
- The assumption is that no other program besides blktrace
  even looks at this data, but of course cannot be sure.
- On 64-bit systems, the time gets read from the unsigned
  32-bit kernel structure into a timespec in a way that will
  work correctly until 2106, so there is no 2038 problem.
- On 32-bit systems that have a new (future) libc build with
  a 64-bit time_t type, it will work the same way.
- On current 32-bit systems, the time is passed into localtime(),
  at which point the overflow happens, but those systems are
  already broken.

In short, it's good enough for now, so update the comment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 59a37f8baeb2 ("blktrace: avoid using timespec")
Cc: Jeff Moyer <jmoyer@redhat.com>
---
 kernel/trace/blktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index b0816e4a61a5..4a3666779589 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -131,7 +131,8 @@ static void trace_note_time(struct blk_trace *bt)
 	unsigned long flags;
 	u32 words[2];
 
-	/* need to check user space to see if this breaks in y2038 or y2106 */
+	/* blktrace converts this to a time_t and will overflow in
+	   2106, not in 2038 */
 	ktime_get_real_ts64(&now);
 	words[0] = (u32)now.tv_sec;
 	words[1] = now.tv_nsec;
-- 
2.9.0
