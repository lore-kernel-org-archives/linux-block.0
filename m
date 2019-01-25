Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4973BC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 20:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0272B2184C
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 20:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jahQ99d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfAYUvf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:51:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37525 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYUvf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 15:51:35 -0500
Received: by mail-io1-f67.google.com with SMTP id g8so8824389iok.4
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NWvYiafXWIr2YoTmrbQ8NwZvqsgopnJJzq2QLWvcwAk=;
        b=jahQ99d15NeFpQSrjMzUfWIXXTzqzxEVVDmOCm62eX6EmGpXSaKQ9I2YWv9t49Xwex
         HeKAwvrOES8U2K3N6Z1A5V0ZQJzyPlOUvjo78ArenDvObk/5N+j2wIbHRs6Kk0mskyv6
         nCIgTWklqWGKJAqZijmxJuTPWwmgGfiw1lQSMwj0yh+lsIKVU4jk/jg8J69xpdtU0DgR
         KyhHtjULtlDACp5jWXijdmU57WNruo+pB4p1vor+g1bRXSOdoQrCERJXI5CInYLHSSuX
         6tDqaK7kV6l4jfChLqTJobOspP/PY0evlzEfJuHRQ46nlbuP3QkRLfnf3mAPJtLZBTDa
         Z4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NWvYiafXWIr2YoTmrbQ8NwZvqsgopnJJzq2QLWvcwAk=;
        b=QqtJYDAUR5UWK0I8X92t2quQV5Q7QhmqrMXK+CbSaCNCZsxu9pmL4z1BPurBdMSqRr
         2vd7bDzO4jIDsjLdHCvTLec1lIjlvOs1fBeA+CS1om04mcPR5w52nnA33gVmFFnc7QD1
         67pSetvPkKHvO7w+Plx7j7ua4ravDqdVYv5wVucTIOIGezMiGCNMCLQRkLNb7fSsv5j4
         xLevps20/ZFn0BZhtDmghtTPN3qJVImero40Xrwc8iwkYZ2LjrFHE3/7Ves9JbdtQdlL
         4fBRza0rmUFITPrA+MtFUKtTWjBUrr+KsTNZ6fDt+tuA94yG0qLbN3D21i05lX+72VaX
         uJrw==
X-Gm-Message-State: AJcUukdRTVR7RbT6YCTSd7asDw0WgjSi2jhLyeyJW9k9P1Wg2w1ARMIb
        6qCnHiB8RiJCiWI/L4CKsX2XzJjcT88=
X-Google-Smtp-Source: ALg8bN6+G6jhX964gQYoNaNDp+Pm2ruibILUR6046069JpftLespCe/1uuK+KFQCY0/VGHmiHyB8Ug==
X-Received: by 2002:a6b:3fd7:: with SMTP id m206mr7312945ioa.210.1548449491561;
        Fri, 25 Jan 2019 12:51:31 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w26sm10571630iol.60.2019.01.25.12.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 12:51:30 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.0-rc4
Message-ID: <8755a2bb-c583-1b2a-c94e-e2d1cef78035@kernel.dk>
Date:   Fri, 25 Jan 2019 13:51:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A collection of fixes for this release. This pull request contains:

- Silence sparse rightfully complaining about non-static wbt functions
  (Bart)

- Fixes for the zoned comments/ioctl documentation (Damien)

- direct-io fix that's been lingering for a while (Ernesto)

- cgroup writeback fix (Tejun)

- Set of NVMe patches for nvme-rdma/tcp (Sagi, Hannes, Raju)

- Block recursion tracking fix (Ming)

- Fix debugfs command flag naming for a few flags (Jianchao)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190125


----------------------------------------------------------------
Bart Van Assche (1):
      blk-wbt: Declare local functions static

Damien Le Moal (2):
      uapi: fix ioctl documentation
      block: Fix comment typo

Ernesto A. Fernández (1):
      direct-io: allow direct writes to empty inodes

Hannes Reinecke (1):
      nvme-multipath: drop optimization for static ANA group IDs

Jianchao Wang (1):
      blk-mq: fix the cmd_flag_name array

Ming Lei (1):
      block: cover another queue enter recursion via BIO_QUEUE_ENTERED

Raju Rangoju (1):
      nvmet-rdma: fix null dereference under heavy load

Sagi Grimberg (3):
      nvme-rdma: fix timeout handler
      nvme-tcp: fix timeout handler
      nvme-rdma: rework queue maps handling

Tejun Heo (1):
      writeback: synchronize sync(2) against cgroup writeback membership switches

 block/blk-core.c                 | 11 +++++++
 block/blk-merge.c                | 10 -------
 block/blk-mq-debugfs.c           |  3 +-
 block/blk-wbt.c                  |  4 +--
 drivers/nvme/host/multipath.c    |  3 +-
 drivers/nvme/host/rdma.c         | 64 +++++++++++++++++++++++++++-------------
 drivers/nvme/host/tcp.c          | 19 +++++++-----
 drivers/nvme/target/rdma.c       | 15 +++++++++-
 fs/direct-io.c                   |  5 ++--
 fs/fs-writeback.c                | 40 +++++++++++++++++++++++--
 include/linux/backing-dev-defs.h |  1 +
 include/linux/blk_types.h        |  2 +-
 include/uapi/linux/blkzoned.h    |  1 +
 mm/backing-dev.c                 |  1 +
 14 files changed, 129 insertions(+), 50 deletions(-)
-- 
Jens Axboe

