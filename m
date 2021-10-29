Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488AC433F5
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 15:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50170610FD
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhJ2PLF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJ2PLE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 11:11:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D4C061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 08:08:36 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g8so11590541iob.10
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Wg12jtnJUebZTlLZl49X+DQiScWcL6+PgN0u+A1DvFw=;
        b=6RzpFYv1EKF320lMXHQSSrj71r7hxnaQj+h8PHYrKpr/csh+yHSdicADHvcnDwSZtS
         y3EeN9HBED5cKwsukV35JdDF8MjWV1SBEqiqhfROfb3GKDvsu6Yg5gINS6zQLJsSyU62
         BNfoqcOTBVtiOvju3ShHdpnhDquQTBbCDdkokdQ34nYsR59mLR4HxM6siVGdQ68KHj1a
         IPoVUlP49h7LwM5Rql+bQ3rC/CM1S39xOMEsPjEq+gePP0yKWuDVWIhiow79fQy3ZnwJ
         Nq0kbj/uXwiVmMnh0vIFWtHMKWGUcYK8WAigskRExutG69sS0/1Am+uZe6/SavLK8M0F
         rlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Wg12jtnJUebZTlLZl49X+DQiScWcL6+PgN0u+A1DvFw=;
        b=W6Lv0ITLM1Uu2LzZZcIfGEFj+RCcjVNTkXmERQm8RgHbwfkSGoxs7SE+8OThydu1Q2
         tKdrtyBh/oLKGG5SHZnfl1V4sf4ykiIcchMJDuiA82GdiAsn3fzdiAC9IEE8cQj9ioES
         ZldUhVL26bl32Xo2G7gEHJPX6SUCBTn+oeV9NWeDo/vDUVZ9oRXWAonsVapaS/l/8eET
         8ceWwHCv31Ai5vnygESrpIty8XDdc/nGpHP4yJ7NSrnGGpKYJQ5pHO3mjvHsU3u8A5Sp
         Cde65XIJSBMIMgYD/hbTYjmgJtDZqraEl2o04tvfOqLRCz2/4N0aSX784AeQcfoaYQs/
         zaZA==
X-Gm-Message-State: AOAM531vNY4WgHRNJKsbG2CbAYTjeblUmXyF29+iJYdTEsJeexCHzFkq
        KxsXwe2nLiaQQTlgO7bGPKZSi4y6QMBkOw==
X-Google-Smtp-Source: ABdhPJxtUWS1fYIf6pzyHb9sQ1s8pHw6uzmxvJRNttbx4b2cDfN9A/3qC2EEVhgEpCvk3lQehJU04w==
X-Received: by 2002:a02:880a:: with SMTP id r10mr8322726jai.40.1635520115282;
        Fri, 29 Oct 2021 08:08:35 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t5sm3171010ilp.8.2021.10.29.08.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 08:08:34 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-final
Message-ID: <f86feb9d-f667-66d1-1ffe-d74f83847d3a@kernel.dk>
Date:   Fri, 29 Oct 2021 09:08:34 -0600
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

Fixes that should go into this release:

- NVMe pull request
	- fix nvmet-tcp header digest verification (Amit Engel)
	- fix a memory leak in nvmet-tcp when releasing a queue
	  (Maurizio Lombardi)
	- fix nvme-tcp H2CData PDU send accounting again (Sagi Grimberg)
	- fix digest pointer calculation in nvme-tcp and nvmet-tcp
	  (Varun Prakash)
	- fix possible nvme-tcp req->offset corruption (Varun Prakash)

- Queue drain ordering fix (Ming)

- Partition check regression for zoned devices (Shin'ichiro)

- Zone queue restart fix (Naohiro)

Please pull!


The following changes since commit 9fbfabfda25d8774c5a08634fdd2da000a924890:

  block: fix incorrect references to disk objects (2021-10-18 11:20:38 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-29

for you to fetch changes up to f4aaf1fa8b17e74aa46bf0165c35a1575b239d4e:

  Merge tag 'nvme-5.15-2021-10-28' of git://git.infradead.org/nvme into block-5.15 (2021-10-28 08:34:01 -0600)

----------------------------------------------------------------
block-5.15-2021-10-29

----------------------------------------------------------------
Amit Engel (1):
      nvmet-tcp: fix header digest verification

Jens Axboe (1):
      Merge tag 'nvme-5.15-2021-10-28' of git://git.infradead.org/nvme into block-5.15

Maurizio Lombardi (1):
      nvmet-tcp: fix a memory leak when releasing a queue

Ming Lei (1):
      block: drain queue after disk is removed from sysfs

Naohiro Aota (1):
      block: schedule queue restart after BLK_STS_ZONE_RESOURCE

Sagi Grimberg (1):
      nvme-tcp: fix H2CData PDU send accounting (again)

Shin'ichiro Kawasaki (1):
      block: Fix partition check for host-aware zoned block devices

Varun Prakash (3):
      nvme-tcp: fix possible req->offset corruption
      nvme-tcp: fix data digest pointer calculation
      nvmet-tcp: fix data digest pointer calculation

 block/blk-mq.c            | 13 +++++++++----
 block/blk-settings.c      | 20 +++++++++++++++++++-
 block/genhd.c             | 22 ++++++++++++----------
 drivers/nvme/host/tcp.c   |  9 ++++++---
 drivers/nvme/target/tcp.c |  7 +++++--
 5 files changed, 51 insertions(+), 20 deletions(-)

-- 
Jens Axboe

