Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46B2C4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 12:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLOMhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Dec 2022 07:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLOMhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2022 07:37:22 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5B5F4E;
        Thu, 15 Dec 2022 04:37:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NXsF65pCbz4f3kKx;
        Thu, 15 Dec 2022 20:37:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHONb9FJtjOv0bCQ--.50238S4;
        Thu, 15 Dec 2022 20:37:17 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH v2 0/5] A few bugfix and cleanup patches for sbitmap
Date:   Fri, 16 Dec 2022 04:36:16 +0800
Message-Id: <20221215203621.3572458-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHONb9FJtjOv0bCQ--.50238S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW8JF4DZFy5Jry8uw1xZrb_yoW3Kwb_tF
        WkAFW8tFykJF15JFy7XFy7AFyDKw4kJa4UtanayrWxJr1xZas7Xw4kuFW2qr15ZFyDuF15
        Jry5Jrs5AwnI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
        AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
        3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI0tCUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, this series contain a bugfix patch to correct wake_batch
recalculation to avoid potential IO hung and a few cleanup patches to
remove unnecessary check and repeat code in sbitmap. Thanks.

---
v2:
 -add patch "sbitmap: correct wake_batch recalculation to avoid potential
IO hung"
---

Kemeng Shi (5):
  sbitmap: remove unnecessary calculation of alloc_hint in
    __sbitmap_get_shallow
  sbitmap: remove redundant check in __sbitmap_queue_get_batch
  sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
  sbitmap: add sbitmap_find_bit to remove repeat code in
    __sbitmap_get/__sbitmap_get_shallow
  sbitmap: correct wake_batch recalculation to avoid potential IO hung

 lib/sbitmap.c | 103 ++++++++++++++++++++++----------------------------
 1 file changed, 46 insertions(+), 57 deletions(-)

-- 
2.30.0

