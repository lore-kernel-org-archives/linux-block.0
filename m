Return-Path: <joelaf@google.com>
MIME-Version: 1.0
In-Reply-To: <20170604040350.12641-3-joelaf@google.com>
References: <20170604040350.12641-1-joelaf@google.com> <20170604040350.12641-3-joelaf@google.com>
From: Joel Fernandes <joelaf@google.com>
Date: Sat, 3 Jun 2017 22:44:35 -0700
Message-ID: <CAJWu+oqeeWj-956wO_3HXemhhuDj_iuR8+gwuQ=Kbhzovb2weA@mail.gmail.com>
Subject: Re: [RFC v2 2/4] tracing: Add support for recording tgid of tasks
To: LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, kernel-team@android.com,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Some minor things that I will rework in next rev after spending some
more time on it:

On Sat, Jun 3, 2017 at 9:03 PM, Joel Fernandes <joelaf@google.com> wrote:
[..]
> @@ -463,7 +469,7 @@ int trace_set_clr_event(const char *system, const char *event, int set);
>  #define event_trace_printk(ip, fmt, args...)                           \
>  do {                                                                   \
>         __trace_printk_check_format(fmt, ##args);                       \
> -       tracing_record_cmdline(current);                                \
> +       tracing_record_taskinfo_single(current, true, false);           \
>         if (__builtin_constant_p(fmt)) {                                \
>                 static const char *trace_printk_fmt                     \
>                   __attribute__((section("__trace_printk_fmt"))) =      \
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 193c5f5e3f79..d7394cdf899e 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -236,7 +236,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
>         cpu = raw_smp_processor_id();
>
>         if (blk_tracer) {
> -               tracing_record_cmdline(current);
> +               tracing_record_taskinfo_single(current, true, false);

I think I will try to preserve the existing API so that existing users
aren't bothered much.

>
>                 buffer = blk_tr->trace_buffer.buffer;
>                 pc = preempt_count();
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 63deff9cdf2c..7be21ae4f0a8 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -87,7 +87,7 @@ dummy_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
>   * tracing is active, only save the comm when a trace event
>   * occurred.
>   */
> -static DEFINE_PER_CPU(bool, trace_cmdline_save);
> +static DEFINE_PER_CPU(bool, trace_taskinfo_save);
>
>  /*
>   * Kill all tracing for good (never come back).
> @@ -790,7 +790,7 @@ EXPORT_SYMBOL_GPL(tracing_on);
>  static __always_inline void
>  __buffer_unlock_commit(struct ring_buffer *buffer, struct ring_buffer_event *event)
>  {
> -       __this_cpu_write(trace_cmdline_save, true);
> +       __this_cpu_write(trace_taskinfo_save, true);
>
>         /* If this is the temp buffer, we need to commit fully */
>         if (this_cpu_read(trace_buffered_event) == event) {
> @@ -1709,6 +1709,15 @@ void tracing_reset_all_online_cpus(void)
>         }
>  }
>
> +static unsigned int *tgid_map;
> +
> +void tracing_alloc_tgid_map(void)
> +{
> +       tgid_map = kzalloc((PID_MAX_DEFAULT + 1) * sizeof(*tgid_map),
> +                          GFP_KERNEL);
> +       WARN_ONCE(!tgid_map, "Allocation of tgid_map failed\n");

I should check if tgid_map is already allocated or there's a chance of
re-allocating.

Looking forward to any other comments...

thanks,

-Joel
