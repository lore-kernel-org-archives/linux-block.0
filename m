Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E03C433F5
	for <linux-block@archiver.kernel.org>; Sat, 13 Nov 2021 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D99F6112F
	for <linux-block@archiver.kernel.org>; Sat, 13 Nov 2021 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhKMQyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Nov 2021 11:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhKMQyC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Nov 2021 11:54:02 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3DC061766
        for <linux-block@vger.kernel.org>; Sat, 13 Nov 2021 08:51:09 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id k21so15332765ioh.4
        for <linux-block@vger.kernel.org>; Sat, 13 Nov 2021 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rZ5kLkwG/Pl3SUxIQXbWTApi1C8zID/4vBoMcy2FIdg=;
        b=kxUY/NDeExvqHMMMG6PIxkH8U2ab+bVUdPyCvsikr6uUz5YuVLhx4OJ8eogLbpqBog
         J4ZSuRBbYufWxnd0PZJy0hCH+ORjz6scIWARIJIcwc+VGABLKiVnHqtP01HXvM9/+DCL
         sL1JmYk9+EgtyCDbN5mZPT9rQmwq1z0hq52Q84eahA8OTJ7pCa9xoNjp7+Lhr5diVmob
         /DgDYksXaPeLmqoeRo37p6ZdjfFEcDASZr/gdHA7k9JaTHMNVNyx0UEaFIwc7MZnBQxx
         ywPbMjfF23dRoUUH3cpphOrc6Iv42c60OEWNei5UWnLwiA4XQxHZHW2FFK2urzks7x33
         kFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rZ5kLkwG/Pl3SUxIQXbWTApi1C8zID/4vBoMcy2FIdg=;
        b=Oz0VWlmbcBDdT96T7FRYRW9pKguZBQZNQ7T2ksKLuNWlLAEkBkX9Js3ecWzGA/vTOo
         Xe/pwU7lqTzNw4/KeLOuv/g0AmnQ+/JIBZ4x9yX6boF8AkJZL3ZfBEFELgU7+PyoM3Cx
         A9h6dKr5OZs0xL1+qWypXeM6QuzRUuKiCtpI4w4rxlu2OqilXXkLeYZMuA470s8L9s5t
         nK3wNyu803FT585mDvcpGAfdbRaZ68aqVtl2GzO17G/fmBpOFXHCUQNRJHS52eGXHLyp
         vfUzAYkGd/k534jkKkh3XWXY2z71xgSyk6XiunLEmYjhtilcpkj9xzfrupoSzkT/mH2d
         glhQ==
X-Gm-Message-State: AOAM530GovvBDnxaZ08LHZRquUDKMZ9htAGz276zPoL1dc0i22cfLmU7
        egWZVjocUYcgT9v+9M2hB+8DJ/8hS58TeEQB
X-Google-Smtp-Source: ABdhPJxjaFUvVewrnbwTWz99sRp3TABlnrDKi/OpJGHMjVCy5uR3GWj/PqMvKuOp8D5d5g2k1aGA/w==
X-Received: by 2002:a6b:6802:: with SMTP id d2mr16262092ioc.187.1636822269040;
        Sat, 13 Nov 2021 08:51:09 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w21sm5395837iov.6.2021.11.13.08.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 08:51:08 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.16-rc1
Message-ID: <095f684a-8928-5f91-3382-a8e38fbc8c35@kernel.dk>
Date:   Sat, 13 Nov 2021 09:51:05 -0700
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

Set of fixes that should go into this merge window:

- ioctl vs read data race fixes (Shin'ichiro)

- blkcg use-after-free fix (Laibin)

- Last piece of the puzzle for add_disk() error handling, enable
  __must_check for (Luis)

- Request allocation fixes (Ming) 

- Misc fixes (me)

Please pull!


The following changes since commit cb690f5238d71f543f4ce874aa59237cf53a877c:

  Merge tag 'for-5.16/drivers-2021-11-09' of git://git.kernel.dk/linux-block (2021-11-09 11:24:08 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-13

for you to fetch changes up to b637108a4022951dcc71b672bd101ebe24ad26d5:

  blk-mq: fix filesystem I/O request allocation (2021-11-12 09:31:13 -0700)

----------------------------------------------------------------
block-5.16-2021-11-13

----------------------------------------------------------------
Jens Axboe (2):
      block: use enum type for blk_mq_alloc_data->rq_flags
      block: fix kerneldoc for disk_register_independent_access__ranges()

Laibin Qiu (1):
      blkcg: Remove extra blkcg_bio_issue_init

Luis Chamberlain (1):
      block: add __must_check for *add_disk*() callers

Ming Lei (3):
      blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
      blk-mq: rename blk_attempt_bio_merge
      blk-mq: fix filesystem I/O request allocation

Shin'ichiro Kawasaki (3):
      block: Hold invalidate_lock in BLKDISCARD ioctl
      block: Hold invalidate_lock in BLKZEROOUT ioctl
      block: Hold invalidate_lock in BLKRESETZONE ioctl

 block/blk-core.c      |  4 +---
 block/blk-ia-ranges.c |  4 ++--
 block/blk-mq-sched.c  |  4 ----
 block/blk-mq.c        | 47 +++++++++++++++++++++++++++++++++++------------
 block/blk-mq.h        | 28 ++++++++++++++++------------
 block/blk-zoned.c     | 15 +++++----------
 block/genhd.c         |  6 +++---
 block/ioctl.c         | 24 ++++++++++++++++++------
 include/linux/genhd.h |  6 +++---
 9 files changed, 83 insertions(+), 55 deletions(-)

-- 
Jens Axboe

