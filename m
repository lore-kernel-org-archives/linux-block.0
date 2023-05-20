Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE75FC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 12:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjETMDR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjETMDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 08:03:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E718F
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 05:03:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25377d67da9so456927a91.0
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684584195; x=1687176195;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9TwJkiD/D4r+xz97xXnN2ZniBpU1ye0ahbgrL0eGQg=;
        b=E+N5le+7bQ/tbJ8yt3LPCem+a2af071Me7Tui/ACtUhZ0j9ozmfZiDyWKq3PnhRwgI
         ZT7KfOQh7djpkPkBpPugkc2il7d9ZecSiCbab5aZDgPBak3furBCFRqRkp95XRl175SL
         i3AFdMnpkQgz5v6My6Zs+Nj5kDNTGQhTjcNm1kQsgfrg1edbTcdNJQXzlXZ6heJwGJMH
         bazd400VRaenNJKB2xLtHrz6FF8zAAzY3INZvzoVXregwUYz848/xuQrkV0ezHE1RMC2
         J3Mz+WOgzRWKBenqJcwzZ/M1zQx0fL4VF01qGfkBOacAmM8h/lOu51k0kX54CqXk56Oo
         0TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684584195; x=1687176195;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a9TwJkiD/D4r+xz97xXnN2ZniBpU1ye0ahbgrL0eGQg=;
        b=VbHA8DymxjFTIp0jwVzosXpqO35624NuVRppTrgy96srCb60brsbjML+AnQfIpaUKd
         oJz64QpJGapmOE5MDUqGKbqKll3Tsl22Y07o+lW9StPZFhq7unG3YYN4gxoJDCiw38zE
         ZZ6Qvs2+aPCzl0UYJ2blVu1rEFGB4bxAUlMraAW8Pu8C1AmA1lCNvdNUJYnmHiOBWi92
         tMs6T6Gkm/d38VLuVPChWTmPaTuvnHEdsOjZ4n62UT1k84AZO/vHIhf5nYkXgGFvkJCi
         v+QE/92TU9sZWiMnPyWuTw2vcW+USESw3LWYWAVZUIFSUwtO0uTuKVmrHR4L0MhjXce2
         +eiA==
X-Gm-Message-State: AC+VfDx+A+HSRSTBGV2owZcEy2uNU19Kau1ucweXc7mKsyCeuq3oO/WP
        GEpLnk0ZqoCGtqmzipEXrZFfOyRBSrunBd+v190=
X-Google-Smtp-Source: ACHHUZ7jHDpvP07T6f0Zd7ZwG92pYYR5NovO1BhOLAp+KYnmTRbHBi/myRd9UuCeFT23wjQIH/y/0A==
X-Received: by 2002:a17:90b:4d8a:b0:250:d8e1:d326 with SMTP id oj10-20020a17090b4d8a00b00250d8e1d326mr6038629pjb.0.1684584195006;
        Sat, 20 May 2023 05:03:15 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090ad80c00b0024b9e62c1d9sm1102243pjv.41.2023.05.20.05.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 05:03:14 -0700 (PDT)
Message-ID: <26d11955-8978-1be6-628d-4b8ecda5f6a8@kernel.dk>
Date:   Sat, 20 May 2023 06:03:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.4-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes for the 6.4-rc3 kernel:

- NVMe pull request via Keith
	- More device quirks (Sagi, Hristo, Adrian, Daniel)
	- Controller delete race (Maurizo)
	- Multipath cleanup fix (Christoph)

- Deny writeable mmap mapping on a readonly block device (Loic)

- Kill unused define that got introduced by accident (Christoph)

- Error handling fix for s390 dasd (Stefan)

- ublk locking fix (Ming)

Please pull!


The following changes since commit 56cdea92ed915f8eb37575331fb4a269991e8026:

  Documentation/block: drop the request.rst file (2023-05-12 11:04:58 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.4-2023-05-20

for you to fetch changes up to e3afec91aad23c52dfe426c7d7128e4839c3eed8:

  block: remove NFL4_UFLG_MASK (2023-05-20 05:38:01 -0600)

----------------------------------------------------------------
block-6.4-2023-05-20

----------------------------------------------------------------
Adrian Huang (1):
      nvme-pci: clamp max_hw_sectors based on DMA optimized limitation

Christoph Hellwig (2):
      nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk
      block: remove NFL4_UFLG_MASK

Daniel Smith (1):
      nvme-pci: Add quirk for Teamgroup MP33 SSD

Hristo Venev (1):
      nvme-pci: add quirk for missing secondary temperature thresholds

Jens Axboe (1):
      Merge tag 'nvme-6.4-2023-05-18' of git://git.infradead.org/nvme into block-6.4

Loic Poulain (1):
      block: Deny writable memory mapping if block is read-only

Maurizio Lombardi (1):
      nvme: do not let the user delete a ctrl before a complete initialization

Ming Lei (1):
      ublk: fix AB-BA lockdep warning

Sagi Grimberg (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G

Stefan Haberland (1):
      s390/dasd: fix command reject error on ESE devices

 block/fops.c                   | 12 +++++++++++-
 drivers/block/ublk_drv.c       |  9 +++++++--
 drivers/nvme/host/core.c       |  6 +++++-
 drivers/nvme/host/hwmon.c      |  4 +++-
 drivers/nvme/host/multipath.c  |  1 -
 drivers/nvme/host/nvme.h       |  5 +++++
 drivers/nvme/host/pci.c        |  8 +++++++-
 drivers/s390/block/dasd_eckd.c | 33 +++++++++++++++++++++++++++++++--
 include/linux/blkdev.h         |  2 --
 9 files changed, 69 insertions(+), 11 deletions(-)

-- 
Jens Axboe

