Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E018C433E6
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 18:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114E7650AD
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 18:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCESJe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCESJX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 13:09:23 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A1C061574
        for <linux-block@vger.kernel.org>; Fri,  5 Mar 2021 10:09:22 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id s1so2788603ilh.12
        for <linux-block@vger.kernel.org>; Fri, 05 Mar 2021 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ucfQCY+mJHjWO4Hdv4kmbQFFQHVnW6fNOjXrQ5wMVvg=;
        b=BqMRJpDRTlAsu8ObkD8IPOGJ6A8nf3iF2nD+mBmKP7HFAMtPkTamjQqtRlVMN20zAA
         3S+F6iUddwuw/hrWEkJpqESETeXV3EE7xbsnLXOKQflRX+1LP7YGLEjSWw3V0SxdJUP3
         FfMuQLJqfRRs2MHtUTWz0gLn5uBAFb/p4bKfEwAKLKRov6cjHPNuMiFlXMgd9j5jlPNm
         dNUOml7lw8GYkx2UE+hQM0KHUQCILDR6taeOpXuFlHMyFzhDLR75qRtnxRuFq/V9lOnL
         uZYyJKIistACrzAHACwdqjf3Cl4LQOeMedo6MRlHDKyIkxYlHBwSrgCefxa+MnYAQ/kb
         2VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ucfQCY+mJHjWO4Hdv4kmbQFFQHVnW6fNOjXrQ5wMVvg=;
        b=Ep1NcSis2MQHJNRgEfhS5HItsoxqcVXHVbnZbNgicDxSToe5oLkLcB4mWNDZ3tzd9l
         dMjMx/+Bpv4x1isks3EA7Pa81jTCibeheEkgawrV7qnV4kfvDegti5t/SLrBCJoLNmIU
         7Bq4ZMuMGFNS5YpYBZ7h+rKcD9a20QwIH97Aodo79EwdJcbu62xVlzCu173xR3voh/Ia
         6s8wLXYLIykswH+8hL3L98EflZkIdeiMh65X7cdwshADANLSvY31jS1a0EDrTNWAsYqY
         BOz/M3bjAjqYhjm5WKVoRMpe2ZloJYApSKb4m96YoHsm7+gozN01/zUd3G/XhU2Nk5M9
         fj6Q==
X-Gm-Message-State: AOAM532Q9ryWcIFoSaEVLhYVFYAh3pvsFIqkfiWJMm9heBWjlKtuBbcc
        jhDSkPXniOsgUTJ7JPFFsqcn5smod320uw==
X-Google-Smtp-Source: ABdhPJxXbjxyfm+uzApuVkWFClnP3t+9vd1rM3SfPXayqEa+UY5p2vDTaorAmaJcQUX7CiJtgLJIEg==
X-Received: by 2002:a05:6e02:1845:: with SMTP id b5mr10059517ilv.11.1614967762161;
        Fri, 05 Mar 2021 10:09:22 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b19sm1581119ioj.50.2021.03.05.10.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 10:09:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.12-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <fbbd162e-2221-502a-2d3a-d6115b206be0@kernel.dk>
Date:   Fri, 5 Mar 2021 11:09:21 -0700
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

Changes that should go into 5.12-rc2:

- NVMe fixes:
	- more device quirks (Julian Einwag, Zoltán Böszörményi,
	  Pascal Terjan)
	- fix a hwmon error return (Daniel Wagner)
	- fix the keep alive timeout initialization (Martin George)
	- ensure the model_number can't be changed on a used subsystem
	  (Max Gurtovoy)

- rsxx missing -EFAULT on copy_to_user() failure (Dan)

- rsxx remove unused linux.h include (Tian)

- Kill unused RQF_SORTED (Jean)

- Updated outdated BFQ comments (Joseph)

- Revert work-around commit for bd_size_lock, since we removed the
  offending user in this merge window (Damien)

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
