Return-Path: <SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org>
Date: Fri, 13 Apr 2018 10:16:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, Li Zefan
 <lizf@cn.fujitsu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] tracing/events: block: track and print if unplug
 was explicit or schedule
Message-ID: <20180413101612.3999f742@gandalf.local.home>
In-Reply-To: <20180413130719.22921-2-maier@linux.ibm.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
	<20180413130719.22921-2-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 13 Apr 2018 15:07:17 +0200
Steffen Maier <maier@linux.ibm.com> wrote:

> Just like blktrace distinguishes explicit and schedule by means of
> BLK_TA_UNPLUG_IO and BLK_TA_UNPLUG_TIMER, actually make use of the
> existing argument "explicit" to distinguish the two cases in the one
> common tracepoint block_unplug.
> 
> Complements v2.6.39 commit 49cac01e1fa7 ("block: make unplug timer trace
> event correspond to the schedule() unplug") and commit d9c978331790
> ("block: remove block_unplug_timer() trace point").
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> ---
>  include/trace/events/block.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 81b43f5bdf23..a13613d27cee 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -470,6 +470,11 @@ TRACE_EVENT(block_plug,
>  	TP_printk("[%s]", __entry->comm)
>  );
>  
> +#define show_block_unplug_explicit(val)		\
> +	__print_symbolic(val,			\
> +			 {false, "schedule"},	\
> +			 {true,	 "explicit"})

That's new. I haven't seen "true"/"false" values used for
print_symbolic before. But could you please use 1 and 0 instead, because
perf and trace-cmd won't be able to parse that. I could update
libtraceevent to handle it, but really, the first parameter is suppose
to be numeric.

-- Steve

> +
>  DECLARE_EVENT_CLASS(block_unplug,
>  
>  	TP_PROTO(struct request_queue *q, unsigned int depth, bool explicit),
> @@ -478,15 +483,18 @@ DECLARE_EVENT_CLASS(block_unplug,
>  
>  	TP_STRUCT__entry(
>  		__field( int,		nr_rq			)
> +		__field( bool,		explicit		)
>  		__array( char,		comm,	TASK_COMM_LEN	)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->nr_rq = depth;
> +		__entry->explicit = explicit;
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>  	),
>  
> -	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
> +	TP_printk("[%s] %d %s", __entry->comm, __entry->nr_rq,
> +		  show_block_unplug_explicit(__entry->explicit))
>  );
>  
>  /**
