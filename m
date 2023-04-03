Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B76C76188
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 15:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjDCPwW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjDCPwH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 11:52:07 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900C3ABA
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 08:51:40 -0700 (PDT)
Date:   Mon, 3 Apr 2023 11:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680537095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2gJhk2EudPdDf1rhN0+Yqo19FdGtI3AE5kQt4njseU=;
        b=xvC3EoZpCjRIKJSK/hMwRQRQLoIWADFK/Lxj5KYc3TL23GHTWhquFpjxEiiIy/Ch8MjEuw
        MwwFvPIR7ofTcOYm5vwb8vNmt1FJzlw8x3sfWJD8pdQaZ9Y6G6yDyGciA0PezYCox2paBw
        EflYNGdHo2WjJQYRlkhAE5h/kg318tU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 2/2] block: Rework bio_for_each_folio_all()
Message-ID: <ZCr1/K03uGF3neCY@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-3-kent.overstreet@linux.dev>
 <ZCrtEWEYGdGN++wX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCrtEWEYGdGN++wX@infradead.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 03, 2023 at 08:13:21AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 01:44:02PM -0400, Kent Overstreet wrote:
> > +	bio_for_each_folio_all(fv, bio, iter)
> > +		iomap_finish_folio_read(fv.fv_folio, fv.fv_offset, fv.fv_len, error);
> 
> Please avoid the overly long lines.  Also if we pass all arguments
> of the folio_vec we might as ell just pass that folio_vec anyway.
> 
> > -	BUG_ON(iter->idx > bio->bi_vcnt || (iter->idx == bio->bi_vcnt && iter->done));
> > +	BUG_ON(iter->idx > bio->bi_vcnt ||
> > +	       (iter->idx == bio->bi_vcnt && iter->done));
> 
> Seems like this should be folded into the previous patch.  Also I
> generally prefer to avoid top-level || in asserts and just do multiple
> asserts, as that shows which condition triggered.

It should be folded in, but it's logically the same assert (advance
past the end of the iter) so not worth the increased code size.
