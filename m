Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Dec 2017 16:08:05 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCHSET v2] blk-mq: reimplement timeout handling
Message-ID: <20171221000805.GC1084507@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <1513813261.2603.36.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513813261.2603.36.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 20, 2017 at 11:41:02PM +0000, Bart Van Assche wrote:
> On Tue, 2017-12-12 at 11:01 -0800, Tejun Heo wrote:
> > Currently, blk-mq timeout path synchronizes against the usual
> > issue/completion path using a complex scheme involving atomic
> > bitflags, REQ_ATOM_*, memory barriers and subtle memory coherence
> > rules.  Unfortunatley, it contains quite a few holes.
> 
> Hello Tejun,
> 
> An attempt to run SCSI I/O with this patch series applied resulted in
> the following:

Can you please try the v3?  There were a couple bugs that I missed
while testing earlier versions.

 http://lkml.kernel.org/r/20171216120726.517153-1-tj@kernel.org

Thanks.

-- 
tejun
