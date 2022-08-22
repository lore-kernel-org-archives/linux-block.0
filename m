Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F741C28D13
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 06:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiHVGRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHVGRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 02:17:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01C927177
        for <linux-block@vger.kernel.org>; Sun, 21 Aug 2022 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=B42I4RyXsvZ/IqVAc47sbEI/93yC6JhjypSy5p/Un4o=; b=ydqWOx83N/TqdIpT7OZxEPRtOQ
        2ekK4gqZiREC8BJVzMPonQvhfjdhOqJvwl0fMZMl8gcm0rkF+r5rFNbds4Yh98JMOxd3yhhy2Inld
        UxudXvOu8B9/wmx4/47Pz095gBk0aDSgDw+ph9RaPoNXgiaoK0nnMgi6o2go5CWfaOp3zA/dPm1Z2
        LvvZ5YQqe+Mdtoegk8tvukdREdpzb5KiFJaKkF1CnHUxKDOjLkx31a4HKuu4NLNoTDygOc7wZoc+c
        qdybuGocFe1CuA2+t37bspIB+PeDRd7rB1esSdIcYwgWJn+wv4HjAj78CaHY7/WTDinsmn0BkAt//
        AwEVXD0Q==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ0kt-005M8k-4a; Mon, 22 Aug 2022 06:17:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: rnbd cleanups
Date:   Mon, 22 Aug 2022 08:17:41 +0200
Message-Id: <20220822061745.152010-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series has a few simple rnbd cleanups.

Slightly related question:  why does rnbd send the max_hw_sectors value
to the client given that it can't in any way be used by the client?

Diffstat:
 drivers/block/rnbd/Makefile       |    1 
 drivers/block/rnbd/rnbd-srv.c     |   92 +++++++++++++++-----------------------
 drivers/block/rnbd/rnbd-srv.h     |    2 
 drivers/block/rnbd/rnbd-srv-dev.c |   43 -----------------
 drivers/block/rnbd/rnbd-srv-dev.h |   64 --------------------------
 5 files changed, 39 insertions(+), 163 deletions(-)
