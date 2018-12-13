Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF78C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A553A20672
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A553A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeLMJOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:14:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:52588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeLMJOO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 04:14:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A26AAC36;
        Thu, 13 Dec 2018 09:14:13 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: move holder tracking from struct block_device
 to hd_struct
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-2-cascardo@canonical.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <534a98ae-9da8-bd02-9d7d-f33e4b23e455@suse.de>
Date:   Thu, 13 Dec 2018 10:14:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206164812.30925-2-cascardo@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 5:48 PM, Thadeu Lima de Souza Cascardo wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> We'd like to track the slaves and holder for nvme multipath devices
> in the same standard fashion as all the other stacked block devices
> to make the life for things like distro installers easy.
> 
> But struct block_device only exists while we have open instances,
> which we never have for the underlying devices of a nvme-multipath
> setup.  But we can easily move the older list into struct hd_struct
> which exists all the time the block device exists, the only interesting
> bit is that we need a new mutex for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c                |  4 +++
>   block/partition-generic.c    |  4 +++
>   drivers/block/drbd/drbd_nl.c |  4 +--
>   drivers/md/bcache/super.c    |  8 +++---
>   drivers/md/dm.c              |  4 +--
>   drivers/md/md.c              |  4 +--
>   fs/block_dev.c               | 48 ++++++++++++++++--------------------
>   include/linux/fs.h           | 11 +++------
>   include/linux/genhd.h        |  4 +++
>   9 files changed, 47 insertions(+), 44 deletions(-)
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
