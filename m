Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11293C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0872082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0872082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLDOzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:55:16 -0500
Received: from verein.lst.de ([213.95.11.211]:44251 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeLDOzQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 09:55:16 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E54C568BDB; Tue,  4 Dec 2018 15:55:13 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:55:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec
 pages to bio
Message-ID: <20181204145513.GH3180@lst.de>
References: <20181130165646.27341-1-axboe@kernel.dk> <20181130165646.27341-25-axboe@kernel.dk> <20181130192102.GP2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130192102.GP2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 07:21:02PM +0000, Al Viro wrote:
> On Fri, Nov 30, 2018 at 09:56:43AM -0700, Jens Axboe wrote:
> > For an ITER_KVEC, we can just iterate the iov and add the pages
> > to the bio directly.
> 
> > +		page = virt_to_page(kv->iov_base);
> > +		size = bio_add_page(bio, page, kv->iov_len,
> > +					offset_in_page(kv->iov_base));
> 
> Who said that you *can* do virt_to_page() on those?  E.g. vmalloc()'ed
> addresses are fine for ITER_KVEC, etc.

In this particular case the caller it seems the callers knows what kind
of pages we have, but we need to properly document this at the very least.

Note that in the completely generic case iov_base could also point to
memory without a struct page at all (e.g. ioremap()ed memory).
