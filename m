Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 14:31:46 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180411213146.GS793541@devbig577.frc2.facebook.com>
References: <20180410152553.GC22340@ming.t460p>
 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
 <20180410153812.GA3219@ming.t460p>
 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
 <20180410213323.GC793541@devbig577.frc2.facebook.com>
 <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
 <20180410215456.GD793541@devbig577.frc2.facebook.com>
 <7a586854-33a5-fe3b-6d94-24d305696126@grimberg.me>
 <0da96ded-7bfc-e6a8-428c-1ce1e3db0378@mellanox.com>
 <20180411170733.GM793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411170733.GM793541@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

Hey, again.

On Wed, Apr 11, 2018 at 10:07:33AM -0700, tj@kernel.org wrote:
> Hello, Israel.
> 
> On Wed, Apr 11, 2018 at 07:16:14PM +0300, Israel Rukshin wrote:
> > >Just noticed this one, this looks interesting to me as well. Israel,
> > >can you run your test with this patch?
> > 
> > Yes, I just did and it looks good.
> 
> Awesome.

Just to be sure, you tested the combined patch and saw the XXX debug
messages, right?

Thanks.

-- 
tejun
