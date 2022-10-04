Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C97DC433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 22:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJDWMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJDWMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 18:12:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1C5C345
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 15:12:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l12so13857909pjh.2
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=7DqxR/qKtk6ps4xalZ1dcZ6Xj4vfAqGCt50HxUw/7Kg=;
        b=7AL2g8wuVL7PNfrFAVdiSnGPRnWUbaVRUv/UlZKulQBHv2U7LGe3OLHfQ3vEQmFlnV
         zKXXT6k7yePy33BpKv1K48iwEIW+s4LZY2UrJp0zqlasac/9q+qVwz9BOtMyhvaq0G5s
         keSH/iRuJ3WvkzAlJ9+NOGJKO71b4pnR46opnCE8tT0sgV/pyZ2WHI6qKltH3TP5YRX4
         E2wK6bowCdFs99YrFtOApmK76O+Eb+IkWvrigx6IRrjq4dtTdRmudFtT90RL4iPaS1lQ
         eK+3vLfZJVoJUgG3Lf56HF4b1ANwDQWnU4pqpcyzMar3/oMUvt8iRY59pocCI+/3Dv7+
         /HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=7DqxR/qKtk6ps4xalZ1dcZ6Xj4vfAqGCt50HxUw/7Kg=;
        b=LQ1y48vZIpzak1cqX5ZfvCf9MAK6+P3MPn1E0brVn7OBL4G9NdMOrvgs8yOy45IuYx
         kWFq+i8Md875vonIxEGk85vLX5HqTnKQMJ4a0N2O6iNkqe/vi8PZcQRnLxIqyxBpBHg7
         LNTJ6vxoVxvRszgAzH1DTvyu8R60dAISUdH6Jdlzeh/UNu5U5qqTH341c8IKRnC55AiA
         g/lcwkKIuCxjo9kiKJjt57O5F3j70C+WYFvSWveBjS6uU3M9d+QHud1AuUJwxomndC6g
         eh6DpLQAuzkDwHi/tuSKk+ft7bz6eWnM8Xxx1dfXCQZIbQI7xF+N3YUCkH66ca1UliVt
         hNSw==
X-Gm-Message-State: ACrzQf1Sbf3Vfiw02ZBLHLxtJmsVVxduIQun2YkQPtuTb/o4bEpxKHvF
        YYA3V1GQWP5P7AKQUugAhiQ6SF9zY6tnqg==
X-Google-Smtp-Source: AMsMyM6OjpZO4EvuhzmTHvk47SOLaIoyUBHPhL76y1d/nf2rUV0ARDnCDxfL62OyG67grK89yvM0KQ==
X-Received: by 2002:a17:90a:dc05:b0:20a:d73b:53a3 with SMTP id i5-20020a17090adc0500b0020ad73b53a3mr1826354pjv.67.1664921531504;
        Tue, 04 Oct 2022 15:12:11 -0700 (PDT)
Received: from ?IPV6:2600:380:4b7a:dece:391e:b400:2f06:c12f? ([2600:380:4b7a:dece:391e:b400:2f06:c12f])
        by smtp.gmail.com with ESMTPSA id f19-20020a63de13000000b00434e1d3b2ecsm8872044pgg.79.2022.10.04.15.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:12:11 -0700 (PDT)
Message-ID: <8bbcb3e9-118c-ea25-a906-24aa28a6c48c@kernel.dk>
Date:   Tue, 4 Oct 2022 16:12:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] v2 Passthrough updates for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the block and io_uring branches, here are a set of updates for
the passthrough support that was merged in the 6.0 kernel. With these
changes, passthrough NVMe support over io_uring now performs at the same
level as block device O_DIRECT, and in many cases 6-8% better. This pull
request contains:

- Add support for fixed buffers for passthrough (Anuj, Kanchan)

- Enable batched allocations and freeing on passthrough, similarly to
   what we support on the normal storage path (me)

- Fix from Geert fixing an issue with !CONFIG_IO_URING

Please pull!


The following changes since commit 30514bd2dd4e86a3ecfd6a93a3eadf7b9ea164a0:

  sbitmap: fix lockup while swapping (2022-09-29 17:58:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.1/passthrough-2022-10-04

for you to fetch changes up to 0e0abad2a71bcd7ba0f30e7975f5b4199ade4e60:

  io_uring: Add missing inline to io_uring_cmd_import_fixed() dummy (2022-10-04 08:13:20 -0600)

----------------------------------------------------------------
for-6.1/passthrough-2022-10-04

----------------------------------------------------------------
Anuj Gupta (6):
      io_uring: add io_uring_cmd_import_fixed
      io_uring: introduce fixed buffer support for io_uring_cmd
      block: add blk_rq_map_user_io
      scsi: Use blk_rq_map_user_io helper
      nvme: Use blk_rq_map_user_io helper
      block: rename bio_map_put to blk_mq_map_bio_put

Geert Uytterhoeven (1):
      io_uring: Add missing inline to io_uring_cmd_import_fixed() dummy

Jens Axboe (8):
      Merge branch 'for-6.1/block' into for-6.1/passthrough
      Merge branch 'for-6.1/io_uring' into for-6.1/passthrough
      block: kill deprecated BUG_ON() in the flush handling
      block: enable batched allocation for blk_mq_alloc_request()
      block: change request end_io handler to pass back a return value
      block: allow end_io based requests in the completion batch handling
      nvme: split out metadata vs non metadata end_io uring_cmd completions
      nvme: enable batched completions of passthrough IO

Kanchan Joshi (6):
      nvme: refactor nvme_add_user_metadata
      nvme: refactor nvme_alloc_request
      block: factor out blk_rq_map_bio_alloc helper
      block: extend functionality to map bvec iterator
      nvme: pass ubuffer as an integer
      nvme: wire up fixed buffer support for nvme passthrough

 block/blk-flush.c                  |  11 +-
 block/blk-map.c                    | 150 ++++++++++++++++---
 block/blk-mq.c                     | 107 ++++++++++++--
 drivers/md/dm-rq.c                 |   4 +-
 drivers/nvme/host/core.c           |   6 +-
 drivers/nvme/host/ioctl.c          | 227 +++++++++++++++++++----------
 drivers/nvme/host/pci.c            |  12 +-
 drivers/nvme/target/passthru.c     |   5 +-
 drivers/scsi/scsi_error.c          |   4 +-
 drivers/scsi/scsi_ioctl.c          |  22 +--
 drivers/scsi/sg.c                  |  31 +---
 drivers/scsi/st.c                  |   4 +-
 drivers/target/target_core_pscsi.c |   6 +-
 drivers/ufs/core/ufshpb.c          |   8 +-
 include/linux/blk-mq.h             |  12 +-
 include/linux/io_uring.h           |  10 +-
 include/uapi/linux/io_uring.h      |   9 ++
 io_uring/uring_cmd.c               |  29 +++-
 18 files changed, 476 insertions(+), 181 deletions(-)

-- 
Jens Axboe
