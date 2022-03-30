Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 19:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350620AbiC3TZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiC3TZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 15:25:04 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D021237
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 12:23:16 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id x31so13123768pfh.9
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 12:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHtyaTDCFwT16k5cdDfPF/P2EA5gPFqUR2PCvm4ECgI=;
        b=YQfob1wgJ8QhpYSvS1CfnB2Df1MJFbEXTXCNza5VUvu8+wThcuvOvK08J/zTZ4Qbdm
         1GxBpCLPfS2ilJhgRSeOPcSLxVsNQkIttpUi8oqmd2oUbLxFeIvZxUpMrXZCWE3v/PCo
         sUzMJPWZK6HKPXpgBTsIJGH4ejQoATg7infOmEj8NG9uxgXORVkwCxBRi67/xp1JyfHL
         ZmdChelr/5IM3NTkn+5Nw5vOf5Z1g31imRSUT4HqISREpyLAqqz0JRfYA89x66y8mKxc
         mlvlcwYq6cLW51vYS+ekfpOmIhFppu3Mg5LZU8UUsZ9tZyaZ1MobS8fFifGBCsp3xcAD
         73SA==
X-Gm-Message-State: AOAM533ytZfYvrRc4tV4AL7ljBEiT2nZ3m524yBHhc2TuWLcYUVLWs2F
        TIqi+rcREOyNfxn9oNnUeAd0WkrcyMM=
X-Google-Smtp-Source: ABdhPJzwW5Uj3tPdbpOaNG5QzaofCKC1qF7aDIo6ArraeWowHZ4NFFbLL3rxw31k/agc3F4ivB+E5w==
X-Received: by 2002:a05:6a00:ad0:b0:4f7:a357:6899 with SMTP id c16-20020a056a000ad000b004f7a3576899mr34729945pfl.80.1648668195778;
        Wed, 30 Mar 2022 12:23:15 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00218600b004f65315bb37sm26083117pfi.13.2022.03.30.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:23:15 -0700 (PDT)
Date:   Wed, 30 Mar 2022 08:28:28 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     tj@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YkRM7Iyp8m6A1BCl@fedora>
References: <YkSK6mU1fja2OykG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkSK6mU1fja2OykG@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Mike,

On Wed, Mar 30, 2022 at 12:52:58PM -0400, Mike Snitzer wrote:
> Hey Tejun and Dennis,
> 
> I recently found that due to bio_set_dev()'s call to
> bio_associate_blkg(), bio_set_dev() needs much more cpu than ideal;
> especially when doing 4K IOs via io_uring's HIPRI bio-polling.
> 
> I'm very naive about blk-cgroups.. so I'm hopeful you or others can
> help me cut through this to understand what the ideal outcome should
> be for DM's bio clone + remap heavy use-case as it relates to
> bio_associate_blkg.
> 
> If I hack dm-linear with a local __bio_set_dev that simply removes
> the call to bio_associate_blkg() my IOPS go from ~980K to 995K.
> 
> Looking at what is happening a bit, relative to this DM bio cloning
> usecase, it seems __bio_clone() calls bio_clone_blkg_association() to
> clone the blkg from DM device, then dm-linear.c:linear_map's call
> to bio_set_dev() will cause bio_associate_blkg(bio) to reuse the css
> but then it triggers an update because the bdev is being remapped in
> the bio (due to linear_map sending the IO to the real underlying
> device). End result _seems_ like collective wasteful effort to get the
> blk-cgroup resources setup properly in the face of a simple remap.
> 
> Seems the current DM pattern is causing repeat blkg work for _every_
> remapped bio?  Do you see a way to speed up repeat calls to
> bio_associate_blkg()?
> 

I must admit I wrote this with limited knowledge of bio cloning at the
time. I can fill in the thought process here.

The idea was every bio should have a blkg associated with it for io
accounting and things like blk-iolatency and blk-iocost. The device
abstraction I believe means we can set limits here as well on submission
rate to the md device.

I think cloning is a special case that I might have gotten wrong. If
there is a bio_set_dev() call after each clone(), then the
bio_clone_blkg_association() is excess work. We'd need to audit how
bio_alloc_clone() is being used to be safe. Alternatively, we could opt
for a bio_alloc_clone_noblkg(), but that's a little bit uglier.

1. bio_set_dev() above md <- needed so we can do throttling on the md.
2. bio_alloc_clone() <- doesn't need to clone the blkg() info.
3. bio_set_dev() in md <- sets the right underlying device association.

Thanks,
Dennis

> Test kernel is my latest dm-5.19 branch (though latest Linus 5.18-rc0
> kernel should be fine too):
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19
> 
> I'm using dm-linear ontop on a 16G blk-mq null_blk device:
> 
> modprobe null_blk queue_mode=2 poll_queues=2 bs=4096 gb=16
> SIZE=`blockdev --getsz /dev/nullb0`
> echo "0 $SIZE linear /dev/nullb0 0" | dmsetup create linear
> 
> And running the workload with fio using this wrapper script:
> io_uring.sh 20 1 /dev/mapper/linear 4096
> 
> #!/bin/bash
> 
> RTIME=$1
> JOBS=$2
> DEV=$3
> BS=$4
> 
> QD=64
> BATCH=16
> HI=1
> 
> fio --bs=$BS --ioengine=io_uring --fixedbufs --registerfiles --hipri=$HI \
>         --iodepth=$QD \
>         --iodepth_batch_submit=$BATCH \
>         --iodepth_batch_complete_min=$BATCH \
>         --filename=$DEV \
>         --direct=1 --runtime=$RTIME --numjobs=$JOBS --rw=randread \
>         --name=test --group_reporting
