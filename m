Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A07EC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F0F619CD
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhCWQQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:16:03 -0400
Received: from verein.lst.de ([213.95.11.211]:33105 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233030AbhCWQPw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:15:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D2ED68BFE; Tue, 23 Mar 2021 17:15:47 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:15:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323161544.GA13402@lst.de>
References: <20210322073726.788347-1-hch@lst.de> <20210322073726.788347-3-hch@lst.de> <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me> <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me> <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com> <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 12:36:40AM -0700, Sagi Grimberg wrote:
>> The process:
>> 1.nvme_ns_head_submit_bio call srcu_read_lock(&head->srcu).
>> 2.nvme_ns_head_submit_bio will add the bio to current->bio_list instead of 
>> waiting for the frozen queue.
>
> Nothing guarantees that you have a bio_list active at any point in time,
> in fact for a workload that submits one by one you will always drain
> that list directly in the submission...

It should always be active when ->submit_bio is called.

>
>> 3.nvme_ns_head_submit_bio call srcu_read_unlock(&head->srcu, srcu_idx).
>> So nvme_ns_head_submit_bio do not hold head->srcu long when the queue is 
>> frozen, can avoid deadlock.
>>
>> Sagi, suggest trying this patch.
>
> The above reproduces with the patch applied on upstream nvme code.

Weird.  I don't think the deadlock in your original report should
happen due to this.  Can you take a look at the callstacks in the
reproduced deadlock?  Either we're missing something obvious or it is a
a somewhat different deadlock.
