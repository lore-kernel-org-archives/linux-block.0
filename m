Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755892AbdAKHtO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 02:49:14 -0500
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <m@bjorling.me>, Theodore Ts'o <tytso@mit.edu>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <20170104165745.7uuwl6phm6g6kouu@thunk.org>
 <1b457b77-34d8-ab82-ae1d-279e86053af9@wdc.com>
 <20170110042442.ixxxi4yhj5gu7byh@thunk.org>
 <ddeefd67-afb6-72a4-f59b-6fe623fbfbc3@bjorling.me>
 <03f7ac72-c0a6-3101-7f07-e8322dcd32f5@wdc.com>
Cc: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a545cf3e-26b1-9b35-5d5f-1f6180dabb1c@suse.de>
Date: Wed, 11 Jan 2017 08:49:10 +0100
MIME-Version: 1.0
In-Reply-To: <03f7ac72-c0a6-3101-7f07-e8322dcd32f5@wdc.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/11/2017 05:07 AM, Damien Le Moal wrote:
> 
> Matias,
> 
> On 1/10/17 22:06, Matias Bjorling wrote:
>> On 01/10/2017 05:24 AM, Theodore Ts'o wrote:
>>> This may be an area where if we can create the right framework, and
>>> fund some research work, we might be able to get some researchers and
>>> their graduate students interested in doing some work in figuring out
>>> what sort of divisions of responsibilities and hints back and forth
>>> between the storage device and host have the most benefit.
>>>
>>
>> That is a good idea. There is a couple of papers at FAST with
>> Open-Channel SSDs this year.  They look into the interface and various
>> ways to reduce latency fluctuations.
>>
>> One thing I've heard a couple of times is the feature to move the GC
>> read/write process into the firmware. Enabling the host to offload GC
>> data movement, while the keeping the host in control. Would this be
>> beneficial for SMR?
> 
> Host-aware SMR drives already have GC internally implemented (for cases
> when the host does not write sequentially). Host-managed drives do not.
> As for moving an application specific GC code into the device, well,
> code injection in the storage device is not for tomorrow, and likely not
> ever.
> 
> There are however other clever ways to reduce GC related host overhead
> with basic commands. For SCSI, these may be WRITE SCATTERED, EXTENDED
> COPY, and some others can greatly improve overhead over a simple
> read+write loop. A better approach to GC offload may not be a "GC"
> command, but something more generic for moving around LBAs internally
> within the device. That is, if existing commands are not satisfactory.
> 
Logical head depop rears its head again...

But yes, I think it's more sensible to have I/O functions which help GC
(like UNMAP) instead of influencing the GC itself.

Anyway. Given the length of this thread I guess this is a worthy topic
for LSF.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
