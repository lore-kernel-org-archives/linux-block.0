Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E63C47086
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7391661159
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhEYIOM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhEYINc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:13:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC5C061249
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHkmSXbexSqVKfSWUyjg+nTH6QI3hVq2/I/E7OYWsB0=; b=oxNHw8MYX7fOK40IvQhAYi2MCh
        CfGm6bi0kAveH+AQ7hwaAFmNzFVqnbNRRVborvfVg0cN3qz0nErHHWLOfbOQB57v7mQgW7lx/oaoz
        PRX2i7d3BMvPTOBZVZkGWYtNr8tWkB05iT5rgkaSb6iRX9o3RnHXbQaKeUx4tpSnNzRLUT21GVaXk
        XUcUgxddKEzOvXoQNDiXxn7Zc4r4X1tJZ4KhQSuu9W4fNGCYmJGx7f5AZcTinpKayvSGz815k7WNl
        gm5NI6zO385ngMR5yt7RwrS+7QQwNLvrKczscmewSm1NF/mFib4rUxZiwrWs+I12rQG82AkxrY3zZ
        VmKn8CVw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llS7E-003GHq-1f; Tue, 25 May 2021 08:09:05 +0000
Date:   Tue, 25 May 2021 09:08:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 02/11] block: introduce bio zone helpers
Message-ID: <YKywiKQX1nFFF4/8@infradead.org>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525022539.119661-3-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25, 2021 at 11:25:30AM +0900, Damien Le Moal wrote:
> Introduce the helper functions bio_zone_no() and bio_zone_is_seq().
> Both are the BIO counterparts of the request helpers blk_rq_zone_no()
> and blk_rq_zone_is_seq(), respectively returning the number of the
> target zone of a bio and true if the BIO target zone is sequential.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
