Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D9C433E0
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F4164F73
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhCLUVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhCLUVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 15:21:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE40C061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=otb3LF22QrkNLfbh/hj/fFQ0SOolTYszqEC35Z7P/14=; b=fEpH/IO614HbIv25u3JDbKcAea
        0g+xEf5eWo2v2YQ1pCZ4nvjxUF3GY1yx7sraBUp7sx2g/YauOLi5iZgeOSnf+s6qYU2jeW+ARXsgN
        VFX5T3wOj2gSkbaZ+zKAkP7ItfmY3YrLb3OmmUS1/Y4J8x36+Q9WTvxSF7OKyjGo4NfiVphahphvp
        KI+iU8K8aw69F2cQMZTHrA/kSwUOlx0KBRF72RtGSXqkEOI36AYoNryOVxkuXUa2SJ7UM8RUgOXS1
        66C+RFiJMOcvKsIG4ZRWZe5Hn2fEv7LCsLAlMkM3Pd9DCb5I/9OM35P6qS6LbkKz/06VfLnPl1rnz
        aHLJewlA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKoGv-00Bf0q-FS; Fri, 12 Mar 2021 20:20:36 +0000
Date:   Fri, 12 Mar 2021 20:20:33 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 5.12
Message-ID: <20210312202033.GA2778279@infradead.org>
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
 <20210312195932.GA2766489@infradead.org>
 <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 12, 2021 at 01:01:18PM -0700, Jens Axboe wrote:
> On 3/12/21 12:59 PM, Christoph Hellwig wrote:
> > On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
> >> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
> >>> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
> >>>
> >>>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
> >>
> >> Pulled, thanks.
> > 
> > I just sent you another one liner fixup on top of this directly.
> 
> Where? I didn't receive any.

"[PATCH] nvme: fix the nsid value to print in nvme_validate_or_alloc_ns"

I just noticed it went into your facebook address as I copied and pasted
from MAINTAINERS..
