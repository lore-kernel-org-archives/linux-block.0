Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C51FC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 19:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26528204FD
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 19:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dru/c+LT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLTEG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:04:06 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:44524 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDLTEG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 15:04:06 -0400
Received: by mail-pf1-f174.google.com with SMTP id y13so5565056pfm.11
        for <linux-block@vger.kernel.org>; Fri, 12 Apr 2019 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wn/zWfkvPhdjTSsQXnaOQHuKJHJYIks9pTlouOxnq1k=;
        b=Dru/c+LT8O+FvNjvxdvP1/uAHEgZwteK6EDrpJs7NHqWD6h1B2dUzvzuQg6XzV0TeA
         1NrQw8VwVJazs8sEsMdzzHGrJkgaE9+IoTXPOO2hgG7/Fxes9LhNCrfUK34TmjF0FBS3
         EF2XCmzB0YbKN9pips4YMSdABbgey7Zb2m2TcV+NTqELptul93hp5E+tfTEbSSMQnMDL
         bRrPeQY8WX9BdE6y0p/6FTOQ9P3IVcuoI00kLa2urAEZvWdcDlO56TNg7HyWfNtM2rr4
         ELo7OmMP3aek0Wwi+at8HFNYWG4lAPOtjivWCthIZNrz9qm61KZXOb3ZWF1jzQgne5F+
         zbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wn/zWfkvPhdjTSsQXnaOQHuKJHJYIks9pTlouOxnq1k=;
        b=E0jXYbgh6ejydkMjo+WAMSDJR/BUSWe6J0Y0mCAoOR4ssFS1IZN6dZ5+AnqJedtyVo
         cuL2I1QSkjZS+Bi7fzKwKpMRprRQE+feoiX/y32K+fizgBj/LSXwEsDyW2yamkzPuYOA
         P2oYjPSvEas6YKVPhTyMPK0MZ48lIaODrDAR2ZyR/mEg02UJzcZLFaymA7TAnzxxV2G3
         sWIJnOQ8XS78RKuNjrdq+CEaeO3jwKgOFt/rC4dut8qYqucX5Ubw8NJZ7sttjN3zvKdh
         G4OXrgg6GZrht49ZkaFcCsFaosKsvD+h5rmSYqjcfYaDCxokYHPYGIURsFI4VDtnBhBV
         zPYQ==
X-Gm-Message-State: APjAAAW0poOHsqCWsSgeLry4ymmK1XR9rZkB37PjgjnnlavFbqi8yALt
        /15vD6CGirCCTDFP44Hwaer66hESLxf5bA==
X-Google-Smtp-Source: APXvYqyMG9RE8sQHtpRhP9QBlhu1gSaWyeRrIHiamanjtBMt6kizesC0BIgwqdFXePlLpXYnSoaQ3g==
X-Received: by 2002:a62:6c6:: with SMTP id 189mr31213906pfg.36.1555095844990;
        Fri, 12 Apr 2019 12:04:04 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c5sm22233287pgh.5.2019.04.12.12.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 12:04:03 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.1-rc5
Message-ID: <79665835-13af-ad47-14a0-2b377bc356dd@kernel.dk>
Date:   Fri, 12 Apr 2019 13:04:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes that should go into this round. For no particular reason,
this pull is larger than I'd like at this time, but there's really no
specific reason for that. Some are fixes for issues that went into this
merge window, others are not. Anyway, this pull request contains:

- Hardware queue limiting for virtio-blk/scsi (Dongli)

- Multi-page bvec fixes for lightnvm pblk

- Multi-bio dio error fix (Jason)

- Remove the cache hint from the io_uring tool side, since we didn't
  move forward with that (me)

- Make io_uring SETUP_SQPOLL root restricted (me)

- Fix leak of page in error handling for pc requests (Jérôme)

- Fix BFQ regression introduced in this merge window (Paolo)

- Fix break logic for bio segment iteration (Ming)

- Fix NVMe cancel request error handling (Ming)

- NVMe pull request with two fixes (Christoph):
	- fixing the initial CSN for nvme-fc (James)
	- handle log page offsets properly in the target (Keith)

Please pull!


  git://git.kernel.dk/linux-block.git for-linus-20190412


----------------------------------------------------------------
Dongli Zhang (2):
      virtio-blk: limit number of hw queues by nr_cpu_ids
      scsi: virtio_scsi: limit number of hw queues by nr_cpu_ids

Hans Holmberg (1):
      lightnvm: pblk: fix crash in pblk_end_partial_read due to multipage bvecs

James Smart (1):
      nvme-fc: correct csn initialization and increments on error

Jason Yan (1):
      block: fix the return errno for direct IO

Jens Axboe (3):
      tools/io_uring: remove IOCQE_FLAG_CACHEHIT
      io_uring: restrict IORING_SETUP_SQPOLL to root
      Merge branch 'nvme-5.1' of git://git.infradead.org/nvme into for-linus

Jérôme Glisse (1):
      block: do not leak memory in bio_copy_user_iov()

Keith Busch (1):
      nvmet: fix discover log page when offsets are used

Ming Lei (3):
      block: don't use for-inside-for in bio_for_each_segment_all
      blk-mq: introduce blk_mq_complete_request_sync()
      nvme: cancel request synchronously

Paolo Valente (1):
      block, bfq: fix use after free in bfq_bfqq_expire

 block/bfq-iosched.c             | 15 +++++----
 block/bfq-iosched.h             |  2 +-
 block/bfq-wf2q.c                | 17 +++++++++--
 block/bio.c                     |  5 ++-
 block/blk-mq.c                  |  7 +++++
 drivers/block/virtio_blk.c      |  2 ++
 drivers/lightnvm/pblk-read.c    | 50 +++++++++++++++++-------------
 drivers/nvme/host/core.c        |  2 +-
 drivers/nvme/host/fc.c          | 20 +++++++++---
 drivers/nvme/target/admin-cmd.c |  5 +++
 drivers/nvme/target/discovery.c | 68 +++++++++++++++++++++++++++--------------
 drivers/nvme/target/nvmet.h     |  1 +
 drivers/scsi/virtio_scsi.c      |  1 +
 fs/block_dev.c                  |  8 ++---
 fs/io_uring.c                   |  4 +++
 include/linux/bio.h             | 20 +++++++-----
 include/linux/blk-mq.h          |  1 +
 include/linux/bvec.h            | 14 ++++++---
 include/linux/nvme.h            |  9 ++++--
 tools/io_uring/io_uring-bench.c | 32 +++----------------
 20 files changed, 174 insertions(+), 109 deletions(-)

-- 
Jens Axboe

