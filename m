Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B37C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 06:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62B12086B
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 06:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62B12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKORBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:01:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:56976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbeKORBh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 12:01:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75C95AF11;
        Thu, 15 Nov 2018 06:55:02 +0000 (UTC)
Subject: Re: [PATCH 04/16] block: use atomic bitops for ->queue_flags
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20181114160219.28328-1-hch@lst.de>
 <20181114160219.28328-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ddb96188-b2dd-6aaf-90f5-7eb5889691f8@suse.de>
Date:   Thu, 15 Nov 2018 07:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114160219.28328-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 5:02 PM, Christoph Hellwig wrote:
> ->queue_flags is generally not set or cleared in the fast path, and also
> generally set or cleared one flag at a time.  Make use of the normal
> atomic bitops for it so that we don't need to take the queue_lock,
> which is otherwise mostly unused in the core block layer now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       | 54 ++++++----------------------------------
>   block/blk-mq.c         |  2 +-
>   block/blk-settings.c   | 10 +++-----
>   block/blk-sysfs.c      | 28 +++++++++------------
>   block/blk.h            | 56 ------------------------------------------
>   include/linux/blkdev.h |  1 -
>   6 files changed, 24 insertions(+), 127 deletions(-)
> 
I wonder if we can't remove the 'blk_queue_flag_XXX' helpers and replace 
them with inlines ...

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
