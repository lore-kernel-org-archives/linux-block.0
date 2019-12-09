Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD88C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E135920692
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gK0WC1Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfLIJid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:38:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLIJid (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 04:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3pRO+Huj4dL5d2b5Vz1e69G/oUXWF3IOIpNL1cYBovs=; b=gK0WC1ZlnsyZtcXaMyVnGaW8P
        wUuahe9Q3AL2vTA2mH5+MpoH3kZIUJIHiA7dnorGPsXF08FqMhfvppdS2qRhUigGfI6oe154QVIva
        b0gsposcRFG3UivnuhW5o/a8mw313otNRhfIRCTVX/nI0IL4yBIZ5zpYUyB7yZ09mSxvo4S5+5m+y
        17lfk5mdV+JIDWPWOs0i1uJhdtLOOthgwb7PhUDpet557TCGP/Ie/untdQYMbtwkCMrSXSCTgYI85
        aUd+bICZSXYeOI8vpoSEFrWOJZdebbnPXprRXhNy1chUH2IaNSGNwPLwgZB7COV9ek6L0Y6s3PNxY
        rxCh/7tfA==;
Received: from [2001:4bb8:188:2b00:20e6:8b5a:ed96:f9da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieFUt-0002fF-KR; Mon, 09 Dec 2019 09:38:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, liangchen.linux@gmail.com,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: bcache kbuild cleanups
Date:   Mon,  9 Dec 2019 10:38:22 +0100
Message-Id: <20191209093829.19703-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Coly and Liang,

can you review this series to sort out the bcache superblock reading for
larger page sizes?  I don't have bcache test setup so this is compile
tested only.
