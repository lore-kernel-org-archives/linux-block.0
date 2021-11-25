Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA07C433F5
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 16:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbhKYQyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhKYQwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 11:52:10 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FAC0613E0
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:42:49 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id k21so8261242ioh.4
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZcB2KnJeF64dOXF1V0U7NNaRUXTvT0BPNf7KL5t8HuU=;
        b=bZGyFu+wu2BzC1tyqW4Hq5FJz/kWNE67C0hblr44aTh2i2lGSFyNQ9/cAW+wc8QX+M
         oICSudFOro3nVwuMEr5DDk/wf5xUgOIYcl2rawsaghKcW1sWsug8jLjNQYZnsQPd0hz5
         WXA8KP4CHj5IG1gZKo252529SyB65/o1l6eTjmbtD11r8nDj2fG4ieUXQemfSEO3+7hi
         /PFH4YOFVPUKvKJSrn6JPHevloOTg/UI7hYOgasORQqSVZy+nwCSNSoIHqfpdhFIxTuo
         Fh1IApNKy5yeOnpnn3gtRCjya0W6uDnUXb7n0GHDOkgoZ3UQ9O7LSBygW8l2+nO5Vk46
         fT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZcB2KnJeF64dOXF1V0U7NNaRUXTvT0BPNf7KL5t8HuU=;
        b=qO3IvYfiaf8pe5ZRGi+ZU4ZAZBx7HGtSjBpdyIqsG9QZecLeU/PyNRFUZa6YNMqOv9
         wOMmxubAV79VZMKfsQG1YM/AzJdWM6j/bJmArFcVB0RLwLXK4yB38aSksGyUKkrO2JSM
         iPqPeZMsD2Pc+eofGkShW6c9BsyAy3qv74JP2nSFCaaWIubl+B09aT85o3H4ATd6M86l
         fAq4/9hsNLVHapbgcU/ddYJdU3P6fa3YPzpfxqe6I5XElknmYsVCyu4N2F9ZZcuV2Vt1
         R/H36Zq2BznNSrvmzNtt+eEiD/E4kXWA8bSj77gJ5ZJ/0eSwuR4PY6+JxWvf5ooFuszt
         xt0g==
X-Gm-Message-State: AOAM533ACipMxu9jpT24bPaTGj33ixE5asqzIbpoHiXZVLMEXMfQlld7
        4gBqjCOysRiubBVZ/9MhpPHU/Q+4Ak0sxCI+
X-Google-Smtp-Source: ABdhPJxFhkE273OmyWzyR5Tu+0LEuQrOnH74zGdEUqYeQvkm8wkAsle7oRdWa121iERi+NbYAMnbwA==
X-Received: by 2002:a02:a708:: with SMTP id k8mr30860181jam.26.1637858569023;
        Thu, 25 Nov 2021 08:42:49 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d2sm1866586ilv.73.2021.11.25.08.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 08:42:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.16-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <ddc913c4-9789-ca29-6cba-60ac173fc2e1@kernel.dk>
Date:   Thu, 25 Nov 2021 09:42:48 -0700
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

- NVMe pull request via Christoph:
	- Add a NO APST quirk for a Kioxia device (Enzo Matsumiya)
	- Fix write zeroes pi (Klaus Jensen)
	- Various TCP transport fixes (Maurizio Lombardi and
	  Varun Prakash)
	- Ignore invalid fast_io_fail_tmo values (Maurizio Lombardi)
	- Use IOCB_NOWAIT only if the filesystem supports it
	  (Maurizio Lombardi)

- Module loading fix (Ming)

- Kerneldoc warning fix (Yang)

Please pull!


The following changes since commit 2b504bd4841bccbf3eb83c1fec229b65956ad8ad:

  blk-mq: don't insert FUA request with data into scheduler queue (2021-11-19 06:28:18 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-25

for you to fetch changes up to e30028ace8459ea096b093fc204f0d5e8fc3b6ae:

  block: fix parameter not described warning (2021-11-25 09:32:19 -0700)

----------------------------------------------------------------
block-5.16-2021-11-25

----------------------------------------------------------------
Enzo Matsumiya (1):
      nvme-pci: add NO APST quirk for Kioxia device

Jens Axboe (1):
      Merge tag 'nvme-5.16-2021-11-25' of git://git.infradead.org/nvme into block-5.16

Klaus Jensen (1):
      nvme: fix write zeroes pi

Maurizio Lombardi (6):
      nvmet-tcp: fix a race condition between release_queue and io_work
      nvmet-tcp: add an helper to free the cmd buffers
      nvmet-tcp: fix memory leak when performing a controller reset
      nvme-tcp: fix memory leak when freeing a queue
      nvme-fabrics: ignore invalid fast_io_fail_tmo values
      nvmet: use IOCB_NOWAIT only if the filesystem supports it

Ming Lei (1):
      block: avoid to touch unloaded module instance when opening bdev

Varun Prakash (2):
      nvmet-tcp: fix incomplete data digest send
      nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()

Yang Guang (1):
      block: fix parameter not described warning

 block/bdev.c                      | 12 ++++----
 block/blk-core.c                  |  1 +
 drivers/nvme/host/core.c          | 29 +++++++++++++++++--
 drivers/nvme/host/fabrics.c       |  3 ++
 drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
 drivers/nvme/target/io-cmd-file.c |  4 ++-
 drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
 7 files changed, 102 insertions(+), 52 deletions(-)

-- 
Jens Axboe

