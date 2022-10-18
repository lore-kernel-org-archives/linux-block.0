Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6BCC433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiJRPxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiJRPxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 11:53:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2DCD7E1A;
        Tue, 18 Oct 2022 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zf4gOcI6C87scCaKQU1pT9sh6A
        yUWEyyw87qh1lBwPTHTqke1kzwIVtX4vu7GWCMymusv4xKiEwpSe99CtTjLv/TikxKQ4eSJ/b+i27
        8kXbZ9X5lusgDpdwiDMfgwTG9AmUf7cdEFNcO8aL7XPzwHijGWGT8rt2BRbQtAFO4nARdzGP+avT0
        0PmUwVRJBvUHf09qpuQwCjIWG9SrBXvB0UkrrEf8PTk+wq/S5BfarkAhSjGYDRRbP/6go38kTUOE+
        nMGUIRrmnPgDGsxNTUQOXlCFibQzQ1hG8/pIw0adCphJr8ASU4y8d2d72s+Qc4igosaHTyfVGMeiy
        VGCC+ytA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okotd-0081xt-3D; Tue, 18 Oct 2022 15:52:49 +0000
Date:   Tue, 18 Oct 2022 08:52:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] blktrace: fix possible memleak in
 '__blk_trace_remove'
Message-ID: <Y07L0U0qppqv4cfg@infradead.org>
References: <20221018145135.932240-1-yebin@huaweicloud.com>
 <20221018145135.932240-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018145135.932240-3-yebin@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
