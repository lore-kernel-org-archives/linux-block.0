Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE22AC001B5
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 16:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiIBQjQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiIBQjP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 12:39:15 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D8F61BC
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 09:39:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b142so2049734iof.10
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=3GHtQ7tsGyp9XH9bQNTonNEMci4seqGr6crNQBG2IA0=;
        b=TSbO0U7V8IBLdDEv8dZg9SW1zh+JJgu4SpABKwxqopJpAshPJPJRho2qw9e85lgaee
         TV8gi35+6LYcMpkLQTMjD05q4xSx7w/GfgmVv/HkaBLTuazz4rb0TVnkVIqrlPW5VwZ7
         9xSP9OJHhwip8NpcixxjLSYqScpmMsWgcxvSMqQdPZh2opMBMHArXy3yhwmCmQwcgAQn
         T2qlMhP9l0VeC5oi5WWuozz59+xk3PGDucmBMvhB1dZZ9ySBeZY9+KNoZMLyZtpNjbyQ
         r5cxWedUPdzL3et2xARxHMoLbM/g3qpKNpCh0EnzCBHUgDg5l/aR/2tgN3dG+mC7Bdd6
         REfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=3GHtQ7tsGyp9XH9bQNTonNEMci4seqGr6crNQBG2IA0=;
        b=RieI8q8uB3Ad7Oc1vTb4sLbdJPepxxf/KjNv//PbRmOV46ZBr9B4uVb3wkXmkqw5hF
         pSaZQUg54S6NezhfFzNOQ91eOu3y/2PzFPaWEamHwsb0u5A86nA5DcY08o/BFE2gQlYb
         b+8NsjtzsDoqyLd59R4zxKUNCyxFyDKa9p5FhXxhLGSvYuXS/VmcU79OtIaSNX6vf+y0
         4azvWBnFHSE4pLbJrnLgkSNeE3Wq85q01GnsSeQLNmPHMpDkCihrfR88XvTZrntLOnjt
         48M8GoMquZ1Yb+mXEAIrAyQ0G4+oVX1ryYTQ6VJsRbr5Zr8wPdPWzVeyzazbDYS3UCwE
         6nTA==
X-Gm-Message-State: ACgBeo18chBx2e1/SsWa9Om3AFtbZ76AJS6YHWrwTAOZw3kqfE5sHh//
        hsOhehseoLzKYjsQTQWU5NxbIevvCl0RNA==
X-Google-Smtp-Source: AA6agR4ZWbeHlidCEiLuB59R65v/LHgW6ta/MjDOQT/EUKN47Ungkep5qpauFI7pIJFFW3ovt1ybSw==
X-Received: by 2002:a05:6638:430d:b0:343:69f4:2016 with SMTP id bt13-20020a056638430d00b0034369f42016mr20706153jab.90.1662136752990;
        Fri, 02 Sep 2022 09:39:12 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y8-20020a92c748000000b002dc2b20e9cfsm985796ilp.1.2022.09.02.09.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:39:12 -0700 (PDT)
Message-ID: <2e744edd-4b72-4071-99c2-c09848460490@kernel.dk>
Date:   Fri, 2 Sep 2022 10:39:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- NVMe pull request via Christoph:
	- error handling fix for the new auth code (Hannes Reinecke)
	- fix unhandled tcp states in nvmet_tcp_state_change
	  (Maurizio Lombardi)
	- add NVME_QUIRK_BOGUS_NID for Lexar NM610 (Shyamin Ayesh)

- Add documentation for the ublk driver merged in this merge window
  (Ming)

Please pull!


The following changes since commit 645b5ed871f408c9826a61276b97ea14048d439c:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.0 (2022-08-24 13:58:37 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-02

for you to fetch changes up to 7a3d2225f1ae9e591fefd65c3bb1715dc54d96f1:

  Documentation: document ublk (2022-09-02 09:31:15 -0600)

----------------------------------------------------------------
block-6.0-2022-09-02

----------------------------------------------------------------
Hannes Reinecke (1):
      nvmet-auth: add missing goto in nvmet_setup_auth()

Jens Axboe (1):
      Merge tag 'nvme-6.0-2022-09-01' of git://git.infradead.org/nvme into block-6.0

Maurizio Lombardi (1):
      nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()

Ming Lei (1):
      Documentation: document ublk

Shyamin Ayesh (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM610

 Documentation/block/index.rst |   1 +
 Documentation/block/ublk.rst  | 253 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                   |   1 +
 drivers/nvme/host/pci.c       |   2 +
 drivers/nvme/target/auth.c    |   1 +
 drivers/nvme/target/tcp.c     |   3 +
 6 files changed, 261 insertions(+)
 create mode 100644 Documentation/block/ublk.rst

-- 
Jens Axboe
