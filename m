Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CFBC04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 22:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCEA21479
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 22:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfETWMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 18:12:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55338 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETWME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 18:12:04 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hSqTP-0005r7-PU
        for linux-block@vger.kernel.org; Mon, 20 May 2019 22:09:36 +0000
Received: by mail-qt1-f200.google.com with SMTP id g14so15472427qta.12
        for <linux-block@vger.kernel.org>; Mon, 20 May 2019 15:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Kb9dwGb7EDZjWXcJgCYvh+scyOCXdmQMfxa74lNg9A=;
        b=EDPG3FEaK3ETGI8U9OvXOTmAS9/9QraMY88IBNv3yA0rwbT9sU0vT8eilnx9ewMMLG
         FL8AHsL1mLnSCpBuEvYsggFZzxEsEbdU0b1gh/5ZlhzE+p3N1GGbz9RA1r+TVpEGhEiG
         Hg8XwhB4u69V9c1QJhRZE1M2/510hJYFqOu2C1iKKv69Vzo4HRkktdH8gCs+o5grDhiw
         6kOXVqyiqQiD7i2VCRMDMDR28wGsSOItRDG9YUYNrCE8h7kgIV4F6eTamdnCrlAYSS0P
         Ea3cqGsqTIyFb4M/AU9D8ZsRayNBj5/yLMmeiYTX3YpiRfwOJenr1wfXjIPB/xQsbr/H
         KANw==
X-Gm-Message-State: APjAAAXAORL1Okhfe/2tTyodzUR0VoXoP5Mkcp7lXU6qjB7tBmPLrtl9
        2Ti5hQ4YUPOK4iOcEJwnY781+NrN3r+ntQ+gYUY32wavurrJA79PGsG1mB648vzH9nsTSsCdTyR
        IsB95xlaRP3VC241W+fOz781CYwJ8HZpfgzar2llw
X-Received: by 2002:a37:8502:: with SMTP id h2mr17302674qkd.281.1558390174407;
        Mon, 20 May 2019 15:09:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRIY8VAy8Nou+AqtITvyvN0y8SyGXWRHpV5X/2071IU5iR1yqSJwUbYPM++Dqa379vjgPjQQ==
X-Received: by 2002:a37:8502:: with SMTP id h2mr17302655qkd.281.1558390174135;
        Mon, 20 May 2019 15:09:34 -0700 (PDT)
Received: from localhost ([152.250.107.7])
        by smtp.gmail.com with ESMTPSA id j10sm8277639qth.8.2019.05.20.15.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 15:09:33 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, axboe@kernel.dk, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, gpiccoli@canonical.com,
        kernel@gpiccoli.net, Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org
Subject: [PATCH V2 2/2] md/raid0: Do not bypass blocking queue entered for raid0 bios
Date:   Mon, 20 May 2019 19:09:11 -0300
Message-Id: <20190520220911.25192-2-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520220911.25192-1-gpiccoli@canonical.com>
References: <20190520220911.25192-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit cd4a4ae4683d ("block: don't use blocking queue entered for
recursive bio submits") introduced the flag BIO_QUEUE_ENTERED in order
split bios bypass the blocking queue entering routine and use the live
non-blocking version. It was a result of an extensive discussion in
a linux-block thread[0], and the purpose of this change was to prevent
a hung task waiting on a reference to drop.

Happens that md raid0 split bios all the time, and more important,
it changes their underlying device to the raid member. After the change
introduced by this flag's usage, we experience various crashes if a raid0
member is removed during a large write. This happens because the bio
reaches the live queue entering function when the queue of the raid0
member is dying.

A simple reproducer of this behavior is presented below:
a) Build kernel v5.2-rc1 with CONFIG_BLK_DEV_THROTTLING=y.

b) Create a raid0 md array with 2 NVMe devices as members, and mount it
with an ext4 filesystem.

c) Run the following oneliner (supposing the raid0 is mounted in /mnt):
(dd of=/mnt/tmp if=/dev/zero bs=1M count=999 &); sleep 0.3;
echo 1 > /sys/block/nvme0n1/device/device/remove
(whereas nvme0n1 is the 2nd array member)

This will trigger the following warning/oops:

------------[ cut here ]------------
no blkg associated for bio on block-device: nvme0n1
WARNING: CPU: 9 PID: 184 at ./include/linux/blk-cgroup.h:785
generic_make_request_checks+0x4dd/0x690
[...]
BUG: unable to handle kernel NULL pointer dereference at 0000000000000155
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
RIP: 0010:blk_throtl_bio+0x45/0x970
[...]
Call Trace:
 generic_make_request_checks+0x1bf/0x690
 generic_make_request+0x64/0x3f0
 raid0_make_request+0x184/0x620 [raid0]
 ? raid0_make_request+0x184/0x620 [raid0]
 ? blk_queue_split+0x384/0x6d0
 md_handle_request+0x126/0x1a0
 md_make_request+0x7b/0x180
 generic_make_request+0x19e/0x3f0
 submit_bio+0x73/0x140
[...]

This patch changes raid0 driver to fallback to the "old" blocking queue
entering procedure, by clearing the BIO_QUEUE_ENTERED from raid0 bios.
This prevents the crashes and restores the regular behavior of raid0
arrays when a member is removed during a large write.

[0] https://marc.info/?l=linux-block&m=152638475806811

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: stable@vger.kernel.org # v4.18
Fixes: cd4a4ae4683d ("block: don't use blocking queue entered for recursive bio submits")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

No changes from V1, only rebased to v5.2-rc1.
Also, notice that if [1] gets merged before this patch, the
BIO_QUEUE_ENTERED flag will change to BIO_SPLITTED, so the (easy) conflict
will need to be worked.

[1] https://lore.kernel.org/linux-block/20190515030310.20393-4-ming.lei@redhat.com/

 drivers/md/raid0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f3fb5bb8c82a..d5bdc79e0835 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -547,6 +547,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 			trace_block_bio_remap(bdev_get_queue(rdev->bdev),
 				discard_bio, disk_devt(mddev->gendisk),
 				bio->bi_iter.bi_sector);
+		bio_clear_flag(bio, BIO_QUEUE_ENTERED);
 		generic_make_request(discard_bio);
 	}
 	bio_endio(bio);
@@ -602,6 +603,7 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 				disk_devt(mddev->gendisk), bio_sector);
 	mddev_check_writesame(mddev, bio);
 	mddev_check_write_zeroes(mddev, bio);
+	bio_clear_flag(bio, BIO_QUEUE_ENTERED);
 	generic_make_request(bio);
 	return true;
 }
-- 
2.21.0

