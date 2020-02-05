Return-Path: <SRS0=z7Fj=3Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63ECC35247
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7625C2072B
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 21:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QE5jJxyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBEVWC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:22:02 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46378 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBEVWB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Feb 2020 16:22:01 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so3136618ilm.13
        for <linux-block@vger.kernel.org>; Wed, 05 Feb 2020 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iIGSDF+vs90mNXEmT61srPqAn44AWQtWxQPhmFu+gUA=;
        b=QE5jJxylgdkv85n7ZTcA+QS3vt0s5WNLpvNpBfX9xZJI3CKniQMCHpEUy51hsZ9+s6
         w5ZILk0pLsCx4OoItqeoYrtKxIP1AhPRGfjJeZmrh849dHxhwiQNYHYVoFFBXPqE63Br
         ygkfe4XQvpXmEewbUmiFJU2aCfT2NX+Csu4GHyAGKRlnuBfq3At5Bolp33W4oM0/piqd
         pLi53Nx58aqMQCD3yqXbD/tR1FtKQF+AUkGLpmACdyMngKToExCW9U1fwQslC1Wvya+B
         tgA1yB9k98y7XbRtr8L6Y3/9DG8IlQxudcIVM+MIXoWxiU35BVM5aTghkTaK5wLfPYp3
         tUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iIGSDF+vs90mNXEmT61srPqAn44AWQtWxQPhmFu+gUA=;
        b=OXXNuHB9nT+jmxgJ1rhpKAbFTtA6m3sTlFwI0cLwB5IZ/I/VCTt3FSsQaFRjRJLhK5
         Fy1hC1AyyZwZbVsM/pn4M9mpoGyi64MZQJLE35WGYJdHtSbJ8xUpiiSHGsC3f3uII7kx
         Y1tMEpkhChgUJG4Yy1d7KYpv4mho94crPEbB9PZ+60TE/sCb+hiiIQXZ7pscM/h3tKoe
         F6FM6PurUD/1nu3xckKG+ZiLX+fpsCKOnBbOg+neKWYST6UuuRTUomFH6e+enezSI/5V
         mAVITOlnRzqD/csf/ZM09jPNCib7T3Dli/i0zScLJ9Xt6cy/RtWCWMmV0wDmk9B10Jhh
         vQOw==
X-Gm-Message-State: APjAAAVN7OQlyvXpt5YK2gGVfkKi3c9QQt4kmXueC48YpWmcKkF0nr/B
        sLNxL9AiHRhwIiGYWfZp+oR8MjVz2xQ=
X-Google-Smtp-Source: APXvYqxHQax2PCBxuUtOztXKedYk7Gpu1UvhmpJbQ0jkTQir15yb6gHglBzJx2zeF4u40BJcoShpYg==
X-Received: by 2002:a92:3611:: with SMTP id d17mr173386ila.264.1580937720894;
        Wed, 05 Feb 2020 13:22:00 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r22sm286505ilb.25.2020.02.05.13.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 13:22:00 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.6-rc1
Message-ID: <46878e95-2ae8-e05d-416c-237df0c1f62f@kernel.dk>
Date:   Wed, 5 Feb 2020 14:21:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Followup pull request for block for this merge window. Some later
arrivals, but all fixes at this point. This pull request contains:

- bcache fix series (Coly)

- Series of BFQ fixes (Paolo)

- NVMe pull request from Keith with a few minor NVMe fixes

- Various little tweaks

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.6-2020-02-05


----------------------------------------------------------------
Amol Grover (1):
      nvmet: Pass lockdep expression to RCU lists

Christoph Hellwig (1):
      nvme-pci: remove nvmeq->tags

Coly Li (5):
      bcache: fix memory corruption in bch_cache_accounting_clear()
      bcache: explicity type cast in bset_bkey_last()
      bcache: add readahead cache policy options via sysfs interface
      bcache: fix incorrect data type usage in btree_flush_write()
      bcache: check return value of prio_read()

Daniel Wagner (1):
      nvmet: update AEN list and array at one place

Israel Rukshin (2):
      nvmet: Fix error print message at nvmet_install_queue function
      nvmet: Fix controller use after free

Jens Axboe (1):
      Merge branch 'nvme-5.6' of git://git.infradead.org/nvme into block-5.6

Jon Derrick (1):
      MAINTAINERS: Add Revanth Rajashekar as a SED-Opal maintainer

Juergen Gross (1):
      xen/blkfront: limit allocated memory size to actual use case

Paolo Valente (7):
      block, bfq: do not plug I/O for bfq_queues with no proc refs
      block, bfq: do not insert oom queue into position tree
      block, bfq: get extra ref to prevent a queue from being freed during a group move
      block, bfq: extend incomplete name of field on_st
      block, bfq: remove ifdefs from around gets/puts of bfq groups
      block, bfq: get a ref to a group when adding it to a service tree
      block, bfq: clarify the goal of bfq_split_bfqq()

Sagi Grimberg (1):
      nvmet: fix dsm failure when payload does not match sgl descriptor

Stephen Kitt (1):
      drbd: fifo_alloc() should use struct_size

Sun Ke (1):
      nbd: add a flush_workqueue in nbd_start_device

Zhiqiang Liu (1):
      brd: check and limit max_part par

 MAINTAINERS                        |  2 +-
 block/bfq-cgroup.c                 | 16 +++++++-
 block/bfq-iosched.c                | 26 ++++++++++---
 block/bfq-iosched.h                |  4 +-
 block/bfq-wf2q.c                   | 23 ++++++++---
 drivers/block/brd.c                | 22 ++++++++++-
 drivers/block/drbd/drbd_int.h      |  2 +-
 drivers/block/drbd/drbd_nl.c       |  3 +-
 drivers/block/drbd/drbd_receiver.c |  2 +-
 drivers/block/drbd/drbd_worker.c   |  4 +-
 drivers/block/nbd.c                | 10 +++++
 drivers/block/xen-blkfront.c       |  8 ++--
 drivers/md/bcache/bcache.h         |  3 ++
 drivers/md/bcache/bset.h           |  3 +-
 drivers/md/bcache/journal.c        |  3 +-
 drivers/md/bcache/request.c        | 17 +++++---
 drivers/md/bcache/stats.c          | 10 +++--
 drivers/md/bcache/super.c          | 21 +++++++---
 drivers/md/bcache/sysfs.c          | 22 +++++++++++
 drivers/nvme/host/pci.c            | 23 ++++-------
 drivers/nvme/target/core.c         | 80 ++++++++++++++++++++++++--------------
 drivers/nvme/target/fabrics-cmd.c  | 15 ++++---
 drivers/nvme/target/io-cmd-bdev.c  |  2 +-
 drivers/nvme/target/io-cmd-file.c  |  2 +-
 drivers/nvme/target/nvmet.h        |  1 +
 25 files changed, 230 insertions(+), 94 deletions(-)

-- 
Jens Axboe

