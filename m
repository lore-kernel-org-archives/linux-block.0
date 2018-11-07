Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41302 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGMkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Nov 2018 07:40:06 -0500
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
 <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a98db60d-ceb9-2a30-39bb-187125f56627@grimberg.me>
Date: Tue, 6 Nov 2018 19:11:36 -0800
MIME-Version: 1.0
In-Reply-To: <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> If you mean the real huge page, this patch shouldn't have made a difference
>> because bio_vec->bv_offset is in [0, PAGE_SIZE), and iSer sets virt
>> boundary as 4K - 1.
>>
>> However, things will change after multipage bvec is introduced.
> 
> 
> Hi Ming,
> 
> I've received a blktrace from our customer showing the issue [1].
> 
> In this example trace they've submitted (contiguous) 64K I/Os and
> without this patch, they're seeing a lot of splits as indicated by the
> trace.
> 
> With the patch applied the I/O is directly issued to the LLDD without
> the splits.
> 
> [1] http://beta.suse.com/private/jthumshirn/blktrace.txt
> 

This patch makes sense to me. However I agree that we need to clarify
that this addresses cases where PAGE_SIZE-1 > queue_virt_boundary(q).

And also, lets replace "like iser" with "drivers that sets a virtual
boundary constraint" as nvme-rdma does the same thing.
