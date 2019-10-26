Return-Path: <SRS0=tXSx=YT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6261CA9EBD
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B864222BD
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SdzxGr5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfJZN3w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:29:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44117 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfJZN3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Oct 2019 09:29:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so3578255pfn.11
        for <linux-block@vger.kernel.org>; Sat, 26 Oct 2019 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bjrS9aOrBY9wi/J4EynIuA8aIpJywM1n4ctnDMJ9wuo=;
        b=SdzxGr5o6UMaGoF9GQQpxpfmKE1I2xMbeZRsFOjZWs44eomB339Vj3R5lQToUj9hLe
         zhHMIVuz+IhrWM4+5tkI3E43KUz9l5QHbRaeKJileWWwSVXp6yhDmCjbIaMZdMfdLX5+
         uJD27fBuuTSEctyKsh1EdGY0pL/EIXUaSyU6Zj7XdYxxJzc5waaIoxJPMnartqEYhlHf
         Qt/oIAG9Gf7REFVJ6BAg5CLzKk5UDcd/By2uqU372BCavmw2v31AMSGLQAzaNNOKQw3G
         D0pP7rcLN1olSpiC1zUp47iacGKMmf7CStJ+JFsv4FO8hlQd9kAHhiEpWGPPvrWamzs2
         l2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bjrS9aOrBY9wi/J4EynIuA8aIpJywM1n4ctnDMJ9wuo=;
        b=GEoqLMQI72+S9KTEGBd2JusUMhLHKogsLCneEL6K8ZPrC3kfrCEyOrCFH06VHZB8PC
         m8aJw2j/uhblDlogA8H5iM1ABFvhXjSJM4JGgHvfcD/7dhO+3L/5KmeDRlKbVUtmO9u5
         /Vii5BFi4lMkw26bHtlqTU93B+pgcmh8VSdpb5m6W/lIstsIT8u8NsALQkg3yJEZrq9w
         m+hDhCp6c8u/tXGrvonSm/YUMLJTeEVeUbMGUVRchne0dcAQ2CAzh8AMc15mSJpcM65g
         BCXwfrasDpxmqJqGmXY1FXr+Adu3EH0KzqkfxDUrRcZoQ1NGIMtlGs07uFfXMbx8Em2z
         WZ1g==
X-Gm-Message-State: APjAAAXc3j1Nig7nnshmy8sY7muF8qDDE1fIJfbMQ8pkQRxkv5wKW6vI
        vfjfKg0Q1P4hWLDOPiAVAv1ZDROzlRAI4A==
X-Google-Smtp-Source: APXvYqwUWG0YBva0L5GirXHS0meket7yK05BkgAFvmF2JjaJRt1QBiMlUPdPdt3Rp3ByefT6ogwrVA==
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr10856520pjz.80.1572096589709;
        Sat, 26 Oct 2019 06:29:49 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id a8sm5124758pfc.20.2019.10.26.06.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 06:29:48 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Fixes for 5.4-rc5
Message-ID: <c62a7e99-e230-f879-12b6-934a60db346c@kernel.dk>
Date:   Sat, 26 Oct 2019 07:29:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of fixes that should go into this release. A bit bigger
than usual at this point in time, mostly due to some good bug hunting
work by Pavel that resulted in 3 io_uring fixes from him and 2 from me.
Anyway, this pull request contains:

- Revert of the submit-and-wait optimization for io_uring, it can't
  always be done safely. It depends on commands always making progress
  on their own, which isn't necessarily the case outside of strict file
  IO. (me)

- Series of 2 patches from me and 3 from Pavel, fixing issues with
  shared data and sequencing for io_uring.

- Lastly, two timeout sequence fixes for io_uring (zhangyi)

- Two nbd patches fixing races (Josef)

- libahci regulator_get_optional() fix (Mark)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-2019-10-26


----------------------------------------------------------------
Jens Axboe (3):
      io_uring: revert "io_uring: optimize submit_and_wait API"
      io_uring: used cached copies of sq->dropped and cq->overflow
      io_uring: fix bad inflight accounting for SETUP_IOPOLL|SETUP_SQTHREAD

Josef Bacik (2):
      nbd: protect cmd->status with cmd->lock
      nbd: handle racing with error'ed out commands

Mark Brown (1):
      ata: libahci_platform: Fix regulator_get_optional() misuse

Mike Christie (1):
      nbd: verify socket is supported during setup

Pavel Begunkov (3):
      io_uring: Fix corrupted user_data
      io_uring: Fix broken links with offloading
      io_uring: Fix race for sqes with userspace

zhangyi (F) (2):
      io_uring : correct timeout req sequence when waiting timeout
      io_uring: correct timeout req sequence when inserting a new entry

 drivers/ata/libahci_platform.c |  38 +++-----
 drivers/block/nbd.c            |  41 ++++++--
 fs/io_uring.c                  | 207 ++++++++++++++++++++++-------------------
 3 files changed, 161 insertions(+), 125 deletions(-)

-- 
Jens Axboe

