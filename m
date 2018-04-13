Return-Path: <SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org>
Date: Fri, 13 Apr 2018 13:50:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, Li Zefan
 <lizefan@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] tracing/events: block: bring more on a par with
 blktrace
Message-ID: <20180413135029.05163827@gandalf.local.home>
In-Reply-To: <20180413163623.11282-1-maier@linux.ibm.com>
References: <20180413163623.11282-1-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 13 Apr 2018 18:36:20 +0200
Steffen Maier <maier@linux.ibm.com> wrote:

> I had the need to understand I/O request processing in detail.
> But I also had the need to enrich block traces with other trace events
> including my own dynamic kprobe events. So I preferred block trace events
> over blktrace to get everything nicely sorted into one ftrace output.
> However, I missed device filtering for (un)plug events and also
> the difference between the two flavors of unplug.
>=20
> The first two patches bring block trace events closer to their
> counterpart in blktrace tooling.
>=20
> The last patch is just an RFC. I still kept it in this patch set because
> it is inspired by PATCH 2/2.
>=20
> Changes since v1:
> [PATCH v2 1/2]
> Use 0 and 1 instead of false and true for __print_symbolic table.
> Now "trace-cmd report" can decode it. [Steven Rostedt]
>=20
> Steffen Maier (3):
>   tracing/events: block: track and print if unplug was explicit or
>     schedule
>   tracing/events: block: dev_t via driver core for plug and unplug
>     events
>   tracing/events: block: also try to get dev_t via driver core for some
>     events
>=20
>  include/trace/events/block.h | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>=20

=46rom just the tracing point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

as for the race conditions in the block layer, I'll let someone else
decided that.

-- Steve
