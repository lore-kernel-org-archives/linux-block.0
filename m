Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53651C4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234FB224D2
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 14:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgLOOWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729422AbgLOOWg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 09:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608042069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nNAN1vGyAciYBO+ou4+cqD2HBxuVIVg3uWlbifmOtUY=;
        b=a5FPX6Q6LF6HXkK/T+OMjpljgc9fGMgpBJYtysSjaOkvgrqsmnIOBEzlgYDaNxPUjB1kw9
        IIfK/KpV27wI9zvJw+s9qur+RiuztiuSXfofqNWzPd0276wlRSvBJBc6UyNh4Vms/p6ce5
        hc8Mb7+2PoZyM0bhseHuAVqw6jrTEwY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-Firk2t6iOZ2F2Zc1CZwSdQ-1; Tue, 15 Dec 2020 09:21:05 -0500
X-MC-Unique: Firk2t6iOZ2F2Zc1CZwSdQ-1
Received: by mail-qk1-f197.google.com with SMTP id p13so9120739qki.14
        for <linux-block@vger.kernel.org>; Tue, 15 Dec 2020 06:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nNAN1vGyAciYBO+ou4+cqD2HBxuVIVg3uWlbifmOtUY=;
        b=gWYO/+tC2U6DcD6MHgPkUhPHOoT4hXcuyHfLGEnESDn35cdO0iRzrD9u/GYBgpss14
         GwX0nGzPDuKL9I1YPIk85E8So/Ac2q3zbx8J+63AJOKOPqugDcNIMCU8V/00vW524Vna
         5MXTBR0VhLFz/aBddoGgEknyBGAmdhY/mivLrQBRcrQl5k688vlGYBDt4q1jEnyoOiy8
         Q2dt5pyRXKUFs7RRR34vCOhLNiTE4KfIaNORzeE/FU3AONaVkXCuV3+xaylaQgR46F4v
         76biHBZgaD7GtXS4g3Oua9r4oItvFftls6y2vCXuArOVxub3kelrQa5qADDw3DEN2itl
         9kmQ==
X-Gm-Message-State: AOAM531LKu/S9OHq9bA1nXSFzPXPyqMIqXyIPsX49d3+aYa58J3S34Vq
        TLIqnP+JT9RYAqFkb+5S4TyWc5t7fkdVhnknBGsUrL8iBs5aL0ERYbzD7yU53Wf9sx8Gn7xKBJA
        rYSeoLe6BaVkIFGGEf7Jw9YM=
X-Received: by 2002:ac8:e06:: with SMTP id a6mr39343275qti.384.1608042064916;
        Tue, 15 Dec 2020 06:21:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfH8vkI0rTKDiu924mjDigF3TrXfgqa/9f5ICyqT9e1uYrAA4AN2xEOCl8WNNMfItb+n2UAw==
X-Received: by 2002:ac8:e06:: with SMTP id a6mr39343254qti.384.1608042064747;
        Tue, 15 Dec 2020 06:21:04 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x65sm15959059qkc.130.2020.12.15.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:21:04 -0800 (PST)
From:   trix@redhat.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] block: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:20:58 -0800
Message-Id: <20201215142058.1844696-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7663a9b94b80..7c839e396f24 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1181,7 +1181,7 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
 	 */
 	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
 	if (rq->nr_phys_segments > queue_max_segments(q)) {
-		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
+		printk(KERN_ERR "%s: over max segments limit. (%u > %u)\n",
 			__func__, rq->nr_phys_segments, queue_max_segments(q));
 		return BLK_STS_IOERR;
 	}
-- 
2.27.0

