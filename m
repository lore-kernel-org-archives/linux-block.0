Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8BBC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF15223D57
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 08:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbgLJITB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 03:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbgLJITB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 03:19:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEFC0613CF;
        Thu, 10 Dec 2020 00:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vls8peTcu4VR9er5d5Be2NTNZjHuOofPbhF7Ss1JGy8=; b=E+qG0G0LsI12x9jKG3NkLtqcf0
        us9gZbEzweAGbelaDsPsXRZBaikQCGjzsjB2IyKYgHBFnv5f0tkAcBYGcpwLwreWua4Do3yklmeHe
        8i8vwaz05f9sPGcNbhqf/rJqlKu9PW61RlevKLuNgfJS3XhMcFJp9PSRVij0LwcyMo7tpeBt7jmep
        FcaBjk+xhos7ALnA1Jc5yoGtcdhUUEtz+HUTKTpk67rVMS/brBUsz4dkycFCi3HmyPMdwgquhhc8A
        wiH+GX/3R/cqAM3Vp1dquWZ6WWrpHegzvMfcAlHW4owpo78izoW8xdI7mfNkQjsByaQtSWVQYiNcu
        aEfaVbug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knH9K-0003qD-2w; Thu, 10 Dec 2020 08:18:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 426013011E6;
        Thu, 10 Dec 2020 09:18:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93B712BD0331F; Thu, 10 Dec 2020 09:18:02 +0100 (CET)
Date:   Thu, 10 Dec 2020 09:18:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: Re: [PATCH] block: blk-iocost: fix build for ARCH with missing
 local64.h files
Message-ID: <20201210081802.GS3040@hirez.programming.kicks-ass.net>
References: <20201209204657.6676-1-rdunlap@infradead.org>
 <20201210060742.GA19263@infradead.org>
 <04828b4e-8791-6f3e-8984-9de06f40c85a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04828b4e-8791-6f3e-8984-9de06f40c85a@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 09, 2020 at 10:16:20PM -0800, Randy Dunlap wrote:
> On 12/9/20 10:07 PM, Christoph Hellwig wrote:
> > On Wed, Dec 09, 2020 at 12:46:57PM -0800, Randy Dunlap wrote:
> >> When building block/blk-iocost.c on arch/x6x/ or arch/nios2/, the
> >> build fails due to missing the <asm/local64.h> file.
> > 
> > Please mark it mandatory-y if the asm-generic version is suitable
> > for everyone and random pieces of kernel code are supposed to include
> > it.
> 
> include/asm-generic/local64.h has comments about some $arch could do
> its things better/faster instead of using asm-generic, but no $arch has
> done that since 2010 when it was added.

Yeah, it's only 32bit archs, and of those I'm only sure i386 could do it
better, very maybe arm-v7. But nobody cares enough to make it happen.

All the 64bit archs are already good, because local_t is long and
local64_t defaults to local_t.


