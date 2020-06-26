Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A7C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797892080C
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ePU86+1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgFZICQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgFZICP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:15 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E998EC08C5C1;
        Fri, 26 Jun 2020 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=evLhQUDqGn1MyI0vCZBcL2D9Su9YcVfh2zXK+rFpq50=; b=ePU86+1eGaB4Eb42we8BRUWkzy
        vf1oca8hIWNAvr7X5ke8sNR8wyRln6ZQFY1JIhIebBV1bwSiOKIP4pf/a3+k0Nhd4isbYF2wWIqGY
        e4J2/spxMcirpebuRwfbyS9FsMkNIqycXDudhnH5NifHPtG60wxHJkjH+l54AOgkp8P9uJBSX7o7H
        UBYSXp6tbMW51QmB1desCemBRGT/J4bhgsh2UrpCfAraHzzfDSWFlZ8JenQ/j6GfMuxwlHTeU8++E
        3hn6dH3WMFI8Sv9KCKF+gc5uwo8LPMVb8Q/MixzDBHGkP5qgtt987islj5Sgim/5kgW2YPgGrB+M9
        0z605/oQ==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJ9-0007U2-Cm; Fri, 26 Jun 2020 08:01:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: remove not needed fields from struct block_device
Date:   Fri, 26 Jun 2020 10:01:51 +0200
Message-Id: <20200626080158.1998621-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series put struct block_device on a bit of a diet by removing
fields that are unused or rather pointless.
