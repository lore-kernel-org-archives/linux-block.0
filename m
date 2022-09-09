Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16AAC6FA82
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIINPX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIINPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 09:15:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E46B55097
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7p/KNPv3D+T4c0ErI9K5h7dSVVWtOPDPJhJF8ts8MNE=; b=YXUJP6rZlwMU5W64N0zlWKBesZ
        Xbvp/axn338NKqfcXp0g8wDrYHVZSfrJJJ7/l0gpX+jJu0yoL1e97VQmA19leAcLd4wjyx3aUS/az
        z/X5ZyhYJJkgXKbYiqniOw2skt3QgOkl/L/8OVA/DOPVZICadO77YydW+Tc9ktebx7/wkGhM37Y5g
        6AoBO3cHZIDKIEfQAL5/cZM5/DG3PKOrX0ypqaiYhxG7Zx7xVYrx/ZkXwgvJyfgKm9i46trz8aZNF
        ULZZxErbpJ8yWnejvb2UsP64OpNR1/nwtH60Alm5xOVNfgarHbec0cADu1FDdqAzpKObA4BGZQv17
        ubLrvg0w==;
Received: from [2001:4bb8:198:38af:a077:6a38:dc23:be2c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWdqm-00GGtt-Mq; Fri, 09 Sep 2022 13:15:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: rnbd cleanups v2
Date:   Fri,  9 Sep 2022 15:15:05 +0200
Message-Id: <20220909131509.3263924-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series has a few simple rnbd cleanups.

Changes since v1:
 - rebased over a trivial cleanup in removed code that got merged into
   the block tree

Diffstat:
 b/drivers/block/rnbd/Makefile     |    1 
 b/drivers/block/rnbd/rnbd-srv.c   |   92 +++++++++++++++-----------------------
 b/drivers/block/rnbd/rnbd-srv.h   |    2 
 drivers/block/rnbd/rnbd-srv-dev.c |   42 -----------------
 drivers/block/rnbd/rnbd-srv-dev.h |   64 --------------------------
 5 files changed, 39 insertions(+), 162 deletions(-)
