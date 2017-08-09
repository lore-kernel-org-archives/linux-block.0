Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36746 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbdHICcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2017 22:32:54 -0400
Received: by mail-ua0-f194.google.com with SMTP id w45so3260894uac.3
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2017 19:32:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170809001143.GH4072@vader.DHCP.thefacebook.com>
References: <20170805065705.12989-1-ming.lei@redhat.com> <20170805065705.12989-2-ming.lei@redhat.com>
 <20170809001143.GH4072@vader.DHCP.thefacebook.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 9 Aug 2017 10:32:52 +0800
Message-ID: <CACVXFVMx4vmzXeeVki40TgtX5Zpeqd-bFh5MaLP1iUEixoZA+A@mail.gmail.com>
Subject: Re: [PATCH V2 01/20] blk-mq-sched: fix scheduler bad performance
To: Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 9, 2017 at 8:11 AM, Omar Sandoval <osandov@osandov.com> wrote:
> On Sat, Aug 05, 2017 at 02:56:46PM +0800, Ming Lei wrote:
>> When hw queue is busy, we shouldn't take requests from
>> scheduler queue any more, otherwise IO merge will be
>> difficult to do.
>>
>> This patch fixes the awful IO performance on some
>> SCSI devices(lpfc, qla2xxx, ...) when mq-deadline/kyber
>> is used by not taking requests if hw queue is busy.
>
> Jens added this behavior in 64765a75ef25 ("blk-mq-sched: ask scheduler
> for work, if we failed dispatching leftovers"). That change was a big
> performance improvement, but we didn't figure out why. We'll need to dig
> up whatever test Jens was doing to make sure it doesn't regress.

Not found info about Jen's test case on this commit from google.

Maybe Jens could provide some input about your test case?

In theory, if hw queue is busy and requests are left in ->dispatch,
we should not have continued to dequeue requests from sw/scheduler queue
any more. Otherwise, IO merge can be hurt much. At least on SCSI devices,
this improved much on sequential I/O,  at least 3X of sequential
read is increased on lpfc with this patch, in case of mq-deadline.

Or are there other special cases in which we still need
to push requests hard into a busy hardware?

And this patch won't have an effect on devices in which queue busy
is seldom triggered, such as NVMe.


Thanks,
Ming Lei
