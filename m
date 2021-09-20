Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97CFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDA160F6B
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhITL02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhITL02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 07:26:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38AC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Tn7pqMzfMVPd2wh6wmeXrFt6kOxT77dk6/Jn1YxPjw8=; b=j9cO74c6XRKgivyHVMr2mst3IW
        7Nwy9w+ZinXH0XIGFFi12jtq5NHoDd1AFMbws94acbaVhG7syG6q4Bp0HdpzQpJRWhgFYGW9T0/is
        79R0nb7Fkci8URdtTmykhPA661tP+lLRhRXBU0RCXWFNgHg8xUQyePEocIwhiI9wU9pHwMr5ai8Un
        CD6vWPyPaIvJOz560Xs/v2PYWhyaykdDhP0OqdYq/whp3F1g47rhlnus4kqFlZIZ+WDojm9e3inkb
        Quy+29b/QpRNh27+aLrlC2NjrVI3XdcMtNW/EI9Ilo/6DrGLL6ejIjzXyDvfvKlJ6vemHjOaK/9I6
        GI4rL/tw==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHP5-002byA-2p; Mon, 20 Sep 2021 11:24:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: tear down file system I/O in del_gendisk
Date:   Mon, 20 Sep 2021 13:24:01 +0200
Message-Id: <20210920112405.1299667-1-hch@lst.de>
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
