Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04EDC433E3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800CE207DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mahqk11P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHUI5L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgHUI47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA4C061387;
        Fri, 21 Aug 2020 01:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EVl8E61DXgRR1ZNIk2YxGikvQ2O1Ac8Y751dPUZf5kA=; b=Mahqk11P0dtVI6WvpVZ3wbPfd6
        TOLmouapre5P0kVTzEU3HqwZFByZlxCfsG6R4LCAQEde65aGjIHnOELkSeXiwBiVLsCgnaiFc5MSt
        bvGYyrZ9NusMwXnv+hlzhDJ+I4OVdlWF/WhR7di5/YwH+8C/4tFLNJRZdH9NKDu3+jfaCADVNAeGN
        ktm0Qw0jD8zXP93Qm5deyNsGMKjxkuKyjwIUIvulughoawMKj7P036hpaE1C8BhnQ1KNpjW7ltyqz
        UB5eZs1ummTyPWBBdfzQmKKtQe7CWVkU7RMOrEnMA4elIOFazI/1fyVNV75dx+bpdv3LTg5BtDuoO
        VVT7V/RQ==;
Received: from [2001:4bb8:198:f3b2:a2b:85ba:fb78:c253] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92qE-0007el-7k; Fri, 21 Aug 2020 08:56:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: fix block device size update serialization
Date:   Fri, 21 Aug 2020 10:55:58 +0200
Message-Id: <20200821085600.2395666-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series fixes how we update i_size for the block device inodes (and
thus the block device).  Different helpers use two different locks
(bd_mutex and i_rwsem) to protect the update, and it appears device
mapper uses yet another internal lock.  A lot of the drivers do the
update handcrafted in often crufty ways.  And in addition to that mess
it turns out that the "main" lock, bd_mutex is pretty dead lock prone
vs other spots in the block layer that acquire it during revalidation
operations, as reported by Xianting.

Fix all that by adding a dedicated spinlock just for the size updates.
