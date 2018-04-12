Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 11:11:21 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Message-ID: <20180412181121.GA1911913@devbig577.frc2.facebook.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
 <20180412135149.GX793541@devbig577.frc2.facebook.com>
 <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
 <20180412153748.GB793541@devbig577.frc2.facebook.com>
 <beafd7bc4f2fdb7e672ad97e57ff4f82464182da.camel@wdc.com>
 <20180412161247.GD793541@devbig577.frc2.facebook.com>
 <f98af37ea6755119177c26fbb73b0071ddef90b8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f98af37ea6755119177c26fbb73b0071ddef90b8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Apr 12, 2018 at 04:29:09PM +0000, Bart Van Assche wrote:
> Any code that submits a bio or request needs blk_queue_enter() /
> blk_queue_exit() anyway. Please have a look at the following commit - you will
> see that that commit reduces the number of blk_queue_enter() / blk_queue_exit()
> calls in the hot path:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-linus&id=37f9579f4c31a6d698dbf3016d7bf132f9288d30

So, this can work, but it's still pretty fragile.

* Lock switching is fragile and we really should get rid of it.  This
  is very likely to come back and bite us.

* Right now, blk_queue_enter/exit() doesn't have any annotations.
  IOW, there's no way for paths which need enter locked to actually
  assert that.  If we're gonna protect more things with queue
  enter/exit, it gotta be annotated.

Thanks.

-- 
tejun
