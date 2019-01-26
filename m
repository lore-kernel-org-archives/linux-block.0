Return-Path: <SRS0=xZ4d=QC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8CAC282C7
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 10:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E538A217D7
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 10:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfAZKJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:09:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:58800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfAZKJY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Jan 2019 05:09:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73C7CAB87;
        Sat, 26 Jan 2019 10:09:22 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: disk_events: introduce event flags
To:     Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <20190118213207.2309-1-mwilck@suse.com>
 <20190118213207.2309-2-mwilck@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <be93f1f5-cb79-04b2-5fc1-140678245197@suse.de>
Date:   Sat, 26 Jan 2019 11:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190118213207.2309-2-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/19 10:32 PM, Martin Wilck wrote:
> Currently, an empty disk->events field tells the block layer not to forward
> media change events to user space. This was done in commit 7c88a168da80 ("block:
> don't propagate unlisted DISK_EVENTs to userland") in order to avoid events
> from "fringe" drivers to be forwarded to user space. By doing so, the block
> layer lost the information which events were supported by a particular
> block device, and most importantly, whether or not a given device supports
> media change events at all.
> 
> Prepare for not interpreting the "events" field this way in the future any
> more. This is done by adding two flag bits that can be set to have the
> device treated like one that has the "events" field set to a non-zero value
> before. This applies only to the sd and sr drivers, which are changed to
> set the new flags.
> 
> The new flags are DISK_EVENT_FLAG_POLL to enforce polling of the device for
> synchronous events, and DISK_EVENT_FLAG_UEVENT to tell the blocklayer to
> generate udev events from kernel events. They can easily be fit in the int
> reserved for event bits.
> 
> This patch doesn't change behavior.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   block/genhd.c         | 22 ++++++++++++++++------
>   drivers/scsi/sd.c     |  3 ++-
>   drivers/scsi/sr.c     |  3 ++-
>   include/linux/genhd.h |  7 +++++++
>   4 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 1dd8fd6..bcd16f6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1631,7 +1631,8 @@ static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
>   	 */
>   	if (ev->poll_msecs >= 0)
>   		intv_msecs = ev->poll_msecs;
> -	else if (disk->events & ~disk->async_events)
> +	else if (disk->events & DISK_EVENT_FLAG_POLL
> +		 && disk->events & ~disk->async_events)
>   		intv_msecs = disk_events_dfl_poll_msecs;
>   
>   	return msecs_to_jiffies(intv_msecs);
Hmm. That is an ... odd condition.
Clearly it's pointless to have the event bit set in the ->events mask if 
it's already part of the ->async_events mask.
But shouldn't we better _prevent_ this from happening, ie refuse to set
DISK_EVENT_FLAG_POLL in events if it's already in ->async_events?
Then the above check would be simplified.

Cheers,

Hannes
