Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbdAMMKJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 07:10:09 -0500
Subject: Re: [PATCHSET v6] blk-mq scheduling framework
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <e1f8f6c5-5347-d8d8-57a2-0367d828dd22@suse.de>
 <5850a4ad-74a1-8d30-e865-fbd35679e84f@suse.de>
Cc: osandov@osandov.com, bart.vanassche@sandisk.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cab72b22-d672-3c68-ec4a-6e3cb65f93ab@suse.de>
Date: Fri, 13 Jan 2017 13:10:07 +0100
MIME-Version: 1.0
In-Reply-To: <5850a4ad-74a1-8d30-e865-fbd35679e84f@suse.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/13/2017 12:04 PM, Hannes Reinecke wrote:
> On 01/13/2017 09:15 AM, Hannes Reinecke wrote:
>> On 01/11/2017 10:39 PM, Jens Axboe wrote:
>>> Another year, another posting of this patchset. The previous posting
>>> was here:
>>>
>>> https://www.spinics.net/lists/kernel/msg2406106.html
>>>
>>> (yes, I've skipped v5, it was fixes on top of v4, not the rework).
>>>
>>> I've reworked bits of this to get rid of the shadow requests, thanks
>>> to Bart for the inspiration. The missing piece, for me, was the fact
>>> that we have the tags->rqs[] indirection array already. I've done this
>>> somewhat differently, though, by having the internal scheduler tag
>>> map be allocated/torn down when an IO scheduler is attached or
>>> detached. This also means that when we run without a scheduler, we
>>> don't have to do double tag allocations, it'll work like before.
>>>
>>> The patchset applies on top of 4.10-rc3, or can be pulled here:
>>>
>>> git://git.kernel.dk/linux-block blk-mq-sched.6
>>>
>> Well ... something's wrong here on my machine:
>>
[ .. ]

Turns out that selecting CONFIG_DEFAULT_MQ_DEADLINE is the culprit;
switching to CONFIG_DEFAULT_MQ_NONE and selecting mq-deadline after
booting manually makes the problem go away.

So there is a race condition during device init and switching the I/O
scheduler.

But the results from using mq-deadline are promising; the performance
drop I've seen on older hardware seems to be resolved:

mq iosched:
 seq read : io=13383MB, bw=228349KB/s, iops=57087
 rand read : io=12876MB, bw=219709KB/s, iops=54927
 seq write: io=14532MB, bw=247987KB/s, iops=61996
 rand write: io=13779MB, bw=235127KB/s, iops=58781
mq default:
 seq read : io=13056MB, bw=222588KB/s, iops=55647
 rand read : io=12908MB, bw=220069KB/s, iops=55017
 seq write: io=13986MB, bw=238444KB/s, iops=59611
 rand write: io=13733MB, bw=234128KB/s, iops=58532
sq default:
 seq read : io=10240MB, bw=194787KB/s, iops=48696
 rand read : io=10240MB, bw=191374KB/s, iops=47843
 seq write: io=10240MB, bw=245333KB/s, iops=61333
 rand write: io=10240MB, bw=228239KB/s, iops=57059

measured on mpt2sas with SSD devices.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
