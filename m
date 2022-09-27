Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC9C07E9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 15:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiI0Pdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiI0Pdc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 11:33:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F0F1C26CF
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:33:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s10so11345901ljp.5
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fw/Fvmj6HURwdpMd9Zq01ypXyjOL6RV78gxv0xHlLeM=;
        b=CgXEwZnS0/IxgG7UJHpXokOQM9iSMoc3vkUXkZNvIdAw6yyCsLqDXDsrHmsd9JHwC+
         d0WLHIum5UwejYwNfbKMFWkqdLm85+X7SSl8EPlgYtDt6dwL3hGMJZCcE8RLAUc8VfkY
         MQp/0yzfT4vKoodReNx4YHPBajjKGXJaHFpTwVGjWk7Mo/wDNBvNDaz/XAXy70vfHGta
         BZq2s56NnTjFwmPO7xjTUp7SC/tC0IirWVMkqDZNTBQJcD+zdvAnrDLPaktbGq/FCNOg
         mhjnpBrB4JT43dv1hzjcmFPb8fMU5kA1XaZ//4Eg0YhGbkAWjOkYuWI/sA9Rkv4xuwfi
         aZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fw/Fvmj6HURwdpMd9Zq01ypXyjOL6RV78gxv0xHlLeM=;
        b=MI3eJpGO20q/V5iMcEkVL/aSnR4IuUHdKV+x0ZRiZBq+w/TEVuu07vhxerf/SXn6YA
         Rd1pUcYEZtk7IXAv+Ize7ycCftJ7bd8NLR3uTd3eD2wA+iTw0Sp/dtL6+ztBw+vmrTyU
         mgB/S1BSIb+Vx1JKsa5Ge4bACstHUv+k3hy55r2U6EaZhAbEfEL6fgopjb+3PWxg2HL2
         7y5CZeFqTHOqV3iUiTe6Y/8e5NRkdG1oQFUNoyu164vlc8slQdPJ8BFIbrjgO148muEt
         ghd1Ph17qDMA4dUtPgXF6fKb7a17hiLA1Wei+LAH0S6QYoKdF53yk9YlYsBfYDRwfhX6
         fChg==
X-Gm-Message-State: ACrzQf0avqOrE9hhoPzmJCgpQw6ScwubpISARPI3r2kKudj+RJ5ugIA0
        gY02v1Xi7B39ag2PctSb5vjm6qjB2aM=
X-Google-Smtp-Source: AMsMyM5SF9i0ulJ9ayOhXxjsLl6aIOcAQ8P24ov3CoBpjVkJZnoc1UTnSrXt5Aui1JCykKviSShgDw==
X-Received: by 2002:a2e:8917:0:b0:26a:a520:db52 with SMTP id d23-20020a2e8917000000b0026aa520db52mr9513210lji.289.1664292809003;
        Tue, 27 Sep 2022 08:33:29 -0700 (PDT)
Received: from localhost (80-62-116-219-mobile.dk.customer.tdc.net. [80.62.116.219])
        by smtp.gmail.com with ESMTPSA id o25-20020ac25e39000000b0049311968ca4sm190404lfg.261.2022.09.27.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:33:28 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:33:26 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] block: replace blk_queue_nowait with bdev_nowait
Message-ID: <20220927153326.mbih752mdtzu3jom@quentin>
References: <20220927075815.269694-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927075815.269694-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 27, 2022 at 09:58:15AM +0200, Christoph Hellwig wrote:
> Replace blk_queue_nowait with a bdev_nowait helpers that takes the
> block_device given that the I/O submission path should not have to
> look into the request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       | 2 +-
>  drivers/md/dm-table.c  | 4 +---
>  drivers/md/md.c        | 4 ++--
>  include/linux/blkdev.h | 6 +++++-
>  io_uring/io_uring.c    | 2 +-
>  5 files changed, 10 insertions(+), 8 deletions(-)
> 
Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
