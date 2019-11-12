Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73183C17441
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA8120818
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 14:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WlrR7WN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfKLOuo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:50:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLOuo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 09:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sEPUX+fjGSBAUvIPMLjjkbM2wjez+7ShnBnUv0GrGXQ=; b=WlrR7WN0oU471oOXPzD/76xEH
        DpRzwnLXM1J6c9eHsZ9uHwP1womIAHdH/BLxeGPujcBv5eijmHg2NKXX0F0+QK4aXHeL7JzG4yXgS
        DBrc/zS1n40MPVH2DUHxyco4Gz4yB/HFzIZHk0nYHPy3waYm/HOVPs2l9clqXGtWmdeSv4b85g2b1
        s8NyDr7bSFHYbrxbd61CuMXCGVU8DPE3W08RO1Cqy8r94/GZN7KZj+0liECO7qu7V45Kds5frmjtA
        2iDWbyoP1NCdDQZq23AnjCqcpUL5JVxD8UnpvZFA2tpLA8HwjPCJGIg1qGsBwCXG4SxbVY9JIpdb/
        YczsttymQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUXVD-00014g-Gu; Tue, 12 Nov 2019 14:50:43 +0000
Date:   Tue, 12 Nov 2019 06:50:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     jgq516@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: Re: [RFC PATCH] block: move rb interval tree from drbd to block
Message-ID: <20191112145043.GA31295@infradead.org>
References: <20191112090139.16092-1-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112090139.16092-1-guoqing.jiang@cloud.ionos.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 12, 2019 at 10:01:39AM +0100, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Currently, drbd has the implementation of rb interval tree.
> And we would like to reuse it for raid1 io serialization [1],
> so move it to a common place, rename to block_interval, export
> those symbols and make necessary changes to drbd.

This should not be built unconditonally, but be selected by the two
users.  And lib/ seems like a better place than block.

Also please fix up any > 80 char lines that your naming changes
introduce.
