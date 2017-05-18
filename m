Return-Path: <minchan@kernel.org>
Date: Thu, 18 May 2017 13:53:46 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	kernel-team <kernel-team@lge.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@infradead.org,
	viro@zeniv.linux.org.uk, axboe@kernel.dk, jlayton@redhat.com,
	tytso@mit.edu
Subject: Re: [PATCH 2/2] zram: do not count duplicated pages as compressed
Message-ID: <20170518045346.GB25750@bbox>
References: <20170516073616.GB767@jagdpanzerIV.localdomain>
 <20170517083212.GA25750@bbox>
 <20170517091423.GA14662@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517091423.GA14662@jagdpanzerIV.localdomain>
List-ID: <linux-block@vger.kernel.org>

Hi Sergey,

On Wed, May 17, 2017 at 06:14:23PM +0900, Sergey Senozhatsky wrote:
> Hello Minchan,
> 
> On (05/17/17 17:32), Minchan Kim wrote:
> [..]
> > > what we can return now is a `partially updated' data, with some new
> > > and some stale pages. this is quite unlikely to end up anywhere good.
> > > am I wrong?
> > > 
> > > why does `rd block 4' in your case causes Oops? as a worst case scenario?
> > > application does not expect page to be 'all A' at this point. pages are
> > > likely to belong to some mappings/files/etc., and there is likely a data
> > > dependency between them, dunno C++ objects that span across pages or
> > > JPEG images, etc. so returning "new data   new data   stale data" is a bit
> > > fishy.
> > 
> > I thought more about it and start to confuse. :/
> 
> sorry, I'm not sure I see what's the source of your confusion :)
> 
> my point is - we should not let READ succeed if we know that WRITE
> failed. assume JPEG image example,

I don't think we shoul do it. I will write down my thought below. :)

> 
> 
> over-write block 1 aaa->xxx OK
> over-write block 2 bbb->yyy OK
> over-write block 3 ccc->zzz error
> 
> reading that JPEG file
> 
> read block 1 xxx OK
> read block 2 yyy OK
> read block 3 ccc OK   << we should not return OK here. because
>                          "xxxyyyccc" is not the correct JPEG file
>                          anyway.
> 
> do you agree that telling application that read() succeeded and at
> the same returning corrupted "xxxyyyccc" instead of "xxxyyyzzz" is
> not correct?

I don't agree. I *think* block device is a just dumb device so
zram doesn't need to know about any objects from the upper layer.
What zram should consider is basically read/write success or fail of
IO unit(maybe, BIO).

So if we assume each step from above example is bio unit, I think
it's no problem returns "xxxyyyccc".

What I meant "started confused" was about atomicity, not above
thing.

I think it's okay to return ccc instead of zzz but is it okay
zram to return "000", not "ccc" and "zzz"?
My conclusion is that it's okay now after discussion from one
of my FS friends.

Let's think about it.

FS requests write "aaa" to block 4 and fails by somethings
(H/W failure, S/W failure like ENOMEM). The interface to catch
the failure is the function registered by bio_endio which is
normally handles by AS_EIO by mappint_set_error as well as
PG_error flags of the page. In this case, FS assumes the block
4 can have stale data, not 'zzz' and 'ccc' because the device
was broken in the middle of write some data to a block if
the block device doesn't support atomic write(I guess it's
more popular) so it would be safe to consider the block
has garbage now rather than old value, new value.
(I hope I explain my thought well :/)

Having said that, I think everyone likes block device supports
atomicity(ie, old or new). so I am reluctant to change the
behavior for simple refactoring.

Thanks.
