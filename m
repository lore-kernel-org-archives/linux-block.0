Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF5CC6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 16:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCXQ2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCXQ2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 12:28:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D32DBD6
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 09:28:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso2118421pjb.2
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679675330;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfSeDmyLNk5kEL58erzze+WgOQ8324zTXVhInnnT7io=;
        b=VXg+M3cnQDzoVGBaf6LhfNyY3MjUTBLodRbCD2TpI5xsr8YdGdBtUdhCkyHJm290sD
         q9v0dhM5gw96KugbZO+0ooyxPCAcVEdJjzyCW1LaokkA7pmo1FrNWrcFumff8RhB1AMZ
         mCasWKpWmFM2m8X9OSCFd5R6uholIW8FBJJgjul7FYYELmx0TFQO+Xa5Sm6WTEc4abVn
         g2zWNI1So28CzmAa2WikoLw+Fh2Gf62Zioy1jw7HWDr0qpN5Ljtp3vuwTE5Lo8Y9lFkP
         00ty7rfhQ/1/N/rX/fhC3r4r4oixFenVHLCmn4D/joX68ATzTBuWwzVEfXTFjVxzATjc
         tfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679675330;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfSeDmyLNk5kEL58erzze+WgOQ8324zTXVhInnnT7io=;
        b=5Cr0ZbAv6zrab0FiGHwcx9bUOl5oQJkJUgqzTEdzrkOmgjLyxwb8SYwinnA6kdFNj+
         Oh0+qxt+mrRcStMVTtm9f6TwQyne3uGW2irvfHzDOKQEF46hx9GkoUtLpmNp0fS/107K
         reyi2aFiqF7GbgbE0mV7lE8w9+d9I31Xou3C0vvq3xz+2PJkZNP36wMKthdA27Kt7nYu
         NxdeBL+E+XtuigoxVddZuCVg6rBHeMQ3J3YvkgNUTz1deJdaTsfU7HJ6cPcsxDU2pHZa
         Haf16AJ6cLLxHSh1Oo0ahW+9lr1Fo4jvE5ru6huulktDtSVaGvdhCVIzkJPT55rvGBOd
         +gcA==
X-Gm-Message-State: AO0yUKXy83sASH2vi9DhLSs3PODMqlGG2iiijSxGnHlycV1T0B7+hrA2
        gMMV/45MiYiN8dfvPorE2NVi3whOv0Ni3MuQyuXtzg==
X-Google-Smtp-Source: AK7set+nm7M7ab2U9WdKadJe4nq2Ec5m5kYNn4PnyLrecvU3WtDlTaWCygsNY0K1phbDg4ckwXm9kQ==
X-Received: by 2002:a05:6a20:4408:b0:da:c070:c466 with SMTP id ce8-20020a056a20440800b000dac070c466mr3750797pzb.6.1679675330179;
        Fri, 24 Mar 2023 09:28:50 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c1::1239? ([2620:10d:c090:400::5:56f0])
        by smtp.gmail.com with ESMTPSA id h24-20020a63f918000000b004fb8732a2f9sm13563633pgi.88.2023.03.24.09.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 09:28:49 -0700 (PDT)
Message-ID: <a3e790c2-e454-f49e-b2c0-2353ceb9752c@kernel.dk>
Date:   Fri, 24 Mar 2023 10:28:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.3-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes on the storage front that should go into the 6.3 release:

- NVMe pull request via Christoph:
	- Send Identify with CNS 06h only to I/O controllers
	  (Martin George)
	- Fix nvme_tcp_term_pdu to match spec (Caleb Sander)

- Pass in issue_flags for uring_cmd, so the end_io handlers don't need
  to assume what the right context is (me)

- Fix for ublk, marking it as LIVE before adding it to avoid races on
  the initial IO (Ming)

Please pull!


The following changes since commit 8f0d196e4dc137470bbd5de98278d941c8002fcb:

  block: remove obsolete config BLOCK_COMPAT (2023-03-16 09:35:44 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-03-24

for you to fetch changes up to f915da0f0dfb69ffea53f62101b38073e0b81f73:

  Merge tag 'nvme-6.3-2023-03-23' of git://git.infradead.org/nvme into block-6.3 (2023-03-23 13:02:20 -0600)

----------------------------------------------------------------
block-6.3-2023-03-24

----------------------------------------------------------------
Caleb Sander (1):
      nvme-tcp: fix nvme_tcp_term_pdu to match spec

Jens Axboe (2):
      block/io_uring: pass in issue_flags for uring_cmd task_work handling
      Merge tag 'nvme-6.3-2023-03-23' of git://git.infradead.org/nvme into block-6.3

Martin George (1):
      nvme: send Identify with CNS 06h only to I/O controllers

Ming Lei (1):
      block: ublk_drv: mark device as LIVE before adding disk

 drivers/block/ublk_drv.c  | 34 ++++++++++++++++++++--------------
 drivers/nvme/host/core.c  |  3 ++-
 drivers/nvme/host/ioctl.c | 14 ++++++++------
 include/linux/io_uring.h  | 11 ++++++-----
 include/linux/nvme-tcp.h  |  5 +++--
 io_uring/uring_cmd.c      | 10 ++++++----
 6 files changed, 45 insertions(+), 32 deletions(-)

-- 
Jens Axboe

