Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA09EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 17:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiFQRLo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383145AbiFQRLn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 13:11:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2A48E73
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 10:11:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so3528515pjm.4
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=CEY3cvzXVZJD5gWpnHz8TFCAY66BKdISdZGXy0oNJ+c=;
        b=mvhceEfMc7D2LMySjb/Fv5DfeJZgSXv7kXsjLOBQiyxo4wMspJiQq8YHfoxJE+j+C7
         CINxkvCiVms+5iDxO+vSGli2Ng7ERhcMc6vgxBtpg5z/ctWWD8MVEh6vTuu01FgD5z0H
         iHW+QCWN7B4EK/0pYr7dzXt6q0yBOAj4IS3wSrPHJiYJWpMbPcidqNfMGEDifH0Y3c2a
         Vns+IVyiU9Y65m+bjudDpN5pVRG8/bBdyAt7mx7u76WroCndwHDLNUaEbeFPrqXUCdRV
         YUJ0Fs3PokWEfVKBilVu033yof2WqrF7P/ZkjFd4xEoZelmEe7/LFZlLWoeHs9ko+nhB
         7Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=CEY3cvzXVZJD5gWpnHz8TFCAY66BKdISdZGXy0oNJ+c=;
        b=jH3lCUgqXsNMzZRJITPNozTZsEia5oBg2F9fatsiUT8dv4gGqEk6AB/fgMs84Cj9L7
         ruLyqGt1O9bf+aFtGaPhieyoB3/kVv+Hg3MAfa1tax0hpOPssNMYPE9KMAnKPPTO3eV/
         Go8Btqiw4JzZK1jUNlShmvls5sO5wMgP76nVXEnGMTTW+5OiAa5uhxnaOMrs10pr27ry
         7/Y/6oqVHh9Vy2eyQ7jMIb/BlTPPLX4UVILMAum/wry2o6Z8oHIDzIk2D69SY8HbmxXP
         Uycorg2WEbeCcT8AZrb0O+NDO4jAglEsQgFI2723jjuUt0pPQ6FoHWiHWM4nqvIXPkPf
         Z42A==
X-Gm-Message-State: AJIora8uYURmAx0EfU2RzbuGE/8HbeiIAvyhLnBnpTyJEZPwn7c+vLvd
        Ajdgo7RVgnjfUvyDiMI8cX4B75VuYi80lw==
X-Google-Smtp-Source: AGRyM1tp+g1zq1R15LDasIB4ZwZNd2L1eSOtqYPYp76Uf22z6PHkT2q2eE0/bGKi+e2Dh2HkX6RC0g==
X-Received: by 2002:a17:90b:508a:b0:1ec:73d9:a143 with SMTP id rt10-20020a17090b508a00b001ec73d9a143mr5133516pjb.71.1655485901629;
        Fri, 17 Jun 2022 10:11:41 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ms24-20020a17090b235800b001e270cc443dsm5805887pjb.46.2022.06.17.10.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 10:11:41 -0700 (PDT)
Message-ID: <de7e4802-15b6-fbe7-f793-4454c3913f6a@kernel.dk>
Date:   Fri, 17 Jun 2022 11:11:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.19-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Block fixes for 5.19-rc3:

- NVMe pull request from Christoph
	- Quirks, quirks, quirks to work around buggy consumer grade
	  devices (Keith Bush, Ning Wang, Stefan Reiter, Rasheed Hsueh)
	- Better kernel messages for devices that need quirking
	  (Keith Bush)
	- Make a kernel message more useful (Thomas Weißschuh)

- MD pull request from Song, with a few fixes

- blk-mq sysfs locking fixes (Ming)

- BFQ stats fix (Bart)

- blk-mq offline queue fix (Bart)

- blk-mq flush request tag fix (Ming)

Please pull!


The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.19-2022-06-16

for you to fetch changes up to b96f3cab59654ee2c30e6adf0b1c13cf8c0850fa:

  block/bfq: Enable I/O statistics (2022-06-16 16:59:28 -0600)

----------------------------------------------------------------
block-5.19-2022-06-16

----------------------------------------------------------------
Bart Van Assche (2):
      block: Fix handling of offline queues in blk_mq_alloc_request_hctx()
      block/bfq: Enable I/O statistics

Guoqing Jiang (1):
      Revert "md: don't unregister sync_thread with reconfig_mutex held"

Jens Axboe (2):
      Merge tag 'nvme-5.19-2022-06-15' of git://git.infradead.org/nvme into block-5.19
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19

Keith Busch (5):
      nvme: add bug report info for global duplicate id
      nvme-pci: add trouble shooting steps for timeouts
      nvme-pci: phison e12 has bogus namespace ids
      nvme-pci: smi has bogus namespace ids
      nvme-pci: sk hynix p31 has bogus namespace ids

Logan Gunthorpe (1):
      md/raid5-ppl: Fix argument order in bio_alloc_bioset()

Ming Lei (3):
      blk-mq: protect q->elevator by ->sysfs_lock in blk_mq_elv_switch_none
      blk-mq: avoid to touch q->elevator without any protection
      blk-mq: don't clear flush_rq from tags->rqs[]

Ning Wang (1):
      nvme-pci: avoid the deepest sleep state on ZHITAI TiPro7000 SSDs

Stefan Reiter (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S50

Thomas Weißschuh (1):
      nvme: add device name to warning in uuid_show()

rasheed.hsueh (1):
      nvme-pci: disable write zeros support on UMIC and Samsung SSDs

 block/bfq-iosched.c      |  6 ++++++
 block/blk-mq-sched.c     |  1 +
 block/blk-mq.c           | 29 ++++++++++-------------------
 block/kyber-iosched.c    |  3 ++-
 block/mq-deadline.c      |  3 +++
 drivers/md/dm-raid.c     |  2 +-
 drivers/md/md.c          | 14 +++++---------
 drivers/md/md.h          |  2 +-
 drivers/md/raid5-ppl.c   |  4 ++--
 drivers/nvme/host/core.c |  5 +++--
 drivers/nvme/host/nvme.h | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h   |  4 ++--
 13 files changed, 106 insertions(+), 38 deletions(-)

-- 
Jens Axboe

