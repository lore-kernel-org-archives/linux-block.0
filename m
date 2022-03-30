Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C4C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 14:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiC3OOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbiC3OOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 10:14:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7011ED07F
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mCY0uR05JiICycVka4IC+afxOKlJb8tI812tZ6NZkq8=; b=JBxrVZUa0R4slFSswVAxLDL8Yu
        fQ2KsoPNdVokQsbOCTt1jEHixTXwUCTe4PGlXlSwowZlno24qjLmstS5KPXMGc/qxkq8/9d9QvZw/
        oi/KP5w1LjD8v+jp6XdObIQuq+LP0HZcCjpE3QT2U30YAw7m60skudhHlD0z55Uj1WraTtRiC8shC
        6LYpZtxSw8VwbK96h2udokD2hzkCtOOEj343VLKJAUOdtJP1KA739bTN27mz1ecBMEj/e6zozY14O
        3xPCBeXwFFXmJ9oZPrIR0qkzH3XrjHQE4D6iPYgmf1lIv9ToG3raEta9YYxDq/DvOz0LnI1KToo0u
        eH4MRr1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZ4E-00GD4Z-4A; Wed, 30 Mar 2022 14:12:58 +0000
Date:   Wed, 30 Mar 2022 07:12:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 8/9] bfq: Get rid of __bio_blkcg() usage
Message-ID: <YkRlasF4GzJ+iHo/@infradead.org>
References: <20220330123438.32719-1-jack@suse.cz>
 <20220330124255.24581-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330124255.24581-8-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 02:42:51PM +0200, Jan Kara wrote:
> Convert BFQ to the new situation where bio->bi_blkg is initialized in
> bio_set_dev() and thus practically always valid. This allows us to save
> blkcg_gq lookup and noticeably simplify the code.

Is there any case at all where it is not valid these days?
I can't think of any even if we have plenty of boilerplate code trying
to handle that case.
