Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3462C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 16:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698B22086A
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="geqmG9h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436819AbfHIQFo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:05:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34091 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHIQFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 12:05:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so39859073pgc.1
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2019 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zKKoOqHywF2bTPoVET6LAftqPnv09CFIlUAmHA3SV2g=;
        b=geqmG9h9RvP21uXyRyTUIL7SV0q8fpx1voDVXvKTJorpxgvGWo9pFIjCnkGNZpkOUK
         R3RhpTqLdMxB3SCO4RZVZCFQEaz8fTwQO0Y1h0Fd2e0jcfWDKlCmakzY6GJFNoLYz2Rx
         rNCgUE9IqdP/xnltxqT+6qwIGm/uLoGhXAOFX1+Nevkl+5bZDah+EwTfajXfmK7KRdvH
         jm9hGi4Sqw5q1I9PpCz1/QSblYE2K0WL0iTdF7g6pCHPPj4eCbpNbWgAKP92VPxMHZru
         nVGEWdw/ReFelWWYPEjsx0me3HCQbMO9uDwVtUVaSOJNdKl/UNcdADuA8j5plWiLHQJV
         vJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zKKoOqHywF2bTPoVET6LAftqPnv09CFIlUAmHA3SV2g=;
        b=XBjNMLOFBem0LPQzJfoGY0fnK80HWQn9nw0j4j23lRWg+xwN3YCL7GKpfMB/dmHq4w
         ym/Wv+l/pxWKswhrG2Eff3kqSmdaTspD6Y5WNXm7aeZQkfdxxbwOmFqWSjNthu3A8TFS
         5GioqUBKnEvbPVlqe+Pzqsjmn8yszkX4L8iMfw4HGLpDriTpBcJtTXJlqMINGZIsf4hI
         eIB5KsB12HYiDn76JnQ6Y9KhtR4f+4+nRGZUNdNGVlmLECz3DYmocCS0B/0Opv65i030
         N7t//eMCbgO8jmfECJd+X+TZt2ubS6aGVi5iU26BuCjLo3p0B/4qKDlE49zDCUneq8G9
         Rynw==
X-Gm-Message-State: APjAAAWdLgHz8dSl3q0LCjSHjgsXTZxlIWip3o2gS52EBdZLET/NQ5tK
        BT360CrG6/YUVZiAnEoEN/kheQ4lo23MlA==
X-Google-Smtp-Source: APXvYqxUIjX3nWU2W4xG/1hfqwZCMtnBSbR2q0hZe7+f4WEi6ry8dgfN1GREIBC9O2fYe6F3YEyFMg==
X-Received: by 2002:aa7:8804:: with SMTP id c4mr21999678pfo.65.1565366743107;
        Fri, 09 Aug 2019 09:05:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:8460:a1eb:bc6a:7081? ([2605:e000:100e:83a1:8460:a1eb:bc6a:7081])
        by smtp.gmail.com with ESMTPSA id v14sm20895088pgi.79.2019.08.09.09.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 09:05:42 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.3-rc4
Message-ID: <f3f005d2-701c-c943-b906-675d58d1164c@kernel.dk>
Date:   Fri, 9 Aug 2019 09:05:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of fixes that should go into this release. This pull
request contains:

- Revert of a bcache patch that caused an oops for some (Coly)

- ata rb532 unused warning fix (Gustavo)

- AoE kernel crash fix (He)

- Error handling fixup for blkdev_get() (Jan)

- libata read/write translation and SFF PIO fix (me)

- Use after free and error handling fix for O_DIRECT fragments. There's
  still a nowait + sync oddity in there, we'll nail that start next
  week. If all else fails, I'll queue a revert of the NOWAIT change. (me)

- Loop GFP_KERNEL -> GFP_NOIO deadlock fix (Mikulas)

- Two BFQ regression fixes that caused crashes (Paolo)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190809


----------------------------------------------------------------
Coly Li (1):
      bcache: Revert "bcache: use sysfs_match_string() instead of __sysfs_match_string()"

Gustavo A. R. Silva (1):
      ata: rb532_cf: Fix unused variable warning in rb532_pata_driver_probe

He Zhe (1):
      block: aoe: Fix kernel crash due to atomic sleep when exiting

Jan Kara (1):
      bdev: Fixup error handling in blkdev_get()

Jens Axboe (3):
      block: fix O_DIRECT error handling for bio fragments
      libata: have ata_scsi_rw_xlat() fail invalid passthrough requests
      libata: add SG safety checks in SFF pio transfers

Mikulas Patocka (1):
      loop: set PF_MEMALLOC_NOIO for the worker thread

Paolo Valente (3):
      block, bfq: reset last_completed_rq_bfqq if the pointed queue is freed
      block, bfq: move update of waker and woken list to queue freeing
      block, bfq: handle NULL return value by bfq_init_rq()

 block/bfq-iosched.c         | 68 +++++++++++++++++++++++++++++++--------------
 drivers/ata/libata-scsi.c   | 21 ++++++++++++++
 drivers/ata/libata-sff.c    |  6 ++++
 drivers/ata/pata_rb532_cf.c |  1 -
 drivers/block/aoe/aoedev.c  | 13 +++++++--
 drivers/block/loop.c        |  2 +-
 drivers/md/bcache/sysfs.c   | 20 +++++++------
 fs/block_dev.c              | 33 +++++++++++-----------
 8 files changed, 113 insertions(+), 51 deletions(-)

-- 
Jens Axboe

