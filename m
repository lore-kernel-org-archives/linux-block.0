Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27EC433FE
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438CB60E8F
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhJaTol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhJaTol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:41 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCF6C061746
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f9so19046202ioo.11
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zIlVG/U4RIthE6KpwQMHD2gGdoCBOk2ZMIiKhIrkFbs=;
        b=C21s3XtD+5qVCgTWVcZT7crNi4BPg1Q5y4R/yyl9MSnGgbeRlqJUeT6SY4wiMDIB2R
         +EV4PzGAFdM2+8qKuosm2iy5I87QmoUXAHf+tQN8fZUL4Y02t29cnrmpnNbup2nmt6ll
         6DV3nnCAtZ07iG2HLGMFocdMZSj8sVPWnfTQlza2H3BZSouQiQUIoBgvjOxTSaMf4l0+
         Nbex8aHX003uXuE2AxCavEcrcprHwFclAUvvRRm+zP8PJ8VB93DR2dN8ZjkwCBvAVojd
         RKg+65TTaS+UNVREMARhgkEKuiVvs1btvtIVcmEDuf5eVTGw0STg6tE8QUUDDj4ACMFq
         pnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zIlVG/U4RIthE6KpwQMHD2gGdoCBOk2ZMIiKhIrkFbs=;
        b=Z27l92dJMDiBDeABSYAP61Kj06FvN/a74zOD30x3kEn/Kf2Jkr8QyljFOycsqCmkFb
         n6B7DQImenJljjR5DzRDFAdd1LDVwcCnRMHxez9HRJLYUgUdfToRXd2EccJ5eVCjREmR
         kjCwrfoKBUBLcmWab8rAErwoYxEWVNlVJcROe/KF2/tA/tk0s4Ps+Ec+htXvS0MmHFkc
         NdKtNOHjjJgQIh4yFEwdljAth57ZfjLu4oxHF+YHwKyrHxPXqR/T1MRkn9tLLhAvmVnE
         PGGMhCetZmmfKoBSOyIpzo8xhvSEN3GEuYe2NRof33fOCR8C9hfaybpkip30RIC2KqK0
         TvHw==
X-Gm-Message-State: AOAM533lQqQqJyjzBM4xxEIwjTp0cHDuOmXr6JSk2iGiWhrhKbrvSxEz
        1pgEfuzHOqp9FX6+HOxcz8C83cuxwZpitQ==
X-Google-Smtp-Source: ABdhPJzwtwxpCa/i+3LkPbxPSxNkfA/1m9SSc20612KwWtZs21cBStOgT84aEIDO2h+6cL41c6d+5w==
X-Received: by 2002:a5d:8b94:: with SMTP id p20mr17145429iol.146.1635709327178;
        Sun, 31 Oct 2021 12:42:07 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b4sm6707533iot.45.2021.10.31.12.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:42:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Remove QUEUE_FLAG_SCSI_PASSTHROUGH
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <24663413-71ff-33be-e874-a0852cad343a@kernel.dk>
Date:   Sun, 31 Oct 2021 13:42:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block branch, this pull request contains a series
leading to the removal of the QUEUE_FLAG_SCSI_PASSTHROUGH queue flag.

As a matter of convenience, due to potential merge conflicts, the last
patch is not strictly related and just removes two wrapper functions we
have for request allocation/freeing.

Please pull!


The following changes since commit 8e9f666a6e66d3f882c094646d35536d2759103a:

  blk-crypto: update inline encryption documentation (2021-10-21 10:49:32 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/passthrough-flag-2021-10-29

for you to fetch changes up to 0bf6d96cb8294094ce1e44cbe8cf65b0899d0a3a:

  block: remove blk_{get,put}_request (2021-10-29 06:50:52 -0600)

----------------------------------------------------------------
for-5.16/passthrough-flag-2021-10-29

----------------------------------------------------------------
Christoph Hellwig (8):
      block: add a ->get_unique_id method
      sd: implement ->get_unique_id
      nfsd/blocklayout: use ->get_unique_id instead of sending SCSI commands
      bsg-lib: initialize the bsg_job in bsg_transport_sg_io_fn
      scsi: add a scsi_alloc_request helper
      block: remove the initialize_rq_fn blk_mq_ops method
      block: remove QUEUE_FLAG_SCSI_PASSTHROUGH
      block: remove blk_{get,put}_request

 block/blk-core.c                   |  28 -------
 block/blk-mq-debugfs.c             |   1 -
 block/bsg-lib.c                    |  32 +++-----
 drivers/block/Kconfig              |   2 +-
 drivers/block/paride/pd.c          |   4 +-
 drivers/block/pktcdvd.c            |   9 ++-
 drivers/block/virtio_blk.c         |   4 +-
 drivers/md/dm-mpath.c              |   4 +-
 drivers/mmc/core/block.c           |  20 ++---
 drivers/scsi/scsi_bsg.c            |   6 +-
 drivers/scsi/scsi_error.c          |   4 +-
 drivers/scsi/scsi_ioctl.c          |   8 +-
 drivers/scsi/scsi_lib.c            |  29 +++++--
 drivers/scsi/scsi_scan.c           |   1 -
 drivers/scsi/sd.c                  |  39 +++++++++
 drivers/scsi/sg.c                  |  10 +--
 drivers/scsi/sr.c                  |   4 +-
 drivers/scsi/st.c                  |   6 +-
 drivers/scsi/ufs/ufshcd.c          |  20 ++---
 drivers/scsi/ufs/ufshpb.c          |   8 +-
 drivers/target/target_core_pscsi.c |   7 +-
 fs/nfsd/Kconfig                    |   1 -
 fs/nfsd/blocklayout.c              | 158 ++++++++++---------------------------
 fs/nfsd/nfs4layouts.c              |   5 +-
 include/linux/blk-mq.h             |   8 --
 include/linux/blkdev.h             |  14 +++-
 include/scsi/scsi_cmnd.h           |   3 +
 27 files changed, 191 insertions(+), 244 deletions(-)

-- 
Jens Axboe

