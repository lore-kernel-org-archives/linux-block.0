Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A6FC43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8B4206C3
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 17:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J3k+LJMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLTRvn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:51:43 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36543 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTRvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 12:51:42 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so8660559iln.3
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2019 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bF5zpNQjZVrG8GbR7spp80rbVDm5IlmhBGNSopBcmC4=;
        b=J3k+LJMlXcwHxIXsi5FSqpOOmD5cqMuzDWAmj1PSE8raXbrcwQjhdq364lUcpXKvIM
         epO8BH7N1IgBNJI6S01/3MNeSMQGS3exNPxTl6uWWytTNO8MOSQzDyqh/aC9G8LCAgkN
         ahhTyHpYVKH4ZJEIFouEP/i2rHeBCQXB5zIWEUma/gtgszncni1UKlkhsfKHhTsXN3Tz
         K6AMS1L8ZlQBtujOUA+WUb8SVWKipiOXh3446iN/9TILi2hxRJC0qM012s5/LCZTEJZK
         na8Znnlaw1yY7EJHIrJSbsfFFbHm+nnltT+r27B04pdeVHDc64gywiOjl/0QWGQ/sxQ8
         RyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bF5zpNQjZVrG8GbR7spp80rbVDm5IlmhBGNSopBcmC4=;
        b=d4smTSuTdNHvuQ7Lv0ZzXSUpPX8u/ow5XGPh5/mpyt6UCUqBNJtqidvylvyTsjN/gF
         UoduerNlcFiSmlxRSNk9RPC+7S9rVx3vgl/9OY/iHm9CrZHj1+qLFhqL30c5vhS+71Os
         gNhVxUfeGy19olzXqTwzjL5E1wBZED74UR05n9WBDzJWmJQjGV+wYaAwKAgr0bksbdVl
         Rxa5Yl01gO8huT3WCLmdg1MJwnq3c1Kw/RLdM0MZeEgXwEAeeXIZKZYi6ULtgGCbZ5PI
         sCpUdLFw3AdJCLOmcrbFDpvY0cM85cAa0TqECudgcVTBKh1aEc73/OswFzVR9NodHIGI
         xRgg==
X-Gm-Message-State: APjAAAUfb0W0uzEjMqtTR9iO5SZUuQ+uKSHQPjC1TdQAX6HU3Ywrnnkl
        uGNSRgwZ3vdEjAO0n2qFnn4GGe6h/9xOJQ==
X-Google-Smtp-Source: APXvYqwfD0+StS/VwB2z3oN+zew08yoFkQKntvJh+bTiWF26BUGwwBOe12htpfGNjhW+zne5sdAaRg==
X-Received: by 2002:a92:35d0:: with SMTP id c77mr12797787ilf.94.1576864301959;
        Fri, 20 Dec 2019 09:51:41 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q11sm734467ioi.25.2019.12.20.09.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:51:41 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.5-rc3
Message-ID: <b596cdab-4a73-39c6-1d35-4804794cf8f4@kernel.dk>
Date:   Fri, 20 Dec 2019 10:51:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of block changes that should go into this release. This
pull request contains:

- Series from Arnd with compat_ioctl fixes

- pktdvd regression fix for 64-bit (Arnd)

- block queue flush lockdep annotation (Bart)

- Type fix for bsg_queue_rq() (Bart)

- Three dasd fixes (Stefan, Jan)

- nbd deadlock fix (Mike)

- Error handling bio user map fix (Yang)

- iocost fix (Tejun)

Please pull!
 

  git://git.kernel.dk/linux-block.git tags/block-5.5-20191220


----------------------------------------------------------------
Arnd Bergmann (5):
      pktcdvd: fix regression on 64-bit architectures
      compat_ioctl: block: handle BLKREPORTZONE/BLKRESETZONE
      compat_ioctl: block: handle BLKGETZONESZ/BLKGETNRZONES
      compat_ioctl: block: handle add zone open, close and finish ioctl
      compat_ioctl: block: handle Persistent Reservations

Bart Van Assche (2):
      block: Fix the type of 'sts' in bsg_queue_rq()
      block: Fix a lockdep complaint triggered by request queue flushing

Jan Höppner (1):
      s390/dasd/cio: Interpret ccw_device_get_mdc return value correctly

Jens Axboe (1):
      Merge tag 'block-ioctl-fixes-5.5' of git://git.kernel.org:/.../arnd/playground into block-5.5

Mike Christie (1):
      nbd: fix shutdown and recv work deadlock v2

Roman Penyaev (1):
      block: end bio with BLK_STS_AGAIN in case of non-mq devs and REQ_NOWAIT

Stefan Haberland (2):
      s390/dasd: fix memleak in path handling error case
      s390/dasd: fix typo in copyright statement

Tejun Heo (1):
      iocost: over-budget forced IOs should schedule async delay

Yang Yingliang (1):
      block: fix memleak when __blk_rq_map_user_iov() is failed

 block/blk-core.c               | 11 +++++++----
 block/blk-flush.c              |  5 +++++
 block/blk-iocost.c             | 13 ++++++++-----
 block/blk-map.c                |  2 +-
 block/blk.h                    |  1 +
 block/bsg-lib.c                |  2 +-
 block/compat_ioctl.c           | 15 +++++++++++++++
 drivers/block/nbd.c            |  6 +++---
 drivers/block/pktcdvd.c        |  2 +-
 drivers/s390/block/dasd_eckd.c | 28 +++++++---------------------
 drivers/s390/block/dasd_fba.h  |  2 +-
 drivers/s390/block/dasd_proc.c |  2 +-
 drivers/s390/cio/device_ops.c  |  2 +-
 13 files changed, 52 insertions(+), 39 deletions(-)

-- 
Jens Axboe

