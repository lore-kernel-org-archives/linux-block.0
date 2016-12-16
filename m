Return-Path: <linux@rasmusvillemoes.dk>
Return-Path: <linux@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Tejun Heo <tj@kernel.org>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Lai Jiangshan <jiangshanlai@gmail.com>,  "Jens Axboe" <axboe@kernel.dk>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,  "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,  "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [RFC 00/10] implement alternative and much simpler id allocator
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
	<20161209140140.5e0a68e2e1cf9861335bdf3b@linux-foundation.org>
	<BY2PR21MB00364EEDE35645341BEC695CCB9C0@BY2PR21MB0036.namprd21.prod.outlook.com>
Date: Fri, 16 Dec 2016 21:32:11 +0100
In-Reply-To: <BY2PR21MB00364EEDE35645341BEC695CCB9C0@BY2PR21MB0036.namprd21.prod.outlook.com>
	(Matthew Wilcox's message of "Fri, 16 Dec 2016 19:14:11 +0000")
Message-ID: <87inqj8vjo.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 16 2016, Matthew Wilcox <mawilcox@microsoft.com> wrote:

> From: Andrew Morton [mailto:akpm@linux-foundation.org]
>> On Thu,  8 Dec 2016 02:22:55 +0100 Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>> > TL;DR: these patches save 250 KB of memory, with more low-hanging
>> > fruit ready to pick.
>> >
>> > While browsing through the lib/idr.c code, I noticed that the code at
>> > the end of ida_get_new_above() probably doesn't work as intended: Most
>> > users of ida use it via ida_simple_get(), and that starts by
>> > unconditionally calling ida_pre_get(), ensuring that ida->idr has
>> > 8==MAX_IDR_FREE idr_layers in its free list id_free. In the common
>> > case, none (or at most one) of these get used during
>> > ida_get_new_above(), and we only free one, leaving at least 6 (usually
>> > 7) idr_layers in the free list.
>> 
>> I expect we'll be merging patches 1-32 of that series into 4.10-rc1 and
>> the above patch (#33) into 4.11-rc1.
>
> Hi Rasmus,
>
> Thanks for your work on this; you've really put some effort into
> proving your work has value.  My motivation was purely aesthetic, but
> you've got some genuine savings here (admittedly it's about a quarter
> of a cent's worth of memory with DRAM selling for $10/GB).
> Nevertheless, that adds up over a billion devices, and there are still
> people trying to fit Linux into 4MB embedded devices.
>

Yeah, my main motivation was embedded devices which don't have the
luxury of measuring their RAM in GB. E.g., it's crazy that the
watchdog_ida effectively use more memory than the .text of the watchdog
subsystem, and similarly for the kthread workers, etc., etc.. I didn't
mean for my patches to go in as is, more to provoke some discussion. I
wasn't aware of your reimplementation, but it seems that may make the
problem go away.

> I think my reimplementation of the IDA on top of the radix tree is
> close enough to your tIDA in memory consumption that it doesn't
> warrant a new data structure.
>
> On a 64-bit machine, your tIDA root is 24 bytes; my new IDA root is 16
> bytes.  If you allocate only one entry, you'll allocate 8 bytes.
> Thanks to the slab allocator, that gets rounded up to 32 bytes.  I
> allocate the full 128 byte leaf, but I store the pointer to it in the
> root (unlike the IDR, the radix tree doesn't need to allocate a layer
> for a single entry).  So tIDA wins on memory consumption between 1 and
> 511 IDs, and newIDA is slightly ahead between 512 and 1023 IDs.

This sounds good. I think there may still be a lot of users that never
allocate more than a handful of IDAs, making a 128 byte allocation still
somewhat excessive. One thing I considered was (exactly as it's done for
file descriptor tables) to embed a single word in the struct ida and
use that initially; I haven't looked closely at newIDA, so I don't know
how easy that would be or if its worth the complexity.

Rasmus
