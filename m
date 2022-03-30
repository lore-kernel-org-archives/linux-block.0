Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbiC3Qyr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349070AbiC3Qyr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 12:54:47 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6D2963CC
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 09:53:01 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id s11so18611748qtc.3
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 09:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DCyj2h8Dyfgvj0yFsW9pEgqH+Yiq59PwixRUyZw8nsU=;
        b=YeqHR7LA34/4ilrIRDGEvQQFy3dqreyf4LBD3tX+lSvk9kB/nSS9Fw5tvKGsPQSaLK
         NrhTJgZ1x9BOKij1b0QnhhgSwPgEofUJNW/Py8BzZrCM0hSHmE4neDE3CicKENGqtsLG
         +P3QhzLA9A4qjT2h0W5lHBXcxqL1etA7cwwQNbzaGt4ToUVpjS4dGr3q9cTVLFmTfdBa
         KeY6Qf89jzqM5PK+0aXiTecXMV51e8GqfivYQh3CDYjCuGThCDt3zhqx42VsYYK0aTSm
         LkLVyNzr9TugAeu5Q+SUQwr9Oe/9s+scy17cPYJ2z5VwyWhQ/tll4KYcs2Q6FUg3XDMm
         qYRQ==
X-Gm-Message-State: AOAM533w9aYx7NttSgLLt/eBBCIUFdNH4M5tX7rNBhzGcJbqLLin6DNF
        t6OW3OMWCpMAWS/WO0Gp53ff
X-Google-Smtp-Source: ABdhPJyi6dMu69H3/JMdAZkKfzcZKrpkGifKmMBPz1vbayqx22rOZG5aY5frWWaRoxtInlriFgcGZw==
X-Received: by 2002:ac8:5c05:0:b0:2e1:de0f:d974 with SMTP id i5-20020ac85c05000000b002e1de0fd974mr423619qti.632.1648659180461;
        Wed, 30 Mar 2022 09:53:00 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w3-20020a05622a190300b002e1f084d84bsm18106868qtc.50.2022.03.30.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:52:59 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:52:58 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     tj@kernel.org, dennis@kernel.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YkSK6mU1fja2OykG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Tejun and Dennis,

I recently found that due to bio_set_dev()'s call to
bio_associate_blkg(), bio_set_dev() needs much more cpu than ideal;
especially when doing 4K IOs via io_uring's HIPRI bio-polling.

I'm very naive about blk-cgroups.. so I'm hopeful you or others can
help me cut through this to understand what the ideal outcome should
be for DM's bio clone + remap heavy use-case as it relates to
bio_associate_blkg.

If I hack dm-linear with a local __bio_set_dev that simply removes
the call to bio_associate_blkg() my IOPS go from ~980K to 995K.

Looking at what is happening a bit, relative to this DM bio cloning
usecase, it seems __bio_clone() calls bio_clone_blkg_association() to
clone the blkg from DM device, then dm-linear.c:linear_map's call
to bio_set_dev() will cause bio_associate_blkg(bio) to reuse the css
but then it triggers an update because the bdev is being remapped in
the bio (due to linear_map sending the IO to the real underlying
device). End result _seems_ like collective wasteful effort to get the
blk-cgroup resources setup properly in the face of a simple remap.

Seems the current DM pattern is causing repeat blkg work for _every_
remapped bio?  Do you see a way to speed up repeat calls to
bio_associate_blkg()?

Test kernel is my latest dm-5.19 branch (though latest Linus 5.18-rc0
kernel should be fine too):
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19

I'm using dm-linear ontop on a 16G blk-mq null_blk device:

modprobe null_blk queue_mode=2 poll_queues=2 bs=4096 gb=16
SIZE=`blockdev --getsz /dev/nullb0`
echo "0 $SIZE linear /dev/nullb0 0" | dmsetup create linear

And running the workload with fio using this wrapper script:
io_uring.sh 20 1 /dev/mapper/linear 4096

#!/bin/bash

RTIME=$1
JOBS=$2
DEV=$3
BS=$4

QD=64
BATCH=16
HI=1

fio --bs=$BS --ioengine=io_uring --fixedbufs --registerfiles --hipri=$HI \
        --iodepth=$QD \
        --iodepth_batch_submit=$BATCH \
        --iodepth_batch_complete_min=$BATCH \
        --filename=$DEV \
        --direct=1 --runtime=$RTIME --numjobs=$JOBS --rw=randread \
        --name=test --group_reporting
