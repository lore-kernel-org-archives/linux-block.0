Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2018 09:54:51 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180208175451.GS695913@devbig577.frc2.facebook.com>
References: <1518047297.2870.80.camel@wdc.com>
 <1518052193.2870.90.camel@wdc.com>
 <20180208153940.GM695913@devbig577.frc2.facebook.com>
 <1518107501.3611.19.camel@wdc.com>
 <20180208170010.GP695913@devbig577.frc2.facebook.com>
 <1518109843.3611.25.camel@wdc.com>
 <20180208171934.GQ695913@devbig577.frc2.facebook.com>
 <1518111465.3611.36.camel@wdc.com>
 <20180208174017.GR695913@devbig577.frc2.facebook.com>
 <1518112111.3611.42.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518112111.3611.42.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 08, 2018 at 05:48:32PM +0000, Bart Van Assche wrote:
> On Thu, 2018-02-08 at 09:40 -0800, tj@kernel.org wrote:
> > Heh, sorry about not being clear.  What I'm trying to say is that
> > scmd->device != NULL && device->host == NULL.  Or was this what you
> > were saying all along?
> 
> What I agree with is that the request pointer (req argument) is stored in %rdi
> and that mov 0x1b0(%rdi),%rax loads scmd->device into %rax. Since RIP ==
> scsi_times_out+0x17, since the instruction at that address tries to dereference
> %rax and since the register dump shows that %rax == NULL I think that means that
> scmd->device == NULL.

Ah, I was completely confused about which one had to be NULL.  You're
absolutely right.  Let's continue earlier in the thread.

Thanks.

-- 
tejun
