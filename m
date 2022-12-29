Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7444EC3DA7A
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 23:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiL2Xgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 18:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiL2Xgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 18:36:38 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B97238F
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 15:36:32 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k137so8748034pfd.8
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 15:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOlXib8R+5UZepmDaXZJBSg9Vhd8JVlNmHFSQlvmQzk=;
        b=ayoq66+sJauDY6UGa1fPDamJ4gIDuipQOUx8r5jmdK1jUhzbMBLhSpSPbr3RcHEoPx
         Shb6rIbWFE8CZ1RpbEVMv4l1RZPHM1xS6j33p1x9FUKxhAEYk+KqRjKis4DAi5d1i4ed
         0T3hsR/VGiN3z0NE4xdkk/1uNsiJ6zOXdV99ClgmYTdRBA1KEVNz5jTKJshxgbbaE+Hz
         raJ3qByPlG1VMGD6mkgYjv8bagoLOvDwiViequ0avsZgLDGseVwvBEwXNtEhOKyNlrWx
         U0SzHplRYm6xibSH0DUsmGky5PWos21C9bf+jOXU+1FA4ttJj5Wb9/7MOWGMF0ejQGj0
         NkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOlXib8R+5UZepmDaXZJBSg9Vhd8JVlNmHFSQlvmQzk=;
        b=xUYl+UM8iNBY0vgPMBt1aArng6bbbG1KYI+QonzTB+noMp+KHDuW+dl3gX2fzIyI3x
         sJhyP2+0pIv8B5QGWhcsn1m5JRPYnLbQm64BNhq4x0TCD5FzM7clebDzik4NxZxxVYX0
         waL87My4kThT3P3W2nmAJs8UrC360r0fcEPldMx6fTZdhFelpsZMsu2U+lHGLNMkiE6y
         EIQ6z7eMzrpEdADedybKsrSojycYA2wGjGkBV6y4PIbovNjo/hLgIRm6pbeCNSXM+p52
         gXWImyeMei0B49DeedEKfdp6fA87Fm4ezA85KLtYQlC0T+ymr/ZulxqZWnNI4n+ngQPG
         js5w==
X-Gm-Message-State: AFqh2krZEsec/rafmx+bzE5hN6KDplhEJFtPaDF2b7GPfid9sNPDfcvn
        bA/TiNDIKmSXZKCdWjCHXB827Ob/dqawdOaT
X-Google-Smtp-Source: AMrXdXsBUHBP694D4/t1jptilZ54mMj6tdSNAzJ/o0RVMEe/LzTZj7aNF9/9cW06uK9TlegsVTvXeg==
X-Received: by 2002:a62:58c7:0:b0:577:3e5c:85e5 with SMTP id m190-20020a6258c7000000b005773e5c85e5mr7158585pfb.0.1672356991971;
        Thu, 29 Dec 2022 15:36:31 -0800 (PST)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b10-20020aa78eca000000b0056b9df2a15esm7086063pfr.62.2022.12.29.15.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 15:36:31 -0800 (PST)
Message-ID: <66ad5fb6-f9de-e47f-336c-7ab14424732f@kernel.dk>
Date:   Thu, 29 Dec 2022 16:36:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.2-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Block related fixes that should go into the 6.2 release. Mostly just
NVMe, but also a single fixup for BFQ for a regression that happened
during the merge window. In detail:

- NVMe pull requests via Christoph:
	- Fix doorbell buffer value endianness (Klaus Jensen)
	- Fix Linux vs NVMe page size mismatch (Keith Busch)
	- Fix a potential use memory access beyong the allocation limit
	  (Keith Busch)
	- Fix a multipath vs blktrace NULL pointer dereference
	  (Yanjun Zhang)
	- Fix various problems in handling the Command Supported and
	  Effects log (Christoph Hellwig)
	- Don't allow unprivileged passthrough of commands that don't
	  transfer data but modify logical block content
	  (Christoph Hellwig)
	- Add a features and quirks policy document (Christoph Hellwig)
	- Fix some really nasty code that was correct but made smatch
	  complain (Sagi Grimberg)

- Use-after-free regression in BFQ from this merge window (Yu)

Please pull!


The following changes since commit 53eab8e76667b124615a943a033cdf97c80c242a:

  block: don't clear REQ_ALLOC_CACHE for non-polled requests (2022-12-16 09:18:09 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2022-12-29

for you to fetch changes up to 1551ed5a178ca030adc92b1eb29157b5e92bf134:

  Merge tag 'nvme-6.2-2022-12-29' of git://git.infradead.org/nvme into block-6.2 (2022-12-29 11:31:45 -0700)

----------------------------------------------------------------
block-6.2-2022-12-29

----------------------------------------------------------------
Christoph Hellwig (9):
      nvme: fix setting the queue depth in nvme_alloc_io_tag_set
      nvme-pci: update sqsize when adjusting the queue depth
      docs, nvme: add a feature and quirk policy document
      nvme: fix the NVME_CMD_EFFECTS_CSE_MASK definition
      nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open coding it
      nvmet: set the LBCC bit for commands that modify data
      nvmet: don't defer passthrough commands with trivial effects to the workqueue
      nvme: also return I/O command effects from nvme_command_effects
      nvme: consult the CSE log page for unprivileged passthrough

Jens Axboe (2):
      Merge tag 'nvme-6.2-2022-12-22' of git://git.infradead.org/nvme into block-6.2
      Merge tag 'nvme-6.2-2022-12-29' of git://git.infradead.org/nvme into block-6.2

Keith Busch (2):
      nvme-pci: fix mempool alloc size
      nvme-pci: fix page size checks

Klaus Jensen (1):
      nvme-pci: fix doorbell buffer value endianness

Sagi Grimberg (1):
      nvme-auth: fix smatch warning complaints

Yanjun Zhang (1):
      nvme: fix multipath crash caused by flush request when blktrace is enabled

Yu Kuai (1):
      block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq

 .../maintainer/maintainer-entry-profile.rst        |  1 +
 Documentation/nvme/feature-and-quirk-policy.rst    | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 block/bfq-iosched.c                                |  2 +-
 drivers/nvme/host/auth.c                           |  2 +-
 drivers/nvme/host/core.c                           | 34 ++++++++--
 drivers/nvme/host/ioctl.c                          | 28 ++++++--
 drivers/nvme/host/nvme.h                           |  2 +-
 drivers/nvme/host/pci.c                            | 46 ++++++-------
 drivers/nvme/target/admin-cmd.c                    | 37 ++++++-----
 drivers/nvme/target/passthru.c                     | 11 ++--
 include/linux/nvme.h                               |  4 +-
 12 files changed, 186 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/nvme/feature-and-quirk-policy.rst

-- 
Jens Axboe

