Return-Path: <linux@rasmusvillemoes.dk>
Return-Path: <linux@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Tejun Heo <tj@kernel.org>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Lai Jiangshan <jiangshanlai@gmail.com>,  "Jens Axboe" <axboe@kernel.dk>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,  "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,  "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [RFC 00/10] implement alternative and much simpler id allocator
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
	<20161209140140.5e0a68e2e1cf9861335bdf3b@linux-foundation.org>
	<BY2PR21MB00364EEDE35645341BEC695CCB9C0@BY2PR21MB0036.namprd21.prod.outlook.com>
	<87inqj8vjo.fsf@rasmusvillemoes.dk>
	<BY2PR21MB003683A1186A143D4B4D1244CB9F0@BY2PR21MB0036.namprd21.prod.outlook.com>
Date: Fri, 23 Dec 2016 00:46:00 +0100
In-Reply-To: <BY2PR21MB003683A1186A143D4B4D1244CB9F0@BY2PR21MB0036.namprd21.prod.outlook.com>
	(Matthew Wilcox's message of "Sat, 17 Dec 2016 13:28:50 +0000")
Message-ID: <87pokjjznr.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

On Sat, Dec 17 2016, Matthew Wilcox <mawilcox@microsoft.com> wrote:

> From: Matthew Wilcox
>> From: Rasmus Villemoes [mailto:linux@rasmusvillemoes.dk]
>> > This sounds good. I think there may still be a lot of users that never
>> > allocate more than a handful of IDAs, making a 128 byte allocation still
>> > somewhat excessive. One thing I considered was (exactly as it's done for
>> > file descriptor tables) to embed a single word in the struct ida and
>> > use that initially; I haven't looked closely at newIDA, so I don't know
>> > how easy that would be or if its worth the complexity.
>> 
>> Heh, I was thinking about that too.  The radix tree supports "exceptional
>> entries" which have the bottom bit set.  On a 64-bit machine, we could use 62
>> of the bits in the radix tree root to store the ID bitmap.  I'm a little wary of the
>> potential complexity, but we should try it out.
>
> Test patch here: http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/idr-2016-12-16
> It passes the test suite ... which I actually had to adjust because it
> now succeeds in cases where it hadn't (allocating ID 0 without
> preallocating), and it will now fail in cases where it hadn't
> previously (assuming a single preallocation would be enough).  There
> shouldn't be any examples of that in the kernel proper; it was simply
> me being lazy when I wrote the test suite.

Nice work! A few random comments/questions:

- It does add some complexity, but I think a few comments would make it
  more digestable.

- Hm, maybe I'm confused, and I certainly don't understand how the whole
  radix tree works. But do you use every leaf node as an exceptional
  entry initially, to allocate the first 62 ids from that level? This
  code

	if ((bit + RADIX_TREE_EXCEPTIONAL_SHIFT) <
					BITS_PER_LONG) {
		bit += RADIX_TREE_EXCEPTIONAL_SHIFT;
		radix_tree_iter_replace(root, &iter, slot,
				(void *)((1UL << bit) |
				RADIX_TREE_EXCEPTIONAL_ENTRY));
		*id = new;
		return 0;
	}

   operates on bit, which is the offset from index*IDA_BITMAP_BITS, and
   it seems to create an exceptional entry somewhere down the tree
   (which may of course be the root).

   But we don't seem to allocate another bit from that exceptional entry
   ever unless it happened to sit at index 0; the code

	unsigned long tmp = (unsigned long)bitmap;
	if (start < BITS_PER_LONG) {
		unsigned tbit = find_next_zero_bit(&tmp,
					BITS_PER_LONG, start);
		if (tbit < BITS_PER_LONG) {
			tmp |= 1UL << tbit;
			rcu_assign_pointer(*slot, (void *)tmp);
			*id = new + tbit -
				RADIX_TREE_EXCEPTIONAL_SHIFT;
			return 0;
		}
	}

   is only used for small values of start (though it does seem to
   account for a non-zero value of new == iter.index * IDA_BITMAP_BITS).
   
- In the micro-optimization department, I think we should avoid
  find_next_zero_bit on a single word, and instead use __ffs. Something
  like (assuming we can use bit instead of start)

  if (bit + RADIX_TREE_EXCEPTIONAL_SHIFT < BITS_PER_LONG) {
    tmp = (~(unsigned long)bitmap) >> (bit + RADIX_TREE_EXCEPTIONAL_SHIFT);
    if (tmp) {
      tbit = __ffs(tmp) + bit + RADIX_TREE_EXCEPTIONAL_SHIFT;
      tmp = (unsigned long)bitmap | (1UL << tbit);
      rcu_assign_pointer(*slot, (void *)tmp);
      *id = new + tbit - RADIX_TREE_EXCEPTIONAL_SHIFT;
      return 0;
    }
  }

Rasmus
