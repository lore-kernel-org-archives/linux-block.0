Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13AFC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 03:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAC12087B
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 03:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc/McHgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfDUDxl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 23:53:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38933 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDUDxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 23:53:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id f125so8114qke.6;
        Sat, 20 Apr 2019 20:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N/VQEvHt12V6NNBwxqDS9TlB5pbHfWUD7eNc/4Ye5XQ=;
        b=Xc/McHgtOHcqDBkLWalsqOUbEMogmVXPI0U+HiXsgLdib0+sm2q6AwJVYCvO/vPxqg
         bFgFVR7BGuZQukKCEJ39bkEr68LE+93ZOfE5hVotQbqXC3H3lQgEl2Lmmq5YZdIztuDo
         +2Oa7gGsux/dj76MCgkW7k0Z7BFPsEK2C7u2csRwdelJx7UtkeEgusnxyO9VdMC9ET4f
         4GMx0eW/QUrs+GyBqgI1XUMSiOiV8kHqcl4SX6Rdi4f1YajLabpqXngGgLVLrjh5T2OP
         s2noUvGlswzYDw6wi6Ib993+7gwDezyQwH5jWg/xd77HuxcIv1rGxl+qGA/Z8iudUJfS
         Baog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N/VQEvHt12V6NNBwxqDS9TlB5pbHfWUD7eNc/4Ye5XQ=;
        b=hX1NPQsJXG9rcKMNt3ixkv1bGvo1N3Mro879xgrrk8o+LAecPKv5hjrnDjRJzmslcg
         Jh19bgiMl+ZxOS/H8CUwOnyktNp/YigrT/YWiBKFh9u+4VaVFuvA8mpRtVYPHMjiQUPj
         VUWUYJhj2trF51Unf6lmoeoHvsWkuTbvF8wm+XrDqdnnQv+IBJnixLqjx6QcFiCAe2fq
         aO4WwaetbqAYq6q44oleW5FptQEmUTTT5NJu2+QIaieTFhnSlGCzHww8RdQ/ophLpaMT
         xzCDuEY79FQ7M5lZrTRDklQX2MkDY6rRqKgRJKFbovG2UdT0mxWrX0DsmCECJWYrZxzJ
         V7iA==
X-Gm-Message-State: APjAAAXfRaW8H/VLHL11+qmMUBJQ6gkefzo7x3C5aQNTRkAlD1p7WiAi
        AHw0iWiw0W0wwbX64XKMdeUPVeRHYzo=
X-Google-Smtp-Source: APXvYqwpaUnOO1XWisXLnQp5tdREM1FKu2ZaqSM6ukJiU70TUiUklqhyPgoORmWo4K1CrBTRbG5WYg==
X-Received: by 2002:a37:bb07:: with SMTP id l7mr9097948qkf.51.1555818819629;
        Sat, 20 Apr 2019 20:53:39 -0700 (PDT)
Received: from localhost.localdomain ([177.96.46.237])
        by smtp.gmail.com with ESMTPSA id b37sm7341398qtb.92.2019.04.20.20.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 20:53:38 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Greg Edwards <gedwards@ddn.com>,
        Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [RFC PATCH 0/2] Introduce size_to_sectors helper in blkdev.h
Date:   Sun, 21 Apr 2019 00:53:26 -0300
Message-Id: <20190421035328.19322-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While reading code of drivers/block, I was curious about the set_capacity
argument, always shifting the value by 9, and so I took me a while to realize
this is done on purpose: the capacity is the number of sectors of 512 bytes
related to the storage space.

Rather the shifting by 9, there are other places where the value if shifted by
SECTOR_SHIFT, which is more readable.
This patch aims to reduce these differences by adding a new function called
size_to_sectors, adding a proper comment explaining why this is needed.

null_blk was changed to use this new function.

This is an RFC, please let me know if you have other suggestions.

Thanks,
Marcos

Marcos Paulo de Souza (2):
  blkdev.h: Introduce size_to_sectors hlper function
  null_blk: Make use of size_to_sectors helper

 drivers/block/null_blk_main.c | 18 +++++++++---------
 include/linux/blkdev.h        | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.16.4

