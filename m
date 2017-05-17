Return-Path: <minchan@kernel.org>
Date: Wed, 17 May 2017 17:32:12 +0900
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
Message-ID: <20170517083212.GA25750@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170516073616.GB767@jagdpanzerIV.localdomain>
List-ID: <linux-block@vger.kernel.org>

Hi Sergey,

On Tue, May 16, 2017 at 04:36:17PM +0900, Sergey Senozhatsky wrote:
> On (05/16/17 16:16), Minchan Kim wrote:
> > > but would this be correct? the data is not valid - we failed to store
> > > the valid one. but instead we assure application that read()/swapin/etc.,
> > > depending on the usage scenario, is successful (even though the data is
> > > not what application really expects to see), application tries to use the
> > > data from that page and probably crashes (dunno, for example page contained
> > > hash tables with pointers that are not valid anymore, etc. etc.).
> > > 
> > > I'm not optimistic about stale data reads; it basically will look like
> > > data corruption to the application.
> > 
> > Hmm, I don't understand what you say.
> > My point is zram_free_page should be done only if whoe write operation
> > is successful.
> > With you change, following situation can happens.
> > 
> > write block 4, 'all A' -> success
> > read  block 4, 'all A' verified -> Good
> > write block 4, 'all B' -> but failed with ENOMEM
> > read  block 4  expected 'all A' but 'all 0' -> Oops
> 
> yes. 'all A' in #4 can be incorrect. zram can be used as a block device
> with a file system, and pid that does write op not necessarily does read
> op later. it can be a completely different application. e.g. compilation,
> or anything else.
> 
> suppose PID A does
> 
> wr block 1       all a
> wr block 2       all a + 1
> wr block 3       all a + 2
> wr block 4       all a + 3
> 
> now PID A does
> 
> wr block 1       all m
> wr block 2       all m + 1
> wr block 3       all m + 2
> wr block 4       failed. block still has 'all a + 3'.
> exit
> 
> another application, PID C, reads in the file and tries to do
> something sane with it
> 
> rd block 1       all m
> rd block 2       all m + 1
> rd block 3       all m + 3
> rd block 4       all a + 3      << this is dangerous. we should return
>                                    error from read() here; not stale data.
> 
> 
> what we can return now is a `partially updated' data, with some new
> and some stale pages. this is quite unlikely to end up anywhere good.
> am I wrong?
> 
> why does `rd block 4' in your case causes Oops? as a worst case scenario?
> application does not expect page to be 'all A' at this point. pages are
> likely to belong to some mappings/files/etc., and there is likely a data
> dependency between them, dunno C++ objects that span across pages or
> JPEG images, etc. so returning "new data   new data   stale data" is a bit
> fishy.

I thought more about it and start to confuse. :/
So, let's Cc linux-block, fs peoples.

The question is that 

Is block device(esp, zram which is compressed ram block device) okay to
return garbage when ongoing overwrite IO fails?

O_DIRECT write 4 block "aaa.." -> success
read  4 block "aaa.." -> success
O_DIRECT write 4 block "bbb.." -> fail
read  4 block "000..' -> it is okay?

Hope to get an answer form experts. :)
