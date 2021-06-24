Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE029C48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84CE613FA
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFXMnZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhFXMnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 08:43:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA061C061574;
        Thu, 24 Jun 2021 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NN6FKb8fPaN7gGJFuuyURG3SMUtb7yV2e8j5LT6i1CA=; b=c73U/Jn9nmNnoFXgk5w0aPdcCG
        BftiYykBW+yTTr9GVDRoqPOJXM9Zi/Hp79OKPUXvlXzLhkOThVq6pJtp7aNR0J/ioGrbmfC/5SaXS
        /RA8W7h12lyJL3deQi/Lo18qODhdfGbm0Ws8fPUEQZADgrtyW7gOmUNhodxcRXhN2y+P138gYnIgZ
        DU/3J6U/m4ls2hVy+1xrW0BMF49OMtRVqzK5j/6m2VxNbRRO5sDTd/SuxD/1jIDVCcjpUcxx9b4Vp
        OXqDAM2dIS/X1IDZlueT5Q2FP6+jHHJeYoIsg5VSc9+KVqvyqhM+WoCnHhPiBBa7KVSPyCUx6J0MQ
        ue94sXuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwOeJ-00GZlL-PY; Thu, 24 Jun 2021 12:40:14 +0000
Date:   Thu, 24 Jun 2021 13:40:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     edwardh <edwardh@synology.com>
Cc:     axboe@kernel.dk, neilb@suse.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com,
        Wade Liang <wadel@synology.com>
Subject: Re: [PATCH v4] block: fix trace completion for chained bio
Message-ID: <YNR9I7zsCJ8s0Drh@infradead.org>
References: <20210624123030.27014-1-edwardh@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624123030.27014-1-edwardh@synology.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 24, 2021 at 08:30:30PM +0800, edwardh wrote:
> From: Edward Hsieh <edwardh@synology.com>
> 
> For chained bio, trace_block_bio_complete in bio_endio is currently called
> only by the parent bio once upon all chained bio completed.
> However, the sector and size for the parent bio are modified in bio_split.
> Therefore, the size and sector of the complete events might not match the
> queue events in blktrace.
> 
> The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
> completion of all bios.") wants multiple complete events to correspond
> to one queue event but missed this.
> 
> The issue can be reproduced by md/raid5 read with bio cross chunks.
> 
> To fix, move trace completion into the loop for every chained bio to call.
> 
> Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
> Reviewed-by: Wade Liang <wadel@synology.com>
> Reviewed-by: BingJing Chang <bingjingc@synology.com>
> Signed-off-by: Edward Hsieh <edwardh@synology.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
