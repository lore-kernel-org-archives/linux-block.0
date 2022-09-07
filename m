Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56462C38145
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 20:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIGUdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIGUdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 16:33:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C55DBD1EA
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 13:33:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i15so2954596qvp.5
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Xg9usTdk0o6C+zSe1YOKjC4WC1xdzLzB/PM0uNLkIkI=;
        b=5RGjXJezlOJDqW62jqniKE9nd0sCKFqd+pYdoNP/51fCNJDmLNWYBG9knRZwzwHqHQ
         UMgwSQii1aaCB6KLAlPZFNIJ9X/vHHJ2SAX/7GFNQCwNh+u8/uBj9hCY/wV8d1RXTd75
         6ApqvxuIfqn4TbiYSpOaXS/W0TBJsRsKZuEjdpecIjpOwmnYpHcpwTUv57XP4Ht7D78w
         mVm24HglVdIr/kcd3zYb4sOHP7EIN/ncTFd9vEdk35fP2PUet4blXGVuKQ9nM3mhGN8w
         ChIhwxcgGR3WwEBpuE9y88JfjhhwjBa4voxnTiCFoRM0oCAIe3eJ/ywhGfx3aYrNcQG0
         u9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xg9usTdk0o6C+zSe1YOKjC4WC1xdzLzB/PM0uNLkIkI=;
        b=H+e4Fq3s0WQIOe9UwDy7K3Lxc6r/DpJ+a/4F5TFTO6yiGucMzp0qr88A/6WbpKrawo
         sKgO22wN7MBPA+t5dwBQPVETiIf2188sYeVy9cLvkD7M0xJ5lJ3VNemUggLjdd43NRo8
         TuGKMVW0sJ9q8SsCDTGLp5O3egviKWstIntmscFnsgUl1WRaiNct0ATTOBeO6yVXy5f8
         SCvlfWi+qRI68NzhYL6JNXEmhGU9QWdK8+Xc3RQYrrCIiWV4ytYGnOEBYiNXFvFZT+w4
         mmvR8+TzzHxkmfy9Fqb6zbJTpvp1OMmCJAN0Pl5wTPdGqQ7AY91qSb4KKBk8Z+vC7hrc
         1tLA==
X-Gm-Message-State: ACgBeo2TL8Bjowd1c1jts4wgcSiU8A4Nl/oV9rirG+UN86VEil2qwQdH
        nW98esTOWcupvRbI3I/IyPY+O4nWOgitYCMk
X-Google-Smtp-Source: AA6agR6+PDEDIx9U94oK9gOGRgiesvdxSGyJ98dR/RxQZopxV5T9kYkTdfx7Z4YPCtjmyEfo8KkPFw==
X-Received: by 2002:a05:6214:230a:b0:46e:3890:afcb with SMTP id gc10-20020a056214230a00b0046e3890afcbmr4831985qvb.59.1662582817038;
        Wed, 07 Sep 2022 13:33:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id cd9-20020a05622a418900b00342fdc4004fsm13275230qtb.52.2022.09.07.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:33:36 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:33:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/17] btrfs: handle checksum generation in the storage
 layer
Message-ID: <YxkAHwUx8SsJzRYJ@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:04AM +0300, Christoph Hellwig wrote:
> Instead of letting the callers of btrfs_submit_bio deal with checksumming
> the (meta)data in the bio and making decisions on when to offload the
> checksumming to the bio, leave that to btrfs_submit_bio.  Do do so the
> existing btrfs_submit_bio function is split into an upper and a lower
> half, so that the lower half can be offloaded to a workqueue.
> 
> The driver-private REQ_DRV flag is used to indicate the special 'bio must
> be contained in a single ordered extent case' that is used by the
> compressed write case instead of passing a new flag all the way down the
> stack.
> 
> Note that this changes the behavior for direct writes to raid56 volumes so
> that async checksum offloading is not skipped when more I/O is expected.
> This runs counter to the argument explaining why it was done, although I
> can't measure any affects of the change.  Commits later in this series
> will make sure the entire direct writes is offloaded to the workqueue
> at once and thus make sure it is sent to the raid56 code from a single
> thread.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/compression.c |  13 +--
>  fs/btrfs/ctree.h       |   4 +-
>  fs/btrfs/disk-io.c     | 170 ++-------------------------------
>  fs/btrfs/disk-io.h     |   5 -
>  fs/btrfs/extent_io.h   |   3 -
>  fs/btrfs/file-item.c   |  25 ++---
>  fs/btrfs/inode.c       |  89 +-----------------
>  fs/btrfs/volumes.c     | 208 ++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/volumes.h     |   7 +-
>  9 files changed, 215 insertions(+), 309 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f932415a4f1df..53f9e123712b0 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -351,9 +351,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	u64 cur_disk_bytenr = disk_start;
>  	u64 next_stripe_start;
>  	blk_status_t ret = BLK_STS_OK;
> -	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
>  	const bool use_append = btrfs_use_zone_append(inode, disk_start);
> -	const enum req_op bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
> +	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
> +		(use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE);
>  

I'd rather see this as a separate change.  Keeping logical changes to themselves
makes it easier to figure out what was going on when we look back at the
history.  Other than that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
