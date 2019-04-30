Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CCC46460
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8F421670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FSNU5ctL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfD3Sn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:43:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfD3Sn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 14:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=705ZHdLGvhRIv+nk4TA5dZa00jGzEf4ucNT1d2/V0B4=; b=FSNU5ctLpromrytj339xoRkjYj
        HkoMxgOcr4J5uGG8Sq+Q56nECULN7yLXPSqBxkg4TzWb3cT7sdf40tch4/FGxgey+i63Zijw5D7qf
        lMSe0jzSXPTc0CDBrEd8cXHiYyJluAhHNrLtHAOMh/lU+P7RT7fXOw3N7ZlqLrXuiwIDldjyNseJA
        hrxmhNIiTeZLl0qM2QvL+7zIPAvzB2lTog0JnmP7FDNufIQprx994oidjWVPtJrM+DCUZvPO2wXnG
        GIubkS6AJdUNCpwYMzQeqkyzvLmNSojl75MNB1e1yV2aZmniz1dL8U5SzJbf7DwztTzx4TSeTHULt
        yF2WAelw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLXiv-0000sY-5k; Tue, 30 Apr 2019 18:43:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sed-opal.h: remove redundant licence boilerplate
Date:   Tue, 30 Apr 2019 14:42:41 -0400
Message-Id: <20190430184243.23436-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430184243.23436-1-hch@lst.de>
References: <20190430184243.23436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The file already has the correct SPDX header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/sed-opal.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index e092e124dd16..33e53b80cd1f 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -5,15 +5,6 @@
  * Authors:
  *    Rafael Antognolli <rafael.antognolli@intel.com>
  *    Scott  Bauer      <scott.bauer@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #ifndef _UAPI_SED_OPAL_H
-- 
2.20.1

