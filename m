Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C4BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B8161368
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 07:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbhI2HP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 03:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244486AbhI2HP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 03:15:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896BAC06161C
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 00:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=q/6bix4Pj8WDMOQ88jaSgL+NDsM1q2XSL46VHfZnYts=; b=W1ubT4SCfrV5ioobA1LV1OwcEB
        uLYCYALX6vXHH49Eo2Rt9Rq5u6M3f1Vq0wdxCo9XgEhniT83p/F/ifvUwMCPRZSi87iC49J0Cichf
        K15hk0ftBD+aBdMv4o5FZe1dDKYvafAe1LG4qppYdLGLmsPle5LwIRkNg/cedD/ZIV3xn10b5bVqR
        ppPV40CXe4bJ61pdiyvpr1Gy2mksifjryGj/PoRNPjnMtufZgkw8qddaSM+AVMnLqkOy3zoaHBgnd
        /ZKMZCZskXFlvWh6TI7OaVpY4vSpAO/84YLD/TunnU1SnmBw6XMmMciUeGlX0XSgt3iDUKAcwd2CR
        TsxOIafQ==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVTli-00BasR-70; Wed, 29 Sep 2021 07:13:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: tear down file system I/O in del_gendisk v3
Date:   Wed, 29 Sep 2021 09:12:36 +0200
Message-Id: <20210929071241.934472-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming reported that for SCSI we have a lifetime problem now that
the BDI moved from the request_queue to the disk as del_gendisk
doesn't finish all outstanding file system I/O.  It turns out
this actually is an older problem, although the case where it could
be hit before was very unusual (unbinding of a SCSI upper driver
while the scsi_device stays around).  This series fixes this by
draining all I/O in del_gendisk.

Changes since v2:
 - move the call to submit_bio_checks into freeze protection

Changes since v1:
 - fix a commit log typo
 - keep the existing nowait vs queue dying semantics in bio_queue_enter 
 - actually keep q_usage_counter in atomic mode after del_gendisk
