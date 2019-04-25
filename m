Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D6C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 08:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA92208E4
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 08:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfDYIgx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:36:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfDYIgw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 04:36:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DA66AC66;
        Thu, 25 Apr 2019 08:36:51 +0000 (UTC)
Subject: Re: [PATCH 2/2] block: remove the i argument to
 bio_for_each_segment_all
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190425070300.3388-1-hch@lst.de>
 <20190425070300.3388-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <09de7bb0-7d35-a346-1021-5ee2192d6ec2@suse.de>
Date:   Thu, 25 Apr 2019 10:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425070300.3388-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/19 9:03 AM, Christoph Hellwig wrote:
> We only have two callers that need the integer loop iterator, and they
> can easily maintain it themselves.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   block/bio.c                       | 29 ++++++++++-------------------
>   block/bounce.c                    |  3 +--
>   drivers/md/bcache/btree.c         |  3 +--
>   drivers/md/dm-crypt.c             |  3 +--
>   drivers/md/raid1.c                |  6 +++---
>   drivers/staging/erofs/data.c      |  3 +--
>   drivers/staging/erofs/unzip_vle.c |  3 +--
>   fs/block_dev.c                    |  6 ++----
>   fs/btrfs/compression.c            |  3 +--
>   fs/btrfs/disk-io.c                |  4 ++--
>   fs/btrfs/extent_io.c              | 10 ++++------
>   fs/btrfs/inode.c                  |  8 ++++----
>   fs/btrfs/raid56.c                 |  3 +--
>   fs/crypto/bio.c                   |  3 +--
>   fs/direct-io.c                    |  3 +--
>   fs/ext4/page-io.c                 |  3 +--
>   fs/ext4/readpage.c                |  3 +--
>   fs/f2fs/data.c                    |  9 +++------
>   fs/gfs2/lops.c                    |  3 +--
>   fs/gfs2/meta_io.c                 |  3 +--
>   fs/iomap.c                        |  6 ++-	---
>   fs/mpage.c                        |  3 +--
>   fs/xfs/xfs_aops.c                 |  3 +--
>   include/linux/bio.h               |  5 ++---
>   24 files changed, 47 insertions(+), 81 deletions(-)
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
