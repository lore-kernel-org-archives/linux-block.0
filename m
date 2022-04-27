Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C81C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 21:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiD0VhQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbiD0Vf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 17:35:27 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E127153
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:15 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id p6so2670816plf.9
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xb894kKqMCbIsOzS7hWHe8SWoEAxpACx1g/g3a5/MwI=;
        b=hHyrv8YORSddyXcEq/1S6e8cGnQoz1oP8n9PsLFZ7by5d2ueccaDrSwW7rb+TUHAYB
         IzYtraB6DCgqjunR/LyfekyIfehFXOmenoP6e35eSCOy5t/IhXX0Zm5tG8DQB364gMmL
         yT96iidjqxSUWJzZiy5K2L5iHUxV7ylRuESF0oYyYZRls9nm4gZF7oUh+AW7x4P/hM4k
         8kZ0Y4oIMtGx7BQ+vb/wTGZ3mwnh/tFYL1dRXJp5UKFl/xk0YoIeewmDzcSNDLqHmfYA
         4TJOwidyw7zglRdLUJZ8AkrqC4viC0RcezBh0P/mA43bdaE/SO8iiboJsTqHBH87NKAK
         2ZqQ==
X-Gm-Message-State: AOAM531f5XzMYnaar6EpRvL0KspIEfri6PvY+yLFICPV3a1qds9GU9X9
        buQwBtcEpwZc6iUyAnKw413nskkshKytQA==
X-Google-Smtp-Source: ABdhPJzggr5snTMtDiWslXWNSl/bNI2ftiWdZQmO7MhE+U6dZpO81tj4XF2YSJIjkVS6KZtmuItUfw==
X-Received: by 2002:a17:902:db10:b0:15c:e4d6:4b10 with SMTP id m16-20020a170902db1000b0015ce4d64b10mr24513498plx.44.1651095134240;
        Wed, 27 Apr 2022 14:32:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
        by smtp.gmail.com with ESMTPSA id nm6-20020a17090b19c600b001cd4989fedbsm7700112pjb.39.2022.04.27.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:32:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 0/3] Add QD=1 and gap zone tests
Date:   Wed, 27 Apr 2022 14:31:40 -0700
Message-Id: <20220427213143.2490653-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

This patch series adds two tests for queue depth one and two tests for SCSI
devices with gap zones. Please consider these patches for inclusion in the
official blktests repository.

Thanks,

Bart.

Bart Van Assche (3):
  Introduce the io_schedulers() function
  Add I/O scheduler tests for queue depth 1
  tests/scsi: Add tests for SCSI devices with gap zones

 common/iosched             | 12 +++++++
 common/multipath-over-rdma | 11 ------
 common/rc                  |  5 +++
 tests/block/005            |  4 +--
 tests/block/014            |  7 ++--
 tests/block/015            |  7 ++--
 tests/block/020            |  7 ++--
 tests/block/021            |  6 ++--
 tests/block/032            | 62 +++++++++++++++++++++++++++++++++
 tests/block/032.out        |  2 ++
 tests/nvmeof-mp/012        |  3 +-
 tests/scsi/008             | 63 ++++++++++++++++++++++++++++++++++
 tests/scsi/008.out         |  2 ++
 tests/scsi/009             | 56 ++++++++++++++++++++++++++++++
 tests/scsi/009.out         |  2 ++
 tests/scsi/010             | 70 ++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out         |  2 ++
 tests/srp/012              |  3 +-
 18 files changed, 290 insertions(+), 34 deletions(-)
 create mode 100644 common/iosched
 create mode 100755 tests/block/032
 create mode 100644 tests/block/032.out
 create mode 100755 tests/scsi/008
 create mode 100644 tests/scsi/008.out
 create mode 100755 tests/scsi/009
 create mode 100644 tests/scsi/009.out
 create mode 100644 tests/scsi/010
 create mode 100644 tests/scsi/010.out

