Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D6C04AAF
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 22:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA021479
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 22:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfETWJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 18:09:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55166 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfETWJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 18:09:28 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hSqTF-0005pf-OE
        for linux-block@vger.kernel.org; Mon, 20 May 2019 22:09:25 +0000
Received: by mail-qt1-f198.google.com with SMTP id c48so15524268qta.19
        for <linux-block@vger.kernel.org>; Mon, 20 May 2019 15:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eleW/E3HCVGRd/hOEzTX6UY7GJoHVcEBDC+LzdhjVI=;
        b=hK8y2S3RyTZpgloc2JJyNLPLGvRXcx7gouufy8x9wR/z4EMK0TcX4+KtSl+OUOwipa
         /7hPera0WnmA/Sg7QhhO98w59m3Wz8J+qcBLut3Imwxg4Z8tV+1vlKUptNPNCdtT4bNM
         40N74KU7hjS7M3bMhbav7HqCC4M/eQeicVhgQ07Nsd+1pslRKFKfogSdexV+KHXBW8j6
         Ev1mDC3gOY/vQkj7hIHnL8isGImGIRQTt/iJTW6HaTNvjtgA/QoL1MG1NHYJqsQN9VtF
         ORNsI+xoiYahVp3iwij3NUfoLjFiMiDo+2uU6OPnl0Myjg4w3WOozo0gv//G5qd6WNlP
         sKog==
X-Gm-Message-State: APjAAAVVVDa6mkMW+p0oKkGvQCHDV9FFLZVlHo0E9sNRJR40ofQAzHKA
        +mu2IhObG0uVXCAJ6gq9Nqt4H9LWSiOM4ZbluF2No5X722SZvnmMbnJ2/292y/f63fn+4d1byMX
        S7E2iLgeJ6QZtiTc7Sra5yP01XmZ+GfIvCv68apoY
X-Received: by 2002:a0c:9e58:: with SMTP id z24mr8192554qve.214.1558390164370;
        Mon, 20 May 2019 15:09:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDPcMv/m+gLKi2bFuQpOJ6k5LytU6lAjId7qA4kvxP4mLQlY8gLTvLnvgb7pw9YL0/VwxNMA==
X-Received: by 2002:a0c:9e58:: with SMTP id z24mr8192528qve.214.1558390164167;
        Mon, 20 May 2019 15:09:24 -0700 (PDT)
Received: from localhost ([152.250.107.7])
        by smtp.gmail.com with ESMTPSA id a51sm11767472qta.85.2019.05.20.15.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 15:09:23 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, axboe@kernel.dk, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, gpiccoli@canonical.com,
        kernel@gpiccoli.net, stable@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>
Subject: [PATCH V2 1/2] block: Fix a NULL pointer dereference in generic_make_request()
Date:   Mon, 20 May 2019 19:09:10 -0300
Message-Id: <20190520220911.25192-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 37f9579f4c31 ("blk-mq: Avoid that submitting a bio concurrently
with device removal triggers a crash") introduced a NULL pointer
dereference in generic_make_request(). The patch sets q to NULL and
enter_succeeded to false; right after, there's an 'if (enter_succeeded)'
which is not taken, and then the 'else' will dereference q in
blk_queue_dying(q).

This patch just moves the 'q = NULL' to a point in which it won't trigger
the oops, although the semantics of this NULLification remains untouched.

A simple test case/reproducer is as follows:
a) Build kernel v5.2-rc1 with CONFIG_BLK_CGROUP=n.

b) Create a raid0 md array with 2 NVMe devices as members, and mount it
with an ext4 filesystem.

c) Run the following oneliner (supposing the raid0 is mounted in /mnt):
(dd of=/mnt/tmp if=/dev/zero bs=1M count=999 &); sleep 0.3;
echo 1 > /sys/block/nvme0n1/device/device/remove
(whereas nvme0n1 is the 2nd array member)

This will trigger the following oops:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
RIP: 0010:generic_make_request+0x32b/0x400
Call Trace:
 submit_bio+0x73/0x140
 ext4_io_submit+0x4d/0x60
 ext4_writepages+0x626/0xe90
 do_writepages+0x4b/0xe0
[...]

This patch has no functional changes and preserves the md/raid0 behavior
when a member is removed before kernel v4.17.

Cc: stable@vger.kernel.org # v4.17
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Eric Ren <renzhengeek@gmail.com>
Fixes: 37f9579f4c31 ("blk-mq: Avoid that submitting a bio concurrently with device removal triggers a crash")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

Changes V1->V2:
* Implemented Ming's suggestion (drop {} from if) - thanks Ming!
* Rebased to v5.2-rc1
* Added Reviewed-by/Tested-by tags

Also, Ming mentioned a new patch series[0] that will refactor legacy IO
path so probably the bug won't happen anymore. Even in this case,
I consider this patch important specially aiming the stable releases,
in which backporting small bugfixes is much simpler than more complex
patch sets.

[0] https://lore.kernel.org/linux-block/20190515030310.20393-1-ming.lei@redhat.com/T/#t

 block/blk-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..e887915c7804 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1054,10 +1054,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 			flags = 0;
 			if (bio->bi_opf & REQ_NOWAIT)
 				flags = BLK_MQ_REQ_NOWAIT;
-			if (blk_queue_enter(q, flags) < 0) {
+			if (blk_queue_enter(q, flags) < 0)
 				enter_succeeded = false;
-				q = NULL;
-			}
 		}
 
 		if (enter_succeeded) {
@@ -1088,6 +1086,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 				bio_wouldblock_error(bio);
 			else
 				bio_io_error(bio);
+			q = NULL;
 		}
 		bio = bio_list_pop(&bio_list_on_stack[0]);
 	} while (bio);
-- 
2.21.0

