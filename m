Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4733FECAAA1
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 21:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIBVHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 17:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIBVHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 17:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53EC6FDD
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662152827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1twqOZV7+i5p56v6efC4Oh5HGPuhxWk74nNLDWtwDHQ=;
        b=CHl+kDtCNfiFoR2bAdRytgAQK5cMciNk4lEiP1V1n+d9b8z1FO6nX2UVkDYxKH+Wg9Pkgj
        Wr/YbBtq9GwEJF8UMl1iBBV8uLu4kVq/wH+4CV+Fk0frKU3wPKqII9glO0tuB+8sRD41Ka
        z51PaIC4Zvhc3zlmN7ydLnIuDKdRVdM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-MFuapnETMF-K6Vps7XDPdA-1; Fri, 02 Sep 2022 17:07:05 -0400
X-MC-Unique: MFuapnETMF-K6Vps7XDPdA-1
Received: by mail-qk1-f197.google.com with SMTP id bq19-20020a05620a469300b006c097741d3dso2884801qkb.2
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 14:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1twqOZV7+i5p56v6efC4Oh5HGPuhxWk74nNLDWtwDHQ=;
        b=tTgFw3GwQTIUTAk8XzXF80b2vg/HeWxNozbXyhMub/1gLljHryz6qz73291U2v+aGj
         GCrDetvf5X61I6flD/deDMp9SwAEps6aiZmjEIzbSlkN7zQs2XFpIDJmqD+Xc++I/LkT
         gJWgT0QXzmdGPh8An9UYA9mnLeCGhkdT+fgZZVOzEfBglI7ue8IpVHCx3ij6SNLJ/fdH
         KxPkkx4cVCy6S6tRuiz0xBt5igCnPMWxo6ln6IJoCMQo7531P/g3wy547pLNPgxvaoYd
         I9p9O8yUGmaTM1fUL5pb3tcRl1fSmyJoi4UkQ7p/tn4iJMIdnK3NpZRfQtH4XUeWr9WP
         r7mA==
X-Gm-Message-State: ACgBeo0Lhk1SMLgyYDAVgQPt+haXeZDNS4JuSldplFIbFmSVVHt4FX4E
        1aCEYc7Pe4m4lu+VYgoiC2U65Qse803DewIUZuIjTdcIcokYMTjqyT5DdriCkjC3IT7gEKXqw1B
        hFnJ71E38CJIXucToDWroTg==
X-Received: by 2002:a05:620a:d51:b0:6bc:c53:5789 with SMTP id o17-20020a05620a0d5100b006bc0c535789mr24465459qkl.47.1662152824812;
        Fri, 02 Sep 2022 14:07:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR43jROB3LezwXP2AO1Z1Rks2S9cODPmCHq7gntetrnSftSFIdvYUe2gMh7gmbyxRiTgUDi2IA==
X-Received: by 2002:a05:620a:d51:b0:6bc:c53:5789 with SMTP id o17-20020a05620a0d5100b006bc0c535789mr24465442qkl.47.1662152824589;
        Fri, 02 Sep 2022 14:07:04 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05620a178800b006b949afa980sm2029065qkb.56.2022.09.02.14.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:07:04 -0700 (PDT)
Date:   Fri, 2 Sep 2022 17:07:03 -0400
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
Message-ID: <YxJwd7xcZRdznsYz@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
 <20220823121859.163903-14-p.raghav@samsung.com>
 <YxJttvB2Z5I58SQ5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxJttvB2Z5I58SQ5@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 02 2022 at  4:55P -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Tue, Aug 23 2022 at  8:18P -0400,
> Pankaj Raghav <p.raghav@samsung.com> wrote:
> 
> > Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> > size) were supported in linux but now non power-of-2(npo2) zone sizes
> > support has been added to the block layer.
> > 
> > Filesystems such as F2FS and btrfs have support for zoned devices with
> > po2 zone size assumption. Before adding native support for npo2 zone
> > sizes, it was suggested to create a dm target for npo2 zone size device to
> > appear as a po2 zone size target so that file systems can initially
> > work without any explicit changes by using this target.
> > 
> > The design of this target is very simple: remap the device zone size to
> > the zone capacity and change the zone size to be the nearest power of 2
> > value.
> > 
> > For e.g., a device with a zone size/capacity of 3M will have an equivalent
> > target layout as follows:
> > 
> > Device layout :-
> > zone capacity = 3M
> > zone size = 3M
> > 
> > |--------------|-------------|
> > 0             3M            6M
> > 
> > Target layout :-
> > zone capacity=3M
> > zone size = 4M
> > 
> > |--------------|---|--------------|---|
> > 0             3M  4M             7M  8M
> > 
> > The area between target's zone capacity and zone size will be emulated
> > in the target.
> > The read IOs that fall in the emulated gap area will return 0 filled
> > bio and all the other IOs in that area will result in an error.
> > If a read IO span across the emulated area boundary, then the IOs are
> > split across them. All other IO operations that span across the emulated
> > area boundary will result in an error.
> > 
> > The target can be easily created as follows:
> > dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
> > 
> > Note that the target does not support partial mapping of the underlying
> > device.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> > Suggested-by: Hannes Reinecke <hare@suse.de>
> 
> 
> This target needs more review from those who Suggested-by it.
> 
> And the header and docs needs to address:
> 
> 1) why is a partial mapping of the underlying device disallowed?
> 2) why is it assumed all IO is read-only? (talk to me and others like
>    we don't know the inherent limitations of this class of zoned hw)
> 
> On a code level:
> 1) are you certain you're properly failing all writes?
>    - are writes allowed to the "zone capacity area" but _not_
>      allowed to the "emulated zone area"? (if yes, _please document_). 
> 2) yes, you absolutely need to implement the .status target_type hook
>    (for both STATUS and TABLE).
> 3) really not loving the nested return (of DM_MAPIO_SUBMITTED or
>    DM_MAPIO_REMAPPED) from methods called from dm_po2z_map().  Would
>    prefer to not have to do a depth-first search to see where and when
>    dm_po2z_map() returns a DM_MAPIO_XXX unless there is a solid
>    justification for it.  To me it just obfuscates the DM interface a
>    bit too much. 
> 
> Otherwise, pretty clean code and nothing weird going on.
> 
> I look forward to seeing your next (final?) revision of this patchset.

Thinking further.. I'm left confused about just what the heck this
target is assuming.

E.g.: feels like its exposing a readonly end of the zone is very
bi-polar... yet no hint to upper layer it shouldn't write to that
read-only end (the "emulated zone").. but there has to be some zoned
magic assumed?  And I'm just naive?

Mike

