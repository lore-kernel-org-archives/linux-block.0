Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5A7C433E9
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 11:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3565964FD0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 11:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhCKLCZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhCKLCD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 06:02:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624F3C061760;
        Thu, 11 Mar 2021 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OC4paoPsTeDwyil2PEGXok/rjQkwTBqmbry1+CpH+UE=; b=UzLhbZEjjd5t4cBp7QJyhwUzM/
        /RfEBwq0E8+mPa8V0Q8O+asOwVwNOdzXwEICChW8xOMulI+M/fm8+3qkxhvo96FuUQZVwFyVJLMkg
        YKQkuw8TJPNpbkS/O89JSk9DF2slrA7kNZbiY9lG6bXn4WdjHfPnTk4lj7D0Rq6g4CWNXbahCRRqO
        dyoPq1ixeHzSEpSUcHXrrw2CGkU4RllPis8n12xLLfcSp2IRvbut1ow2SIVtnCWyDSpM/bxVRcP7c
        +1JvXBobPXvxZwGskBFVowl07nio6SiVCJwD2l3k4AXJ4Ocns5saBv2hZcYGDHw8dHs1UzaUBUHYA
        Q7eX2qRw==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKJ4W-007DkA-Vf; Thu, 11 Mar 2021 11:01:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: rename BIO_MAX_PAGES
Date:   Thu, 11 Mar 2021 12:01:36 +0100
Message-Id: <20210311110137.1132391-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this patch renames BIO_MAX_PAGES to BIO_MAX_VECS as the old name
has been utterly wrong for a while now.  It might be a good idea
to get this to Linus before -rc3 to minimize any merge conflicts.


