Return-Path: <SRS0=STaV=D7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE7BC55178
	for <linux-block@archiver.kernel.org>; Sat, 24 Oct 2020 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A1922203
	for <linux-block@archiver.kernel.org>; Sat, 24 Oct 2020 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NIwaFeqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760917AbgJXPNl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Oct 2020 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760887AbgJXPNk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Oct 2020 11:13:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFCDC0613D2
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2020 08:13:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so3400936pgb.10
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2020 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zUwaF3AB/p05a8vNXvDYSk/Y6Yum2elBwnLT3bgucBE=;
        b=NIwaFeqzcnEl5QPdTuGHMeuWSpZ8UGVqkpvDWWmcB976OI6w40okiAoysAdPWaf3xI
         vS7gV+4WW1WxgzN2jol+4s0zYo9uZKLO1XAYCceHwejwLMnm7lmiWdHHAoSu+61NnA1Q
         QoVkDRZ9PBTRzWjLi4Qx+Ad+CX9F1iJLk6hi3nIcrXWLYnx8HmUeCt7Y0+Ee0C9gGSJ5
         zzVoMh9Gs9dv925Sb/mIOJeMJuVvIRaqoFr6U2ISjOZgyJZ8oBhaMuzJXSLz8crP0WOn
         qyEz+/SBndLu4nMMcMeAQWVw2p+fJvOHteCz5xHgI6JjiUE1jsMu59BkW4sGBoD2n6Cl
         FgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zUwaF3AB/p05a8vNXvDYSk/Y6Yum2elBwnLT3bgucBE=;
        b=fA8iHm+aE0n6QOJVAN4yleRjxegPHR2+fb8Sqb1jWc7vsvAUevzUXtptkQUyEj/rnp
         GUJdvdcYfjKpS+DkJQPw+i7Fk5Xl53hGKoehEP04Sx152tJQ1PSNu+UzEAa2vWp0eS6Q
         AzHjpUMaZ73TEIzfRVz8GCin9t7kfeSy1rO25PRLNzH8eVAz7hzMPDwclvBdCVmK3Oqh
         MKFgAjKIK6z4hPdAx74A0WwmdtYPowjHojMZqwv+Gcq3VWo9mysfuk+t5bY4cpwEtw7t
         UxEJkmsfz+ysoDEb7MHe9UyXWoOnVeVbw+xG/jX2hxu2+aX3rBR84bIA0Ie8j0uqdhp+
         /cTg==
X-Gm-Message-State: AOAM53143nImdsAWRcGea4CxhUaeBeNW14gpYXnBaALsk5oFiX++MhMz
        e5bMN0HD/azkFnVofaVzwlPsW4yRIDpfFA==
X-Google-Smtp-Source: ABdhPJyPzZluKz+Kwc+TcwyxsG/TC5k5ojyOSoWnvoYwRtzk0rF779/YL/s4iIyKsvRNsiGgpge0/g==
X-Received: by 2002:a63:d758:: with SMTP id w24mr6313774pgi.143.1603552418163;
        Sat, 24 Oct 2020 08:13:38 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j24sm6687888pjn.9.2020.10.24.08.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 08:13:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <a73a849f-4818-e083-40f3-c61c662e76e9@kernel.dk>
Date:   Sat, 24 Oct 2020 09:13:36 -0600
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

Block fixes that should go into -rc1:

- NVMe pull request from Christoph
     - rdma error handling fixes (Chao Leng)
     - fc error handling and reconnect fixes (James Smart)
     - fix the qid displace when tracing ioctl command (Keith Busch)
     - don't use BLK_MQ_REQ_NOWAIT for passthru (Chaitanya Kulkarni)
     - fix MTDT for passthru (Logan Gunthorpe)
     - blacklist Write Same on more devices (Kai-Heng Feng)
     - fix an uninitialized work struct (zhenwei pi)"

- lightnvm out-of-bounds fix (Colin)

- SG allocation leak fix (Doug)

- rnbd fixes (Gioh, Guoqing, Jack)

- zone error translation fixes (Keith)

- kerneldoc markup fix (Mauro)

- zram lockdep fix (Peter)

- Kill unused io_context members (Yufen)

- NUMA memory allocation cleanup (Xianting)

- NBD config wakeup fix (Xiubo)

Please pull!


The following changes since commit 029f56db6ac248769f2c260bfaf3c3c0e23e904c:

  Merge tag 'x86_asm_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-10-13 13:36:07 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-24

for you to fetch changes up to 24f7bb8863eb63b97ff7a83e6dd0d188a1c0575e:

  block: blk-mq: fix a kernel-doc markup (2020-10-23 12:20:17 -0600)

----------------------------------------------------------------
block-5.10-2020-10-24

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru

Chao Leng (2):
      nvme-rdma: fix crash when connect rejected
      nvme-rdma: fix crash due to incorrect cqe

Colin Ian King (1):
      lightnvm: fix out-of-bounds write to array devices->info[]

Damien Le Moal (1):
      scsi: handle zone resources errors

Douglas Gilbert (1):
      sgl_alloc_order: fix memory leak

Gioh Kim (1):
      block/rnbd-clt: send_msg_close if any error occurs after send_msg_open

Guoqing Jiang (1):
      block/rnbd-clt: remove nr argument from send_usr_msg

Jack Wang (1):
      block/rnbd-clt: do not cap max_hw_sectors & max_segments with remote device

James Smart (4):
      nvme-fc: fix io timeout to abort I/O
      nvme-fc: fix error loop in create_hw_io_queues
      nvme-fc: wait for queues to freeze before calling update_hr_hw_queues
      nvme-fc: shorten reconnect delay if possible for FC

Jens Axboe (1):
      Merge tag 'nvme-5.10-2020-10-23' of git://git.infradead.org/nvme into block-5.10

Kai-Heng Feng (1):
      nvme-pci: disable Write Zeroes on Sandisk Skyhawk

Keith Busch (4):
      block: add zone specific block statuses
      nvme: translate zone resource errors
      nvme: use queuedata for nvme_req_qid
      null_blk: use zone status for max active/open

Logan Gunthorpe (2):
      nvmet: limit passthru MTDS by BIO_MAX_PAGES
      nvmet: cleanup nvmet_passthru_map_sg()

Mauro Carvalho Chehab (1):
      block: blk-mq: fix a kernel-doc markup

Peter Zijlstra (1):
      zram: Fix __zram_bvec_{read,write}() locking order

Tian Tao (1):
      skd_main: remove unused including <linux/version.h>

Xianting Tian (1):
      blk-mq: remove the calling of local_memory_node()

Xiubo Li (1):
      nbd: make the config put is called before the notifying the waiter

Yufen Yu (1):
      block: remove unused members for io_context

zhenwei pi (1):
      nvmet: fix uninitialized work for zero kato

 Documentation/block/queue-sysfs.rst |   8 +++
 block/blk-core.c                    |   4 ++
 block/blk-mq-cpumap.c               |   2 +-
 block/blk-mq.c                      |   4 +-
 drivers/block/nbd.c                 |   2 +-
 drivers/block/null_blk_zoned.c      |  69 +++++++++++-------
 drivers/block/rnbd/rnbd-clt.c       |  19 +++--
 drivers/block/skd_main.c            |   1 -
 drivers/block/zram/zram_drv.c       |   8 ++-
 drivers/lightnvm/core.c             |   5 +-
 drivers/nvme/host/core.c            |   4 ++
 drivers/nvme/host/fc.c              | 138 ++++++++++++++++++++++++------------
 drivers/nvme/host/nvme.h            |   2 +-
 drivers/nvme/host/pci.c             |   2 +
 drivers/nvme/host/rdma.c            |   6 +-
 drivers/nvme/target/core.c          |   3 +-
 drivers/nvme/target/passthru.c      |  18 +++--
 drivers/scsi/scsi_lib.c             |   9 +++
 include/linux/blk_types.h           |  18 +++++
 include/linux/iocontext.h           |   6 --
 lib/scatterlist.c                   |   2 +-
 21 files changed, 222 insertions(+), 108 deletions(-)

-- 
Jens Axboe

