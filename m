Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23018C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 17:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiDMRnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiDMRnh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 13:43:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D6A6C4A6
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pzPEac9qf8uKzme4W7jZluuPgXHk2smbOZYsmh1aHv0=; b=qxuF2pnCVI9rC6SVgFWm64CFY0
        oAEKNbkF0lUlkImfoWoVmTNheKMMuFmnUh7SqhrVI1bR8PI1/C5nMMnNInF9C34vRdQu2SMKV+N7p
        36tdVaa2PtfztOEENnAn5KuhghHxj0GLPQG06/ZC+RyYqL6TXPvWInczOGdWkMCRa7EaxNlETcQXV
        AiZzn6gingpb4eBtYEk2fTK4v1rd/CH23F4YzDwMMzoMaUqfFFuqBQyiqVJAIk41/0iHJ+wYvLSHe
        sbKgWgeB6SfWYOlCaR0LlB++2db8+4PQZQbB2Ta07VSoXcHZNwWVhW82YSSXXLjA4fpe3latiSw8e
        EYjH076A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1negzQ-001yhj-Ct; Wed, 13 Apr 2022 17:41:12 +0000
Date:   Wed, 13 Apr 2022 10:41:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcLOM49JsdlBqTW@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlcKqu3roZQSxZe8@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 10:38:50AM -0700, Luis Chamberlain wrote:
> On Tue, Apr 12, 2022 at 09:53:12PM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
> > > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> > 
> > I'd suggest to ignore broken tests that require a deprecated option
> > that will eventually be removed.
> 
> CONFIG_NVME_MULTIPATH will eventually be nuked?

You'll only get a single namespace without it once the phaseout is
complete, yes.  If you want nvme multipathing you'll need it, which
is the story since day one.

If Bart wants to test dm-multipath I think his earlier srp_tests are
the much better choice.
