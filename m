Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C32EC6FD1F
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 07:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCNH6A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCNH5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 03:57:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4715D4D601
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tFZwyRwnxbU4hWyKlO7/ivdWjj
        u/cLYGn6xLzBPfAksR8VDfnVBk3b5SkVIZs5SyHBkSJeBXDVa5nPLzcOFEsNISTOUDzk3IpOSaMI7
        QHSlxZUyP2QIRjsX8CyTlWhwSIIKzUpnoakT1Q99T5D6SZOjX0sfI0JAlbZD7Vg17Qu9/NOW13FKJ
        dh2PilRLVCc5FE3vsryrSuplJxDqUCCJWzO35YSNb7K2aBMEcCCvEJimzN4bGvMyd/2gumvofj7d9
        nAx8x+6LxArMgVsItHy5BBModm49BTdmI3g+OK2nwP1KplcNcdFtGKKxFqEAfXWuMDwLXqCTD3Rwr
        s1m88GLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbzXa-009Px4-F0; Tue, 14 Mar 2023 07:57:50 +0000
Date:   Tue, 14 Mar 2023 00:57:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: do not reverse request order when flushing plug
 list
Message-ID: <ZBAo/ujrRXgsCrI6@infradead.org>
References: <20230313093002.11756-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313093002.11756-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
