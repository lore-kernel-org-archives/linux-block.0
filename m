Return-Path: <maier@linux.ibm.com>
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH v2 0/2] tracing/events: block: bring more on a par with blktrace
Date: Fri, 13 Apr 2018 18:36:20 +0200
Message-Id: <20180413163623.11282-1-maier@linux.ibm.com>
List-ID: <linux-block@vger.kernel.org>

I had the need to understand I/O request processing in detail.
But I also had the need to enrich block traces with other trace events
including my own dynamic kprobe events. So I preferred block trace events
over blktrace to get everything nicely sorted into one ftrace output.
However, I missed device filtering for (un)plug events and also
the difference between the two flavors of unplug.

The first two patches bring block trace events closer to their
counterpart in blktrace tooling.

The last patch is just an RFC. I still kept it in this patch set because
it is inspired by PATCH 2/2.

Changes since v1:
[PATCH v2 1/2]
Use 0 and 1 instead of false and true for __print_symbolic table.
Now "trace-cmd report" can decode it. [Steven Rostedt]

Steffen Maier (3):
  tracing/events: block: track and print if unplug was explicit or
    schedule
  tracing/events: block: dev_t via driver core for plug and unplug
    events
  tracing/events: block: also try to get dev_t via driver core for some
    events

 include/trace/events/block.h | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

-- 
2.13.5
