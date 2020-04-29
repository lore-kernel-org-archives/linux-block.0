Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0146C83003
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2EF20775
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLHQWhFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD2HUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgD2HUk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:20:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB998C03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pWZiUOr50LUZPcsWwoXvBliBtclfygG5ruoitObx0l4=; b=YLHQWhFrqHDXvBQJhqrh1hlIV/
        cnnNVB2TZgufIKFaj6OW4iK8VljbtQenFLJS/Lay7WaEKnAWH28ZMNwhU3IpbEZ/3mDJHebpLebdH
        EWd5u/fLeBbfZW2bCl6l2r6GNBEua1BMygq7ZBaag9BDnfcDhugLgog2qaiDOMyDPidMZDOvNskPJ
        7nBfvt9CsKEGY+IPu+cMa2hPC/1L8AtuhmxOECNDAiyQ/yUFdKFqIiHKPZlgowmi2HRODKiY733zX
        8/SvgPmH6OVGxwHmcgNj7QyFmzCG1HjQHoEFm63azb1uxqFi2QRqv8mS4F1EgcBwr2wfBRck31dMJ
        zrQ+Yx+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTh1K-0005Qz-FT; Wed, 29 Apr 2020 07:20:38 +0000
Date:   Wed, 29 Apr 2020 00:20:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/3] block: remove blk_queue_root_blkg
Message-ID: <20200429072038.GA11410@infradead.org>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
 <20200428164434.1517-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428164434.1517-2-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 01:44:32AM +0900, Johannes Thumshirn wrote:
> blk_queue_root_blkg() has no callers, remove it.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
