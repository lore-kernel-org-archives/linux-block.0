Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, y2038@lists.linaro.org, Hannes Reinecke <hare@suse.com>, Mike Christie <mchristi@redhat.com>, Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: avoid using timespec
Date: Mon, 20 Jun 2016 17:18:52 +0200
Message-ID: <3667244.FPOaAfVsUJ@wuerfel>
In-Reply-To: <x49lh1zucsd.fsf@segfault.boston.devel.redhat.com>
References: <20160617145849.3771756-1-arnd@arndb.de> <3744206.k1Hv7RyTzG@wuerfel> <x49lh1zucsd.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Monday, June 20, 2016 10:59:14 AM CEST Jeff Moyer wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Friday, June 17, 2016 5:54:16 PM CEST Jeff Moyer wrote:
> >> Jens Axboe <axboe@kernel.dk> writes:
> >> 
> >> > On 06/17/2016 05:36 PM, Steven Rostedt wrote:
> >> >>
> >> >> Jens,
> >> >>
> >> >> You want to take this, or do you want me to?
> >> >
> >> > I'll add it to my 4.8 tree, thanks Arnd.
> >> 
> >> +       /* need to check user space to see if this breaks in y2038 or y2106 */
> >> 
> >> Userspace just uses it to print the timestamp, right?  So do we need the
> >> comment?
> 
> > If we have more details, the comment should describe what happens and
> > when it overflows. If you have the source at hand, maybe you can answer
> > these:
> 
> As far as I can tell, that value is only ever consulted when an
> undocumented format option is given to blkparse.  I don't think this
> matters very much.

Ok.

> > How does it print the timestamp? Does it print the raw seconds value
> > using %u (correct) or %d (incorrect), or does it convert it into
> > year/month/day/hour/min/sec?
> 
> It converts it, but only prints hour/min/sec (and nsec):
> 
> struct timespec         abs_start_time;
> 
> ...
> static void handle_notify(struct blk_io_trace *bit)
> {
> ...
>         __u32   two32[2];
> ...
>                 abs_start_time.tv_sec  = two32[0];
>                 abs_start_time.tv_nsec = two32[1];
>                 if (abs_start_time.tv_nsec < 0) {
>                         abs_start_time.tv_sec--;
>                         abs_start_time.tv_nsec += 1000000000;
>                 }
> ...
> 
> static const char *
> print_time(unsigned long long timestamp)
> {
>         static char     timebuf[128];
>         struct tm       *tm;
>         time_t          sec;
>         unsigned long   nsec;
> 
>         sec  = abs_start_time.tv_sec + SECONDS(timestamp);
>         nsec = abs_start_time.tv_nsec + NANO_SECONDS(timestamp);
>         if (nsec >= 1000000000) {
>                 nsec -= 1000000000;
>                 sec += 1;
>         }
> 
>         tm = localtime(&sec);
>         snprintf(timebuf, sizeof(timebuf),
>                         "%02u:%02u:%02u.%06lu",
>                         tm->tm_hour,
>                         tm->tm_min,
>                         tm->tm_sec,
>                         nsec / 1000);
>         return timebuf;
> }

I assume that abs_start_time is a timespec, implying that
tv_sec is a time_t. This means it behaves differently on 32-bit
and 64-bit systems, where the former will overflow in the
conversion from a large unsigned 32-bit number to a signed
32-bit number, whereas the conversion to signed 64-bit will
work correctly.

However, this is ok, because 32-bit time_t is already broken
for a number of reasons, and the code you quote will work correctly
on any 32-bit system that is built with a future glibc that provides
a 64-bit time_t.

> > In the last case, how does it treat second values above 0x80000000? Are
> > those printed as  year 2038 or year 1902?
> 
> We don't print the year.

Ok, but the other numbers will be wrong in case of overflow.

> > Are we sure that there is only one user space implementation that reads
> > these values?
> 
> We're never sure about that.  However, I'd be very surprised if anything
> outside of blktrace used this.

Ok. Thanks a lot for the information. I think we can update the
comment as in the incremental patch below. Jens, can you fold that
into the original patch, or should I submit this as a new (or
incremental) patch with an updated description?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
