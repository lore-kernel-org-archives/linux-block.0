Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B32CA9ECB
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227D7208E3
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 19:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y4ZgLZNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfJaT0R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:26:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34036 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbfJaT0R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 15:26:17 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so8083481ion.1
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2019 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uvDSudnf++R38H03QSiZmnEARzqynQJw1auoPiRbamA=;
        b=y4ZgLZNnoP6Hb/siovc6/li+katPBSabT4hkxgPuZW4WP0XAnm7vrO9bDyfbOBb7qB
         OJbZ8lik29xJiuXKQVUmODH146wvFrl/csuXcYre7uoq7asOe9qfp2DQwPZpOJYfT1+w
         2Zep9rY77lklxsj/+aPlV9B0woXKgwU0viPnzHs9h2+T9aLtZIHIx+NgqnRTWJC7xyxw
         u5z4bcNOG74KaRSrNt8rHRCgDmrFuNvs8U7TBrPLpb8e8rqzg2a4g8epo8Wb/kSmsxJT
         ZQ6A0Kwxzx5Zmo8cFYnaF8VaN8bGOkHuj71T2avYnHxR/oXAZ71qR00DP3HcykO43kRa
         Qjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uvDSudnf++R38H03QSiZmnEARzqynQJw1auoPiRbamA=;
        b=tkQcLQcvwguz707ttYOiLh5zfgbhrqjUUJusZ674Pxb1g9uLfBxBd2zT1sZlqPITuO
         ntPiRXAeG71yuQYsvXE7oqLRJ1rhHGEuGfq4MtseODVbjRouM2XeFbHVU53C1UJJC4zA
         9d3CgMpTbqicdg7GuMlxBgad78zMyxArf9F2P3zCneW4cXmZPrjPVOv/IFg6ZoiwVni4
         GY0tZa7FBxh6tfi3JkMnKKDwXibW6ogbWz3WtzQ+4I2MWsOLR/Q89mTlAsS8anG8WCIM
         Njd0qa9ppo9mrlPlKs40u3CiarFioyusvDuSD4ehzTmX0l81g+JYlTOYyggBA94H+wHq
         /txQ==
X-Gm-Message-State: APjAAAWR3DyiixIxvE+eBQ8IBqwNCByyL5905Y7K4aUyDKxToav14yPu
        ONMVbqy7HdG9qUhD9lYucq5esh8+ag8D6A==
X-Google-Smtp-Source: APXvYqzLnSg61C6uiTa3v4w9hEaoUVyR9yCBj8ua34xMfxP0w0WCWByNzfsJF32Vuv0vbd6mJ9VU8Q==
X-Received: by 2002:a6b:38c5:: with SMTP id f188mr6726528ioa.235.1572549974504;
        Thu, 31 Oct 2019 12:26:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1133::1088? ([2620:10d:c090:180::f3f5])
        by smtp.gmail.com with ESMTPSA id s16sm715261ilp.37.2019.10.31.12.26.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 12:26:13 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: retry blk_rq_map_user_iov() on failure
Message-ID: <c8718f10-0442-de4f-edfc-ecc6fe28b768@kernel.dk>
Date:   Thu, 31 Oct 2019 13:26:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We ran into an issue in production where reading an NVMe drive log
randomly fails. The request is a big one, 1056K, and the application
(nvme-cli) nicely aligns the buffer. This means the kernel will attempt
to map the pages in for zero-copy DMA, but we ultimately fail adding
enough pages to the request to satisfy the size requirement as we ran
out of segments supported by the hardware.

If we fail a user map that attempts to map pages in directly, retry with
copy == true set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-map.c b/block/blk-map.c
index db9373bd31ac..2dc5286baec6 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -131,6 +131,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	else if (queue_virt_boundary(q))
 		copy = queue_virt_boundary(q) & iov_iter_gap_alignment(iter);
 
+retry:
 	i = *iter;
 	do {
 		ret =__blk_rq_map_user_iov(rq, map_data, &i, gfp_mask, copy);
@@ -148,6 +149,10 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	__blk_rq_unmap_user(bio);
 fail:
 	rq->bio = NULL;
+	if (ret && !copy) {
+		copy = true;
+		goto retry;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_user_iov);

-- 
Jens Axboe

