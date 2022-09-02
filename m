Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B5C6FA82
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 20:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiIBUz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 16:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiIBUzv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 16:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB33543D1
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662152122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e/i1xNela7arfufOlEWSIrFxi0oQo+ouwTHhQRBJeIY=;
        b=QmNeXyOhkMEj57sXm1+1Xg6S/er5x7DfqkrGw96NAyF+R1dub3ZyQ3R7r0GEWgiBlYhTr0
        riJ+WpA+HUGbHlx4G00kOxZq91k2h155bFsMK+a3qmvlnLQt5CTODdhY1D39mUO+hgLR53
        Vwvx0nIfO+9kHSPxeT0rvJ7e9q1KjZo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-ZCOmP26zMiK5VPAN-_l4gw-1; Fri, 02 Sep 2022 16:55:21 -0400
X-MC-Unique: ZCOmP26zMiK5VPAN-_l4gw-1
Received: by mail-qv1-f69.google.com with SMTP id ll5-20020a056214598500b0049905d71166so2018948qvb.14
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 13:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=e/i1xNela7arfufOlEWSIrFxi0oQo+ouwTHhQRBJeIY=;
        b=nQQKNpVmhlsEHIwUreLawl2wKWD9uAur5Z94cHLxapfxC+eAE37TCrXoRbs/2FoSQP
         pxNecwMdTqyCGA+FipMBwCi2ik3nCxiJYgXfRW2GZ3Nviumi/rHJh4dVrzfLlrTh6Cj5
         JjCjos7ebW0h7k7iUQNpoYWsh/z+9Q0+x/ewTrSSN1Gc8374e5mCnZtiI+qrHBCjX2FP
         rQVx1y7rDbbH+ATkKKKP7sqibxsbZoWVSRnv16hJt9xHtGiEY39LWpj0glgfP8FpFDz0
         et1gyiUAc9fQpWHBC47d+3ql6ZoF1P2EC2BKadeyj6DihLOH89c46PWByv+034fDqmb5
         Wiow==
X-Gm-Message-State: ACgBeo1QQO4MSy0OXNb95IAni8RCgaq/ifqXxqej9zQEcI99mYfIDOKG
        FIv70WjxPVVbjrJ+IDDXwzI8PufYGmSrZPpy/R4LqYlf8Gxi4RPqU3PADg1EOCmwF3m5ZDBOwtJ
        eBm2rHXzzFOX6hXizgAt97Q==
X-Received: by 2002:ac8:574f:0:b0:344:5a94:28fc with SMTP id 15-20020ac8574f000000b003445a9428fcmr30044835qtx.670.1662152120814;
        Fri, 02 Sep 2022 13:55:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7htZ5gZN01TeQlX/VJoxT2IaqgKvr8JeqKIGVMnyaeNem7TxDPPSJJMlag+j644UTpDAvlmQ==
X-Received: by 2002:ac8:574f:0:b0:344:5a94:28fc with SMTP id 15-20020ac8574f000000b003445a9428fcmr30044821qtx.670.1662152120587;
        Fri, 02 Sep 2022 13:55:20 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id fw10-20020a05622a4a8a00b0034361fb2f75sm1584123qtb.22.2022.09.02.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:55:19 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:55:18 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de,
        Damien Le Moal <damien.lemoal@wdc.com>, bvanassche@acm.org,
        pankydev8@gmail.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YxJttvB2Z5I58SQ5@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
 <20220823121859.163903-14-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-14-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
> 
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 zone size target so that file systems can initially
> work without any explicit changes by using this target.
> 
> The design of this target is very simple: remap the device zone size to
> the zone capacity and change the zone size to be the nearest power of 2
> value.
> 
> For e.g., a device with a zone size/capacity of 3M will have an equivalent
> target layout as follows:
> 
> Device layout :-
> zone capacity = 3M
> zone size = 3M
> 
> |--------------|-------------|
> 0             3M            6M
> 
> Target layout :-
> zone capacity=3M
> zone size = 4M
> 
> |--------------|---|--------------|---|
> 0             3M  4M             7M  8M
> 
> The area between target's zone capacity and zone size will be emulated
> in the target.
> The read IOs that fall in the emulated gap area will return 0 filled
> bio and all the other IOs in that area will result in an error.
> If a read IO span across the emulated area boundary, then the IOs are
> split across them. All other IO operations that span across the emulated
> area boundary will result in an error.
> 
> The target can be easily created as follows:
> dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
> 
> Note that the target does not support partial mapping of the underlying
> device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>


This target needs more review from those who Suggested-by it.

And the header and docs needs to address:

1) why is a partial mapping of the underlying device disallowed?
2) why is it assumed all IO is read-only? (talk to me and others like
   we don't know the inherent limitations of this class of zoned hw)

On a code level:
1) are you certain you're properly failing all writes?
   - are writes allowed to the "zone capacity area" but _not_
     allowed to the "emulated zone area"? (if yes, _please document_). 
2) yes, you absolutely need to implement the .status target_type hook
   (for both STATUS and TABLE).
3) really not loving the nested return (of DM_MAPIO_SUBMITTED or
   DM_MAPIO_REMAPPED) from methods called from dm_po2z_map().  Would
   prefer to not have to do a depth-first search to see where and when
   dm_po2z_map() returns a DM_MAPIO_XXX unless there is a solid
   justification for it.  To me it just obfuscates the DM interface a
   bit too much. 

Otherwise, pretty clean code and nothing weird going on.

I look forward to seeing your next (final?) revision of this patchset.

Thanks,
Mike

