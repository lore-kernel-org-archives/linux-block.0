Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C15C433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADDE64F80
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 19:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhCLTsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 14:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhCLTsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 14:48:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6088C061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 11:48:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bt4so5655907pjb.5
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 11:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lD/FmaJkum3/PtS9bwYWdQBjwvAN9x2XlbRumN2IVDQ=;
        b=XLgL3dH9IkW4X/j/sRgWWFtrzRb3T7bdzHvOgySTuY+CPgTFKgIL5bQDbidtMGeSei
         NFg1xArqRVLjMYolOGTkZ6xbYzmBnqi8/4hqOSeIfdeluDlkb6Za52QfTZ1mvQ5i97qh
         w4ZbLBH1/AS1Qr4GWUX4azc6A4N/pYBB6k1EA9a3QqUVvOpQ7adAyuhy/0FWR2mLMy7f
         LJ0m0kp4ofVCfa8C0hHs+eMr5fXZrBs8/lZeoCHpnwQzho9cMy+3rt7kDxERm8kRs2NL
         w2jBc1aAKpRNNbzSo4Rl1639cNUeRsQUqx7h4ymwX/1Q5UINAkLfCOYMro7e/9C6MPIB
         XAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lD/FmaJkum3/PtS9bwYWdQBjwvAN9x2XlbRumN2IVDQ=;
        b=aDQQ5B5LdR6NCGJxY7znLxvkVHFVpZSZ7IAxae9t6uGMrGRq+qZP1ZZ2l6ZPBOIooz
         SzNVDSuz7sAeBcY8Ay3L7CgplhqRI9Cwq+rYfiKe7IgykXRcPAOnN7f2fAZNFj2ukJ7f
         zBeEynJoO1KjyOTVD55lhEeTo7SdcAR3nRs0a2duXm2sQeEiP07BNLQUb7P3HYF4jGEg
         Exidr7wCs8fcHe5yvpIAHaRf8BIgvz91IqOlDLeWSRXJuAoOPVs7/quiTzN5Y72qdUii
         V4nSUQWMPG6kuVYISW6+Rb9s+X/71BRjS8piA0afjh/6AjBG+TK1ZRCxHECxYGXFKT6v
         IlSw==
X-Gm-Message-State: AOAM532eEb8LY5Ymf8sPN7y1zzGwoAh+AizY1QsKcPCpFIcuszCUpvq3
        I1dNHXt1CXU6g56ix2aQr1mVqVx/CunZvA==
X-Google-Smtp-Source: ABdhPJzC2qlgIj1xHp8970H6oupFi/oPDLamfEpMy6d78OO9zOS1aGwdAfMy27Mv7qvHlGD/0zOVhA==
X-Received: by 2002:a17:90a:e614:: with SMTP id j20mr15478117pjy.184.1615578515947;
        Fri, 12 Mar 2021 11:48:35 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r23sm3182557pje.38.2021.03.12.11.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 11:48:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.12-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <fc1d6ba8-9245-dced-6a64-eaf7baf69be7@kernel.dk>
Date:   Fri, 12 Mar 2021 12:48:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Mostly just random fixes all over the map. Only odd-one-out change is
finally getting the rename of BIO_MAX_PAGES to BIO_MAX_VECS done. This
should've been done with the multipage bvec change, but it's been left.
Do it now to avoid hassles around changes piling up for the next merge
window.

- NVMe pull request
	- one more quirk (Dmitry Monakhov)
	- fix max_zone_append_sectors initialization (Chaitanya Kulkarni)
	- nvme-fc reset/create race fix (James Smart)
	- fix status code on aborts/resets (Hannes Reinecke)
	- fix the CSS check for ZNS namespaces (Chaitanya Kulkarni)
	- fix a use after free in a debug printk in nvme-rdma (Lv Yunlong)

- Fixup for the bd_size_lock being IRQ safe, now that the offending
  driver has been dropped (Damien).

- rsxx probe failure error return (Jia-Ju)

- umem probe failure error return (Wei)

- s390/dasd unbind fixes (Stefan)

- blk-cgroup stats summing fix (Xunlei)

- zone reset handling fix (Damien)

- Rename BIO_MAX_PAGES to BIO_MAX_VECS (Christoph)

- Suppress uevent trigger for hidden devices (Daniel)

- Fix handling of discard on busy device (Jan)

- Fix stale cache issue with zone reset (Shin'ichiro)

Please pull!


The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-05

for you to fetch changes up to a2b658e4a07d05fcf056e2b9524ed8cc214f486a:

  Merge tag 'nvme-5.12-2021-03-05' of git://git.infradead.org/nvme into block-5.12 (2021-03-05 09:13:07 -0700)

----------------------------------------------------------------
block-5.12-2021-03-05

----------------------------------------------------------------
Damien Le Moal (1):
      block: revert "block: fix bd_size_lock use"

Dan Carpenter (1):
      rsxx: Return -EFAULT if copy_to_user() fails

Daniel Wagner (1):
      nvme-hwmon: Return error code when registration fails

Jean Delvare (1):
      block: Drop leftover references to RQF_SORTED

Jens Axboe (1):
      Merge tag 'nvme-5.12-2021-03-05' of git://git.infradead.org/nvme into block-5.12

Joseph Qi (1):
      block/bfq: update comments and default value in docs for fifo_expire

Julian Einwag (1):
      nvme-pci: mark Seagate Nytro XM1440 as QUIRK_NO_NS_DESC_LIST.

Martin George (1):
      nvme-fabrics: fix kato initialization

Max Gurtovoy (1):
      nvmet: model_number must be immutable once set

Pascal Terjan (1):
      nvme-pci: add quirks for Lexar 256GB SSD

Tian Tao (1):
      rsxx: remove unused including <linux/version.h>

Zoltán Böszörményi (1):
      nvme-pci: mark Kingston SKC2000 as not supporting the deepest power state

 Documentation/block/bfq-iosched.rst |  4 +--
 block/bfq-iosched.c                 |  2 +-
 block/blk-mq-debugfs.c              |  1 -
 block/blk-mq-sched.c                |  6 +----
 block/genhd.c                       |  5 ++--
 block/partitions/core.c             |  6 ++---
 drivers/block/rsxx/core.c           |  8 +++---
 drivers/block/rsxx/rsxx_priv.h      |  1 -
 drivers/nvme/host/fabrics.c         |  5 +++-
 drivers/nvme/host/hwmon.c           |  1 +
 drivers/nvme/host/pci.c             |  8 +++++-
 drivers/nvme/target/admin-cmd.c     | 36 ++++++++++++++++++--------
 drivers/nvme/target/configfs.c      | 50 +++++++++++++++++--------------------
 drivers/nvme/target/core.c          |  2 +-
 drivers/nvme/target/nvmet.h         |  7 +-----
 include/linux/blkdev.h              |  2 --
 16 files changed, 75 insertions(+), 69 deletions(-)

-- 
Jens Axboe

