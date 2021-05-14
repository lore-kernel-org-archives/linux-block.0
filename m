Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66593C433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FC261415
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 09:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhENJjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhENJjl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 05:39:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC63C061574
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 02:38:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so1363818pjb.4
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IE6DoBHuj1BTNAGdOQwF+HuP5Ow58xWKxeF4GoigiB8=;
        b=eIer510lqTQCjTZLmOq26i+2NhOrI1u28jlyH/4DhTSGkvf6fezrqLpfuI1Nza0Xz4
         1F24TELAq5p+YfbTifoRKWRvxqh/O5lXJjyXezMaMwIUaC5eBcSxBx8hokSqvPoz55nX
         y34wWMfY1v0xcVO3cXfrq+8KTlHSWc1BzICtzWSYBsVdIC/JI+RmE8vkH5GRoMieLBeJ
         IMP23XRt6AQh7nuirgNNTIl4qg+kq23npRB31E/FlxD/pSn8RJB/UG3noCtwXeotlYis
         NR+8/cJzA3YtFtbv/MT4FhVNQtwNki1hMEkdBu0DQt63qkvGy9iYSq0GYUUP71IWHPKM
         X30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IE6DoBHuj1BTNAGdOQwF+HuP5Ow58xWKxeF4GoigiB8=;
        b=BqscnQxNFYSv5YSIOBt6y0rkgyzX+9qM6o2VfniDklP8xBBOgo2LulkY+3GZSqGcWQ
         ltN5cxvU6ivIhDb23tm9xaR8Z257QAVWFpFGa6LhYZ+e45OONqc6HnZAh2poVu9i/OTd
         kxF5V2YnmUgaZrD4UTCMdt8wkBjKmdUSBRH9lBZYNvab3OACe6INAcUgix7yQHgXMBpp
         JHrr7JJU9KQV8CRz5DMw2cn04rhEX+BwoPhoAcOD1pjUBnHk3LEnPmTdzyjD4goylqoS
         yZ6Ci4KMTeO8gm04RWFusdPp5J7y9cBMpQa/PaYv02Sj9A+C3UYRiEVpk3A77U2tTFuJ
         a5rw==
X-Gm-Message-State: AOAM533SDQsTFE6vD1MVhizIPGbiPqpmfh1nM2YJVN9XME0blUaVx+wo
        7+bgOVyM7lvmh9wbvn0gwbI=
X-Google-Smtp-Source: ABdhPJyjp1IWShvMcvIob5BUaLxL4D0Wg399LbwZOqRZPwhzddbzp6Az1oD+r0JKIKgQOu4eWDikyQ==
X-Received: by 2002:a17:902:6901:b029:ee:e531:ca5f with SMTP id j1-20020a1709026901b02900eee531ca5fmr45004486plk.37.1620985107198;
        Fri, 14 May 2021 02:38:27 -0700 (PDT)
Received: from yguoaz-VirtualBox.hz.ali.com ([106.11.30.42])
        by smtp.googlemail.com with ESMTPSA id w12sm3848421pff.42.2021.05.14.02.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 02:38:26 -0700 (PDT)
From:   Yiyuan GUO <yguoaz@gmail.com>
X-Google-Original-From: Yiyuan GUO <yguoaz@cse.ust.hk>
To:     hare@suse.de
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, yguoaz@cse.ust.hk,
        yguoaz@gmail.com
Subject: [PATCH v2] block: add protection for divide by zero in blk_mq_map_queues
Date:   Fri, 14 May 2021 17:38:16 +0800
Message-Id: <20210514093816.66612-1-yguoaz@cse.ust.hk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <274501fd-3115-3015-3577-3ed64e4038a0@suse.de>
References: <274501fd-3115-3015-3577-3ed64e4038a0@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function blk_mq_map_queues, qmap->nr_queues may equal zero
and thus it needs to be checked before we pass it to function
queue_index.

Signed-off-by: Yiyuan GUO <yguoaz@cse.ust.hk>
---
 block/blk-mq-cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 3db84d319..c2163658e 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -64,7 +64,7 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 			map[cpu] = queue_index(qmap, nr_queues, q++);
 		} else {
 			first_sibling = get_first_sibling(cpu);
-			if (first_sibling == cpu)
+			if ((first_sibling == cpu) && nr_queues)
 				map[cpu] = queue_index(qmap, nr_queues, q++);
 			else
 				map[cpu] = map[first_sibling];
-- 
2.25.1

