Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F76C433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 14:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3439320719
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 14:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLqCqkxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHaOMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgHaOMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 10:12:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DA9C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=raGVmUBpFNekA316I/9ocJxfNLwvVvyLKu7HYdnXGgc=; b=dLqCqkxV5WCqpezGBbyVFtWfda
        9g9dGr6D+h/oxl2OP79aPzqpApxGZGUKS8TxbQazmZQ6qu7fcKs3sNL7zE+DzX8mT1leXw7VGvzu4
        Ok7IlnKsvPF1F1wIuhLgPJEIsLpI0KhCrissiuK+uuYatAiBojzH1ZkD3AeyvSz9ww431FnGNr22Q
        61zKpHuDbC/G9JaT5IElJ7mhmlFYNvVGRuTLikF5HUfEuD1B3G8XW1gDADIIlvRkv0RL2mZvmX8Gy
        qIJZcKtE3Bkf2CYQI61zcO55XR3YtIQLdBgqwFSrqdivHH5MEEHYlxyk52CtGMSDe6sKjNu8MaYkZ
        ZPCkzaBQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCkY1-0003Rg-MP; Mon, 31 Aug 2020 14:12:37 +0000
Date:   Mon, 31 Aug 2020 15:12:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
Message-ID: <20200831141237.GA13231@infradead.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
 <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
 <20200830152800.GA16467@infradead.org>
 <ebdb0929-782c-fb66-e3e9-86c077e3b710@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdb0929-782c-fb66-e3e9-86c077e3b710@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 31, 2020 at 08:02:43AM -0600, Jens Axboe wrote:
> >> The use case is async submissions, going through ->read_iter() again.
> >> Or ->write_iter().
> > 
> > But how does a bio flag help there?  If we go through the file ops
> > again the next submission will be a new bio structure.
> 
> Yeah the patch is garbage, can't work. The previous suggestion is here:
> 
> https://lore.kernel.org/linux-block/395b4c19-cc80-eebb-f6ab-04687110c84a@kernel.dk/T/
> 
> which isn't super pretty either, but at least it works. Not sure there's
> a better solution, outside of marking the iocb as retry and then
> carrying that flag forward for the bio as well. And that seems a bit
> much for this case.

We'll still need a flag with the above to skip the submit_bio_noacct
bios.  But I think it is the right way to go.  Eventually we'll also
need to push the accounting down into the individual bio based drivers.
