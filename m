Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
To: Christoph Hellwig <hch@infradead.org>
References: <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p> <20170420045408.GB2235@infradead.org>
 <20170420083041.GA1637@ming.t460p> <20170426104842.GB28062@ming.t460p>
 <38bc590d-8ab4-5c88-d7e7-10cd2ec7d900@kernel.dk>
 <da795dd0-bba1-3a7a-5b24-696d51bcbc2e@kernel.dk>
 <20170427031445.GB4841@ming.t460p>
 <9990a1b5-6c4c-7308-8f38-22bb67c08ff1@kernel.dk>
 <20170427152050.GA733@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>, Jozef Mikovic <jmikovic@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7ac2368a-f51b-d4de-6db8-2f20025411f0@kernel.dk>
Date: Thu, 27 Apr 2017 09:46:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170427152050.GA733@infradead.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/27/2017 09:20 AM, Christoph Hellwig wrote:
> On Thu, Apr 27, 2017 at 06:49:43AM -0700, Jens Axboe wrote:
>> Thanks Ming, I've added that patch and your patch to initialize the cmd
>> at runtime.
> 
> I really think this is the wrong fix, and doing these sort of band-aids
> just will lead to further problems done the road.

Ming's patch is just fine, mine is a bit more of a hack. I'll throw some
cycles at fixing up mtip32xx to not have a hard wired internal tag since
it doesn't need to, and then we can drop my one-liner again.

-- 
Jens Axboe
