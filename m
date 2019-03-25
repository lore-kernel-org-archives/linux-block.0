Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F020AC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF35A2087E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 08:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCYIZX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:25:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729934AbfCYIZX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 04:25:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F57AAC17;
        Mon, 25 Mar 2019 08:25:21 +0000 (UTC)
Subject: Re: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, jthumshirn@suse.de, hch@lst.de,
        bvanassche@acm.org
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
 <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
 <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>
Date:   Mon, 25 Mar 2019 09:25:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 8:37 AM, jianchao.wang wrote:
> Hi Hannes
> 
> On 3/25/19 3:18 PM, Hannes Reinecke wrote:
>> On 3/25/19 6:38 AM, Jianchao Wang wrote:
>>> As nobody uses blk_mq_tagset_busy_iter, remove it.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> ---
>>>    block/blk-mq-tag.c     | 95 --------------------------------------------------
>>>    include/linux/blk-mq.h |  2 --
>>>    2 files changed, 97 deletions(-)
>>>
>> Please, don't.
>>
>> I'm currently implementing reserved commands for SCSI and reworking the SCSI error handling where I rely on
>> this interface quite heavily.
> 
> 
> blk_mq_tagset_busy_iter could access some stale requests which maybe freed due to io scheduler switching,
> request_queue cleanup (shared tagset)
> when there is someone submits io and gets driver tag. When io scheduler attached, even quiesce
> request_queue won't work.
> 
> If this patchset is accepted, blk_mq_tagset_busy_iter could be replaced with blk_mq_queue_inflight_tag_iter
> which needs to be invoked by every request_queue that shares the tagset.
> 
The point is, at that time I do _not_ have a request queue to work with.

Most SCSI drivers have a host-wide shared tagset, which is used by all 
request queues on that host.
Iterating over the shared tagset is far more efficient than to traverse 
over all devices and the attached request queues.

If I had to traverse all request queues I would need to add additional 
locking to ensure this traversal is race-free, making it a really 
cumbersome interface to use.

Plus the tagset iter is understood to be used only in cases where I/O is 
stopped from the upper layers (ie no new I/O will be submitted).
So here we only need to protect against I/O being completed, which is 
not what this patchset is about.

So my objection still stands: Please, don't.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
