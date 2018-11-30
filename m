Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CBC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69772080A
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69772080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLAIfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:35:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52808 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAIfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 03:35:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gSqHX-0003a6-AU; Fri, 30 Nov 2018 21:25:03 +0000
Date:   Fri, 30 Nov 2018 21:25:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec pages
 to bio
Message-ID: <20181130212503.GS2217@ZenIV.linux.org.uk>
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-25-axboe@kernel.dk>
 <20181130192102.GP2217@ZenIV.linux.org.uk>
 <6e42d763-9c94-6b84-7099-f5ef5964404c@kernel.dk>
 <1545b364-df01-51e7-1786-56dde7c49b5d@kernel.dk>
 <20181130211117.GQ2217@ZenIV.linux.org.uk>
 <07803d69-84cc-bb39-686f-2f50874ea184@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07803d69-84cc-bb39-686f-2f50874ea184@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 02:16:38PM -0700, Jens Axboe wrote:
> >> Would this make you happy:
> >>
> >> if (!is_vmalloc_addr(kv->iov_base))
> >>         page = virt_to_page(kv->iov_base);
> >> else
> >>         page = vmalloc_to_page(kv->iov_base);
> > 
> > Free advice: don't ever let Linus see anything along those lines.  Results
> > tend to be colourful...
> 
> We already have those lines in the kernel, XFS for instance. Al, could you
> please try to be helpful instead of being deliberately obtuse?

Again, the last time something like that had been suggested, Linus had replied
with a very impressive rant.  I *did* propose pretty much that, and reaction
was basically "hell no, not in general-purpose primitives".  Precisely about
iov_iter stuff.  A part of that was due to touching page refcounts, but quite
a bit wasn't.
