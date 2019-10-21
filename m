Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E572CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 19:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57C620873
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 19:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="2KVIdo4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJUT4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:56:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46308 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUT4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 15:56:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id e66so13911403qkf.13
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=olbMooGjFBayOK7jc5tAferY0kolRn7LFl7EO6n9+Nc=;
        b=2KVIdo4CnFZeezRJGdUURVYAxlQipkL+U3JQu19GH2FVPmUpW8jPkgNcp3A/FaenyN
         YpDIUISBLUO/+NfQpOynPtqRVUzgjeMb6JGpu3nAufBRVmlsqDu2Gnj1qhczeZX0IW+A
         CvdTsJBaFh/ytGNiETeuhrPHtWaI44lFx5DD/EjujMDDu3QpoL1iDFSJIIpESUEecBMb
         a66XPczNy+vrzshaqgkl5bSWZbiTNlSd+v3cv5tREpLsUw8/tiopaJU1VPrwDzu2hXn6
         0p7w0wNOgxCgzaqslc3rcBA7xzbtodnvQl6D28FMZBFtrugTXGfmbzMWwSk8l0NVaT1/
         qAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olbMooGjFBayOK7jc5tAferY0kolRn7LFl7EO6n9+Nc=;
        b=lRHvJFmqxSp2AGXxDfkd7kzxkf8aWGCRvREFwp0Zjw5z+jQS6uziCc4OT3tdFLBu/k
         lkpOkXiemhBcMexgYMap+4G+PKWwdPhC3yrnnpQPIQZzsvAw5Vre8oyRh4YpQXVuAKM9
         6iMP1qmIALjFFTZhwjCVDeRAVAxgIr9ShFtH8ZYopxhMWYnug64xhBDKkirNKjlxDpGr
         WxNoG29ehWPoUn/c6mJL3UetmtgUyRv8vINkqohxha0LTsCnjotj+ajXPutl46aiOKzz
         y89zKgD15FauqcpM0VaM2aIkzuF2gjNk7V3AWqM8X3m7Za0qeTxiAr/QQayGD4NJlliJ
         bDFw==
X-Gm-Message-State: APjAAAW4ECee+D9HOmP13TNxVvc3p3+nEvMKUAXCSmj+Li6Torv9RCVs
        9w1tpKAzp/7CAPRBAs/jxoZYtw==
X-Google-Smtp-Source: APXvYqynVLEZMpVVt7pXNA5sBJbHLg8xYpkuKPGZrIRVUI+mw+ub3JJnSUuMdGm6zJgRfz/ULG7k2Q==
X-Received: by 2002:a37:353:: with SMTP id 80mr23331009qkd.439.1571687794781;
        Mon, 21 Oct 2019 12:56:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d2sm7734516qkj.123.2019.10.21.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:56:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, mchristi@redhat.com
Subject: [PATCH 2/2] nbd: handle racing with error'ed out commands
Date:   Mon, 21 Oct 2019 15:56:28 -0400
Message-Id: <20191021195628.19849-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021195628.19849-1-josef@toxicpanda.com>
References: <20191021195628.19849-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We hit the following warning in production

print_req_error: I/O error, dev nbd0, sector 7213934408 flags 80700
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 25 PID: 32407 at lib/refcount.c:190 refcount_sub_and_test_checked+0x53/0x60
Workqueue: knbd-recv recv_work [nbd]
RIP: 0010:refcount_sub_and_test_checked+0x53/0x60
Call Trace:
 blk_mq_free_request+0xb7/0xf0
 blk_mq_complete_request+0x62/0xf0
 recv_work+0x29/0xa1 [nbd]
 process_one_work+0x1f5/0x3f0
 worker_thread+0x2d/0x3d0
 ? rescuer_thread+0x340/0x340
 kthread+0x111/0x130
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x1f/0x30
---[ end trace b079c3c67f98bb7c ]---

This was preceded by us timing out everything and shutting down the
sockets for the device.  The problem is we had a request in the queue at
the same time, so we completed the request twice.  This can actually
happen in a lot of cases, we fail to get a ref on our config, we only
have one connection and just error out the command, etc.

Fix this by checking cmd->status in nbd_read_stat.  We only change this
under the cmd->lock, so we are safe to check this here and see if we've
already error'ed this command out, which would indicate that we've
completed it as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8fb8913074b8..e9f5d4e476e7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -693,6 +693,12 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 		ret = -ENOENT;
 		goto out;
 	}
+	if (cmd->status != BLK_STS_OK) {
+		dev_err(disk_to_dev(nbd->disk), "Command already handled %p\n",
+			req);
+		ret = -ENOENT;
+		goto out;
+	}
 	if (test_bit(NBD_CMD_REQUEUED, &cmd->flags)) {
 		dev_err(disk_to_dev(nbd->disk), "Raced with timeout on req %p\n",
 			req);
-- 
2.21.0

