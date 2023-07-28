Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE7AC41513
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 15:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjG1PJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjG1PI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 11:08:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0B4214
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 08:08:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77dcff76e35so27317839f.1
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690556937; x=1691161737;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEgLP/yA09BR2SYf+oBUtrN86kwVVC/NfW0SDvcNEzw=;
        b=DQD/jx5yCxrYVCGzhgVzQkiToIaCWpWDAkfZ3fqi5USvJa9nHZ0IBuTQVVjq8ZTxOz
         Im+hBiGZ6Cbv6KLGQe+kvjCnYEOiyBVsIbHP6yqdUUDK8/N7lzmBgo2ggDaLxkMN+JRb
         nVGvppHit7nwUmVtrQ2axQU4J/NVxc9+i9Qjiu8borAW43COjwnQjkTQLP5ySUaNpgF4
         S7eXp6kiIguflkQWjhCU82nl2bXybtoUsHx/fDnsx2eRGlfiA73ILI/xKUcGAcL53EfH
         B7Z2QnLGM+Pnu5+uR9oWlsQGNyIH7U6B0oMNOL6v+uN7bbOGwZ7nNRYnMwzohryIxy7O
         fkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556937; x=1691161737;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jEgLP/yA09BR2SYf+oBUtrN86kwVVC/NfW0SDvcNEzw=;
        b=GJyiRnAo/Nup0fJvK9LtShXL8nTfkD16IP4B8qAib354kxRRNJ6oPhIyr/lyQmp/CK
         MblCShx0d0Xp/MqY9cL0m/COnf4Fro4Ale7xRtKUtbbF5GFSZJdWTbuGDz1dZXrZ7UhK
         WddAesaI4xMaqzNIloXMZ85Zxz9E+lLnHbT9VJaew4vwdOLlu/QlJHJoLTsDNtfnPLD3
         GzN17MYa/2du14HKB7ihDLQbYPgBFC0Rg3BuLVosmgIDqE4vP6RsQ6JXCSva3fYomxJt
         sJzh9myA3sM6l8+qfCJGIv4MOFYu1xc8nPrheyqSdXg0Tup3vUK6uZePCjyJJAfOggVy
         kDBQ==
X-Gm-Message-State: ABy/qLbUlJgJZ2K2cDHYglTbTWerw1D6tdRuZ/9+dvaKxyqIjFaFjJSd
        qp3qhRdFamO+trJcXNE0OgtVcLx5Lo+kUfYjbhM=
X-Google-Smtp-Source: APBJJlFtZMWemtGlI59pKc6Uzj91nxD+DkpECFSN3kCvRS0ToqW2AUxZatEs7CBsRZVVO4DGg9hzaA==
X-Received: by 2002:a92:c851:0:b0:345:bdc2:eb42 with SMTP id b17-20020a92c851000000b00345bdc2eb42mr2510762ilq.3.1690556937623;
        Fri, 28 Jul 2023 08:08:57 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c14-20020a92cf4e000000b00345e3a04f2dsm1249347ilr.62.2023.07.28.08.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:08:57 -0700 (PDT)
Message-ID: <7ffe03ab-339e-be10-c6e8-7294e4c35bb4@kernel.dk>
Date:   Fri, 28 Jul 2023 09:08:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.5-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should go into the current kernel release, mainly:

- Set of fixes for dasd (Stefan)

- Handle interruptible waits returning because of a signal for ublk
  (Ming)

Please pull!


The following changes since commit bb5faa99f0ce40756ab7bbbce4f16c01ca5ebd5a:

  loop: do not enforce max_loop hard limit by (new) default (2023-07-21 13:20:57 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.5-2023-07-28

for you to fetch changes up to 3e9dce80dbf91972aed972c743f539c396a34312:

  ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV (2023-07-27 07:17:36 -0600)

----------------------------------------------------------------
block-6.5-2023-07-28

----------------------------------------------------------------
Bart Van Assche (1):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h

Ming Lei (3):
      ublk: fail to start device if queue setup is interrupted
      ublk: fail to recover device if queue setup is interrupted
      ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV

Stefan Haberland (4):
      s390/dasd: fix hanging device after quiesce/resume
      s390/dasd: use correct number of retries for ERP requests
      s390/dasd: fix hanging device after request requeue
      s390/dasd: print copy pair message only for the correct error

 drivers/block/ublk_drv.c           |  11 ++--
 drivers/s390/block/dasd.c          | 125 ++++++++++++++-----------------------
 drivers/s390/block/dasd_3990_erp.c |   4 +-
 drivers/s390/block/dasd_ioctl.c    |   1 +
 include/uapi/linux/blkzoned.h      |  10 +--
 5 files changed, 63 insertions(+), 88 deletions(-)

-- 
Jens Axboe

