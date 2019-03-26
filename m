Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C3DC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4E2082F
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 17:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfCZR7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:59:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731828AbfCZR7m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 13:59:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02574AF45;
        Tue, 26 Mar 2019 17:59:40 +0000 (UTC)
Subject: Re: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or
 dying queues
To:     James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block@vger.kernel.org
References: <20190326120712.41657-1-hare@suse.de>
 <82fca840-bce0-938e-abc5-1faff5c255d0@acm.org>
 <a95b94e1-ee6f-a534-a1f0-d55d6b8bffe0@suse.de>
 <1553613164.118779.50.camel@acm.org>
 <761a7684-862d-d3bf-a75d-aab06fd43e29@suse.com>
 <f6096aa5-0311-6d7f-697a-bb5771ca5fc7@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e16814f3-1fc0-ef46-760e-cc23d951030f@suse.de>
Date:   Tue, 26 Mar 2019 18:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f6096aa5-0311-6d7f-697a-bb5771ca5fc7@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/19 6:49 PM, James Smart wrote:
> 
> Cancelling/flushing scan_work before starting reset won't work. Hannes 
> is, correct, reset must take precedent.
> 
> The scenario is a controller that was recently connected, thus scan work 
> started, and while the scan thread is running, there's an error or 
> connectivity is lost.  The errors force the reset - which must run to 
> terminate any outstanding requests, including those issued by the scan 
> thread.  This has to happen or we're going to hang the scan thread as 
> it's synchronous io.  The 
> nvme_fc_delete_association->nvme_start_queues() sequence says the reset 
> path froze the queues, cancelled all outstanding io and is unfreezing 
> the queues to allow io to pass again, so that any new io on the request 
> queue can be rejected while the controller is not connected (ioctls or 
> subsequent io from the scan thread while the controller is unconnected 
> as well as anything that was pending on the io queues from the fs that 
> should be bounced back for multipath).  Meanwhile, the scan thread got 
> the error on the io request, and since it's the identify command that 
> failed, it's deleting the namespace at the same time the transport is 
> unfreezing the queues.
> 
> Given the transport nvme_start_queues() routine has no idea what 
> ns-queues exist, or what state the ns queues are in, it seems like a 
> synchronization issue on the ns queue itself, that can't be solved by 
> scheduling transport work elements.
> 
> I wonder if it should be something like this:
> --- a    2019-03-26 10:46:08.576056741 -0700
> +++ b    2019-03-26 10:47:55.081252967 -0700
> @@ -3870,8 +3870,10 @@ void nvme_start_queues(struct nvme_ctrl
>       struct nvme_ns *ns;
> 
>       down_read(&ctrl->namespaces_rwsem);
> -    list_for_each_entry(ns, &ctrl->namespaces, list)
> -        blk_mq_unquiesce_queue(ns->queue);
> +    list_for_each_entry(ns, &ctrl->namespaces, list) {
> +        if (!test_bit(NVME_NS_REMOVING, &ns->flags))
> +            blk_mq_unquiesce_queue(ns->queue);
> +    }
>       up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_queues);
> 
> which if valid, would also mean the same check should be in 
> nvme_stop_queues() and perhaps elsewhere.
> 
Well, if the namespace wouldn't be part of the list in the first place 
once it's been set to 'REMOVING'... lemme check.

Cheers,

Hannes
