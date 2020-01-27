Return-Path: <SRS0=/Ic2=3Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA4AC2D0DB
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 19:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D04E24681
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 19:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KzOXaDIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgA0TfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:35:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41189 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0TfL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 14:35:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so5363347pfw.8
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2020 11:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2yn86+GKDEiTDAG+Fx4VdeLqpfzep1e8GJZc8Z8KOAk=;
        b=KzOXaDIoTJ1uVwYlE+JP60v5axRy6CVhrz6DPTKxtNnoPcPIy//RTXn6laY6yVbcpF
         905XI+e1CIenyVzB/UHjj+OsZM4OKW5pyqJWTurGVpSKPKee6pO8gMFZYKf/BNo0PkXs
         d26GGQQWucXbB+1Bx3KkoES1LVGd8GvcsXdNHYSO9832WnWKQpUsqz/KbB402Ti/fhOH
         VNwbsIyTLMZTrUBhaljriFnjAYB/XSqZ2m96TPCu+7EzBAqvyauF+dfLXblLltOmW5LO
         NgTVvMcKYayVCCmhBdnnp7HUoJ5ScaGPwfL8qpzFTfBKU8PsvoQdrdWyauyZIm5v7SLC
         kYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2yn86+GKDEiTDAG+Fx4VdeLqpfzep1e8GJZc8Z8KOAk=;
        b=ra5EhpEmoJ3y4gqWRSewILJ3xaVKRYP7IAO0w1OvznpA1pKnKjKE+DByE5Ek3/f3SN
         p2agDC8CTmTZAUgUrInwoIs6QEYoiPdCfjmwLPQKYApPlsY0HtdEDZlMxy38LwqjFQ/w
         hAFto0gIFVK9NeU+yhOc9DR4J5TNGPwF9NvEwvged2vkJZiqEdV5sPYO53Tu8GsHwihv
         huK5T4xxZmRiJBE8W8H9b/ywIKQL8Ns1nrrdCb5W4rCYpSp14b7qkxTHopyX4nPOlnaf
         MYuiMZ/RYUR7I8IX05RUHs4FRtIOAEsM+cN7ctBwkboiU22pHp0mrj5iy44XHItzXZpe
         63NQ==
X-Gm-Message-State: APjAAAXcDpTpq0WAj+c2cP9WHknpFXOAlVSgFb2i2UER23CVUO6GSsfd
        cvK91sRTH7z1Oc/brLscpAKzRZ+uRQs=
X-Google-Smtp-Source: APXvYqwhvQGj+pjlXrsw0Yzc0NyWVe1xyNqy8KbeY3V30Di+odY7Omp5IBMlQOb5UySPSApeLibnPw==
X-Received: by 2002:a65:6447:: with SMTP id s7mr21933085pgv.325.1580153709834;
        Mon, 27 Jan 2020 11:35:09 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11c2? ([2620:10d:c090:180::dec1])
        by smtp.gmail.com with ESMTPSA id b15sm17044553pgh.40.2020.01.27.11.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 11:35:09 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 5.6-rc
Message-ID: <80ededdb-90de-6120-4250-252f019d78b4@kernel.dk>
Date:   Mon, 27 Jan 2020 12:35:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This may be the most quiet round we've had in years. I'm not
complaining. Really not a lot to detail here, outside of spelling and
documentation improvements/fixes, we have:

- Allow t10-pi to be modular (Herbert)

- Remove dead code in bfq (Alex)

- Mark zone management requests with REQ_SYNC (Chaitanya)

- BFQ division improvement (Wen)

- Small series improving plugging (Pavel)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.6/block-2020-01-27


----------------------------------------------------------------
Alex Shi (1):
      block/bfq: remove unused bfq_class_rt which never used

André Almeida (1):
      blk-mq: Document functions for sending request

Chaitanya Kulkarni (1):
      block: mark zone-mgmt bios with REQ_SYNC

Colin Ian King (1):
      partitions/ldm: fix spelling mistake "to" -> "too"

Herbert Xu (1):
      block: Allow t10-pi to be modular

Pavel Begunkov (3):
      blk-mq: optimise rq sort function
      list: introduce list_for_each_continue()
      blk-mq: optimise blk_mq_flush_plug_list()

Wen Yang (1):
      block, bfq: improve arithmetic division in bfq_delta()

 block/Kconfig             |   6 +-
 block/Makefile            |   3 +-
 block/bfq-iosched.c       |   1 -
 block/bfq-wf2q.c          |   5 +-
 block/blk-mq.c            | 154 +++++++++++++++++++++++++++++++---------------
 block/blk-zoned.c         |   2 +-
 block/partitions/ldm.c    |   2 +-
 block/t10-pi.c            |   3 +
 drivers/nvme/host/Kconfig |   1 +
 drivers/scsi/Kconfig      |   1 +
 include/linux/list.h      |  10 +++
 11 files changed, 131 insertions(+), 57 deletions(-)

-- 
Jens Axboe

