Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdLHB2W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Dec 2017 20:28:22 -0500
Date: Fri, 8 Dec 2017 09:28:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Alban Browaeys <alban.browaeys@gmail.com>,
        Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        SERENA ZIVIANI <169364@studenti.unimore.it>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: blk-mq + bfq:  udevd hang on usb2 storages
Message-ID: <20171208012803.GC21488@ming.t460p>
References: <1512147869.8698.21.camel@gmail.com>
 <20171204105720.GA6884@ming.t460p>
 <D03704C9-BF8E-49E1-B552-90393BC9DE4A@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D03704C9-BF8E-49E1-B552-90393BC9DE4A@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Paolo,

On Thu, Dec 07, 2017 at 07:04:54PM +0100, Paolo Valente wrote:
> 
> > Il giorno 04 dic 2017, alle ore 11:57, Ming Lei <ming.lei@redhat.com> ha scritto:
> > 
> > On Fri, Dec 01, 2017 at 06:04:29PM +0100, Alban Browaeys wrote:
> >> I initially reported as https://bugzilla.kernel.org/show_bug.cgi?id=198
> >> 023 .
> >> 
> >> I have now bisected this issue to commit a6a252e6491443c1c1 "blk-mq-
> >> sched: decide how to handle flush rq via RQF_FLUSH_SEQ".
> >> 
> >> This is with an USB stick Sandisk Cruzer (USB Version:  2.10) I
> >> regressed with.
> >> systemctl restart systemd-udevd restores sanity.
> >> 
> >> PS: With an USB3 Lexar (USB Version:  3.00) I get more severe an issue
> >> (not bisected) where I find no way out of reboot. My report to bugzilla
> >> has logs when I was swapping between the these keys. The logs attached
> >> there mixes what looks like two different behaviors.
> > 
> > Hi Paolo,
> > 
> > From both Alban's trace and my trace, looks this issue is in BFQ,
> > since request can't be retrieved via e->type->ops.mq.dispatch_request()
> > in blk_mq_do_dispatch_sched() after it is inserted into BFQ's queue.
> > 
> >        https://bugzilla.kernel.org/show_bug.cgi?id=198023#c4
> >        https://marc.info/?l=linux-block&m=151214241518562&w=2
> > 
> > BTW, I have tried to reproduce the issue with scsi_debug, but not succeed,
> > and it can't be reproduced with other schedulers(mq-deadline, none) too.
> > 
> > So could you take a look?
> > 
> 
> Hi Ming, all,
> sorry for the delay, but we preferred to reply directly after finding
> the cause of the problem.  And the cause is that gdisk makes an I/O

Not a problem, :-)

In the previous mail, I just want to share you our findings.

> request that is dispatched to the drive, but apparently never
> completed (as Serena, in CC discovered).  Or, at least, the execution
> of completed_request in bfq is never triggered.

I can understand the case a bit, and the following info may be helpful
for you:

1) USB's queue depth is one

2) the only pending request is completed, and scsi_finish_command() is called

3) inside scsi_finish_command(), scsi_device_unbusy() is called at the
beginning, once it is done, blk_mq_get_dispatch_budget() in blk_mq_do_dispatch_sched()
returns true, then we can start to try to dispatch request

4) e->type->ops.mq.dispatch_request() is called, but the request in 2)
isn't completed yet, completed_request in bfq isn't be run yet because
it is called later from scsi_end_request()(<-scsi_io_completion()<-scsi_finish_command())

Then no request can be dispatched any more, and hang happens, but
finally completed_request should be run later.

> 
> In more detail: disk is a process for which bfq performs device idling
> (for good reasons), and, for one such process, bfq does not switch to
> serving another process until the last pending request of the process
> is completed, after which device idling is started, to wait for the
> next request of the process.  So, if such a last request is never
> completed, bfq remains forever waiting for such an event, and then
> refuses forever to deliver requests of other queues.
> 
> As for why bfq_completed_request is not executed for the above,

It should be run.

> dispatched request, the reason is either that the bfq_finish_request
> hook is not invoked at all, or that it is invoked, but the request
> does not have the RQF_STARTED flag set.  Discovering which event

The flag of RQF_STARTED is set only if there is one request found by
__bfq_dispatch_request(), which can never happen in this case, since
we observed no request is found by __bfq_dispatch_request() even though
it has been inserted to BFQ queue already.

> occurs is our next step.
> 
> We'll let you know.

Thanks,
Ming
