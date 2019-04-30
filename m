Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4452AC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2C2087B
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfD3Whg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:37:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32834 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfD3Whg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 18:37:36 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hLbNW-0008Vs-Ca
        for linux-block@vger.kernel.org; Tue, 30 Apr 2019 22:37:34 +0000
Received: by mail-qt1-f197.google.com with SMTP id o34so15115765qte.5
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 15:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgoSZsdwFw8Q/prYgcdaWGqbAEOq+PelG6nqt2UwOVY=;
        b=Mfj79DcWbxxACgmhdrOseGW6Jo6g7vG+LjJa3sCYhQg5yz8tIA7R1RzeX1LLPMSQKI
         2mghpttpDLmtvQGNx+IJXAhlvGgOW0M13Y/v6lvC+rvvVeOF7tGDj2KPsea4sv43DyEA
         WW1kErEwTmtAlNAuc4zfcrxK+gpMGCKjjzZEqn6UkrYljiTR9XjaR8X3jEvifjRXzz+c
         mEjoHWvbwTzM2ip+uVW1r2+N1b38eDstItSg6+uuVbZKk1LEvk+LPKGNxPwy6WQPO1y/
         GdRm0sRyzqNiqEaqPStVYI4lMlurl7UnQPRxwdhmGdSbWD7ezpGIJW/KUxsyQf4as+Cl
         v0Gw==
X-Gm-Message-State: APjAAAWqQpA41ydlranY6B3P4Tnoc4Yn7kUOpBw47cvihp/nlqddic8e
        cBB6NBC7zu8fevkMKGrMRB9BYb0t79ClRM3qHH5pZtsZCeWB1MpyUpK6tlWmVYGzINQrZUfuqn5
        kKNPDlOnu8DVB1oCBYuqpOyas5ssjYKHF9YxSJYGJ
X-Received: by 2002:aed:3f4b:: with SMTP id q11mr34249843qtf.18.1556663853358;
        Tue, 30 Apr 2019 15:37:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7vhTwhHnYlyqaq5Oxv0tWjuUfEQp4eI6S7cAWJxIbExGQPqR5pZAAY0sniOUMh/U6GpLBmA==
X-Received: by 2002:aed:3f4b:: with SMTP id q11mr34249822qtf.18.1556663853180;
        Tue, 30 Apr 2019 15:37:33 -0700 (PDT)
Received: from localhost (201-13-157-136.dial-up.telesp.net.br. [201.13.157.136])
        by smtp.gmail.com with ESMTPSA id l15sm10369506qti.12.2019.04.30.15.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:37:32 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, axboe@kernel.dk, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, gpiccoli@canonical.com,
        kernel@gpiccoli.net, Bart Van Assche <bvanassche@acm.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] block: Fix a NULL pointer dereference in  generic_make_request()
Date:   Tue, 30 Apr 2019 19:37:21 -0300
Message-Id: <20190430223722.20845-1-gpiccoli@canonical.com>
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
a) Build kernel v5.1-rc7 with CONFIG_BLK_CGROUP=n.

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

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org # v4.17
Fixes: 37f9579f4c31 ("blk-mq: Avoid that submitting a bio concurrently with device removal triggers a crash")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a55389ba8779..e21856a7f3fa 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1076,7 +1076,6 @@ blk_qc_t generic_make_request(struct bio *bio)
 				flags = BLK_MQ_REQ_NOWAIT;
 			if (blk_queue_enter(q, flags) < 0) {
 				enter_succeeded = false;
-				q = NULL;
 			}
 		}
 
@@ -1108,6 +1107,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 				bio_wouldblock_error(bio);
 			else
 				bio_io_error(bio);
+			q = NULL;
 		}
 		bio = bio_list_pop(&bio_list_on_stack[0]);
 	} while (bio);
-- 
2.21.0

