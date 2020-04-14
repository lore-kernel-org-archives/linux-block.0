Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA02CC2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814492076A
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJA54/BG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390780AbgDNH3I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:29:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgDNH3I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 03:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BKn5jefJR/eysebjx+9KHAQmWkLyv0jA4EDNIFifSXU=; b=NJA54/BGEKWwWdE69yY4wIT5oi
        L2GFmGf4i7zf/xvo/uxJYmoEqF296UekQ0y5zdjNoVWsHNl+II55OIrN5cI2QfNKQomvfvn9NWFIe
        5WiermtDUHj9xHslW1EXv5Bz+H3taWtn7xbGqZ/eSjAVAKiKu1DfH7mqC4cL8LMp0qRXiHqkzYQXL
        nyOiBvXsDEgf+g9WE+1z4k+UXg3jY9MTEbRJecuLfwGWYNELp13woGt5mrR/u7n6VfEEAONMRzA28
        h6mkdvgMSyWRb/b8CPbEyYvuoyD8ACdVSJAsyPcoCIt7oXmPUbSEOWnEXcixHGaVRW/82zcyvrPGj
        2RTWcO8g==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0I-0005YV-Ki; Tue, 14 Apr 2020 07:29:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: more partition handling cleanups v2
Date:   Tue, 14 Apr 2020 09:28:52 +0200
Message-Id: <20200414072902.324936-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up more lose ends in the partitioning code.  It also
removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.

Changes since v1:
 - fix a brown paperbag typo in blkpg_do_ioctl
 - fix a commit message typo
