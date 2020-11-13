Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E780EC63697
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868AA22244
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h+H/5fg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKMIrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgKMIrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 03:47:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDAC0617A6
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LKtTAdbeKt517SneoOlu0cwcttd8zYq9OQq0oU5GShg=; b=h+H/5fg6tajPUmldIluqHkHBN2
        XGPeEpA3JfovJrpI+QJJrmP0denn87y+IL/OhC2RGco1s6MGdtjZFmoepgwAW720xrrW6QD+ZSNMP
        E8Gd/FVEKijlrm7x04ILIGmD6zdJWUhPyuARqWLx9R49SBcUSEIFhqipza7TKiCFt15+vwl1sa+gP
        84gKea5SlReK7zSG3yKTx65kZaGTMc31jlNQQNX7cJtrSGdlJYPv2vIktRdWnQAerCVU4srnqvmzC
        U2snpCOA3xsmj+WWdUYV6lbutz//OIHSo5IL1ujez+4lAuOwrAoX8SyI6elkb5n+D77UspmP0hHXf
        knTqXmaQ==;
Received: from [2001:4bb8:180:6600:bcb2:53c8:d87f:72a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdUjX-0000QO-3m; Fri, 13 Nov 2020 08:47:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org
Subject: split hard read-only vs read-only policy
Date:   Fri, 13 Nov 2020 09:46:59 +0100
Message-Id: <20201113084702.4164912-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series resurrects a patch from Martin to properly split the flag
indicating a disk has been set read-only by the hardware vs the userspace
policy set through the BLKROSET ioctl.
