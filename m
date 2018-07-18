Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3e0e3537-b37e-860f-fee3-4324c70a1deb@kernel.dk>
References: <20180713080602.31602-1-ming.lei@redhat.com> <20180713080602.31602-4-ming.lei@redhat.com>
 <20180717132411.GI13582@lst.de> <20180717153031.GA8973@ming.t460p>
 <07874eaab2d93728afe3f220cd0efa8f41d4955a.camel@wdc.com> <20180717153847.GB8973@ming.t460p>
 <3e0e3537-b37e-860f-fee3-4324c70a1deb@kernel.dk>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 18 Jul 2018 20:06:10 +0800
Message-ID: <CACVXFVNpyOENs=F1pkiwTVfD6H9essfbcc8_-zQOrG56Fs1w=Q@mail.gmail.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <Bart.VanAssche@wdc.com>,
	"hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hare@suse.de" <hare@suse.de>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 5:49 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 7/17/18 9:38 AM, Ming Lei wrote:
>> On Tue, Jul 17, 2018 at 03:34:35PM +0000, Bart Van Assche wrote:
>>> On Tue, 2018-07-17 at 23:30 +0800, Ming Lei wrote:
>>>> On Tue, Jul 17, 2018 at 03:24:11PM +0200, Christoph Hellwig wrote:
>>>>> On Fri, Jul 13, 2018 at 04:06:02PM +0800, Ming Lei wrote:
>>>>>> Usually SCSI supports runtime PM, so pass BLK_MQ_F_SUPPORT_RPM to blk-mq
>>>>>> core for enabling block runtime PM.
>>>>>
>>>>> I still think enabling this unconditionally for any SCSI device was
>>>>> a mistake, and it is even more so for blk-mq.
>>>>>
>>>>> Please only opt in for ufs, ATA first, adding others if wanted by
>>>>> maintainers.
>>>>
>>>> No, this way will cause regression because runtime PM works for
>>>> all sd/sr device actually, and it isn't related with scsi host.
>>>
>>> For which SCSI devices other than ufs and ATA do we need PM support?
>>
>> As I said, it is any sd/sr device, which can be put down by runtime PM
>> via START_STOP command if it isn't used for a while.
>
> Christoph is basically echoing my concerns. Why don't we just enable
> it on slower devices, similarly to what we do for adding
> randomness? Nobody wants to pay this overhead for faster devices,
> since most people won't care.

IMO the problem isn't related with slow or quick device, it is related with
the system, especially when it cares about power consumption, such as
mobile phone, or laptop or servers with lots of disks attached. And we know
it is often to see some fast disks shipped in laptop, such as NVMe, or other
SSD.

Thanks,
Ming Lei
