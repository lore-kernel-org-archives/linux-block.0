Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49831 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750878AbdJBGTr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Oct 2017 02:19:47 -0400
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
 <20170928155315.GK8463@localhost.localdomain>
 <mqdk20ghta5.fsf@linux-x5ow.site>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c6fe82f1-558f-50ee-e053-d55f4ec54801@suse.de>
Date: Mon, 2 Oct 2017 08:19:30 +0200
MIME-Version: 1.0
In-Reply-To: <mqdk20ghta5.fsf@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/30/2017 09:37 PM, Johannes Thumshirn wrote:
> 
> [+Cc Hannes ]
> 
> Keith Busch <keith.busch@intel.com> writes:
> 
>> On Mon, Sep 25, 2017 at 03:40:30PM +0200, Christoph Hellwig wrote:
>>> The new block devices nodes for multipath access will show up as
>>>
>>> 	/dev/nvm-subXnZ
>>
>> Just thinking ahead ... Once this goes in, someone will want to boot their
>> OS from a multipath target. It was a pain getting installers to recognize
>> /dev/nvmeXnY as an install destination. I'm not sure if installers have
>> gotten any better in the last 5 years about recognizing new block names.
> 
> We discussed (Hannes, Christoph and me) this as well offline this week
> and it should eithr be possible with some udev magic (fake a
> /dev/mapper/WWID symlink) or a shim device-mapper target that prevents
> dm-mpath from attaching to the underlying block devices and creates a
> real /dev/mapper/WWID device node (Christoph especially dislikes
> this). None of them are pretty, but probably all we can do so far.
> 
There are several issues here.
The one is the device-naming issue; I'm heavily against the nvm-subX
thing. Why don't we just name them

/dev/nvmsXnZ

which nicely aligns with the existing /dev/nvmeXnZ naming scheme.

The other issue is how to enable multipath booting. Painful experience
tells us we _need_ to be able to figure out if a device is multipath
capable without having to invoke any external tools, ie the device
itself need to carry some marker 'this device is multipath capable'.
In NVMe speak this means we have to export the CMIC bit from the
Identify controller data structure to somewhere in sysfs.

Then it's easy to setup a udev rule which sets 'SYSTEMD_READY=0'
whenever this setting is detected, and the entire udev mechanism will
leave it alone.

Once this is done we have the paths nicely separated in udev, and then
setting up the symlinks pointing to the correct device is trivial.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
