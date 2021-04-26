Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3454C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CFA61027
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhDZOdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZOdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:33:37 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AFF8C061574;
        Mon, 26 Apr 2021 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=oTrHkGHNpd
        lXGR6rvnn5CxbspkndmU94+AgUSlg0N6I=; b=eDVZ2SV9VDl9CELXhdy6iWmXyJ
        mciwzpWUtnelUQrUDjBfc74eNAYI+JNrGxmjhKB19lzqKiMaIRhsbP2JMAzXwfxf
        pHbH95zwdBRaU6JFAjWZRaRkZEfIUAnVkJavX8B3aLcCiLdCEUz2Z4H8QGgX1ebN
        02nGG4HMeehJ+IRjY=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBHTzf_zoZgi2hLAA--.6103S4;
        Mon, 26 Apr 2021 22:32:32 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     axboe@kernel.dk, damien.lemoal@wdc.com, johannes.thumshirn@edc.com,
        martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] drivers/block/null_blk/main: Fix a double free in null_init.
Date:   Mon, 26 Apr 2021 07:32:29 -0700
Message-Id: <20210426143229.7374-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygBHTzf_zoZgi2hLAA--.6103S4
X-Coremail-Antispam: 1UD129KBjvdXoWruFy8Jr17Kw1rXF4UZw1xAFb_yoWkArb_uw
        4Fyr4kXr45Jr1I9w13AF1UArySkr10gF48Xr1IqFn3Way7X3ZrXw17ZrWrCry7Kry7GFWa
        y3yF9ry3ur4rCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUBT5QUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In null_init, null_add_dev(dev) is called.
In null_add_dev, it calls null_free_zoned_dev(dev) to free dev->zones
via kvfree(dev->zones) in out_cleanup_zone branch and returns err.
Then null_init accept the err code and then calls null_free_dev(dev).

But in null_free_dev(dev), dev->zones is freed again by
null_free_zoned_dev().

My patch set dev->zones to NULL in null_free_zoned_dev() after
kvfree(dev->zones) is called, to avoid the double free.

Fixes: 2984c8684f962 ("nullb: factor disk parameters")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/block/null_blk/zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index bfcab1c782b5..dae54dd1aeac 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -180,6 +180,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 void null_free_zoned_dev(struct nullb_device *dev)
 {
 	kvfree(dev->zones);
+	dev->zones = NULL;
 }
 
 int null_report_zones(struct gendisk *disk, sector_t sector,
-- 
2.25.1


