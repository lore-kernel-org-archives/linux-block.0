Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60512 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbcGXHKH (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sun, 24 Jul 2016 03:10:07 -0400
Subject: Re: [PATCH 4/6] block: Add 'zoned' sysfs queue attribute
To: Bart Van Assche <bart.vanassche@sandisk.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
 <1468934439-93579-5-git-send-email-hare@suse.de>
 <yq1wpkd9zbc.fsf@sermon.lab.mkp.net>
 <f39f2a46-75ab-a770-025f-6807c2f14413@suse.de>
 <1dc7f9d7-5a91-b160-7031-8d69ede5567b@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Damien Le Moal <damien.lemoal@hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <13b63331-f920-0904-b8f7-c3a2ea8270d6@suse.de>
Date: Sun, 24 Jul 2016 09:10:04 +0200
MIME-Version: 1.0
In-Reply-To: <1dc7f9d7-5a91-b160-7031-8d69ede5567b@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/24/2016 12:13 AM, Bart Van Assche wrote:
> On 07/23/16 05:43, Hannes Reinecke wrote:
>> On 07/22/2016 10:45 PM, Martin K. Petersen wrote:
>>>>>>>> "Hannes" == Hannes Reinecke <hare@suse.de> writes:
>>>
>>> Hannes> Add a sysfs queue attribute 'zoned' to display the zone layout
>>> Hannes> for zoned devices.
>>>
>>> Not quite one value per file :(
>>>
>> Yes.
>> But I wanted to display the zone layout in a concise way allowing
>> user-space programs to determine the zone layout without having to
>> issue a 'REPORT ZONES' command themselves.
>> I found it slightly pointless to add one sysfs entry per zone,
>> and at the same time a simple 'zone_size' attribute wouldn't cover all
>> possibilities.
>>
>> However, as SMR drives seem to stabilise around having a fixed zone size
>> (with a possible exemption of the last zone to cover left-overs)
>> I'd be fine a replace this with a single 'zone_size' attribute which
>> could be set to eg '-1' for drives which indeed would implement variable
>> zone sizes.
> 
> It's not that hard to convert the information exported by
> queue_zoned_show() from a single sysfs attribute into one directory per
> zone. Doing so would make it much easier for scripts to parse that
> information and would also avoid that the zone information has to be
> truncated because not all of it fits into a single page.
> 
But this is precisely what I've tried to avoid.
Creating one file or directory per zone would mean we'll end up with
rough 20k files/directories.
Which I found rather excessive.

Of course, it that is not a concern that I can easily convert it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
