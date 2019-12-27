Return-Path: <SRS0=cIu3=2R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97679C2D0CE
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7454521744
	for <linux-block@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470533;
	bh=YQpnEO+zftTcEksKOgn/okVCs3guuDl7CCpC4AedMHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9bKMsjLug6LN1h07HtF5OYAkf9eGxoDU7AnHKFeyJJb97ZmzpyIN1jZDQ6qq7F4L
	 HIUI+b7qBI0iJEeEREB0uuzzeoAT4OTyHSaW2oFVgANw/MymfnkA9xqDzzrOxGFq8a
	 +MDpDzfCx8m1CF07fez5uYlk7zt1cav3ssZ10kfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfL0SPT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:15:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbfL0SPS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Dec 2019 13:15:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9095E20722;
        Fri, 27 Dec 2019 18:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470517;
        bh=YQpnEO+zftTcEksKOgn/okVCs3guuDl7CCpC4AedMHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+XCNGbUwcjRfvoeqywAheztejyaB/I+51dNkOOcEeozrxT9u/OsfmmQQUbMn29XC
         ckk28Gfpbhu+PuykSarRLbHvqOwPgIpEnT5l3eTAKDKW2yxNp5auDZed1x9k7q1jED
         bzbDlUwm0clTNOhH1nbv2/q/daljbs2240oanmbg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Bob Liu <bob.liu@oracle.com>, Hulk Robot <hulkci@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 34/38] block: fix memleak when __blk_rq_map_user_iov() is failed
Date:   Fri, 27 Dec 2019 13:14:31 -0500
Message-Id: <20191227181435.7644-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181435.7644-1-sashal@kernel.org>
References: <20191227181435.7644-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 3b7995a98ad76da5597b488fa84aa5a56d43b608 ]

When I doing fuzzy test, get the memleak report:

BUG: memory leak
unreferenced object 0xffff88837af80000 (size 4096):
  comm "memleak", pid 3557, jiffies 4294817681 (age 112.499s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    20 00 00 00 10 01 00 00 00 00 00 00 01 00 00 00   ...............
  backtrace:
    [<000000001c894df8>] bio_alloc_bioset+0x393/0x590
    [<000000008b139a3c>] bio_copy_user_iov+0x300/0xcd0
    [<00000000a998bd8c>] blk_rq_map_user_iov+0x2f1/0x5f0
    [<000000005ceb7f05>] blk_rq_map_user+0xf2/0x160
    [<000000006454da92>] sg_common_write.isra.21+0x1094/0x1870
    [<00000000064bb208>] sg_write.part.25+0x5d9/0x950
    [<000000004fc670f6>] sg_write+0x5f/0x8c
    [<00000000b0d05c7b>] __vfs_write+0x7c/0x100
    [<000000008e177714>] vfs_write+0x1c3/0x500
    [<0000000087d23f34>] ksys_write+0xf9/0x200
    [<000000002c8dbc9d>] do_syscall_64+0x9f/0x4f0
    [<00000000678d8e9a>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

If __blk_rq_map_user_iov() is failed in blk_rq_map_user_iov(),
the bio(s) which is allocated before this failing will leak. The
refcount of the bio(s) is init to 1 and increased to 2 by calling
bio_get(), but __blk_rq_unmap_user() only decrease it to 1, so
the bio cannot be freed. Fix it by calling blk_rq_unmap_user().

Reviewed-by: Bob Liu <bob.liu@oracle.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index a8b4f526d8bb..52edbe6b9380 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -142,7 +142,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	return 0;
 
 unmap_rq:
-	__blk_rq_unmap_user(bio);
+	blk_rq_unmap_user(bio);
 fail:
 	rq->bio = NULL;
 	return ret;
-- 
2.20.1

