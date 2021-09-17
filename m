Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D46C611C3
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 14:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhIQOqZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Sep 2021 10:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhIQOpx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Sep 2021 10:45:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D2C061574
        for <linux-block@vger.kernel.org>; Fri, 17 Sep 2021 07:44:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m11so12478166ioo.6
        for <linux-block@vger.kernel.org>; Fri, 17 Sep 2021 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SWqxZwzEUyPyq2OG7ADk/BzT9dxdtgMkalWEWJm0cB8=;
        b=cejR1F0vIacg70wjP5VkXxtm9r3IZcRHoUeVcj/RwdOBgN8rkOlDo0yYmWkB4tVGv5
         fYXCgNH18vGv0CYPSXtqc2rqGTMkhQBfEA1hyUzA0/jdpEEuEkwd7lk7GFvWQYdcptNf
         68kNImTDzTePIUc5Gg6TI7OR/I/o8PwU4q/gIjHbEXCoFnmdHv/7ziHx5Ig2EF78oHPV
         LGzfRk1ypWhPfQT0E1DXU4PUgRU14ec3qwm6oDy9C+f5kGVaMej+27kHJFVEPU2Uk3mV
         yzlmb3YEC+VrhMMZ7FTIuo8tkB5WwoeEtnYWk4pnKazv66OVc8lOvEOOAozCnBm8ElPf
         WUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SWqxZwzEUyPyq2OG7ADk/BzT9dxdtgMkalWEWJm0cB8=;
        b=XjMQ96aGdexOgaHXYJI6/QpP4E7mC0W+wDo7EG6CqN+FbntpW/a4RFdUKsH1+K0myC
         sJlIuWLJMOW7rsFWwHo3X480NGnhR8ForqHYO1ZXqbDjjciGoiWuUHkP1Njx+E1syDEq
         F+zOUknxkkF0M/Jk9v40H1zpYtYj36j89WDC+DTkGxiyKLPEzKmnAI09dSRLcaE6TB7Y
         hMK9qoJ1TrdZo6AX/w0ui/QDDDmGtJqU/a/zYYXB06uTc32V62zM4rePBlX7WdzrD3YJ
         xLmlAhwFGZo0dUN2Iv6ZfWq5Pp38fw9SIwNteyPYh6WNVILLOZfh/elgOMogERRUy5gW
         oF+g==
X-Gm-Message-State: AOAM532ywyfIzk0v7ITAG9yQCGCWOsZUoVjwFl33nHfWNVMamBmMjrSG
        B4td2xerqRcOI1cXcnvzDyeJ7V3erfBTdpd2MPs=
X-Google-Smtp-Source: ABdhPJzksa8LYBLmrkY5gkBZf20ifk3XyVcH1Tf1jhGKRMgKBQaRqR4JRE+aVkiRYO6x6gXObF6bqw==
X-Received: by 2002:a5e:a916:: with SMTP id c22mr1057370iod.211.1631889865625;
        Fri, 17 Sep 2021 07:44:25 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a14sm3669032iol.24.2021.09.17.07.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 07:44:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <56b251c1-3638-40d9-6fee-38b8f3b9bed2@kernel.dk>
Date:   Fri, 17 Sep 2021 08:44:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus

- NVMe pull request via Christoph:
	- fix ANA state updates when a namespace is not present
	  (Anton Eidelman)
	- nvmet: fix a width vs precision bug in
	  nvmet_subsys_attr_serial_show (Dan Carpenter)
	- avoid race in shutdown namespace removal (Daniel Wagner)
	- fix io_work priority inversion in nvme-tcp (Keith Busch)
	- destroy cm id before destroy qp to avoid use after free
	  (Ruozhu Li)

- blk-integrity profile registration fixes (Christoph, Lihong)

- blk-cgroup UAF fix (Li)

- blk-mq tag iterator fix (Ming)

- blkcg memory leak fix (Yanfei)

Please pull!


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-17

for you to fetch changes up to 858560b27645e7e97aca37ee8f232cccd658fbd2:

  blk-cgroup: fix UAF by grabbing blkcg lock before destroying blkg pd (2021-09-15 12:03:18 -0600)

----------------------------------------------------------------
block-5.15-2021-09-17

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix ANA state updates when a namespace is not present

Christoph Hellwig (2):
      block: check if a profile is actually registered in blk_integrity_unregister
      nvme: remove the call to nvme_update_disk_info in nvme_ns_remove

Dan Carpenter (1):
      nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show()

Daniel Wagner (1):
      nvme: avoid race in shutdown namespace removal

Jens Axboe (1):
      Merge tag 'nvme-5.15-2021-09-15' of git://git.infradead.org/nvme into block-5.15

Keith Busch (1):
      nvme-tcp: fix io_work priority inversion

Li Jinlin (1):
      blk-cgroup: fix UAF by grabbing blkcg lock before destroying blkg pd

Lihong Kou (1):
      block: flush the integrity workqueue in blk_integrity_unregister

Ming Lei (1):
      blk-mq: avoid to iterate over stale request

Ruozhu Li (1):
      nvme-rdma: destroy cm id before destroy qp to avoid use after free

Yanfei Xu (1):
      blkcg: fix memory leak in blk_iolatency_init

 block/blk-cgroup.c             | 18 ++++++++++++++----
 block/blk-integrity.c          |  9 ++++++++-
 block/blk-mq-tag.c             |  2 +-
 drivers/nvme/host/core.c       | 17 +++++++----------
 drivers/nvme/host/multipath.c  |  7 +++++--
 drivers/nvme/host/rdma.c       | 16 +++-------------
 drivers/nvme/host/tcp.c        | 20 ++++++++++----------
 drivers/nvme/target/configfs.c |  2 +-
 8 files changed, 49 insertions(+), 42 deletions(-)

-- 
Jens Axboe

