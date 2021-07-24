Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5255BC4338F
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 15:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2869A60E8E
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 15:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGXPK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Jul 2021 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGXPKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jul 2021 11:10:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90535C061575
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 08:50:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso8881527pjn.1
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Sg3HZ2LWmsxvN1PjwE9Zhub2tv7T+zAL42fZfnh0dfc=;
        b=Klnb+O813Iht8GL9jYb5KrCv2cEHdIH8ABCBRDQwcIkDHaWeMAR2hBeCuDfPyBT6Wo
         iTGi186kwwchA40+sH+QRAhKe0xi9S6YQSZ9UtIBemmHmRLBLiA4xl5qHSfvSfRxXNxW
         GU8cFirx9m/ZuCuh+A9W4T+il+OD84Gbu5KjNJ9/QLexvgJ+5+9ii8HLUFlF/cDmf7mg
         9qV2K67MKWUuEFU8DM5XXonBwWSi20Q8LVrBx1diz5lsbCJ90cnTNOJ3KsjrNamSSUoi
         3LahRcw/9SZ9agCEBxorv3Wa7oCT0xvLrPkNx+a7hsj8Uj9OEVaysxYyk6U9MjlLAEG8
         s9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Sg3HZ2LWmsxvN1PjwE9Zhub2tv7T+zAL42fZfnh0dfc=;
        b=f4aLVB3UeQC5LP50ZHHkHMCsmubTbsmO5w/ZqqiRqrOS1zB98cHhHIrCoJRUmpgD+j
         T6sdWYGs2+GLHW2ZgYIAzV8VFXz6TDMBXJVdcAFdF/SBd6snijETVCbsVg8gFrJQyuKl
         WZmSoVYodbxrGV0ElmI4ZUiDpW6gkNLWGQ1mfxwmoUc+oBzOMzdXj2Wf7nM3pR4dQ0lG
         ML5ERcuu+wnb2O/dgkZz5jA0qBaYlsp0AMfgjmBBptNXhoVRnsQuSCcLECB2IC2afY9B
         SDftTfHs9PBy7CMYVdnLaCpRgfe9/I7T4DV/bgN7tJ4wy7xTLn4hUfiLRfLfwYXC89e3
         C9OQ==
X-Gm-Message-State: AOAM531NHcOBR58hJ+3DSMRY5vltJRqYpECRDyljvUUNkXPQ0cUd3HEA
        30s/1Z/8Rq5ACWHumlx3/ri0z9j3fcmRA+X5
X-Google-Smtp-Source: ABdhPJwJn1lK9Mo7VFR/ShUluf9CoD9/DpY0zcXBGLsVmAQyRVsgt5GR15ITS+IllkcPIhd2QXaYiA==
X-Received: by 2002:a17:902:a513:b029:11a:9be6:f1b9 with SMTP id s19-20020a170902a513b029011a9be6f1b9mr7732053plq.55.1627141856687;
        Sat, 24 Jul 2021 08:50:56 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id u188sm12199092pfc.115.2021.07.24.08.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 08:50:56 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.14-rc3
Message-ID: <b5a906fb-0e55-cfb1-ba4b-d12ecc3a42d4@kernel.dk>
Date:   Sat, 24 Jul 2021 09:50:54 -0600
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

A few fixes for the 5.14 release:

- NVMe pull request (Christoph)
	- tracing fix (Keith Busch)
	- fix multipath head refcounting (Hannes Reinecke)
	- Write Zeroes vs PI fix (me)
	- drop a bogus WARN_ON (Zhihao Cheng)

- Increase max blk-cgroup policy size, now that mq-deadline uses it too
  (Oleksandr)

Please pull!


The following changes since commit 05d69d950d9d84218fc9beafd02dea1f6a70e09e:

  xen-blkfront: sanitize the removal state machine (2021-07-15 09:32:34 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-24

for you to fetch changes up to 7054133da39a82c1dc44ce796f13a7cb0d6a0b3c:

  Merge tag 'nvme-5.14-2021-07-22' of git://git.infradead.org/nvme into block-5.14 (2021-07-22 14:23:55 -0600)

----------------------------------------------------------------
block-5.14-2021-07-24

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: set the PRACT bit when using Write Zeroes with T10 PI

Hannes Reinecke (1):
      nvme: fix refcounting imbalance when all paths are down

Jens Axboe (1):
      Merge tag 'nvme-5.14-2021-07-22' of git://git.infradead.org/nvme into block-5.14

Keith Busch (1):
      nvme: fix nvme_setup_command metadata trace event

Oleksandr Natalenko (1):
      block: increase BLKCG_MAX_POLS

Zhihao Cheng (1):
      nvme-pci: don't WARN_ON in nvme_reset_work if ctrl.state is not RESETTING

 drivers/nvme/host/core.c      | 19 +++++++++++++++----
 drivers/nvme/host/multipath.c |  9 ++++++++-
 drivers/nvme/host/nvme.h      | 11 ++---------
 drivers/nvme/host/pci.c       |  4 +++-
 drivers/nvme/host/trace.h     |  6 +++---
 include/linux/blkdev.h        |  2 +-
 6 files changed, 32 insertions(+), 19 deletions(-)

-- 
Jens Axboe

