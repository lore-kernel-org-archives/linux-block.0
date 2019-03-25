Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0936DC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D485C206BA
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfCYHeT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:34:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbfCYHeT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:34:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5F75AD76;
        Mon, 25 Mar 2019 07:34:17 +0000 (UTC)
Subject: Re: [PATCH RESEND v2 2/5] block: disk_events: introduce event flags
To:     Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20190322224353.11088-1-mwilck@suse.com>
 <20190322224353.11088-3-mwilck@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f9f3499e-0c74-8861-bcd4-5db3dafff04a@suse.de>
Date:   Mon, 25 Mar 2019 08:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322224353.11088-3-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 11:43 PM, Martin Wilck wrote:
> Currently, an empty disk->events field tells the block layer not to forward
> media change events to user space. This was done in
> commit 7c88a168da80 ("block: don't propagate unlisted DISK_EVENTs to userland")
> in order to avoid events from "fringe" drivers to be forwarded to user
> space. By doing so, the block layer lost the information which events were
> supported by a particular block device, and most importantly, whether or
> not a given device supports media change events at all.
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
>   block/genhd.c         | 15 ++++++++++-----
>   drivers/scsi/sd.c     |  3 ++-
>   drivers/scsi/sr.c     |  3 ++-
>   include/linux/genhd.h |  7 +++++++
>   4 files changed, 21 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
