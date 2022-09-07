Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A590C54EE9
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 17:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIGRvh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiIGRvh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 13:51:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4426871726
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 10:51:36 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l5so11246024qvs.13
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ITGHEw/7ymb4th+IGnerzxh0oAntgrwPzuWkbu2it9c=;
        b=iT1680MlJ9vpZy2yyO5XAToQ3Yz6tDTkpa3MqBL8w4OtIYy7MEGpYgQoxKjJzVQpy6
         dop58K4LGi1dN1l6Jvak7BuMUzaECUuFmbJbI01m6hxRK6tj9I4mSuc1SkibN/5Ji+rL
         tyRh3QN0zfntEHEuMDI2hJOuiuRn5nydQjCLfeU1njLXMW7MHmJRILKQq/iGGY2/QdZU
         KpDsYl3lK5xrnzHPVkGVJq0QAIYG5Zb1SWhmcz7VrJikOrII5ir2khpZVJeq7H39wUFF
         EpT6YpDHW85nqZyJaXpnEfcnPHFc8OGF4ExKde4s3dZOrz1Ex79aeETUvq3scZr8RQwB
         LJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ITGHEw/7ymb4th+IGnerzxh0oAntgrwPzuWkbu2it9c=;
        b=5zgfT8pNKWi2yz8n5OqF5MK24qoyKGPl2IW0Egqr0KiegHL/5k02GaC6kSXVuPCtNz
         iMV1LEAFY198kPgWr8ltdJJamABBL8e0eMaR9sDIBWW7Hhvgo1t3FdZd4lqR9kH374Hz
         mnZ6JwEQfEMnoD5rnR8xz+RqYI7BGfistOFpGHNcW09k2GJoBYWspNd6Uzh8OIOLFMNw
         B9+ENN8cmGjfcSVDVUJ/YztNVlVAZPC67ePf4W+SxnYfu9nFo09mm3cQcq6daEkCaIok
         1ovvFpaK51JZcGJ5KpXSghjcKm7P+AoZ0PncjqhJo5EHhURSeknpO6YR9nT73hQQTpGe
         qs1Q==
X-Gm-Message-State: ACgBeo3djvLAhpQx/+BQsDcTKKAKS6Oy/KnM6/vBDHheVnyfLqkjYqi9
        Gvtp/GgqGhLvVAANj+1GcJySlw==
X-Google-Smtp-Source: AA6agR6CoYWGm4o+0w84/9spuynpg9aAhitgRahCqiScW9rPfy0FJ/KazSprmNPB45S/CDtHbrY3dg==
X-Received: by 2002:a05:6214:62c:b0:4aa:a427:add2 with SMTP id a12-20020a056214062c00b004aaa427add2mr4175958qvx.47.1662573095310;
        Wed, 07 Sep 2022 10:51:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x2-20020a376302000000b006b905e003a4sm13742672qkb.135.2022.09.07.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:51:34 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:51:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/17] block: export bio_split_rw
Message-ID: <YxjaJQth4QkEy0HL@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:00AM +0300, Christoph Hellwig wrote:
> bio_split_rw can be used by file systems to split and incoming write
> bio into multiple bios fitting the hardware limit for use as ZONE_APPEND
> bios.  Export it for initial use in btrfs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
