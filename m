Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4D1C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 07:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1B62086B
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 07:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1B62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKORHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:07:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbeKORHf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 12:07:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C30E7B029;
        Thu, 15 Nov 2018 07:00:58 +0000 (UTC)
Subject: Re: [PATCH 15/16] block: remove the lock argument to
 blk_alloc_queue_node
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20181114160219.28328-1-hch@lst.de>
 <20181114160219.28328-16-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ceb13a4b-8434-1850-2067-163d64ec0335@suse.de>
Date:   Thu, 15 Nov 2018 08:00:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114160219.28328-16-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 5:02 PM, Christoph Hellwig wrote:
> With the legacy request path gone there is no real need to override the
> queue_lock.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c               | 16 +++-------------
>   block/blk-mq.c                 |  2 +-
>   drivers/block/drbd/drbd_main.c |  2 +-
>   drivers/block/null_blk_main.c  |  3 +--
>   drivers/block/umem.c           |  2 +-
>   drivers/lightnvm/core.c        |  2 +-
>   drivers/md/dm.c                |  2 +-
>   drivers/nvdimm/pmem.c          |  2 +-
>   drivers/nvme/host/multipath.c  |  2 +-
>   include/linux/blkdev.h         |  3 +--
>   10 files changed, 12 insertions(+), 24 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
