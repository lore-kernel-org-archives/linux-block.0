Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F33C54EE9
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 20:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIGUhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGUhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 16:37:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7B7E807
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 13:36:58 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j6so11393105qkl.10
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=C1BHBcAsOSyQRMHN3OzwuxzeT1VFxcXC8BZIu2j3tLU=;
        b=g4iyp/DXOUn/ZrDVhsoOcC4O19DxkXrUzEUGqZJeMDf1QDm7j+TIK67zTZE0aBBgTv
         Rou6b+1gXbQu1cuDCXd+2CRzTqHOBFNt/ZWll/fMJ1OneI95xjIalMd5u4iEXMFtiE0D
         JWLa16oSFqFYLp8L+CN920pVmpKlKDmn7HIdQuRAPWDxBMPy8zoulX1uVp+ixgl52cxD
         lRJyeYc1TO6O7dMzvgWUAFTjqE9EayVdT7PBt1Ij6iCLofjy64+ZMWc63DFJfm532gNt
         01jYFqBs0V6+InjoL/7OagoBIKcvWEe+SYL/Nvz2hdauS3/PUSx/6wkVluTDF+dQ8pUD
         5X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C1BHBcAsOSyQRMHN3OzwuxzeT1VFxcXC8BZIu2j3tLU=;
        b=nNGizMQyVWBcwCCL0wFtih1UAjV7rT+r3onjZEoi64UmeJ7+T2MX7yIYb99sB/sFUV
         aPj8yFqTEjBHKaEB5nqCznuojtCOsExGlQzeTSvq3ydmicQRH1pgFRz9az/FzEMUv27L
         UpXW4nNeDZ60noJZmn3jdrb+H2d0O8glAK1Ha7Wk9He2dNgaYPqM37MfDpe04Y2ZHUgl
         ccBm/Qv60nMETwLaU+F6XfuPLak2R81T0HTyTWdoKs9YskAf6uxALy9jNqoMD6oshspx
         K2I2RuwZw6wTXhhH4lj3jFIZT2Q+7ANnyvE8zhGViuMPNTCG+l9m1M1iyy3rOPDLG/LB
         hbnA==
X-Gm-Message-State: ACgBeo2IAQ9xzfBq8XwvXqubOHvbktxErn4SrPANMURsZdkQ6A9/CrXR
        AXno56PKTXi3lh3HH5jvwH7gNA==
X-Google-Smtp-Source: AA6agR7WbFK3hNsj7u4rSvbpte5v8Bf/PMRPFx6mZwZZNtClyjs2s0puEF5jTalrINZMmUDKYAWMkQ==
X-Received: by 2002:a37:aa04:0:b0:6bc:56c0:63c9 with SMTP id t4-20020a37aa04000000b006bc56c063c9mr4070160qke.449.1662583017073;
        Wed, 07 Sep 2022 13:36:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q11-20020a05620a0d8b00b006bbf85cad0fsm15708263qkl.20.2022.09.07.13.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:36:56 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:36:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/17] btrfs: handle recording of zoned writes in the
 storage layer
Message-ID: <YxkA539zjxA3OvwV@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:05AM +0300, Christoph Hellwig wrote:
> Move the code that splits the ordered extents and records the physical
> location for them to the storage layer so that the higher level consumers
> don't have to care about physical block numbers at all.  This will also
> allow to eventually remove accounting for the zone append write sizes in
> the upper layer with a little bit more block layer work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
