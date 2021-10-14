Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7EDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B7B61056
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhJNFXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 01:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhJNFX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 01:23:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C67C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H55f6yk87tZalaURpqOVLVLUDba77r/24NDVtX/bfYU=; b=Sj1sVzNR9v8oA7PS6U7WPv4Nhy
        dwbv9a75fEoE1roVRVJaCEoFu62TJ9qZeWN2/cAYqh4KGa685cmlZJHjpzCRuLFNQgGnuNrnMa5sF
        NzZVmbk7D/nR0Po0l4esrh1i+yZ4BrbtWr6nDUiE/NNz1bc9DcJ/hTyNeZi6uWhmGVLwKaqMt6+MP
        U1lV3bP4IagQWvh5JCHcZTWK+zPUuDRXU+2bxvt0wgRhbjEuhFfTpcksqBRMpKrR9Anna1z+5FTO1
        rXtJn2NDGdDKEBWFQL1QQl0U0HSf105rB4acR3vAk12nFXPPY0WGt1l5SxkC3tIy/vVO061e8Hqv+
        yQPloYRA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1matAR-0083I7-94; Thu, 14 Oct 2021 05:20:50 +0000
Date:   Thu, 14 Oct 2021 06:20:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove plug based merging
Message-ID: <YWe+I6pG4zQxvGDm@infradead.org>
References: <f17bf111-d625-88a1-238c-842e11b10c55@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17bf111-d625-88a1-238c-842e11b10c55@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 12:12:39PM -0600, Jens Axboe wrote:
> It's expensive to browse the whole plug list for merge opportunities at
> the IOPS rates that modern storage can do. For sequential IO, the one-hit
> cached merge should suffice on fast drives, and for rotational storage the
> IO scheduler will do a more exhaustive lookup based merge anyway.

I don't really want to argue, but maybe some actual measurements to
support the above claims would be useful in the commit log?
