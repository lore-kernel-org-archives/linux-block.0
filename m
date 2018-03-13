Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:56822 "EHLO othala.uls.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751975AbeCMJbD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 05:31:03 -0400
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "pieterk@uls.co.za" <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
 <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
 <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
 <1520737695.8740.4.camel@wdc.com>
 <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
 <1520744455.8740.9.camel@wdc.com>
From: Jaco Kroon <jaco@uls.co.za>
Message-ID: <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
Date: Tue, 13 Mar 2018 11:30:48 +0200
MIME-Version: 1.0
In-Reply-To: <1520744455.8740.9.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

On 11/03/2018 07:00, Bart Van Assche wrote:
> On Sun, 2018-03-11 at 06:33 +0200, Jaco Kroon wrote:
>> crowsnest ~ # find /sys -name sdm
>> /sys/kernel/debug/block/sdm
>> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/host0/port-0:0/expander-0:0/port-0:0:0/expander-0:1/port-0:1:0/end_device-0:1:0/target0:0:13/0:0:13:0/block/sdm
>> /sys/class/block/sdm
>> /sys/block/sdm
>>
>>> lspci
>> crowsnest ~ # lspci
>> [ ... ]
>> 01:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic
>> SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
>> [ ... ]
> Hi Jaco,
>
> Recently a bug fix for the mq-deadline scheduler was posted but I don't
> think that that patch will change the behavior on your setup since you are
> not using ZBC disks. See also "mq-deadline: Make sure to always unlock
> zones" (https://marc.info/?l=linux-block&m=151983933714492).
>From that link:

In case of a failed write request (all retries failed) and when using
libata, the SCSI error handler calls scsi_finish_command(). In the
case of blk-mq this means that scsi_mq_done() does not get called,
that blk_mq_complete_request() does not get called and also that the
mq-deadline .completed_request() method is not called. This results in
the target zone of the failed write request being left in a locked
state, preventing that any new write requests are issued to the same
zone.

Why do you say that this won't make a difference? To me it sounds like
it could very well relate? You're talking about "ZBC" disks. I'm going
to assume that the ZBC is Zoned Block ??? and reading up on it I get
really confused.

Either way, the source version onto hich the patch applies is not
4.14.13 code (the patch references lines 756 and the source in 4.14.13
only has 679 lines of code.  I also can't find any kind of locking that
I can imagine that can cause a problem unless there is problems inside
__dd_dispatch_request, blk_mq_sched_try_merge or dd_insert_request (none
of which contains any loops that I can see at a quick glance, at least
down to elv_merge, from there it gets more complicated).

>
> Did I see correctly that /dev/sdm is behind a MPT SAS controller? You may
> want to contact the authors of this driver and Cc the linux-scsi mailing
> list. Sorry but I'm not familiar with the mpt3sas driver myself.
You did see correctly, all drives are behind the MPT SAS.  If there is
in fact a problem with the driver (or the controller itself for that
matter) it would explain things.  It would also explain why we don't see
this problem on other hosts.

I'll contact them as well.

Kind Regards,
Jaco
