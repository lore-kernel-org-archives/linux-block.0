Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750843AbdAXSp4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 13:45:56 -0500
Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Jens Axboe <axboe@fb.com>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
 <1c9beccc-c7cc-dd3e-703d-e91d8110ec86@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9cf5637f-fa15-23b4-e64e-4b27e0b6bcbe@suse.de>
Date: Tue, 24 Jan 2017 19:45:52 +0100
MIME-Version: 1.0
In-Reply-To: <1c9beccc-c7cc-dd3e-703d-e91d8110ec86@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/24/2017 05:03 PM, Jens Axboe wrote:
> On 01/24/2017 08:54 AM, Hannes Reinecke wrote:
>> Hi Jens,
>>
>> I'm trying to debug a queue stall with your blk-mq-sched branch; with my
>> latest mpt3sas patches fio stops basically directly after starting a
>> sequential read :-(
>>
>> I've debugged things and came up with the attached patch; we need to
>> restart waiters with blk_mq_tag_idle() after completing a tag.
>> We're already calling blk_mq_tag_busy() when fetching a tag, so I think
>> calling blk_mq_tag_idle() is required when retiring a tag.
>
> I'll take a look at this. It sounds like all your grief is related to
> shared tag maps, which I don't have anything that uses here. I'll see
> if we are leaking it, you should be able to check that by reading the
> 'active' file in the sysfs directory.
>
Ah. That'll explain it.

Basically _all_ my HBAs I'm testing with have shared tag maps :-(

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
