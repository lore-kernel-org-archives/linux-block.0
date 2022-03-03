Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF931C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 11:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiCCLf0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiCCLez (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 06:34:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3574B418;
        Thu,  3 Mar 2022 03:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bJa9qgtYYfiIC+/F69WRpdhiIshV0iFeP9NQD2r57nU=; b=pJ9yeyYaX6spyaSzNdz4ZWz/+3
        4vvJ1ua3dKNn0a/+vA8kygqoFt4BP7vNGJl5ZhGy7RGnTuVV1EYGDFzSs3k7jnOzixxeHnRvToRgz
        uSx5cTsaz+uvUl73IBetWqRvMbYEqHU/eKTaVjVL7VsC1UFLU97UlraqBCZzLfWCwxdxXHBu1xicV
        DgYVmcuPbL3D7OIwQlzRn+wvHPymiw72yyPwi4XapikvmeHj43cFEs/PyK6nGzdiUM2G2OtsvjrBT
        rPzWBCrPTqAEUJxW+upFLV4V+3G0pV1YPlDe1onNub1l9cgl/1MeOt9mOMgnVk/hA4PiHIyRT3pCG
        a3VvQQvw==;
Received: from [91.93.38.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjh6-006Dd0-7h; Thu, 03 Mar 2022 11:32:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-security-module@vger.kernel.org
Subject: a few trivial bdevname() removals
Date:   Thu,  3 Mar 2022 14:32:18 +0300
Message-Id: <20220303113223.326220-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series contains a few trivial conversion from bdevname to the %pg
format specifier.

Diffstat:
 block/bdev.c                  |    8 +++-----
 block/blk-lib.c               |    6 ++----
 drivers/block/drbd/drbd_req.c |    6 ++----
 drivers/block/pktcdvd.c       |   10 +++-------
 security/loadpin/loadpin.c    |    5 +----
 5 files changed, 11 insertions(+), 24 deletions(-)
