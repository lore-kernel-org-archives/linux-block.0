Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 13 Apr 2018 08:18:42 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Message-ID: <20180413151842.GC1911913@devbig577.frc2.facebook.com>
References: <20180412135149.GX793541@devbig577.frc2.facebook.com>
 <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
 <20180412153748.GB793541@devbig577.frc2.facebook.com>
 <beafd7bc4f2fdb7e672ad97e57ff4f82464182da.camel@wdc.com>
 <20180412161247.GD793541@devbig577.frc2.facebook.com>
 <f98af37ea6755119177c26fbb73b0071ddef90b8.camel@wdc.com>
 <20180412181121.GA1911913@devbig577.frc2.facebook.com>
 <22e0bba319877407a0abccf292ef0b22454db04d.camel@wdc.com>
 <20180412190915.GB1911913@devbig577.frc2.facebook.com>
 <ee8defd68976a607c03ee6c0ad4e14217f328db3.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee8defd68976a607c03ee6c0ad4e14217f328db3.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Thu, Apr 12, 2018 at 10:40:52PM +0000, Bart Van Assche wrote:
> Is something like the patch below perhaps what you had in mind?

Yeah, exactly.  It'd be really great to have the lockdep asserts add
to the right places.

Thanks.

-- 
tejun
