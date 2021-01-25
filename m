Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DAAC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D8522583
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 20:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbhAYUNB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbhAYUMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 15:12:40 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E61C06174A
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 12:11:59 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a12so3876258qkh.10
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9nkFhjU5njicagJGun4ufUpTiD2I63Zo0PXOZCwddU=;
        b=nojJ+D4kawGxVb48gTvmnEePW6Thx1S7hWNnopt3NadONtOz5v4hB/g/RYc0e0DDUX
         D24RGBWWMBwDlhETSQxnbKMFzd2qtFkw2VeoQvIIucDjdnDkAUqQ8WuI51OFcT3Q1n2F
         w5X5/QbZwwYX7/P7YvETM4mbtNehBDVKHtbZkrwXKlsWCtn/0U6i83jEtXT6mTtbQl9J
         s77gMXxXz/NKDYMlFNSG6+XiWBpJCyM9OZ1gpvjT4pq4nUM/I5lSszpfWS6+mGodYzgI
         MGzDpaRSPwg/Yq/nPsAxRPDnu9tEohKaAFm0up7Nbk86jNr1S/40XWM9nADEMG4uhqkA
         WX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9nkFhjU5njicagJGun4ufUpTiD2I63Zo0PXOZCwddU=;
        b=SNPj07CaC3JWDsQpYgXZw/uA+EXDH1QYpo414WLttlW5x+jKQzIOx6W4Vb9RQ9GYew
         SHbkTFkIXCn9jW8rI09J7ZXEGAPx3SFp1tAoe86pdAUKDoBH8PX8xYnZ9ldCqnVXkjP5
         xqnuG6RKlzKJWx2XQTaFcH44JoYdIKoKO0QINWMbmT78OQ9uGj+v3SBPJ9nhOGZg2T77
         1azCTq1aqVARoXNZrkpcQpqgIBlZEOrwKwwB+b0LS6Qsm/7el81+BQrSGv/ygfy2S0Mv
         v/OhVIrvGpuGX3qWeCir4PWI76wEA1lhInFnUW1rMT04MsPmKFgBnx/mOkhQTt8em7pg
         jMNQ==
X-Gm-Message-State: AOAM532NxGmG7w4O/DWemFru7DuGqPO9NzWcCL3IXqKAkwzDY9J0LAEx
        wkrihfoCa2jtEzX0G1o/2XR+TBh1JVUa0A==
X-Google-Smtp-Source: ABdhPJwYKlhAOUltpHl5IUufiWHQpgdYM9D3VAOvH5xCW66euBRQbGG8vibLvusmFuMUJklo7W9ozg==
X-Received: by 2002:a37:2784:: with SMTP id n126mr2562649qkn.328.1611605518742;
        Mon, 25 Jan 2021 12:11:58 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 2sm11918564qtt.24.2021.01.25.12.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:11:58 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org, jmorris@namei.org,
        lukas.bulwahn@gmail.com, hch@lst.de, pvorel@suse.cz,
        ming.lei@redhat.com, mzxreary@0pointer.de, mcgrof@kernel.org,
        zhengbin13@huawei.com, maco@android.com, colin.king@canonical.com,
        evgreen@chromium.org
Subject: [PATCH v3 0/1] scale loop device lock
Date:   Mon, 25 Jan 2021 15:11:55 -0500
Message-Id: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changelog
v3
  - Added review-by Tyler
  - Sync with mainline
v2
  - Addressed Tyler Hicks comments
  - added mutex_destroy()
  - comment in lo_open()
  - added lock around lo_disk
===

In our environment we are using systemd portable containers in
squashfs formats, convert them into loop device, and mount.

NAME                      MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
loop5                       7:5    0  76.4M  0 loop
`-BaseImageM1908          252:3    0  76.4M  1 crypt /BaseImageM1908
loop6                       7:6    0    20K  0 loop
`-test_launchperf20       252:17   0   1.3M  1 crypt /app/test_launchperf20
loop7                       7:7    0    20K  0 loop
`-test_launchperf18       252:4    0   1.5M  1 crypt /app/test_launchperf18
loop8                       7:8    0     8K  0 loop
`-test_launchperf8        252:25   0    28K  1 crypt app/test_launchperf8
loop9                       7:9    0   376K  0 loop
`-test_launchperf14       252:29   0  45.7M  1 crypt /app/test_launchperf14
loop10                      7:10   0    16K  0 loop
`-test_launchperf4        252:11   0   968K  1 crypt app/test_launchperf4
loop11                      7:11   0   1.2M  0 loop
`-test_launchperf17       252:26   0 150.4M  1 crypt /app/test_launchperf17
loop12                      7:12   0    36K  0 loop
`-test_launchperf19       252:13   0   3.3M  1 crypt /app/test_launchperf19
loop13                      7:13   0     8K  0 loop
...

We have over 50 loop devices which are mounted  during boot.

We observed contentions around loop_ctl_mutex.

The sample contentions stacks:

Contention 1:
__blkdev_get()
   bdev->bd_disk->fops->open()
      lo_open()
         mutex_lock_killable(&loop_ctl_mutex); <- contention

Contention 2:
__blkdev_put()
   disk->fops->release()
      lo_release()
         mutex_lock(&loop_ctl_mutex); <- contention

With total time waiting for loop_ctl_mutex ~18.8s during boot (across 8
CPUs) on our machine (69 loop devices): 2.35s per CPU.

Scaling this lock eliminates this contention entirely, and improves the boot
performance by 2s on our machine.

v2 https://lore.kernel.org/lkml/20200723211748.13139-1-pasha.tatashin@soleen.com
v1 https://lore.kernel.org/lkml/20200717205322.127694-1-pasha.tatashin@soleen.com

Pavel Tatashin (1):
  loop: scale loop device by introducing per device lock

 drivers/block/loop.c | 92 +++++++++++++++++++++++++-------------------
 drivers/block/loop.h |  1 +
 2 files changed, 54 insertions(+), 39 deletions(-)

-- 
2.25.1

