Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BDDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhLUQUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbhLUQUC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:20:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C8C061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=shE1Wtofp16DWvLrOi6IE6l+Wu
        zp4n8J0/Hd9+RiSkASgT6g7YKfJ8xUuyT2gHhZJiN7wvoHPt10e3Wk4SwFT5QSsKh5XMq/KKefGkY
        SYiDefVoyNqwT4OAiW6owGC18bw/MHdcji35j2IqjqdiNNLdw1w8UeY6wLtfH2DDdvcDb3v+ap9BC
        YXftKWsB3m+pwKkR/vreNdftE1wzAfnqASNT/5oUsvv0BLzfJ1CkmblCAe/T9sJFAlt4I1rBFZUgP
        3Zr92NFIv9XRq4TI6FWFRCTf3cBNhavQF3LFHR15D6M0t04pt7I9EN4gsw3M3wxKndCuvpOE3/MRX
        fk7CsyMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzhrt-007Xc5-70; Tue, 21 Dec 2021 16:20:01 +0000
Date:   Tue, 21 Dec 2021 08:20:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: use "unsigned long" for
 blk_validate_block_size().
Message-ID: <YcH+sf3PpqVs+Yr0@infradead.org>
References: <f81aaa2b-16c4-6e20-8a13-33f0a7d319d1@i-love.sakura.ne.jp>
 <b114e2c8-d5c2-c2e8-9aeb-c18eaba52de0@kernel.dk>
 <7943926f-4365-f741-a353-4820b8707d87@i-love.sakura.ne.jp>
 <6e9e3cf6-5cb6-cde6-c8ef-aafd685d6d97@i-love.sakura.ne.jp>
 <9ecbf057-4375-c2db-ab53-e4cc0dff953d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ecbf057-4375-c2db-ab53-e4cc0dff953d@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
