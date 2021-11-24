Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 07:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhKXHqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 02:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhKXHqP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 02:46:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAEC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 23:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=IO4N6hUDJ1K95SL0pp5XCQ7KK+
        veyYRn5b9T3dk51XCqtV2hV1eMbaLguzXCQW/YweTMgmGGCUcpee6WSEwZ2XdSrj88WWNeZHjwYXR
        pZHTFHY6FPw7zm7orx3LZO/iko08nrEz3TqdwFCL5E3sihFKsYGZSVX7gh0juAQLgDUlYf+y7pX+y
        nI67aCyyiSUbCMRJT4pKofhl/kHEkquw/iTJTVqQDa40uoDKSpbuXKfCq1NGyR/5ONxcxtok4yWP7
        F/KX0CtfN2zsiCQhJ8AqconF33dkK2KCjAQgMJnzifwTmaueQOH2xhIgQFBRoCMCt7xhQjDnO0ZrP
        kX/NprOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpmvp-0049SS-RX; Wed, 24 Nov 2021 07:43:05 +0000
Date:   Tue, 23 Nov 2021 23:43:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: move io_context creation into where it's
 needed
Message-ID: <YZ3tCeepj7B1PUR2@infradead.org>
References: <20211123191518.413917-1-axboe@kernel.dk>
 <20211123191518.413917-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123191518.413917-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
