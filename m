Return-Path: <SRS0=CsIW=UA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B8DC28CC1
	for <linux-block@archiver.kernel.org>; Sat,  1 Jun 2019 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7DD27693
	for <linux-block@archiver.kernel.org>; Sat,  1 Jun 2019 17:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z3znWHJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfFARUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:20:13 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45742 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFARUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jun 2019 13:20:13 -0400
Received: by mail-pf1-f178.google.com with SMTP id s11so8095528pfm.12
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2019 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7UNdOXcKcnEXur7jMzGGiBcZqSpK9Bjh6eWbInakmqw=;
        b=Z3znWHJ67Dvj5mtxy/6DqDdBQgLvJ1oz9u4bxq5tH39RCxZv1yfkugCF4HODqdVmF4
         UkMzzrVzJQIqT15zqN1AybntFJEGBP1cLsJ7FXrKaboUx8SHS30t2lE8qwNdozm8J+hW
         MwMpWSI5hZ86btuNHvfU/Loup8tAUVwANJDez4NSrGh+JxDnZ8bfnPENTX1fqv3FdYcw
         PTL+7hZN0Kp1UObGJmPYBiTJ4ns1hPShvP/uUUTwCBL0UiGAgnLXn0CD29AC6imisPb5
         R7uT0dz1eJKrC+Dw5MKCuuM4t+8dnMtueoK80mzts7kbGLk36OH+pNuK89QU+Oz6W3KI
         +q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7UNdOXcKcnEXur7jMzGGiBcZqSpK9Bjh6eWbInakmqw=;
        b=q8/6yr6KJNid+3RisnSJfuRFP9scia2Ys0+DGpR8zxkzqeHuQzpo1VXoAzqx1pMGBJ
         Hp9eCDgQ3WACZtWDO3DpovnasE7Gpc6JUf0WcsaGGMIpy7DQhRFALUBMbK9+REJCGivz
         bx9b7Vc2mINpCYLp7ApRp6rzR4qh1YYRTkC2ceb5leX1Lxu6ghnIl+TLG144/K8jiKXp
         so2o7xCzR0osbXJr3AOW/GpWIuAS46xD5YWxR3SBVpOWSEK7gmZZ+/Km51jozgurqcuS
         dcGLK8ib0WSZYge/5uLG75ShUdr6PzP7QEQ0rsuUEWjfiak2gWjoa0o6II5MszjSHQsd
         cszg==
X-Gm-Message-State: APjAAAUbIgl+Jfg+BuUVJ6QhmeQLirtcduOpKAT7AKBqq9IdJI/sCt/z
        M95EuiBVAxAb63upXAZV2mOlVuJi7RYtVw==
X-Google-Smtp-Source: APXvYqx9eqZkqI9Yk2NJBarfKRml9ug7K4KyQcOrZTmjbF3fwKJ0sdWu60YFPAdxzEANxnM9X8i7Pw==
X-Received: by 2002:a65:52c8:: with SMTP id z8mr16659607pgp.10.1559409612224;
        Sat, 01 Jun 2019 10:20:12 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id x10sm13250676pfj.136.2019.06.01.10.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 10:20:10 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.2-rc3
Message-ID: <b08832e3-1ae2-1c9d-7b82-0b31fb4ece62@kernel.dk>
Date:   Sat, 1 Jun 2019 11:20:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes that should go into this release. This pull request
contains:

- Series of patches fixing code comments / kerneldoc (Bart)

- Don't allow loop file change for exclusive open (Jan)

- Fix revalidate of hidden genhd (Jan)

- Init queue failure memory free fix (Jes)

- Improve rq limits failure print (John)

- Fixup for queue removal/addition (Ming)

- Missed error progagation for io_uring buffer registration (Pavel)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190601


----------------------------------------------------------------
Bart Van Assche (8):
      block/partitions/ldm: Convert a kernel-doc header into a non-kernel-doc header
      block: Convert blk_invalidate_devt() header into a non-kernel-doc header
      block: Fix throtl_pending_timer_fn() kernel-doc header
      block: Fix blk_mq_*_map_queues() kernel-doc headers
      block: Fix rq_qos_wait() kernel-doc header
      block: Fix bsg_setup_queue() kernel-doc header
      blk-mq: Fix spelling in a source code comment
      blk-mq: Document the blk_mq_hw_queue_to_node() arguments

Jan Kara (2):
      loop: Don't change loop device under exclusive opener
      block: Don't revalidate bdev of hidden gendisk

Jes Sorensen (1):
      blk-mq: Fix memory leak in error handling

John Pittman (1):
      block: print offending values when cloned rq limits are exceeded

Ming Lei (2):
      block: move blk_exit_queue into __blk_release_queue
      block: don't protect generic_make_request_checks with blk_queue_enter

Pavel Begunkov (1):
      io_uring: Fix __io_uring_register() false success

 block/blk-core.c       | 81 +++++++-------------------------------------------
 block/blk-mq-cpumap.c  | 10 +++++--
 block/blk-mq-pci.c     |  2 +-
 block/blk-mq-rdma.c    |  4 +--
 block/blk-mq-virtio.c  |  4 +--
 block/blk-mq.c         |  5 +++-
 block/blk-rq-qos.c     |  7 +++--
 block/blk-sysfs.c      | 47 +++++++++++++++++++----------
 block/blk-throttle.c   |  2 +-
 block/blk.h            |  1 -
 block/bsg-lib.c        |  1 +
 block/genhd.c          |  4 +--
 block/partitions/ldm.c |  2 +-
 drivers/block/loop.c   | 18 ++++++++++-
 fs/block_dev.c         | 25 ++++++++++------
 fs/io_uring.c          |  2 +-
 16 files changed, 102 insertions(+), 113 deletions(-)

-- 
Jens Axboe

