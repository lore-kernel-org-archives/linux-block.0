Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Wed, 17 May 2017 18:14:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	kernel-team <kernel-team@lge.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@infradead.org,
	viro@zeniv.linux.org.uk, axboe@kernel.dk, jlayton@redhat.com,
	tytso@mit.edu
Subject: Re: [PATCH 2/2] zram: do not count duplicated pages as compressed
Message-ID: <20170517091423.GA14662@jagdpanzerIV.localdomain>
References: <20170516073616.GB767@jagdpanzerIV.localdomain>
 <20170517083212.GA25750@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517083212.GA25750@bbox>
List-ID: <linux-block@vger.kernel.org>

Hello Minchan,

On (05/17/17 17:32), Minchan Kim wrote:
[..]
> > what we can return now is a `partially updated' data, with some new
> > and some stale pages. this is quite unlikely to end up anywhere good.
> > am I wrong?
> > 
> > why does `rd block 4' in your case causes Oops? as a worst case scenario?
> > application does not expect page to be 'all A' at this point. pages are
> > likely to belong to some mappings/files/etc., and there is likely a data
> > dependency between them, dunno C++ objects that span across pages or
> > JPEG images, etc. so returning "new data   new data   stale data" is a bit
> > fishy.
> 
> I thought more about it and start to confuse. :/

sorry, I'm not sure I see what's the source of your confusion :)

my point is - we should not let READ succeed if we know that WRITE
failed. assume JPEG image example,


over-write block 1 aaa->xxx OK
over-write block 2 bbb->yyy OK
over-write block 3 ccc->zzz error

reading that JPEG file

read block 1 xxx OK
read block 2 yyy OK
read block 3 ccc OK   << we should not return OK here. because
                         "xxxyyyccc" is not the correct JPEG file
                         anyway.

do you agree that telling application that read() succeeded and at
the same returning corrupted "xxxyyyccc" instead of "xxxyyyzzz" is
not correct?



so how about this,

- if we fail to compress page (S/W or H/W compressor error, depending
  on particular setup) let's store it uncompressed (page_size-d zspool
  object).

?

this should do the trick. at least we will have correct data:
	xxx  - compressed
	yyy  - compressed
	zzz  - uncompressed, because compressing back-end returned an error.

thoughts?

	-ss
