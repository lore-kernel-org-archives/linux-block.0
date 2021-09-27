Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E701EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF95C6101A
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhI0WFb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbhI0WFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:16 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E466C06121C;
        Mon, 27 Sep 2021 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Qm1LFoZMfn5lSLKsNTBNPz2MUy7MRXKY17ahzFVUS3I=; b=37HYpCszFL1/b0oe/u8pFd9QH4
        +c+3j84RuEtSW5Qk6nZIclMOP2UEhpq86fk3g/zNpEtdKHuNE5BW9aa9ZQimPbGtXQ5W1rodKdCwR
        /Zrz64kre/ZLz98Q0kSUgNiY3OmmRtSWOxnaOgzxEX7YPUEmIItcEVUI0UxGlhpoGvm0TBpDaFjM4
        f6ccW7cjGNpKb8t58ADq1tt16SwJ/oaYFuW0KmAPiB5snBepZsnNwg3H1tSeitacXdf9g8tsZBa/W
        NPmUVPHx9iHPOioxoiJc5dEFjQpzx8D7ZXWu3TZeiCzx19T2ruTWOCCouk4YwPTKCN1N9y8RbvfR/
        ltsoAbLA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyhC-004UJ9-A2; Mon, 27 Sep 2021 22:01:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bhelgaas@google.com, liushixin2@huawei.com,
        thunder.leizhen@huawei.com, lee.jones@linaro.org,
        geoff@infradead.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com, tim@cyberelk.net, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 00/10] block: fourth batch of add_disk() error handling conversions
Date:   Mon, 27 Sep 2021 15:01:47 -0700
Message-Id: <20210927220157.1069658-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the fourth batch of add_disk() error handling driver
conversions. This set along with the entire 7 set of driver conversions
can be found on my 20210927-for-axboe-add-disk-error-handling branch
[0].

On this v2 series the following modifications have been made since the
last v1 series of this patch set:

  - rebased onto linux-next tag 20210927
  - added the only reviewed-by tag for this series for rnbd Jack Wang

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-for-axboe-add-disk-error-handling

Luis Chamberlain (10):
  mtip32xx: add error handling support for add_disk()
  pktcdvd: add error handling support for add_disk()
  ps3disk: add error handling support for add_disk()
  ps3vram: add error handling support for add_disk()
  rnbd: add error handling support for add_disk()
  block/rsxx: add error handling support for add_disk()
  block/sunvdc: add error handling support for add_disk()
  block/sx8: add error handling support for add_disk()
  pf: add error handling support for add_disk()
  mtd/ubi/block: add error handling support for add_disk()

 drivers/block/mtip32xx/mtip32xx.c |  4 +++-
 drivers/block/paride/pf.c         |  4 +++-
 drivers/block/pktcdvd.c           |  4 +++-
 drivers/block/ps3disk.c           |  8 ++++++--
 drivers/block/ps3vram.c           |  7 ++++++-
 drivers/block/rnbd/rnbd-clt.c     | 13 +++++++++----
 drivers/block/rsxx/core.c         |  4 +++-
 drivers/block/rsxx/dev.c          | 12 +++++++++---
 drivers/block/sunvdc.c            | 14 +++++++++++---
 drivers/block/sx8.c               | 13 +++++++++----
 drivers/mtd/ubi/block.c           |  8 +++++++-
 11 files changed, 69 insertions(+), 22 deletions(-)

-- 
2.30.2

