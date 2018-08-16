Return-Path: <SRS0=v1fk=K7=goodmis.org=rostedt@kernel.org>
Date: Thu, 16 Aug 2018 16:08:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/blktrace: Fix to allow setting same value
Message-ID: <20180816160837.30cb63cf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

[
  Jens, you want to take this one, or do you want me to?
]

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Masami Hiramatsu reported:

  Current trace-enable attribute in sysfs returns an error
  if user writes the same setting value as current one,
  e.g.

    # cat /sys/block/sda/trace/enable
    0
    # echo 0 > /sys/block/sda/trace/enable
    bash: echo: write error: Invalid argument
    # echo 1 > /sys/block/sda/trace/enable
    # echo 1 > /sys/block/sda/trace/enable
    bash: echo: write error: Device or resource busy

  But this is not a preferred behavior, it should ignore
  if new setting is same as current one. This fixes the
  problem as below.

    # cat /sys/block/sda/trace/enable
    0
    # echo 0 > /sys/block/sda/trace/enable
    # echo 1 > /sys/block/sda/trace/enable
    # echo 1 > /sys/block/sda/trace/enable

Link: http://lkml.kernel.org/r/20180816103802.08678002@gandalf.local.home

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: cd649b8bb830d ("blktrace: remove sysfs_blk_trace_enable_show/store()")
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/blktrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index b82e546083e1..614b5f0decd6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1829,6 +1829,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	mutex_lock(&q->blk_trace_mutex);
 
 	if (attr == &dev_attr_enable) {
+		if (!!value == !!q->blk_trace) {
+			ret = 0;
+			goto out_unlock_bdev;
+		}
 		if (value)
 			ret = blk_trace_setup_queue(q, bdev);
 		else
-- 
2.13.6
