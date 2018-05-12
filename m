Return-Path: <linux-scsi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5bb14f3f91dcc1d8ff04de4f01904932@mail.gmail.com>
References: <3f49cb1f5a04fd61a73fe9f033868278@mail.gmail.com>
 <20180502094713.GA31961@ming.t460p> <0efdcd2c4aa241f5d9d6acad915ee4fe@mail.gmail.com>
 <20180502103403.GB31961@ming.t460p> <5bb14f3f91dcc1d8ff04de4f01904932@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 13 May 2018 07:38:09 +0800
Message-ID: <CACVXFVML_UcnJoyWKAJ3vTQdojyZRz6mYwNp_LQhYXU-VgfYYg@mail.gmail.com>
Subject: Re: Performance drop due to "blk-mq-sched: improve sequential I/O performance"
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, May 2, 2018 at 6:39 PM, Kashyap Desai
<kashyap.desai@broadcom.com> wrote:
>> > I have created internal code changes based on below RFC and using irq
>> > poll CPU lockup issue is resolved.
>> > https://www.spinics.net/lists/linux-scsi/msg116668.html
>>
>> Could we use the 1:1 mapping and not apply out-of-tree irq poll in the
>> following test? So that we can keep at same page easily.
>
> Above RFC changes are not used in my testing.  I used same inbox driver
> from 4.17-rc.

Sorry for being late since I have to handle other things recently.

Please test the following host_tagset patches which is against recent
linus tree(v4.17-rc4+)

https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v5

And please post the perf trace without and with this patchset if
possible.

Thanks,
Ming Lei
