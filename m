Return-Path: <BATV+d57f7b82a529b7e9747b+4995+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 27 Apr 2017 08:20:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
	Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170427152050.GA733@infradead.org>
References: <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p>
 <20170420045408.GB2235@infradead.org>
 <20170420083041.GA1637@ming.t460p>
 <20170426104842.GB28062@ming.t460p>
 <38bc590d-8ab4-5c88-d7e7-10cd2ec7d900@kernel.dk>
 <da795dd0-bba1-3a7a-5b24-696d51bcbc2e@kernel.dk>
 <20170427031445.GB4841@ming.t460p>
 <9990a1b5-6c4c-7308-8f38-22bb67c08ff1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9990a1b5-6c4c-7308-8f38-22bb67c08ff1@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 27, 2017 at 06:49:43AM -0700, Jens Axboe wrote:
> Thanks Ming, I've added that patch and your patch to initialize the cmd
> at runtime.

I really think this is the wrong fix, and doing these sort of band-aids
just will lead to further problems done the road.
