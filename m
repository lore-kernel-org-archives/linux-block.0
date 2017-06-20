Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <20170619185805.GC32047@infradead.org>
 <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
 <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
 <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
 <20170620085739.GB31386@infradead.org>
 <6f1be22c-b172-3645-f0ab-8124188756df@kernel.dk>
 <20170620124355.GA6199@infradead.org>
 <6793e5b9-b324-727a-6227-69b5fe233bc4@kernel.dk>
 <20170620124738.GA16917@infradead.org>
 <6b1897c4-400b-faee-38d1-d677c054debc@kernel.dk>
 <20170620125620.GA26153@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b99179f7-b6ec-1537-c749-8c11306e64e9@kernel.dk>
Date: Tue, 20 Jun 2017 07:00:57 -0600
MIME-Version: 1.0
In-Reply-To: <20170620125620.GA26153@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 06:56 AM, Christoph Hellwig wrote:
> On Tue, Jun 20, 2017 at 06:51:34AM -0600, Jens Axboe wrote:
>> That sounds fragile... Is it really worth it to avoid stealing three
>> bits in the inode? Do we have buffer_heads attached everywhere, that
>> sounds surprising to me.
> 
> I'm not concerned about saving a few bits - we'll use those elsewhere
> anyway.  I'm concerned about settings on one file descriptor having
> an effect on other fds that doesn't look intended.  It's not the
> end of the world, as multiple writers to the same file should
> better be aware of each other, but the semantics of setting these
> on a per-inode level still stink.

For O_DIRECT writes, the file level hints work perfectly fine. For
buffered writes, we need some way to defer retrieving this hint to
when the flush happens. Seems very sad and dated to rely on
storing these in buffer_heads, which we've been trying to kill
for more than a decade.

The per inode hint isn't perfect for multiple buffered writers in
a single file. While I think it'd be great to have something bullet
proof there, I also don't think it's a troublesome use cases for
streams.


-- 
Jens Axboe
