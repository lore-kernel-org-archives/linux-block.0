Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DCC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BBE60EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhI0WDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhI0WDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:30 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23583C061575;
        Mon, 27 Sep 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PIC+qXoGsoFJ1eZ9LA9t8T951f2hrkUOPPt1FYAGsmg=; b=FuCcNq9IOVETu5gZfPU8ZyHeZ0
        4yRRj59j+TWMJveqzARzPIPnGBkIS/5Y078bG/DLPJo1lgh8OCNwb8EpIOOsJ0GtuUVKQxuHZ/3ld
        HL0sUlBkiWjZ77631MgWdDggaYxof/KSEim0JSi0S3NKEmak/7p/dqHVg/kW0ASIsF7WDhhpaebSp
        4fefTGDxj/g/uR9rTjLmBSfyf/Tv1cvID9Bf630aiPWO86W8Ajx45BwFipe5bb4YETBXNjbbBvE6r
        f3FqRfIhJNfTLkqYXp8ynHhmGzqzYn2l/ZVmr6WYZBoDyCtvcn9oBnf7tLAJrjDo1H5H71B32c3Fr
        4KiKUnwg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygR-004TPC-K8; Mon, 27 Sep 2021 22:01:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 00/15] block: third batch of add_disk() error handling conversions
Date:   Mon, 27 Sep 2021 15:00:55 -0700
Message-Id: <20210927220110.1066271-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the 2nd version of the third batch of driver conversions for the
add_disk() error handling. This and the entire 7th series of driver
conversions can be found on my 20210927-for-axboe-add-disk-error-handling
branch [0].

On this v2 series the following changes have been made since the v1
series of this patch set:

  - rebased onto linux-next tag 20210927
  - z2ram: fixed compile warning reported by 0day and Geert Uytterhoe
  - um/drivers/ubd_kern: added the reviewed-by tag by Gabriel Krisman
    Bertazi

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-for-axboe-add-disk-error-handling

Christoph Hellwig (4):
  pcd: move the identify buffer into pcd_identify
  pcd: cleanup initialization
  pf: cleanup initialization
  pd: cleanup initialization

Luis Chamberlain (11):
  z2ram: add error handling support for add_disk()
  aoe: add error handling support for add_disk()
  m68k/emu/nfblock: add error handling support for add_disk()
  drbd: add error handling support for add_disk()
  um/drivers/ubd_kern: add error handling support for add_disk()
  xtensa/platforms/iss/simdisk: add error handling support for
    add_disk()
  n64cart: add error handling support for add_disk()
  pcd: add error handling support for add_disk()
  pcd: fix ordering of unregister_cdrom()
  pcd: capture errors on cdrom_register()
  pd: add error handling support for add_disk()

 arch/m68k/emu/nfblock.c             |   9 +-
 arch/um/drivers/ubd_kern.c          |  13 +-
 arch/xtensa/platforms/iss/simdisk.c |  13 +-
 drivers/block/aoe/aoeblk.c          |   6 +-
 drivers/block/drbd/drbd_main.c      |   6 +-
 drivers/block/n64cart.c             |  12 +-
 drivers/block/paride/pcd.c          | 304 +++++++++++++---------------
 drivers/block/paride/pd.c           | 144 ++++++-------
 drivers/block/paride/pf.c           | 223 +++++++++-----------
 drivers/block/z2ram.c               |   7 +-
 10 files changed, 364 insertions(+), 373 deletions(-)

-- 
2.30.2

