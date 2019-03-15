Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB54C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB68218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfCOQtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:49:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729192AbfCOQtZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:49:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF151AE6E;
        Fri, 15 Mar 2019 16:49:23 +0000 (UTC)
Subject: Re: [PATCH 7/8] nvme: use blk_mq_queue_tag_busy_iter
To:     James Smart <james.smart@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        josef@toxicpanda.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com,
        jthumshirn@suse.de, hch@lst.de, bvanassche@acm.org
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
 <62de99e8-0d8d-910a-bfdc-649f734b152c@gmail.com>
 <f284663c-ad13-65ea-5ce0-9b305ca91d3c@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5def1025-a48b-f2a4-d58c-d37135177b0f@suse.de>
Date:   Fri, 15 Mar 2019 17:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f284663c-ad13-65ea-5ce0-9b305ca91d3c@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/19 5:39 PM, James Smart wrote:
> 
> 
> On 3/15/2019 9:33 AM, James Smart wrote:
>> On 3/15/2019 1:57 AM, Jianchao Wang wrote:
>>> blk_mq_tagset_busy_iter is not safe that it could get stale request
>>> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here. A new helper
>>> interface nvme_iterate_inflight_rqs is introduced to iterate
>>> all of the ns under a ctrl.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> ---
>>>   drivers/nvme/host/core.c   | 12 ++++++++++++
>>>   drivers/nvme/host/fc.c     | 12 ++++++------
>>>   drivers/nvme/host/nvme.h   |  2 ++
>>>   drivers/nvme/host/pci.c    |  5 +++--
>>>   drivers/nvme/host/rdma.c   |  6 +++---
>>>   drivers/nvme/host/tcp.c    |  5 +++--
>>>   drivers/nvme/target/loop.c |  6 +++---
>>>   7 files changed, 32 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 6a9dd68..5760fad 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3816,6 +3816,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>>>   +void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
>>> +        busy_iter_fn *fn, void *data)
>>> +{
>>> +    struct nvme_ns *ns;
>>> +
>>> +    down_read(&ctrl->namespaces_rwsem);
>>> +    list_for_each_entry(ns, &ctrl->namespaces, list)
>>> +        blk_mq_queue_tag_busy_iter(ns->queue, fn, data, true);
>>> +    up_read(&ctrl->namespaces_rwsem);
>>> +}
>>> +EXPORT_SYMBOL_GPL(nvme_iterate_inflight_rqs);
>>
>> Hmm... so this aborts ios for namespaces. How about ios that aren't 
>> for a namespace but rather for the controller itself.  For example, 
>> anything on the admin queue ?   Rather critical for those ios be 
>> terminated as well.
> NVM - didn't look at which tag set.  but it does highlight - doesn't 
> cover anything issued by core/transport on the io queues.
> 
Actually, I would consider that an error.
_All_ commands on io queues (internal or block-layer generated) whould 
be tracked sbitmap and hence the tag iterator.
That's what we have the 'private' tags for, and why the iter callback 
has this ominous 'bool' argument...

Cheers,

Hannes
