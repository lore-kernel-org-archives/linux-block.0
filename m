Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51337C04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D66E205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfEPIsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:48:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfEPIsR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:48:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDE45AEDB;
        Thu, 16 May 2019 08:48:15 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: don't decrement nr_phys_segments for
 physically contigous segments
To:     Christoph Hellwig <hch@lst.de>, axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20190516084058.20678-1-hch@lst.de>
 <20190516084058.20678-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ecf46792-61e5-232a-e4dc-ba7aae040002@suse.de>
Date:   Thu, 16 May 2019 10:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516084058.20678-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 10:40 AM, Christoph Hellwig wrote:
> Currently ll_merge_requests_fn, unlike all other merge functions,
> reduces nr_phys_segments by one if the last segment of the previous,
> and the first segment of the next segement are contigous.  While this
> seems like a nice solution to avoid building smaller than possible
> requests it causes a mismatch between the segments actually present
> in the request and those iterated over by the bvec iterators, including
> __rq_for_each_bio.  This could cause overwrites of too small kmalloc
> allocations in any driver using ranged discard, or also mistrigger
> the single segment optimization in the nvme-pci driver.
> 
> We could possibly work around this by making the bvec iterators take
> the front and back segment size into account, but that would require
> moving them from the bio to the bio_iter and spreading this mess
> over all users of bvecs.  Or we could simply remove this optimization
> under the assumption that most users already build good enough bvecs,
> and that the bio merge patch never cared about this optimization
> either.  The latter is what this patch does.
> 
> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c | 23 +----------------------
>   1 file changed, 1 insertion(+), 22 deletions(-)
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
