Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF29C63697
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C3A22240
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wFelGSIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKPVU1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 16:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKPVU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 16:20:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D6C0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 13:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ugOD0lTGTk7VfrCO9V+Vy1iZ55B+5+LA8fUXq9X4KaQ=; b=wFelGSISc+kkJErsTGCTlMjrV7
        rePdgs0yVi4KZU7wHenep9M0SBo2GVtj4B57awDIfuLLL4K1QYuFXoShi9BGHsCbAY0YX29gl7nvL
        rUiA3eqvLlSCqyfQHoQg0JkylCcGvSASDZkVw6uis4Ch815OaKJ6+kBXfZw12tS0py01r7zn/cl3M
        iZix0ne6TNdFE2W44WhBVtbIuoyoo3WnpJQl+g2iIR+btxpj5wohZuZMTcp9ir4NHfXouzA9Wzgbk
        8cdxAfy0dpOtD03hVpzU4hVk0q0NnI5OCtlcThB45T//XXCOE4Vwx3yighnYRLXdFv2ZxXkvUp3U5
        hv+MDNTA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kelvB-0007OW-3D; Mon, 16 Nov 2020 21:20:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: misc struct block_device related driver cleanups
Date:   Mon, 16 Nov 2020 22:20:14 +0100
Message-Id: <20201116212020.1099154-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Minchan and Mike,

this series cleans up a few interactions of driver with struct
block_device, in preparation for big changes to struct block_device
that I plan to send soon.

Diffstat:
 block/loop.c              |    3 -
 block/mtip32xx/mtip32xx.c |   15 --------
 block/mtip32xx/mtip32xx.h |    2 -
 block/zram/zram_drv.c     |   83 ++++++++--------------------------------------
 block/zram/zram_drv.h     |    1 
 md/dm-core.h              |    2 -
 md/dm.c                   |   31 ++++++-----------
 7 files changed, 27 insertions(+), 110 deletions(-)
