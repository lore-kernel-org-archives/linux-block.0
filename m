Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, y2038@lists.linaro.org,
        Hannes Reinecke <hare@suse.com>, Mike Christie <mchristi@redhat.com>,
        Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: avoid using timespec
References: <20160617145849.3771756-1-arnd@arndb.de>
	<57646E09.9080408@kernel.dk>
	<x494m8r5vnb.fsf@segfault.boston.devel.redhat.com>
	<3744206.k1Hv7RyTzG@wuerfel>
Date: Mon, 20 Jun 2016 10:59:14 -0400
In-Reply-To: <3744206.k1Hv7RyTzG@wuerfel> (Arnd Bergmann's message of "Sat, 18
	Jun 2016 21:02:08 +0200")
Message-ID: <x49lh1zucsd.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday, June 17, 2016 5:54:16 PM CEST Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>> > On 06/17/2016 05:36 PM, Steven Rostedt wrote:
>> >>
>> >> Jens,
>> >>
>> >> You want to take this, or do you want me to?
>> >
>> > I'll add it to my 4.8 tree, thanks Arnd.
>> 
>> +       /* need to check user space to see if this breaks in y2038 or y2106 */
>> 
>> Userspace just uses it to print the timestamp, right?  So do we need the
>> comment?

> If we have more details, the comment should describe what happens and
> when it overflows. If you have the source at hand, maybe you can answer
> these:

As far as I can tell, that value is only ever consulted when an
undocumented format option is given to blkparse.  I don't think this
matters very much.

> How does it print the timestamp? Does it print the raw seconds value
> using %u (correct) or %d (incorrect), or does it convert it into
> year/month/day/hour/min/sec?

It converts it, but only prints hour/min/sec (and nsec):

struct timespec         abs_start_time;

...
static void handle_notify(struct blk_io_trace *bit)
{
...
        __u32   two32[2];
...
                abs_start_time.tv_sec  = two32[0];
                abs_start_time.tv_nsec = two32[1];
                if (abs_start_time.tv_nsec < 0) {
                        abs_start_time.tv_sec--;
                        abs_start_time.tv_nsec += 1000000000;
                }
...

static const char *
print_time(unsigned long long timestamp)
{
        static char     timebuf[128];
        struct tm       *tm;
        time_t          sec;
        unsigned long   nsec;

        sec  = abs_start_time.tv_sec + SECONDS(timestamp);
        nsec = abs_start_time.tv_nsec + NANO_SECONDS(timestamp);
        if (nsec >= 1000000000) {
                nsec -= 1000000000;
                sec += 1;
        }

        tm = localtime(&sec);
        snprintf(timebuf, sizeof(timebuf),
                        "%02u:%02u:%02u.%06lu",
                        tm->tm_hour,
                        tm->tm_min,
                        tm->tm_sec,
                        nsec / 1000);
        return timebuf;
}

> In the last case, how does it treat second values above 0x80000000? Are
> those printed as  year 2038 or year 1902?

We don't print the year.

> Are we sure that there is only one user space implementation that reads
> these values?

We're never sure about that.  However, I'd be very surprised if anything
outside of blktrace used this.

Cheers,
Jeff
