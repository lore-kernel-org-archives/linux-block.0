Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221DC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 05:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbiFCFca (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 01:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiFCFc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 01:32:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7150B31374
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 22:32:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t13so8967567wrg.9
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=EGhxoklc9Tv+TTxKxVIJsGhPC/O9A0vKlHcW2n5dCOY=;
        b=pICnoZ8K0mg5rXvaf1/3b+ZJlJNn//rWM67q5UTI+wvxf8MNtqPaGlG5UnwtuzIVF9
         uRjk6ThA+n/YoxYbOVKs4z5PisUkYPVtMuFFHFsgHmAR9O7DvMy4aCzE3Nyd23VJ4fDe
         rP8Nl1camD4Ks4TGQHLHKIzYc0ltooo1C6JhO0ECK/rlyvp/mtft0yO2+Bf6Y7ND7t/5
         UktJl+AtvUFLdZy3rpsLbsMd1x1GrHSitSQW7jMfZ+r+VXFhoXXkRXfKm9DbWkVJhcjs
         78Bw65dOgCtXo9CgS+LrQ8qzXwRW590JjsBMfv1lWJMGNI9QZkP3jzzTB6nufZSKHr9/
         g5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=EGhxoklc9Tv+TTxKxVIJsGhPC/O9A0vKlHcW2n5dCOY=;
        b=tJr7E42fJCWGN4gXMoASB1dxFbMf72C4/7+lEPZHvoUuC/RcaGUBo3LYEVndc5nbWs
         MmbBTLFJdPpVlOOsJkxkNeY0NdHz+cjRCDthkqqDuwi11Q5/kovw9M5Ea6qSZP536Bnt
         QR2B7BsTlB1NeiO45TAbvxV2JzmfwEwabSpOQJwmngV2dQ2VibNs7lML8miUCtcB3uDY
         L7xDd+WS5Fpz2Qkx+oNfPTKCDCl9r+Ja/4YXTk6Ce4jkm8U4//Z0I4BhJrUd5aOfLrJ5
         +xBoDEdifKYkT72yCNqQuuGte+zfKGNflh5CGWHQTZPY2lfuvHQ+bU8YSKH0hepmdUNy
         AQgw==
X-Gm-Message-State: AOAM530duDOOqegAMoge8PbCY++8fi9b/EHVY593/BBzrE2JFT/n7MLw
        cMvR59twt9Ii6ZYaScVuxkgYjXC7RUqVdLUX
X-Google-Smtp-Source: ABdhPJyGrR0Nq+7FTt/oeniKfIZBN2tVAe7gJc3KVrgeiFfnjud2AeJznkUURHg+My6MN5HpNzh4bw==
X-Received: by 2002:a5d:4352:0:b0:213:4910:6616 with SMTP id u18-20020a5d4352000000b0021349106616mr4943527wrr.226.1654234344927;
        Thu, 02 Jun 2022 22:32:24 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d4a8f000000b0020c5253d8edsm6188458wrq.57.2022.06.02.22.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 22:32:24 -0700 (PDT)
Message-ID: <0d5a62fc-6d6a-5dc8-bb15-d494184909b9@kernel.dk>
Date:   Thu, 2 Jun 2022 23:32:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block exec cleanup series
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This change was advertised in the initial core block pull request, but
didn't actually make that branch as we deferred it to a post-merge pull
request to avoid a bunch of cross branch issues.

This series cleans up the block execute path quite nicely.

Please pull!


The following changes since commit bf272460d744112bacd4c4d562592decbf0edf64:

  Merge tag '5.19-rc-smb3-client-fixes-updated' of git://git.samba.org/sfrench/cifs-2.6 (2022-05-27 16:05:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/block-exec-2022-06-02

for you to fetch changes up to e2e530867245d051dc7800b0d07193b3e581f5b9:

  blk-mq: remove the done argument to blk_execute_rq_nowait (2022-05-28 06:15:27 -0600)

----------------------------------------------------------------
for-5.19/block-exec-2022-06-02

----------------------------------------------------------------
Christoph Hellwig (3):
      blk-mq: remove __blk_execute_rq_nowait
      blk-mq: avoid a mess of casts for blk_end_sync_rq
      blk-mq: remove the done argument to blk_execute_rq_nowait

 block/blk-mq.c                     | 109 ++++++++++++++++---------------------
 drivers/block/sx8.c                |   4 +-
 drivers/nvme/host/core.c           |   3 +-
 drivers/nvme/host/ioctl.c          |   3 +-
 drivers/nvme/host/pci.c            |  10 +++-
 drivers/nvme/target/passthru.c     |   3 +-
 drivers/scsi/scsi_error.c          |   5 +-
 drivers/scsi/sg.c                  |   3 +-
 drivers/scsi/st.c                  |   3 +-
 drivers/scsi/ufs/ufshpb.c          |   6 +-
 drivers/target/target_core_pscsi.c |   3 +-
 include/linux/blk-mq.h             |   3 +-
 12 files changed, 75 insertions(+), 80 deletions(-)

-- 
Jens Axboe

