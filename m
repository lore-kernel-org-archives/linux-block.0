Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7CC77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 20:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjELUVc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjELUVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 16:21:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D42711
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RKxzeAsZF2od71tJyXj11ONdbeZ+nilGNs6MJtTqG+8=; b=2Ctlkh+2PBQhSS5S7c/IEH6+GB
        6ng3TnlyOf0Ww+ipRBhsilbrYI8nDsAQNSXbBUqIo8qsoppBGiK3R4dzZV5KZoRjitnStW18MFFgY
        X+TkkyXW0Fufwm0lEzkPmZPodfChTDP/dTAWfu0faZOi8CgmY660Gx7mB3xgw6aEkB+wHQFXtN2LL
        DwRTYnhtTfYc1xL+/7ZilUkKQA+7zW5oNN52+LqSXVBWLKpK7fsR1iN6XoiUICzRagL3GG4DxEtqp
        X9TcUOeDMebnzOihhPppjGUZlwOoxHLcIxXMa/H2Xhcr05SeU6EzMipS4mar+XcV/jOcaEF8I4fZp
        xvMJCA1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxZGb-00CsCB-22;
        Fri, 12 May 2023 20:21:29 +0000
Date:   Fri, 12 May 2023 13:21:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF6fyc/vFGm56mDO@infradead.org>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
 <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
 <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 09:43:32AM -0600, Jens Axboe wrote:
> We really have two types of passthrough - normal kind of IO, and
> potential error recovery etc IO. The former can plug just fine, and I
> don't think we should treat it differently. Might make more sense to
> just bypass plugging for error handling type of IO, or pt that doesn't
> transfer any data to avoid having a NULL bio inserted into the
> scheduler.

I'd suggest we distinguish by ... having a plug or not.  Anything
internal like EH or probing should never come from a context with
a plug.

