Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02745C433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiBXRa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiBXRaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 12:30:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91964186B9E
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 09:30:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m11so2369934pls.5
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 09:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=HUNJyvAYPAhhXvdopkr0/88WB03DrbYVmjwXZpfGIJo=;
        b=V4SXqyQhdkUOZ6qTyUNbBG7ml5Y9QdCMLXlkTclFikcYKkIWw2FIGiQA73dQ0wGCjz
         GIyKcAoGx1irXTINPYAzInNqOf0GDazeii/AstN3dr1i1HLk8HMIOr2jXxTpERvOMmLa
         EzrdyNAuOh+tFYo5Ic6/x6VfnC8xBavQTjafPbqnxjzz+efa8Fk5EhlBsqLbgzUXaNro
         iainDu1a3XmOANMmf3XbAE7W7uyu2gOEdNHGPf1irIDbdWrDu8Wn8erxzum1TocD5kv2
         PVMSjANhRcSJfNI7eSvQvRBkrmn/RQ+29D6vqQEJnUd3i1yLP3l8A1yQl9Wld++2cm5f
         Xsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=HUNJyvAYPAhhXvdopkr0/88WB03DrbYVmjwXZpfGIJo=;
        b=yBqTPMBQiwEQvMhJFzSp6KW65p2QuB22atqi4BtCQ/WIuK6iPxp/bwb/E2AmiuEefR
         A1ynm3Fypw35dPNdMdkCRNeVOdv5qQi1RHbArvbwiwi1vZCukoshYjTIG2+mFJzIZRTd
         Y7R49TPQ1lJFApmMTpkxItxlgXkuXaWayKMecewP+doP6fFYOTvcvuiNRz34tbu1Iicx
         IxAq+Zmtvl1AEnvfEpI4RlIeUw+j3uR65VRrrFqtMfFe2jhWD6/jDI2PCg05ZUhKSMmC
         w2ZPTENJBVdxqCRInCYuZW9wAJ1GAx82Y0j6Ub3CgySa1XNJhJGB9rImmw1sMD3cYl0u
         cnDg==
X-Gm-Message-State: AOAM533Z9A710rYlIi3vbcpQzNguklZaooDxCUs3EWQCB+pOvmgOnhMj
        C69FL+qS5sYPflECCpeSCPvmypHRn1WzKg==
X-Google-Smtp-Source: ABdhPJy/2eYML5iu/ANJsqkGOF6oxFl6TZe35JQPiIo4WEFq2pxyAOa9vb0HXq70MTGh6pj33P+i0Q==
X-Received: by 2002:a17:903:1249:b0:14e:e477:5019 with SMTP id u9-20020a170903124900b0014ee4775019mr3847618plh.53.1645723824910;
        Thu, 24 Feb 2022 09:30:24 -0800 (PST)
Received: from [192.168.4.157] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b3-20020a056a00114300b004cc39630bfcsm30723pfm.207.2022.02.24.09.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:30:24 -0800 (PST)
Message-ID: <f2985ee4-cf5a-431e-2d11-8bd9c9d4e8fa@kernel.dk>
Date:   Thu, 24 Feb 2022 10:30:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.17-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- NVMe pull request
	- send H2CData PDUs based on MAXH2CDATA (Varun Prakash)
	- fix passthrough to namespaces with unsupported features
	  (Christoph Hellwig)

- Clear iocb->private at poll completion (Stefano)

Please pull!


The following changes since commit e92bc4cd34de2ce454bdea8cd198b8067ee4e123:

  block/wbt: fix negative inflight counter when remove scsi device (2022-02-17 07:54:03 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-24

for you to fetch changes up to b2750f14007f0e1b36caf51058c161d2c93e63b6:

  Merge tag 'nvme-5.17-2022-02-24' of git://git.infradead.org/nvme into block-5.17 (2022-02-24 07:02:15 -0700)

----------------------------------------------------------------
block-5.17-2022-02-24

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: don't return an error from nvme_configure_metadata
      nvme: also mark passthrough-only namespaces ready in nvme_update_ns_info

Jens Axboe (1):
      Merge tag 'nvme-5.17-2022-02-24' of git://git.infradead.org/nvme into block-5.17

Stefano Garzarella (1):
      block: clear iocb->private in blkdev_bio_end_io_async()

Varun Prakash (1):
      nvme-tcp: send H2CData PDUs based on MAXH2CDATA

 block/fops.c             |  2 ++
 drivers/nvme/host/core.c | 19 ++++++---------
 drivers/nvme/host/tcp.c  | 63 +++++++++++++++++++++++++++++++++++++-----------
 include/linux/nvme-tcp.h |  1 +
 4 files changed, 60 insertions(+), 25 deletions(-)

-- 
Jens Axboe

