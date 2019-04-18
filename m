Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F900C10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E13206B6
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 15:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbfDRPCM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:02:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388548AbfDRPCM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 11:02:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3E7DADEC;
        Thu, 18 Apr 2019 15:02:10 +0000 (UTC)
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        neilb@suse.com
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <28f8343f-3159-9ca2-f98f-a37ecce31fd5@suse.de>
Date:   Thu, 18 Apr 2019 17:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418143429.GA19175@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/19 4:34 PM, Ming Lei wrote:
> Hi Hannes,
> 
> On Thu, Apr 18, 2019 at 04:06:32PM +0200, Hannes Reinecke wrote:
>> When calling blk_queue_split() it will be using the per-queue
>> bioset to allocate the split bio from. However, blk_steal_bios()
>> might move the bio to another queue, _and_ the original queue
>> might be removed completely (nvme is especially prone to do so).
> 
> Could you explain a bit how the original queue is removed in case
> that blk_steal_bios() is involved?
> 
It's not blk_steal_bios() which removes the queue. What happens is:

- bio returns with error
- blk_steal_bios() moves bio over to a different queue
- nvme_reset_ctrl() is called
- Error detection finds that the original device is gone
- nvme calls nvme_remove_ns()
- nvme_remove_ns() removes the original request queue alongside the 
bio_set from which the bvecs have been allocated from.
- 'stolen' bio is completed
- 'stolen' bio calls bio_endio()
- bio_endio() calls mempool_free() on the bvecs, referencing the mempool 
from the original queue
- crash

>> That leaves the bvecs of the split bio with a missing / destroyed
>> mempool, and a really fun crash in bio_endio().
> 
> per-queue bioset is used originally for avoiding deadlock, are you
> sure the static bioset is safe?
> 
If that turns out be be an issue we could be having a per 'ns_head' 
bio_set for allocating the split bio from.
But the main point is that we cannot use the bioset from the request 
queue as the queue (and the bioset) might be removed during the lifetime 
of the bio.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
