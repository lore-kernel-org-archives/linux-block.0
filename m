Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbdHHNlf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Aug 2017 09:41:35 -0400
Date: Tue, 8 Aug 2017 21:41:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH V2 00/20] blk-mq-sched: improve SCSI-MQ performance
Message-ID: <20170808134110.GA22763@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <df64b15d-a443-553c-a3c6-d834320648fd@redhat.com>
 <CAFfF4qv3W6D-j8BSSZbwPLqhd_mmwk8CZQe7dSqud8cMMd2yPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFfF4qv3W6D-j8BSSZbwPLqhd_mmwk8CZQe7dSqud8cMMd2yPg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Laurence and Guys, 

On Mon, Aug 07, 2017 at 06:06:11PM -0400, Laurence Oberman wrote:
> On Mon, Aug 7, 2017 at 8:48 AM, Laurence Oberman <loberman@redhat.com>
> wrote:
> Hello
> 
> I need to retract my Tested-by:
> 
> While its valid that the patches do not introduce performance regressions,
> they seem to cause a hard lockup when the [mq-deadline] scheduler is
> enabled so I am not confident with a passing result here.
> 
> This is specific to large buffered I/O writes (4MB) At least that is my
> current test.
> 
> I did not wait long enough for the issue to show when I first sent the pass
> (Tested-by) message because I know my test platform so well I thought I had
> given it enough time to validate the patches for performance regressions.
> 
> I dont know if the failing clone in blk_get_request() is a direct a
> catalyst for the hard lockup but what I do know is with the stock upstream
> 4.13-RC3 I only see them when I am set to [none] and stock upstream never
> seems to see the hard lockup.
> 
> With [mq-deadline] enabled on stock I dont see them at all and it behaves.
> 
> Now with Ming's patches if we enable [mq-deadline] we DO see the clone
> failures and the hard lockup so we have opposit behaviour with the
> scheduler choice and we have the hard lockup.
> 
> On Ming's kernel with [none] we are well behaved and that was my original
> focus, testing on [none] and hence my Tested-by: pass.
> 
> So more investigation is needed here.

Laurence, as we talked in IRC, the hard lock issue you saw isn't
related with this patchset, because the issue can be reproduced on
both v4.13-rc3 and RHEL7. The only trick is to run your hammer
write script concurrently in 16 jobs, then it just takes several
minutes to trigger, no matter with using mq none or mq-deadline
scheduler.

Given it is easy to reproduce, I believe it shouldn't be very
difficult to investigate and root cause.

I will report the issue on another thread, and attach the
script for reproduction.

So let's focus on this patchset([PATCH V2 00/20] blk-mq-sched: improve
SCSI-MQ performance) in this thread.

Thanks again for your test!

Thanks,
Ming
