Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CDC43217
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKBCwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKBCwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:52:53 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 70B33220E1;
        Tue,  1 Nov 2022 19:52:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [61.164.42.140])
        by mail-app2 (Coremail) with SMTP id by_KCgB3ffVv22FjEPFcBw--.14956S2;
        Wed, 02 Nov 2022 10:52:38 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH v2 0/2] some random cleanups for blk-mq.c
Date:   Wed,  2 Nov 2022 10:52:28 +0800
Message-Id: <cover.1667356813.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgB3ffVv22FjEPFcBw--.14956S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYr7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
        IEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAa
        Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
        A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F
        5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfU5sqWUUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgoCB1ZdtcNVXAADs6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 1 improves the error handling blk_mq_alloc_rq_map(). Patch 2
improves readability of blk_mq_alloc_cached_request().

Changes in v2:
- drop wrong and worthless patches, suggested by Christoph, Jens and
  Chaitanya
- remove silly goto-return-NULL in patch 1 (patch 2 originally), suggested
  by Christoph and Jens

Jinlong Chen (2):
  blk-mq: improve error handling in blk_mq_alloc_rq_map()
  blk-mq: use if-else instead of goto in blk_mq_alloc_cached_request()

 block/blk-mq.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

-- 
2.31.1

