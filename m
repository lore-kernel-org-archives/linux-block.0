Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA5BC7EE29
	for <linux-block@archiver.kernel.org>; Sun, 28 May 2023 20:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE1Udn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 May 2023 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1Udm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2023 16:33:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9CB2
        for <linux-block@vger.kernel.org>; Sun, 28 May 2023 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k65WaWlBkZLP6SFaIJSZVQAU0MLooq7UEDsv5BMS+ss=; b=Iui5tJdJxnEhPGMN/Z6241/yZs
        on+z5b7mWICOdRLmdoUanOxPDYozxBgknrhT8DsrBsOXAcCuDGZPhwV6uz5kaVHkdjlPNbdE6Llif
        hApPAcWS64fS+LZUtYMW6RoL5hsrDg+32TtkxztIGxKup5twvmRwzgcWZzvoWh0Uk+vbrmJc36tqD
        ZlM1mKQxTTbUHjnEmuLUZxgnMcj64eznmYuMjL/NjgENZx4ZLIL/jZl98YGbTZ7gxgOGaIEe0pdk8
        p2hQvoHvb6mI0ugeAtO7VdIE90T8CZCOBac0r2quMvHLRqs16XTwE8O+oRoCMIvmsk0fHIX2HQX2u
        MyP4+fYQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q3N57-008NBu-3C;
        Sun, 28 May 2023 20:33:37 +0000
Date:   Sun, 28 May 2023 13:33:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 3/9] block: Support configuring limits below the page
 size
Message-ID: <ZHO6oYt/y2lKPBaB@bombadil.infradead.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-4-bvanassche@acm.org>
 <ZHF2Hbv5qBJl9CZl@bombadil.infradead.org>
 <62e672ad-be3a-2ce8-ee11-c9682ab7d21d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e672ad-be3a-2ce8-ee11-c9682ab7d21d@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 27, 2023 at 09:20:30AM -0700, Bart Van Assche wrote:
> On 5/26/23 20:16, Luis Chamberlain wrote:
> > So I see this as a critical fix too. And it gets me wondering what has
> > happened for 512 byte controllers on 4K PAGE_SIZE?
> 
> What is a "512 byte controller"? Most storage controllers I'm familiar with
> support DMA segments well above 4 KiB.

Nevermind, there shouldn't be controllers as such.

> I will look into this.
> 
> > The way I'm thinking about this is, if this is a fix for stable too,
> > what would a minimum safe stable fix be like? And then after whatever
> > we need to make it better (non stable fixes).
> 
> Hmm ... doesn't the "upstream first" rule apply to stable kernels?
> Shouldn't only patches land in stable kernels that are already
> upstream instead of applying different patches on stable kernels?

That's right, so the question is, is there a way to make simpler
modifications which might be sensible for this situation for stable
first, and then enhancements which don't go to stable on top ?

What would the minimum fix look like for stable?

  Luis
