Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D81C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 14:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiFWOAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiFWOAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 10:00:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9493CA40
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JE/h7X/x9s/X5XNVFeGBVYA26JDOiCurzz+86ByGdKE=; b=veoQ+EfKirGSgBQprwk0d6duUE
        C8dGfnziPiLQwJ5MkC28SBttS8qniIgR9pU6dMCrxgf7if5JVqkQup+jo1YGtw1zilwCO0VDiAlTl
        zJR1WnoEX0Gaobj32JGJVDuof2vqNf7iS5RYlrNm1jLjySCOd/vR7Mr5dNMqNPr9abASCkxvrrd3m
        TLpaDZNr2aynZiy7/6Zyzpuz4ta7nAwiiydFDi/1s6KN5F81V2lhpOZDEOPCk7h1QFqKsLZayxZEM
        HNtROgEq5RYnvaRu9OtWQ3FXYBmHiF38njNRJcuDjllEL8G/FPnP1n7b1Qh92p6wslvjOx3cI9WXE
        uRX2dqqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NNu-00FRzc-GR; Thu, 23 Jun 2022 14:00:38 +0000
Date:   Thu, 23 Jun 2022 07:00:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 6/9] blk-ioprio: Remove unneeded field
Message-ID: <YrRyBhC9gYI8EGrm@infradead.org>
References: <20220623074450.30550-1-jack@suse.cz>
 <20220623074840.5960-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074840.5960-6-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks god:

Reviewed-by: Christoph Hellwig <hch@lst.de>
