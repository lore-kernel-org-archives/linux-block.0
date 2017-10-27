Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:53342 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdJ0Rzy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 13:55:54 -0400
Received: by mail-io0-f173.google.com with SMTP id 189so14399576iow.10
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2017 10:55:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171027053834.GA12858@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com> <1509079996.3244.3.camel@wdc.com>
 <20171027053834.GA12858@ming.t460p>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Fri, 27 Oct 2017 19:55:33 +0200
Message-ID: <CAJrWOzD0LoFhKhFf-BrCtWipVEteT3uUqUc30_qr8E8wNeESGg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming,

On Fri, Oct 27, 2017 at 7:38 AM, Ming Lei <ming.lei@redhat.com> wrote:
> Hello Bart,
>
> On Fri, Oct 27, 2017 at 04:53:18AM +0000, Bart Van Assche wrote:
>> On Fri, 2017-10-27 at 12:43 +0800, Ming Lei wrote:
>> > The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
>> > by itself, and not necessary to waste CPU to do the expensive RESTART.
>> > And Roman Pen reported that this RESTART cuts half of IOPS in his case.
>> >
>> > The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
>> > and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.
>>
>> Hello Ming,
>>
>> There are more block drivers than the SCSI core that share tags. If the
>
> Could you share us what the other in-tree driver which share tags is?
>
> If there are really more, and when all can share similar RESTART mechanism, I
> think that is the time for considering the common RESTART.
>
>> restart mechanism is removed from the blk-mq core, does that mean that all
>> block drivers that share tags will have to follow the example of the SCSI
>> core and implement a restart mechanism themselves? As far as I know there
>
> If there are such drivers, there should have been their own restart mechanism
> which works for long time before blk-mq comes, and more importantly each driver
> has much more knowledge than generic block layer to handle the restart,
> such as SCSI's restart, that means driver's implementation may be more efficient.

Personally I would be happier if block layer would do restarts for me.  My eyes
are bleeding when I see chunks of my own code which do this juggling with hctx,
enqueuing or dequeuing from a percpu lists, etc inside IBNBD driver.

> Also the RESTART for TAG-SHARED may never function as expected wrt. SCSI.

E.g. new BLK_MQ_F_NO_RESTARTS flag can help to disable restarts when they
are not needed.

> And more importantly the block's RESTART for TAG-SHARED has caused big performance
> issue for people.

That's just a bug in code, not a in issue with restarts, which can be fixed
if we put hctx which are needed to be restarted in percpu lists and avoid
long loops and contentions.

--
Roman
