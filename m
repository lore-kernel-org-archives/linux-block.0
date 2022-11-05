Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C00C433FE
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 14:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKEOol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOol (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 10:44:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA69DFCB
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 07:44:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso10765735pjc.0
        for <linux-block@vger.kernel.org>; Sat, 05 Nov 2022 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLGRKYeIZFcNxsir6h40pgc12Om8jgMc2MuzPye2fF0=;
        b=QByFh4opDMf6CJR9yhCF1EZgmTf2BCUa9DUgnmjrp7BK4fH27fHw0hVjKr78oX60ac
         CUcwAM4FqScM17ZwnjZ8ofHe3JrbyrcLu4ahyglpFJkK3xre84F0AStFEQE4+ZTMgZK8
         ktApjEWEmb3WniGt/Tf/0sMKRAarpU2X+kWJHCmmMxVEZqnphUFrRKuME2iKDLcBeBe4
         Fr5gcn52kcvrS/GJFgnQoBKaLjXparTM/q4fKrsy4eHZNRQ4a72XVsmYYn+Zb0CQTtAV
         xDw8g8RdL/+M9jkWwbxsa4VXl6oRn21YZHV/SyZbS2438Omz8/sITIpBrBVR1lCibqYz
         5KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CLGRKYeIZFcNxsir6h40pgc12Om8jgMc2MuzPye2fF0=;
        b=xD9ifnGe/nZw370WAK4Opmq3NGWG5JMiWN1GvWfFQ4C6KwShVkte90WkjqpdPTHk02
         bGfdKvuRJA7crbFo21gtgdi6MLEmjQtpRiFReoBLtFFvb1tqakuJY/C3ixVCzUGhAhc/
         Su9fX/5hPl5mGuWM7xa1Z3svPeSWdACgc6N7hBe+eDMjsCIcVzqAhJJEz/U1tuiMigLv
         PhLj7/Rt5m49PGXXICamGa3cwnf6ZVm0g5qaNs69IQ77sp3FSqbZ9HpI7Lx4mGaxwE37
         ZQAAMaafHC/H95eq4q1ZcHkg1KFKIXRXOa7eENy2xnLPAybNCNsERMB4kB12C2XKzSxL
         6t2g==
X-Gm-Message-State: ACrzQf0UDRgu2sHLOoWHzEmVUg8Bk5ZeZ8JctQdYCE4uPN41GBhKEv4v
        OlYn+9Y3SHtCYSxHPzBo5uVFhji7/WV+viJx
X-Google-Smtp-Source: AMsMyM6bA5qKVCqjD27iZ1szpHGdBTGu5DuZXCZmz1X9MSRKIClRh77Dz568VELmPUFwqv5MIZ6vkw==
X-Received: by 2002:a17:902:e154:b0:186:f0d5:1ac0 with SMTP id d20-20020a170902e15400b00186f0d51ac0mr40299272pla.15.1667659478429;
        Sat, 05 Nov 2022 07:44:38 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b001766a3b2a26sm1779177ple.105.2022.11.05.07.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 07:44:37 -0700 (PDT)
Message-ID: <7ecce2b9-6a43-5597-5f7d-2679ebaff4e5@kernel.dk>
Date:   Sat, 5 Nov 2022 08:44:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.1-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should go into the next rc:

- Set of fixes for the ublk driver (Ming)

- Two fixes for error handling memory leaks (Chen Jun, Chen Zhongjin)

- Explicitly clear the last request in a chain when the plug is flushed,
  as it may have already been issued (Al)

Please pull!


The following changes since commit e3c5a78cdb6237bfb9641b63cccf366325229eec:

  blk-mq: Properly init requests from blk_mq_alloc_request_hctx() (2022-10-28 07:54:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-11-05

for you to fetch changes up to 878eb6e48f240d02ed1c9298020a0b6370695f24:

  block: blk_add_rq_to_plug(): clear stale 'last' after flush (2022-10-31 20:21:38 -0600)

----------------------------------------------------------------
block-6.1-2022-11-05

----------------------------------------------------------------
Al Viro (1):
      block: blk_add_rq_to_plug(): clear stale 'last' after flush

Chen Jun (1):
      blk-mq: Fix kmemleak in blk_mq_init_allocated_queue

Chen Zhongjin (1):
      block: Fix possible memory leak for rq_wb on add_disk failure

Ming Lei (4):
      ublk_drv: return flag of UBLK_F_URING_CMD_COMP_IN_TASK in case of module
      ublk_drv: comment on ublk_driver entry of Kconfig
      ublk_drv: avoid to touch io_uring cmd in blk_mq io path
      ublk_drv: add ublk_queue_cmd() for cleanup

 block/blk-mq.c           |   5 +--
 block/genhd.c            |   1 +
 drivers/block/Kconfig    |   6 +++
 drivers/block/ublk_drv.c | 115 ++++++++++++++++++++++++++++-------------------
 4 files changed, 77 insertions(+), 50 deletions(-)

-- 
Jens Axboe
