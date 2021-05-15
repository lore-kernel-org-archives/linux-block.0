Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E4C433ED
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 06:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F3461402
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 06:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhEOGgy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 May 2021 02:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229980AbhEOGgx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 May 2021 02:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621060541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1uS6WmCs7vuGXI0Lgv/TeKWYlCjGDK3uIoVS/uNZyI=;
        b=M2cDtcjx8nFAG+MFWaczdryURTZ+V0yENyFnk3Z4hMS0U7m9ozDdCOyUWJEVwf+s+/vGw5
        nTXxHSAZMllfV/pe8igZJWnQyHgk8kdX7VfP0yDRG+RKxr7xzB7yrmxwFHAaI949cdA7CU
        bcm4aQK9oYk8UIW+7+Y0W/0o2JwuPzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-jEpp6NwkPACrjybH16sMIw-1; Sat, 15 May 2021 02:35:38 -0400
X-MC-Unique: jEpp6NwkPACrjybH16sMIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A2A91005D50;
        Sat, 15 May 2021 06:35:37 +0000 (UTC)
Received: from T590 (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5352D50EDE;
        Sat, 15 May 2021 06:35:31 +0000 (UTC)
Date:   Sat, 15 May 2021 14:35:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, Gulam Mohamed <gulam.mohamed@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: fix a race between del_gendisk and BLKRRPART
Message-ID: <YJ9rr+2GnIef3IXS@T590>
References: <20210514131842.1600568-1-hch@lst.de>
 <20210514131842.1600568-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514131842.1600568-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 14, 2021 at 03:18:42PM +0200, Christoph Hellwig wrote:
> From: Gulam Mohamed <gulam.mohamed@oracle.com>
> 
> When BLKRRPART is called concurrently with del_gendisk, the partitions
> rescan can create a stale partition that will never be be cleaned up.
> 
> Fix this by checking the the disk is up before rescanning partitions
> while under bd_mutex.
> 
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> [hch: split from a larger patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 580bae995b87..4494411fa4d3 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1244,6 +1244,9 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
>  
>  	lockdep_assert_held(&bdev->bd_mutex);
>  
> +	if (!(disk->flags & GENHD_FL_UP))
> +		return -ENXIO;
> +
>  rescan:
>  	if (bdev->bd_part_count)
>  		return -EBUSY;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

