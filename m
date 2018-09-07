Return-Path: <gregkh@linuxfoundation.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 46/89] tracing/blktrace: Fix to allow setting same value
Date: Fri,  7 Sep 2018 23:09:40 +0200
Message-Id: <20180907210858.105984780@linuxfoundation.org>
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 757d9140072054528b13bbe291583d9823cde195 upstream.

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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/blktrace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1809,6 +1809,10 @@ static ssize_t sysfs_blk_trace_attr_stor
 	mutex_lock(&q->blk_trace_mutex);
 
 	if (attr == &dev_attr_enable) {
+		if (!!value == !!q->blk_trace) {
+			ret = 0;
+			goto out_unlock_bdev;
+		}
 		if (value)
 			ret = blk_trace_setup_queue(q, bdev);
 		else
