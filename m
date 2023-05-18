Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C7EC7EE25
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 05:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjERFlC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 01:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjERFlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 01:41:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262A2D49
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:40:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-530638a60e1so1468717a12.2
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684388459; x=1686980459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEffvrInPxS782GT1vsjQl+diWdb2xyAJ3axmrr9Dac=;
        b=CgaGaxfFVrxC91/0Fkb25Pz2glzPt1nbr61Q3ZzzEZ54VXbtem0AQ56w86YLb17bwO
         qhoEDW6nF9o4NpmPZvkJu/SZc6KhwUm5x3mifidEVnGeRVOEa41xddNJN6mwHEx8drYT
         fvDQuRt5XUJdlQI4iNuScocwM1ZEwVmG8QB7d+YCIm2OOaYIt/DeOhLUUpkmqiIh+NP3
         wbTDxMmwo8bXPHCt24rr78dRyDK7XrCbnyZhU4ZMZLnvMwR/NZruqBn/nxeKvFBFW+4C
         DY7uQlX0O8l1RkiJDMSAL1U8u4EUdp5qBsUXe47RoK7wzvt7r0hZRYXFpz6uR/C8uVDM
         5iqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684388459; x=1686980459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEffvrInPxS782GT1vsjQl+diWdb2xyAJ3axmrr9Dac=;
        b=idcPpW1wUvos1o06bXPoLuqKmcLhRKuvRN+UcGAFbpAMM2GdL2KJSqcnAlndZxP9Ma
         GrHLPlOCNvgZ4JM9fAtZM3hTKhE77zKZGtH303fFYfb8ZF0l+tNP6hCaAGdsRKkHJntW
         vACQqe0f2ZTFfCIHkuBQ/jan2p8M+Ss/nmHXNyRUGEzkSl1DHI5eCtpbbPV4neHXfI1z
         +hk5YVwiWCwVUfsOAmWJAqFrVx6CezUeKBRMkGVGGnYk6jHXh0GvroiatUztLWNtmJZf
         jwP1cTPI4mxrjzWcxp3XS1XVDV1lOPQjjmvuBsZYzPoeH9dIB0EuVGim+SrTV9e9EY4/
         CQOA==
X-Gm-Message-State: AC+VfDyWeUMUbnxFZfXkEDePClUPAUK4A+RFb90lFq2+NCIwkk46r3ej
        VZUfYdhWYLu4X4vYmPL9ksvbng==
X-Google-Smtp-Source: ACHHUZ6xti2fYNQIgKO/wNsn2B1J0IDZ9hVUm0X4uTC5UvVWRs7QkVtPS7VSnttDntyMu4lbqI01cw==
X-Received: by 2002:a17:902:db0c:b0:1ae:6135:a050 with SMTP id m12-20020a170902db0c00b001ae6135a050mr1810118plx.19.1684388459359;
        Wed, 17 May 2023 22:40:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id iy1-20020a170903130100b0019309be03e7sm399576plb.66.2023.05.17.22.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 22:40:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1pzWNj-000psy-2e;
        Thu, 18 May 2023 15:40:55 +1000
Date:   Thu, 18 May 2023 15:40:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: wire up the ->mark_dead holder operation for
 log and RT devices
Message-ID: <ZGW6Z7p7hTwHZNe7@dread.disaster.area>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 06:23:22AM +0200, Christoph Hellwig wrote:
> Implement a set of holder_ops that shut down the file system when the
> block device used as log or RT device is removed undeneath the file
> system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_super.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index eb469b8f9a0497..75d37bbc5415fc 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -377,6 +377,17 @@ xfs_setup_dax_always(
>  	return 0;
>  }
>  
> +static void
> +xfs_hop_mark_dead(
> +	struct block_device	*bdev)

I'd prefer these ops to be named "xfs_bdev_...." to indicate the are
fs bdev methods similar to how the super ops use "xfs_fs_...."
to indicate they are fs superblock methods....

Other that this this is fine.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
