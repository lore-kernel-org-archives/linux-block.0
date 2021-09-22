Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F047C6112F
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 17:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhIVR0l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbhIVR0j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 13:26:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E037C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DmdPgSjd64Pg+v1QL6lVG4eJCrvZUh5y3s60Q5/a4tc=; b=aYr/p8EyRQqoA+wn6UbPowLFZT
        0wcVpBvRPWdXoSmKcC8eeSyEpF8NyrHniDT5PzFdM5p0jBFOPP/7GNvBNI3TAyQ9IqX7DzfF7s4no
        7XFa6ys4FUpj978kVXEgPhT4PkeVVlnYXOrFJKb+umt589UHuy3jJWCj/Hmbydd6FLMB69dQwh2v0
        vt5A8qEg4fU3qgnb1jyAmrfr5B7PDTg2YdM3gHLSBB37eMIuL8DH7q2wueHtsHpqSFLAN8fxvVT1l
        gOzoiD2y3/zy9YcXF9aV7ElgzFNgyi+Hp5dsRtDXoBPj2oefEGcLkkW966F52kAjXsT8mp0Gc2p8Z
        SuvkVoPw==;
Received: from [2001:4bb8:184:72db:3a8e:1992:6715:6960] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT5wt-004z2U-W8; Wed, 22 Sep 2021 17:23:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: tear down file system I/O in del_gendisk v2
Date:   Wed, 22 Sep 2021 19:22:18 +0200
Message-Id: <20210922172222.2453343-1-hch@lst.de>
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

Changes since v1:
 - fix a commit log typo
 - keep the existing nowait vs queue dying semantics in bio_queue_enter 
 - actually keep q_usage_counter in atomic mode after del_gendisk
