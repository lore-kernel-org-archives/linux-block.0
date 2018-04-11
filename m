Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:16:43 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"martin@lichtvoll.de" <martin@lichtvoll.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180411141643.GF793541@devbig577.frc2.facebook.com>
References: <20180410143007.GB22340@ming.t460p>
 <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
 <20180410152553.GC22340@ming.t460p>
 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
 <20180410153812.GA3219@ming.t460p>
 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
 <20180410213323.GC793541@devbig577.frc2.facebook.com>
 <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
 <20180410215456.GD793541@devbig577.frc2.facebook.com>
 <ac0d5904dbcd55e190df318a66a9d7d51c56f3ae.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ac0d5904dbcd55e190df318a66a9d7d51c56f3ae.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Wed, Apr 11, 2018 at 12:50:51PM +0000, Bart Van Assche wrote:
> Thank you for having shared this patch. It looks interesting to me. What I
> know about the blk-mq timeout handling is as follows:
> * Nobody who has reviewed the blk-mq timeout handling code with this patch
>   applied has reported any shortcomings for that code.
> * However, several people have reported kernel crashes that disappear when
>   the blk-mq timeout code is reworked. I'm referring to "nvme-rdma corrupts
>   memory upon timeout"
>   (http://lists.infradead.org/pipermail/linux-nvme/2018-February/015848.html)
>   and also to a "RIP: scsi_times_out+0x17" crash during boot
>   (https://bugzilla.kernel.org/show_bug.cgi?id=199077).
> 
> So we have the choice between two approaches:
> (1) apply the patch from your previous e-mail and root-cause and fix the
>     crashes referred to above.
> (2) apply a patch that makes the crashes reported against v4.16 disappear and
>     remove the atomic instructions introduced by such a patch at a later time.
> 
> Since crashes have been reported for kernel v4.16 I think we should follow
> approach (2). That will remove the time pressure from root-causing and fixing
> the crashes reported for the NVMeOF initiator and SCSI initiator drivers.

So, it really bothers me how blind we're going about this.  It isn't
an insurmountable emergency that we have to adopt whatever solution
which passed a couple tests this minute.  We can debug and root cause
this properly and pick the right solution.  We even have two most
likely causes already analysed and patches proposed, one of them
months ago.  If we wanna change the handover model, let's do that
because the new one is better, not because of vague fear.

Thanks.

-- 
tejun
