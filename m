Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63FC001B1
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 19:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjGBTqU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjGBTow (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 15:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622E10FA;
        Sun,  2 Jul 2023 12:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD76E60C8E;
        Sun,  2 Jul 2023 19:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E21C433CC;
        Sun,  2 Jul 2023 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326933;
        bh=Jd9SviMyTJhfuFyAzDT+aOfbtj4KgUV9XUqZfotGHn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2xjRccnABSDwqwOxvZq4OQNQGvRAx56MRIAiVhEFirLrPAQCpP1HkIaFr6pW0Hzc
         Faj2lfH1vHC5VkNuuWylk4lQ3zeGK38anQu85reptkQos7Su5gycpwdVc4TdpF+9o8
         KGiv4CIStzhA6GjhhHukskBlApmSN+3CSF+BQZimbZapYcn7/Z5Dk2kN6knfpLrsTh
         gJrDkWgRJvxSaw8hl7vJ3uS7u0dnFVI+RYVjYUSnpJbC5GkX/+3sEH4hBE71SO/vmq
         17Vn39IgstCMF+E9uDn//X7oledoKphZsX4Gzubkah4T4mn09ZgTW2vfkLHhB1CD9Q
         klMnpfhRn141Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhong Jinghua <zhongjinghua@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 5.4 2/5] nbd: Add the maximum limit of allocated index in nbd_dev_add
Date:   Sun,  2 Jul 2023 15:42:06 -0400
Message-Id: <20230702194209.1779267-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194209.1779267-1-sashal@kernel.org>
References: <20230702194209.1779267-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

[ Upstream commit f12bc113ce904777fd6ca003b473b427782b3dde ]

If the index allocated by idr_alloc greater than MINORMASK >> part_shift,
the device number will overflow, resulting in failure to create a block
device.

Fix it by imiting the size of the max allocation.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230605122159.2134384-1-zhongjinghua@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 218aa7e419700..37994a7a1b6f4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1708,7 +1708,8 @@ static int nbd_dev_add(int index)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
-- 
2.39.2

