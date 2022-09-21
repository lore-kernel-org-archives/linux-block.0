Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D1FC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIUR1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIUR1i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 13:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F237FA031B
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663781256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jf1FYXrDVaqqC4NbZ8fFAHL8bcgUOrwJH0z7ee3/534=;
        b=WAGsNbfnRF10IPtgic/GppqrqQev/JC4NaWg3FAAAXKc6vf/xDCmTyw3c3g5thaazvDfCD
        0OlNsIToFl+0w/q56/1Y7p0/DDFaWSH+WmjrWBu0BMriGJnff+yz3DQXvrO1dyHsVcIkSp
        m54+5eplf2Acf60ndw0grRWp9kABkSo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-qvKFe4ahPyCl2UG6Jn7-0Q-1; Wed, 21 Sep 2022 13:27:34 -0400
X-MC-Unique: qvKFe4ahPyCl2UG6Jn7-0Q-1
Received: by mail-qk1-f197.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so4757241qkp.20
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 10:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jf1FYXrDVaqqC4NbZ8fFAHL8bcgUOrwJH0z7ee3/534=;
        b=13v+I4jcbYi2iwsAWNmjVCqeKy59frYm/DfZJny86MgKIfF8bQ46HEBLv7eWAKszhr
         UGlpilII2r9ckGDr4UFu5bjOMi2AORGpuAlQF0ZODvZP1XWZ3O7bxtFLfxSXrXtc6nEJ
         AtASwtOeV01zVKLL0aXPAAOPPqzE///65qiy92p4rN70ypb9cLT1+anvArAa39pi4znT
         +QufMpeF3oIBhJHDkRysdQzvvDl8zc5P+t30Dgza0pb1gxq4jtLZEs35H813hS4T9ONj
         8eSW1OxqjND3OFpxAwhDxBA228A53vTNtdqfaa2oOSwkXK+GqnXEbqeROm18ImpVE6CR
         oWcg==
X-Gm-Message-State: ACrzQf1IczxpC1yPjO3HoDQSBdFqvZSZrJvTUkw294sb3I6LvfMha7dR
        aQe8VHv1uI2QlFK89kme3B0Mvu2G3JYn3+upj4+2IBie0ZQx9RwAI3KNgrerbKYuvehYNgKxc0z
        wVsJaPw/2ObSqSGClFqjFcg==
X-Received: by 2002:a05:622a:414:b0:35c:f297:ebfc with SMTP id n20-20020a05622a041400b0035cf297ebfcmr10981940qtx.420.1663781254263;
        Wed, 21 Sep 2022 10:27:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6z1zbB3AmadTPASo43OhmHFT6jpU/kArRwI7nXi7rFyLGyH8LCRodE1M4MYgySQ0l8v7sRqg==
X-Received: by 2002:a05:622a:414:b0:35c:f297:ebfc with SMTP id n20-20020a05622a041400b0035cf297ebfcmr10981905qtx.420.1663781253957;
        Wed, 21 Sep 2022 10:27:33 -0700 (PDT)
Received: from localhost ([217.138.198.196])
        by smtp.gmail.com with ESMTPSA id w23-20020a05620a0e9700b006cbdc9f178esm2196842qkm.25.2022.09.21.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:27:33 -0700 (PDT)
Date:   Wed, 21 Sep 2022 13:27:32 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     damien.lemoal@opensource.wdc.com,
        Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
        bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
        matias.bjorling@wdc.com
Subject: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with  non-power-of-2 zone
 sizes]
Message-ID: <YytJhEywBhqcr7MX@redhat.com>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20 2022 at  5:11P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> - Background and Motivation:
> 
> The zone storage implementation in Linux, introduced since v4.10, first
> targetted SMR drives which have a power of 2 (po2) zone size alignment
> requirement. The po2 zone size was further imposed implicitly by the
> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
> across chunks beyond the specified size, since v3.16 through commit
> 762380ad9322 ("block: add notion of a chunk size for request merging").
> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
> to be non-power-of-2").
> 
> NAND, which is the media used in newer zoned storage devices, does not
> naturally align to po2. In these devices, zone capacity(cap) is not the
> same as the po2 zone size. When the zone cap != zone size, then unmapped
> LBAs are introduced to cover the space between the zone cap and zone size.
> po2 requirement does not make sense for these type of zone storage devices.
> This patch series aims to remove these unmapped LBAs for zoned devices when
> zone cap is npo2. This is done by relaxing the po2 zone size constraint
> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
> == zone size.
> 
> Removing the po2 requirement from zone storage should be possible
> now provided that no userspace regression and no performance regressions are
> introduced. Stop-gap patches have been already merged into f2fs-tools to
> proactively not allow npo2 zone sizes until proper support is added [1].
> 
> There were two efforts previously to add support to npo2 devices: 1) via
> device level emulation [2] but that was rejected with a final conclusion
> to add support for non po2 zoned device in the complete stack[3] 2)
> adding support to the complete stack by removing the constraint in the
> block layer and NVMe layer with support to btrfs, zonefs, etc which was
> rejected with a conclusion to add a dm target for FS support [0]
> to reduce the regression impact.
> 
> This series adds support to npo2 zoned devices in the block and nvme
> layer and a new **dm target** is added: dm-po2zoned-target. This new
> target will be initially used for filesystems such as btrfs and
> f2fs until native npo2 zone support is added.

As this patchset nears the point of being "ready for merge" and DM's
"zoned" oriented targets are multiplying, I need to understand: where
are we collectively going?  How long are we expecting to support the
"stop-gap zoned storage" layers we've constructed?

I know https://zonedstorage.io/docs/introduction exists... but it
_seems_ stale given the emergence of ZNS and new permutations of zoned
hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
still left wanting (e.g. "bring it all home for me!")...

Damien, as the most "zoned storage" oriented engineer I know, can you
please kick things off by shedding light on where Linux is now, and
where it's going, for "zoned storage"?

To give some additional context to help me when you answer: I'm left
wondering what, if any, role dm-zoned has to play moving forward given
ZNS is "the future" (and yeah "the future" is now but...)?  E.g.: Does
it make sense to stack dm-zoned ontop of dm-po2zoned!?

Yet more context: When I'm asked to add full-blown support for
dm-zoned to RHEL my gut is "please no, why!?".  And if we really
should add dm-zoned is dm-po2zoned now also a requirement (to support
non-power-of-2 ZNS devices in our never-ending engineering of "zoned
storage" compatibility stop-gaps)?

In addition, it was my understanding that WDC had yet another zoned DM
target called "dm-zap" that is for ZNS based devices... It's all a bit
messy in my head (that's on me for not keeping up, but I think we need
a recap!)

So please help me, and others, become more informed as quickly as
possible! ;)

Thanks,
Mike

ps. I'm asking all this in the open on various Linux mailing lists
because it doesn't seem right to request a concall to inform only
me... I think others may need similar "zoned storage" help.

