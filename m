Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AEFC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 11:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5929221707
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 11:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfD3L51 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:57:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729043AbfD3LsC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 07:48:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D038ADF7;
        Tue, 30 Apr 2019 11:48:01 +0000 (UTC)
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@gmail.com>, neilb@suse.com,
        linux-nvme@lists.infradead.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
 <20190424221422.GA21351@ming.t460p> <20190425004106.GA22683@ming.t460p>
 <c6a54cea-f2ce-3344-efb1-ba8f20bf9509@suse.de>
 <20190425153627.GA9825@ming.t460p>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b884020e-ad18-199f-8377-89e3e42ae84c@suse.de>
Date:   Tue, 30 Apr 2019 13:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425153627.GA9825@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/19 5:36 PM, Ming Lei wrote:
> On Thu, Apr 25, 2019 at 04:32:42PM +0200, Hannes Reinecke wrote:
>> On 4/25/19 2:41 AM, Ming Lei wrote:
>>> On Thu, Apr 25, 2019 at 06:14:22AM +0800, Ming Lei wrote:
>>>> On Wed, Apr 24, 2019 at 10:20:46AM -0700, Sagi Grimberg wrote:
>>>>>
>>>>>> per-queue bioset is used originally for avoiding deadlock, are you
>>>>>> sure the static bioset is safe?
>>>>>
>>>>> Can you explain this? I didn't find any indication of that in the change
>>>>> log history...
>>>>>
>>>>> Originally introduced by Kent:
>>>>
>>>> bio split can be run from stacking drivers, for example, MD over NVMe,
>>>> if the global reserved mempool is consumed by MD bio splitting, then
>>>> no any progress can be made when splitting on bio submitted to NVMe.
>>>>
>>>> Kent may have more details...
>>>
>>> I guess it might be fine to use one shared global bio_set for all
>>> lowest underlying queues, could be all queues except for loop, dm, md
>>> , drbd, bcache, ...
>>>
>> But wasn't the overall idea of stacking drivers that we propagate the queue
>> limits up to the uppermost drivers, so that we have to do a split only at
>> the upper layers?
> 
> For example, LVM over RAID, the limits of LVM queue is figured out and fixed
> during creating LVM. However, new device may be added to the RAID. Then the
> underlying queue's limit may not be propagated to LVM's queue's limit.
> 
> And we did discuss the topic of 'block: dm: restack queue_limits'
> before, looks not see any progress made.
> 
> Also loop doesn't consider stack limits at all.
> 
>> Furthermore, it's not every bio which needs to be split, only those which
>> straddle some device limitations.
>> The only ones not being able to propagate the queue limits is MD, and that
>> is already using a private bio_set here.
> 
> If DM and the lowest queue share one same bio_set(mem_pool), it isn't
> enough for MD to use private bio_set.
> 
Ah, right. I've reviewed the patches implementing the per-queue biosets, 
and indeed we'll need to use them.
But meanwhile I've found another way of circumventing this issue, so 
this patch can be dropped.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
