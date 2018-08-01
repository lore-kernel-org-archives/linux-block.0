Return-Path: <hare@suse.de>
Subject: Re: [PATCH 4/6] aoe: use device_add_disk_with_groups()
To: Ed Cashin <ed.cashin@acm.org>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, hare@suse.com
References: <20180730071227.22887-1-hare@suse.de>
 <20180730071227.22887-5-hare@suse.de>
 <CADvA-d=ESWUgJNpsSxdOhLp1amt3B9Aqy+GZ-i=t5zkLVn6RWg@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <03060ac8-57ce-9b11-cc7a-287264ac87b5@suse.de>
Date: Wed, 1 Aug 2018 08:57:12 +0200
MIME-Version: 1.0
In-Reply-To: <CADvA-d=ESWUgJNpsSxdOhLp1amt3B9Aqy+GZ-i=t5zkLVn6RWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/01/2018 03:00 AM, Ed Cashin wrote:
> On Mon, Jul 30, 2018 at 3:12 AM Hannes Reinecke <hare@suse.de
> <mailto:hare@suse.de>> wrote:
> 
>     Use device_add_disk_with_groups() to avoid a race condition with
>     udev during startup.
> 
> 
> I love the idea of getting rid of the race, but I am having trouble
> seeing what happened to the cleanup we had via sysfs_remove_group.
> You're storing a pointer to groups off the device, but I don't see it
> getting
> used for cleanup later in this patch set.  Are you patching linux-next?
> 
And that's the beauty of this patch: you don't need to free/unlink the
groups yourself.
Unlinking is done in the driver core via
device_del()->device_remove_attrs()->device_remove_groups().

So no separate patch needed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
