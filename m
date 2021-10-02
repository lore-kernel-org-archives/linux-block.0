Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A874C433EF
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 02:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D5D619F5
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 02:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhJBCHw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 22:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbhJBCHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 22:07:51 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03CDC061775
        for <linux-block@vger.kernel.org>; Fri,  1 Oct 2021 19:06:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 134so13705020iou.12
        for <linux-block@vger.kernel.org>; Fri, 01 Oct 2021 19:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4FymQfALAcaKIQofnLlHcpF222fbWGo9fiw52K27ltQ=;
        b=lmxM14+cFSL/S34QCp53j6xuzd53bvllFu3hv14ASLbp8CSEqcw83XjMFS6evrlz/3
         pK3+L8MH3Q0/JzcAUQOrAmGlw4VOEd3NXDcrO3Nthi1Xk6mv2uz4I5nWSQMs8VYqqagE
         0EJDyUlPvznIn5tJbmebd+SujihM+UYiNAi9gtDDeLeh6HTjLZ5AX/itTh8zoGWdrbNI
         fakG/TR4TWznyN0luxHaV9bLzb00b1bwD9G5/B/DNXhJivr+6BjS7IesdbtVd7jbbFNB
         1jmwPUjJAMsLmFaxxCEQeIRaYU+dBaPVAYLvHAR6fh0xHnbaahxNikRKcWlvrZTODPe6
         pmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4FymQfALAcaKIQofnLlHcpF222fbWGo9fiw52K27ltQ=;
        b=oGFuMZ9L2f7liiKi0IK3af0B4J7oh373xSrTLVfYIHlUF7dkYA34sNxhzj1Wo66vlL
         ZQoyvk7NTXIEgUuyRWhzD3N6djuYmEvWdNIQCQq0SjwCHs/JWfQTwe/SCQdniNUOGY7/
         dFSq+XL1NPdT6Cgw3v+KfQcidps1zzZtOqf1ggIqAxLx9MKETqopa/qvqprVsmPKO4pU
         oUEn1OWhAdoxj6+IzU3/EkjCovQT3qHn6PZYAsTD48DHXSJnGYkPwHJThpq5E42M/c77
         yJrGdyqdRSrLSBKqYUpaI1enZUOgJ5A3u4JmiOLRVw71/XbgPtm7j1dq/65NIp1OCsND
         S0NA==
X-Gm-Message-State: AOAM532WVT3l0XOvIfv/Wbx0Ii9gIYSVNdaCbqWCB/iaWFFeSvXfgDtT
        zWEge1QpMpew7OCH87e6mLrj0GCKj4Bzfw==
X-Google-Smtp-Source: ABdhPJyUO/JORvkEj8G/VZYGNMiOu3x21aqTmNRvd1+HTP5aKJZCDWIQesVfHK5kmZIV0L6H0Ka93A==
X-Received: by 2002:a6b:6b03:: with SMTP id g3mr873274ioc.218.1633140366147;
        Fri, 01 Oct 2021 19:06:06 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d1sm4621960ils.25.2021.10.01.19.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 19:06:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
Date:   Fri, 1 Oct 2021 20:06:05 -0600
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

A few block fixes for this release:

- Revert a BFQ commit that causes breakage for people. Unfortunately it
  was auto-selected for stable as well, so now 5.14.7 suffers from it
  too. Hopefully stable will pick up this revert quickly too, so we can
  remove the issue on that end as well.

- Add a quirk for Apple NVMe controllers, which due to their
  non-compliance broke due to the introduction of command sequences
  (Keith)

- Use shifts in nbd, fixing a __divdi3 issue (Nick)

Please pull!


The following changes since commit f278eb3d8178f9c31f8dfad7e91440e603dd7f1a:

  block: hold ->invalidate_lock in blkdev_fallocate (2021-09-24 11:06:58 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-01

for you to fetch changes up to 41e76c6a3c83c85e849f10754b8632ea763d9be4:

  nbd: use shifts rather than multiplies (2021-09-29 20:31:41 -0600)

----------------------------------------------------------------
block-5.15-2021-10-01

----------------------------------------------------------------
Jens Axboe (1):
      Revert "block, bfq: honor already-setup queue merges"

Keith Busch (1):
      nvme: add command id quirk for apple controllers

Nick Desaulniers (1):
      nbd: use shifts rather than multiplies

 block/bfq-iosched.c      | 16 +++-------------
 drivers/block/nbd.c      | 29 +++++++++++++++++------------
 drivers/nvme/host/core.c |  4 +++-
 drivers/nvme/host/nvme.h |  6 ++++++
 drivers/nvme/host/pci.c  |  3 ++-
 5 files changed, 31 insertions(+), 27 deletions(-)

-- 
Jens Axboe

