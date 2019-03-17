Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A68C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 08:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CB21019
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 08:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfCQIFm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 04:05:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfCQIFm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 04:05:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1205C83F51;
        Sun, 17 Mar 2019 08:05:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B9DC1001E6D;
        Sun, 17 Mar 2019 08:05:34 +0000 (UTC)
Date:   Sun, 17 Mar 2019 16:05:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 3/6] block: check if page is mergeable in one helper
Message-ID: <20190317080526.GA11223@ming.t460p>
References: <20190309013737.27741-1-ming.lei@redhat.com>
 <20190309013737.27741-4-ming.lei@redhat.com>
 <20190311142356.GC7850@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311142356.GC7850@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 17 Mar 2019 08:05:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 03:23:56PM +0100, Christoph Hellwig wrote:
> > +static inline bool
> > +page_is_mergeable(const struct bio_vec *bv, struct page *page,
> > +		unsigned int len, unsigned int off, bool same_page)
> 
> Please follow the other function declarations in this file:
> 
> static inline bool page_is_mergeable(const struct bio_vec *bv,
> 		struct page *page, unsigned int len, unsigned int off,
> 		bool same_page)

OK.

> 
> > +	if (same_page && (vec_end_addr & PAGE_MASK) != page_addr)
> > +		return false;
> 
> No need for the inner braces here.

I think it is needed, given "!=" has higher precedence thank "&", see

	https://en.cppreference.com/w/c/language/operator_precedence

Also the line is more readable with inner braces.

Thanks,
Ming
