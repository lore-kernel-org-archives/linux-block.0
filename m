Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
To: Alan Stern <stern@rowland.harvard.edu>,
 Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <tom.leiming@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hare@suse.de" <hare@suse.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
References: <Pine.LNX.4.44L0.1807181010390.29549-100000@netrider.rowland.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <651898d4-f0ab-4bba-dacb-b5e32400fd3a@kernel.dk>
Date: Wed, 18 Jul 2018 08:50:39 -0600
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1807181010390.29549-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/18/18 8:12 AM, Alan Stern wrote:
> On Wed, 18 Jul 2018, Johannes Thumshirn wrote:
> 
>> On Wed, Jul 18, 2018 at 08:06:10PM +0800, Ming Lei wrote:
>>> IMO the problem isn't related with slow or quick device, it is related with
>>> the system, especially when it cares about power consumption, such as
>>> mobile phone, or laptop or servers with lots of disks attached. And we know
>>> it is often to see some fast disks shipped in laptop, such as NVMe, or other
>>> SSD.
>>
>> Yes but you're only taking locally attached devices into account.
>> This is very likely harmful on sd devices attached to a
>> SRP/FC/iSCSI/SAS Target in a SAN environment. These can be really fast
>> and people investing this money are likely to not like additional
>> performance penalties. 
> 
> As one extra reminder...  People who care about extreme performance can 
> perfectly well disable CONFIG_PM in their kernels.  That should remove 
> any overhead due to runtime PM.

This is a kernel fallacy that needs to be shot down. Most folks just run
what the distro provides, so no, they can't just turn off various kernel
options. This is NEVER an argument that carries any weight at all for
me. If we have the implementation, it needs to be fast enough to be on
by default. No "well just turn off the option if you think the overhead
is too high". Never.

That's exactly why I didn't like the first implementation that Ming did.

-- 
Jens Axboe
