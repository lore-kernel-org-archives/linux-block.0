Return-Path: <rostedt@goodmis.org>
Date: Fri, 17 Jun 2016 11:36:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
 y2038@lists.linaro.org, Hannes Reinecke <hare@suse.com>, Mike Christie
 <mchristi@redhat.com>, Shaohua Li <shli@fb.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: avoid using timespec
Message-ID: <20160617113648.69448c9f@gandalf.local.home>
In-Reply-To: <20160617145849.3771756-1-arnd@arndb.de>
References: <20160617145849.3771756-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>


Jens,

You want to take this, or do you want me to?

-- Steve


On Fri, 17 Jun 2016 16:58:26 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> The blktrace code stores the current time in a 32-bit word in its
> user interface. This is a bad idea because 32-bit seconds overflow
> at some point.
> 
> We probably have until 2106 before this one overflows, as it seems
> to use an 'unsigned' variable, but we should confirm that user
> space treats it the same way.
> 
> Aside from this, we want to stop using 'struct timespec' here,
> so I'm adding a comment about the overflow and change the code
> to use timespec64 instead to make the loss of range more obvious.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/blktrace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index ef86b965ade3..b0816e4a61a5 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -127,12 +127,13 @@ static void trace_note_tsk(struct task_struct *tsk)
>  
>  static void trace_note_time(struct blk_trace *bt)
>  {
> -	struct timespec now;
> +	struct timespec64 now;
>  	unsigned long flags;
>  	u32 words[2];
>  
> -	getnstimeofday(&now);
> -	words[0] = now.tv_sec;
> +	/* need to check user space to see if this breaks in y2038 or y2106 */
> +	ktime_get_real_ts64(&now);
> +	words[0] = (u32)now.tv_sec;
>  	words[1] = now.tv_nsec;
>  
>  	local_irq_save(flags);
