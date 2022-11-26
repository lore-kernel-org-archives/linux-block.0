Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60241C4167B
	for <linux-block@archiver.kernel.org>; Sat, 26 Nov 2022 00:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKZATJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Nov 2022 19:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKZATI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 19:19:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B251C38
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 16:19:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y10so5245128plp.3
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 16:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldH1jIGIkd3xFjZykZP+PqItS0IWYtIvbATF+9dnRXw=;
        b=mmP6QKWprOTLcOIty287IyowHO6F6wGFyEkgtpeomNMrKgbQy5WyHv1p7UKg29gXGU
         3B3nmVeR81Ggzap8h1jdntrehchvS9UXXa2QVl9b+ciXuS0VzikGuhY1L0FQNc5faz3Q
         QJpP9ej4zfebdGiPmImdF30g8isjY0/JxndgNraQ6rb8IAbVy7AZu3smj7iInyJsmmJD
         rRKd66/760/YJYgHfJPbTCI9t+xyIC2vnYZ41pAWLZh9T2BJBzBvHG9j0f49wVEjeeRN
         xSv2+aN/dEKfC79P+JugCu+NYz7rS3KnZVoFgB+j6CPuTRYSdAQ3AG2UhMG9dEyBB1uW
         1paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldH1jIGIkd3xFjZykZP+PqItS0IWYtIvbATF+9dnRXw=;
        b=ElfYQhCRlaQozpuBQ58cx6l/wA4u16KAsrPkTcqLrQyZrdcQCqe36QuGAcpW8tABJX
         7T0cAREq7+tLC2C5UZz/lemaAazTGablFh7EwTfaQSlVIs+cJJilUTBxFomWrI9yiyLh
         XkSypSBdGWyiyO6aNVC4+4kvt7JysvUsQyLK/tsUuTF1bhdyJ2ovZlrhSfrdttNVSOhi
         Ib+YJiwzJetX4za0qBebM6l2Yy2RfWH+3Yd+rPhBfQs0IDQ6uRsuKX0+3IDIbjUd+a+T
         bE9tdCX+Fo5XZJQcisT8wCnSwLbKzy2cnluWuuIiVTDJYwHRhlX16OWWzhNnLpqVduKj
         9Tlg==
X-Gm-Message-State: ANoB5pkMJWtI9yszfk3CkHGGv9noy+GpHtswMKf2bC3XppvA4+zOqV8a
        T2ZQF2ONhUqGEtO7/9fdV/V3kQ==
X-Google-Smtp-Source: AA0mqf5Z7OFd0GXk2uXbjaGwUzQkCv5jG8vksBgsmFyomMpaiG9IyelZZM0O11ws9o6n/5r4E7YrvQ==
X-Received: by 2002:a17:90a:bc4b:b0:212:d796:d30f with SMTP id t11-20020a17090abc4b00b00212d796d30fmr43217276pjv.9.1669421947063;
        Fri, 25 Nov 2022 16:19:07 -0800 (PST)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b00186efc56ab9sm3931106ple.221.2022.11.25.16.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:19:06 -0800 (PST)
Message-ID: <b46333b8-a233-8e8b-c688-2c579868872f@kernel.dk>
Date:   Fri, 25 Nov 2022 17:19:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.1-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few block fixes for this release:

- A few fixes for s390 sads (Stefan, Colin)

- Ensure that ublk doesn't reorder requests, as that can be problematic
  on devices that need specific ordering (Ming)

- Fix a queue reference leak in disk allocation handling (Christoph)

Please pull!


The following changes since commit 5c59789ce7ce994e1d9db1973a21f15481bd8513:

  Merge tag 'nvme-6.1-2022-11-18' of git://git.infradead.org/nvme into block-6.1 (2022-11-18 07:47:54 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-11-25

for you to fetch changes up to 7d4a93176e0142ce16d23c849a47d5b00b856296:

  ublk_drv: don't forward io commands in reserve order (2022-11-23 20:36:57 -0700)

----------------------------------------------------------------
block-6.1-2022-11-25

----------------------------------------------------------------
Christoph Hellwig (1):
      blk-mq: fix queue reference leak on blk_mq_alloc_disk_for_queue failure

Colin Ian King (1):
      s390/dasd: Fix spelling mistake "Ivalid" -> "Invalid"

Ming Lei (1):
      ublk_drv: don't forward io commands in reserve order

Stefan Haberland (3):
      s390/dasd: increase printing of debug data payload
      s390/dasd: fix no record found for raw_track_access
      s390/dasd: fix possible buffer overflow in copy_pair_show

 block/blk-mq.c                   |  7 +++-
 drivers/block/ublk_drv.c         | 82 +++++++++++++++++++---------------------
 drivers/s390/block/dasd_devmap.c |  2 +-
 drivers/s390/block/dasd_eckd.c   | 43 ++++++++++-----------
 drivers/s390/block/dasd_ioctl.c  |  2 +-
 5 files changed, 67 insertions(+), 69 deletions(-)

-- 
Jens Axboe
