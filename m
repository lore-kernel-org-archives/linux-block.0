Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA7C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 16:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiGNQ2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiGNQ2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 12:28:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39006B1FA
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 09:28:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id r1so864706plo.10
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=51FMChkJehx7pHQ73T1R4wuQ3K5opuWy1ShYWSXgcLc=;
        b=2bg3ecZuRFVjrx0xZziz+wHecVVGRtdcCdgSMS92KHHiTPhlz0piUC25EoCFkiNcXD
         ZrtVuuscGJ3ZnZfBTgChXQnCFyfUBrhPX5e8M/zFNjSoVGmOABMfhOMMc1VXJeZde9yF
         rkhBC/zlk12GZPYcdOE70ojApWUfJrQ4v8wfHrqZpA5XAHgkgkqr0BJRHbcyKTV9uRWM
         yZunbnmee68SYkDf5V4/Nt2oZmzcf/IUmstH+wxkeEimDPJbvqE9p7Zx5YNXRPqCEw54
         Z8ZJSqV8x7AwD/xypaV8GyHoC46hA1ZkCv7+2DReyqjnduqQHonXixJQXYq22vERL21P
         m8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=51FMChkJehx7pHQ73T1R4wuQ3K5opuWy1ShYWSXgcLc=;
        b=2w3fVDlVDYoYjAyKSc8WA+yJtEX026zHqTBsNVYUCbjo/WCZicsAM6yWLH3jVgjKSr
         vAe3cByN2GUu9XA91cwMJV8n46QLh+IPzYL7gln9UwoqsX0Boh0Qa8XcPeB+Kxo/LVA5
         Upnzi1FCHeemlq+4YM33eAOTg+dV1wFVnv5rmOtDPVw1nN/GbX5nLCcMHsvEM1bsWPBh
         CC/QbSDunCXLDp3LaQpfdIC3EYBz6vvkjqjTcWj+pGyhKLL/zsL4bv4UkjVWR3k4TVUk
         EdNiF8LyTTEltgpkFPSjC3K0hTElKlnH/uvFMPc0jBqXlhsv3e9EM9xtBukVPEUGqOWL
         tjow==
X-Gm-Message-State: AJIora+SerM7rN41AA9VohVyAwF0dCbhWrJVCOy0xIKIddoZG4L1ktpQ
        3Yr1dE5orpYFHLRs/3F0vqG8USqHGYA7/Q==
X-Google-Smtp-Source: AGRyM1sNF6svcWGxSuUx8Ka7ezTADczi0FQJjbOAHkM55oW99hTvyuSUoBOHMICbkM3Ftbz1hcJ25g==
X-Received: by 2002:a17:90b:3c4f:b0:1f0:b59f:8b86 with SMTP id pm15-20020a17090b3c4f00b001f0b59f8b86mr5752596pjb.225.1657816119680;
        Thu, 14 Jul 2022 09:28:39 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mv2-20020a17090b198200b001f0ade18babsm2395855pjb.55.2022.07.14.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:28:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        jinpu.wang@ionos.com, christoph.boehmwalder@linbit.com,
        linux-raid@vger.kernel.org, song@kernel.org, mark@fasheh.com,
        tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, ocfs2-devel@oss.oracle.com,
        joseph.qi@linux.alibaba.com, jack@suse.com, haris.iqbal@ionos.com,
        jlbec@evilplan.org
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
Subject: Re: remove bdevname
Message-Id: <165781611803.623079.18294279066897804471.b4-ty@kernel.dk>
Date:   Thu, 14 Jul 2022 10:28:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Jul 2022 07:53:08 +0200, Christoph Hellwig wrote:
> this series removes the final uses and the implementation of the bdevname()
> function.
> 
> Diffstat:
>  block/bdev.c                        |   10 ++---
>  block/blk-lib.c                     |    6 +--
>  block/genhd.c                       |   23 ------------
>  drivers/block/drbd/drbd_req.c       |    6 +--
>  drivers/block/pktcdvd.c             |   10 +----
>  drivers/block/rnbd/rnbd-srv-dev.c   |    1
>  drivers/block/rnbd/rnbd-srv-dev.h   |    1
>  drivers/block/rnbd/rnbd-srv-sysfs.c |    5 +-
>  drivers/block/rnbd/rnbd-srv.c       |    9 ++---
>  drivers/block/rnbd/rnbd-srv.h       |    3 -
>  drivers/md/md.c                     |    2 -
>  drivers/md/raid1.c                  |    2 -
>  drivers/md/raid10.c                 |    2 -
>  fs/ext4/mmp.c                       |    9 ++---
>  fs/jbd2/journal.c                   |    6 ++-
>  fs/ocfs2/cluster/heartbeat.c        |   64 ++++++++++++++++--------------------
>  include/linux/blkdev.h              |    1
>  kernel/trace/blktrace.c             |    4 +-
>  18 files changed, 62 insertions(+), 102 deletions(-)
> 
> [...]

Applied, thanks!

[1/9] block: stop using bdevname in bdev_write_inode
      commit: 5bf83e9a14ddae994d783dee96b91bf46f04839c
[2/9] block: stop using bdevname in __blkdev_issue_discard
      commit: 02ff3dd20f512cf811ae8028c44fdb212b5f2bf7
[3/9] drbd: stop using bdevname in drbd_report_io_error
      commit: 1b70ccecaed4c3c50239e8409156fb447f965554
[4/9] pktcdvd: stop using bdevname in pkt_seq_show
      commit: fa070a3b50a17506a230e72bd48dba89e7bb5fea
[5/9] pktcdvd: stop using bdevname in pkt_new_dev
      commit: beecf70ee84363e92f3bf783b74da5f26e765d8d
[6/9] rnbd-srv: remove the name field from struct rnbd_dev
      commit: 6e880cf59932a14bca128fc8e8faae0554932942
[7/9] ocfs2/cluster: remove the hr_dev_name field from struct o2hb_region
      commit: 4664954c9421ce326bb5c84f175902b03f17237e
[8/9] ext4: only initialize mmp_bdevname once
      commit: c5b045b9838972cc4c4985a32fa5d35ecf2ab15a
[9/9] block: remove bdevname
      commit: 900d156bac2bc474cf7c7bee4efbc6c83ec5ae58

Best regards,
-- 
Jens Axboe


