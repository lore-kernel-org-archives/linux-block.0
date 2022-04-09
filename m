Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AC7C433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Apr 2022 01:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiDIBzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 21:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDIBzV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 21:55:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12E305059
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 18:53:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s137so6526816pgs.5
        for <linux-block@vger.kernel.org>; Fri, 08 Apr 2022 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=bQjmfmM/WNaeMHfz0+JaVpCrVkxeIbSMHl4rJ5qdjmE=;
        b=QehI+kQN3bdi9Jgam7sfH61mcc8vmx+uYy3LJ2RkzmI6AS2I0wAIN1vHkGI7Nm1SXJ
         jOvCluk7xSrUPWzJ6waLpfjhWe1TuVN1fu8402RYZuYUBdkC+N+lCE0TBIqiXUHCoQVo
         be7mGNegLNvMK6TSg126xeg44N+YgvwOLNijpn0CjvSIwXRxl+5qe03AKSPi6fPWWfE8
         I5fEF4XABBeIW1yojNYjoMFptGKL0sSXjABA5kTzffNFlxGtnyyXxZPTdN2aZgDzFIiS
         M3HkhnfgD44QnaHWKRr/6OtIr8sg03qUkEBjrKs4jwPq3QNGClqRPfRgnoRq2QPm5T3N
         KGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=bQjmfmM/WNaeMHfz0+JaVpCrVkxeIbSMHl4rJ5qdjmE=;
        b=3bOIaEJof4cBlLQ7801/xDppshnenX1vOnrJTDm1+ugjiF+6cWz8L8U4JHzOS0v0Bd
         gV4XIHZWWLC2HjaS/ZYbNVMszLKYAXky03hTT94HwVYupwvYxlXveI2choogsH1UY8ja
         jIiZjV2lzMQjxUE+plUb0DLRTQxHUMZ0zJHxx9AnUZLPYVLTfO2xD7dOEHmlfv8Ffq7Y
         cu+IrB9J4Mv/r+7S+MY6OBR67T+cWG1EJd4WpZQ+qXBcLfLWj0PcCChZs/TQJ1DaFFr/
         v99UZwmycVB5gGcv2jf6e9ezkzQJFB6G6LdE5KVuceV+DxIVvNqGxL+/koMgNGOXEfyc
         t1VQ==
X-Gm-Message-State: AOAM531m1kbsiv+gQy5MrO+x4JcWoBbbl3L2Dkfd0zgbGHgi2gmf8p0M
        OLZNv/evq1NIeMeMq/0wscAaUbPdttrv7Q==
X-Google-Smtp-Source: ABdhPJxC0vC1bX8SedHFstPFb6rfQCXQoFwIRd3etd73WOR2x1U0d+iB9ea1kDOdscIO+lmFdhBCMw==
X-Received: by 2002:a63:612:0:b0:39c:f169:b52b with SMTP id 18-20020a630612000000b0039cf169b52bmr6054551pgg.554.1649469195800;
        Fri, 08 Apr 2022 18:53:15 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0024d500b004fb0e7c7c3bsm29083379pfv.161.2022.04.08.18.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 18:53:15 -0700 (PDT)
Message-ID: <a3b279bb-2462-54bb-54ac-f72ab6a80d53@kernel.dk>
Date:   Fri, 8 Apr 2022 19:53:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.18-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Nothing major in here, just a few small fixes:

- Small series of neglected drbd patches (Christoph, Lv, Xiaomeng)

- Remove dead variable in cdrom (Enze)

Please pull!


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-08

for you to fetch changes up to 286901941fd18a52b2138fddbbf589ad3639eb00:

  drbd: set QUEUE_FLAG_STABLE_WRITES (2022-04-06 13:07:53 -0600)

----------------------------------------------------------------
block-5.18-2022-04-08

----------------------------------------------------------------
Christoph Böhmwalder (1):
      drbd: set QUEUE_FLAG_STABLE_WRITES

Enze Li (1):
      cdrom: remove unused variable

Lv Yunlong (1):
      drbd: Fix five use after free bugs in get_initial_state

Xiaomeng Tong (1):
      drbd: fix an invalid memory access caused by incorrect use of list iterator

 drivers/block/drbd/drbd_int.h          |  8 +++----
 drivers/block/drbd/drbd_main.c         |  7 +++---
 drivers/block/drbd/drbd_nl.c           | 41 +++++++++++++++++++++-------------
 drivers/block/drbd/drbd_state.c        | 18 +++++++--------
 drivers/block/drbd/drbd_state_change.h |  8 +++----
 drivers/cdrom/cdrom.c                  |  3 +--
 6 files changed, 46 insertions(+), 39 deletions(-)

-- 
Jens Axboe

