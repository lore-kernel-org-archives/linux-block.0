Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 10 Apr 2018 07:33:56 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180410143356.GN3126663@devbig577.frc2.facebook.com>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <20180410142028.GM3126663@devbig577.frc2.facebook.com>
 <82f1fa6aba4bd5c7684eac6b375776b43b66f8c3.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <82f1fa6aba4bd5c7684eac6b375776b43b66f8c3.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Apr 10, 2018 at 02:30:26PM +0000, Bart Van Assche wrote:
> > Switching to another model might be better but let's please do that
> > with the right rationales.  A good portion of this seems to be built
> > on misunderstandings.
> 
> Which misunderstandings? I'm not aware of any misunderstandings at my side.
> Additionally, tests with two different block drivers (NVMeOF initiator and
> the SRP initiator driver) have shown that the current blk-mq timeout
> implementation with or without your two patches applied result in subtle and
> hard to debug crashes and/or memory corruption. That is not the case for the

I must have missed that part.  Which tests were they?

> patch at the start of this thread. The latest report of a crash I ran into
> myself and that is fixed by the patch at the start of this thread is
> available here: https://www.spinics.net/lists/linux-rdma/msg63240.html.
> 
> Please also keep in mind that if this patch would be accepted that that does
> not prevent this patch to be replaced with an RCU-based solution later on.
> If anyone comes up any time with a reliably working RCU-based solution I
> will be happy to accept a revert of this patch and I will help reviewing that
> RCU-based solution.

Oh, switching is fine but let's get in sync first.  Who have the repro
cases and what were tested?

Thanks.

-- 
tejun
