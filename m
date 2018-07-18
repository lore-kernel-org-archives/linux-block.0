Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <63b1f80c-00bf-3244-3ba0-337aba1b1c82@suse.de>
References: <20180713080602.31602-1-ming.lei@redhat.com> <20180713080602.31602-4-ming.lei@redhat.com>
 <20180717132411.GI13582@lst.de> <20180717153031.GA8973@ming.t460p>
 <07874eaab2d93728afe3f220cd0efa8f41d4955a.camel@wdc.com> <20180717153847.GB8973@ming.t460p>
 <3e0e3537-b37e-860f-fee3-4324c70a1deb@kernel.dk> <CACVXFVNpyOENs=F1pkiwTVfD6H9essfbcc8_-zQOrG56Fs1w=Q@mail.gmail.com>
 <63b1f80c-00bf-3244-3ba0-337aba1b1c82@suse.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 18 Jul 2018 21:05:26 +0800
Message-ID: <CACVXFVPP-jeYLEzYVsXCuG6-YfAfwA4gYjXKUdyMdvTcmtMbdg@mail.gmail.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 8:43 PM, Hannes Reinecke <hare@suse.de> wrote:
> On 07/18/2018 02:06 PM, Ming Lei wrote:
>> On Wed, Jul 18, 2018 at 5:49 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On 7/17/18 9:38 AM, Ming Lei wrote:
>>>> On Tue, Jul 17, 2018 at 03:34:35PM +0000, Bart Van Assche wrote:
>>>>> On Tue, 2018-07-17 at 23:30 +0800, Ming Lei wrote:
>>>>>> On Tue, Jul 17, 2018 at 03:24:11PM +0200, Christoph Hellwig wrote:
>>>>>>> On Fri, Jul 13, 2018 at 04:06:02PM +0800, Ming Lei wrote:
>>>>>>>> Usually SCSI supports runtime PM, so pass BLK_MQ_F_SUPPORT_RPM to blk-mq
>>>>>>>> core for enabling block runtime PM.
>>>>>>>
>>>>>>> I still think enabling this unconditionally for any SCSI device was
>>>>>>> a mistake, and it is even more so for blk-mq.
>>>>>>>
>>>>>>> Please only opt in for ufs, ATA first, adding others if wanted by
>>>>>>> maintainers.
>>>>>>
>>>>>> No, this way will cause regression because runtime PM works for
>>>>>> all sd/sr device actually, and it isn't related with scsi host.
>>>>>
>>>>> For which SCSI devices other than ufs and ATA do we need PM support?
>>>>
>>>> As I said, it is any sd/sr device, which can be put down by runtime PM
>>>> via START_STOP command if it isn't used for a while.
>>>
>>> Christoph is basically echoing my concerns. Why don't we just enable
>>> it on slower devices, similarly to what we do for adding
>>> randomness? Nobody wants to pay this overhead for faster devices,
>>> since most people won't care.
>>
>> IMO the problem isn't related with slow or quick device, it is related with
>> the system, especially when it cares about power consumption, such as
>> mobile phone, or laptop or servers with lots of disks attached. And we know
>> it is often to see some fast disks shipped in laptop, such as NVMe, or other
>> SSD.
>>
> But those typically have dedicated (transport/driver) mechanism to put
> the device to sleep, _and_ START STOP UNIT will be emulated for those
> devices anyway.
> I'd rather advocate to move runtime PM into the individual
> subsystems/drivers, and _not_ abuse START STOP UNIT here.

Firstly START_STOP isn't a abuse for PM purpose, please see
the description in t10.org:

"The START STOP UNIT command (see 5.17) allows an application client to
control the power condition of a logical unit. This method includes specifying
that the logical unit transition to a power condition."

Secondly the runtime PM on LUN level isn't contradictory with subsystem/driver's
runtime PM. The two can co-exits, for examples, USB storage host, ufshcd, ...


Thanks,
Ming Lei
