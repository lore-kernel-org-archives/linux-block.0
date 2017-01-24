Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57679 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbdAXStt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 13:49:49 -0500
Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Jens Axboe <axboe@fb.com>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
 <762cb508-1de0-93e2-5643-3fe946428eb5@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8abc2430-e1fd-bece-ad52-c6d1d482c1e0@suse.de>
Date: Tue, 24 Jan 2017 19:49:48 +0100
MIME-Version: 1.0
In-Reply-To: <762cb508-1de0-93e2-5643-3fe946428eb5@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/24/2017 05:09 PM, Jens Axboe wrote:
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
> The patch isn't correct, the whole point of the un-idling is that it
> ISN'T happening for every request completion. Otherwise you throw
> away scalability. So a queue will go into active mode on the first
> request, and idle when it's been idle for a bit. The active count
> is used to divide up the tags.
>
> So I'm assuming we're missing a queue run somewhere when we fail
> getting a driver tag. The latter should only happen if the target
> has IO in flight already, and the restart marking should take care
> of it. Obviously there's a case where that is not true, since you
> are seeing stalls.
>
But what is the point in the 'blk_mq_tag_busy()' thingie then?
When will it be reset?
The only instances I've seen is that it'll be getting reset during 
resize and teardown ... hence my patch.

>> However, even with the attached patch I'm seeing some queue stalls;
>> looks like they're related to the 'stonewall' statement in fio.
>
> I think you are heading down the wrong path. Your patch will cause
> the symptoms to be a bit different, but you'll still run into cases
> where we fail giving out the tag and then stall.
>
Hehe.
How did you know that?

That's indeed what I'm seeing.

Oh well, back to the drawing board...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
