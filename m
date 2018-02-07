Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2018 09:35:31 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180207173531.GC695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
 <20180207170612.GB695913@devbig577.frc2.facebook.com>
 <1518024428.2870.35.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518024428.2870.35.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Wed, Feb 07, 2018 at 05:27:10PM +0000, Bart Van Assche wrote:
> Even with the above change I think that there is still a race between the
> code that handles timer resets and the completion handler. Anyway, the test

Can you elaborate the scenario a bit further?  If you're referring to
lost completions, we've always had that and while we can try to close
that hole too, I don't think it's a critical issue.

> with which I triggered these races is as follows:
> - Start from what will become kernel v4.16-rc1 and apply the patch that adds
>   SRP over RoCE support to the ib_srpt driver. See also the "[PATCH v2 00/14]
>   IB/srpt: Add RDMA/CM support" patch series
>   (https://www.spinics.net/lists/linux-rdma/msg59589.html).
> - Apply my patch series that fixes a race between the SCSI error handler and
>   SCSI transport recovery.
> - Apply my patch series that improves the stability of the SCSI target core
>   (LIO).
> - Build and install that kernel.
> - Clone the following repository: https://github.com/bvanassche/srp-test.
> - Run the following test:
>   while true; do srp-test/run_tests -c -t 02-mq; done
> - While the test is running, check whether or not something weird happens.
>   Sometimes I see that scsi_times_out() crashes. Sometimes I see while running
>   this test that a soft lockup is reported inside blk_mq_do_dispatch_ctx().
> 
> If you want I can share the tree on github that I use myself for my tests.

Heh, that's quite a bit.  I'll take up on that git tree later but for
now I'd really appreciate if you can test the patch.

Thank you very much.

-- 
tejun
