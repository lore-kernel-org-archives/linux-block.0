Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC5C47259
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56B02075A
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NeQeB2xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEDOGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 10:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgEDOGL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:06:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FBFC061A0E;
        Mon,  4 May 2020 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O2GPx2eRjN8jkkTzlEq3ED1zoCe+YCEyTNd0Rsv99XQ=; b=NeQeB2xz9Ko+RVrNJI3U7FnsNT
        GcjGRt2AcABv+QpUGUbHjO1CZcJpfsZ32wy+bWcDeisEmuZP8gYyf5jeE/oCfr6sfU9aHUVJAs8JA
        lQ7vehdCu6OCGGxyc1xsM5bNHIaJ9l1DEpGn/8zw1uLI2aBz1KhhhVhDtBEp8NDybrJ+2IHmWYRV2
        khs6l3QkknAws4dc8djzU18r2wzD4ipFmmwcfOUk1YCs/bcvFQ1SXorNxbGo06+S/nxBpwOCDIlbN
        uKiqtjMhNoi7s1sXdEoSTyWm6KwdL+R2VGUIjpLy+qYCOoVafsj3aeDfFBfeldcESO+OktlybZ1R6
        2aCWDcxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbjX-0005nT-KC; Mon, 04 May 2020 14:06:11 +0000
Date:   Mon, 4 May 2020 07:06:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/4] block/part_stat: add helper
 blk_account_io_merge_bio()
Message-ID: <20200504140611.GD29020@infradead.org>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
 <158859906056.19958.10435750035306672420.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158859906056.19958.10435750035306672420.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 04:31:04PM +0300, Konstantin Khlebnikov wrote:
> Move non-"new_io" branch of blk_account_io_start() into separate function.
> Fix merge accounting for discards (they were counted as write merges).
> 
> Also blk_account_io_merge_bio() doesn't call update_io_ticks() unlike to
> blk_account_io_start(), there is no reason for that.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Nitpick below:

> +void blk_account_io_start(struct request *rq)
>  {
>  	struct hd_struct *part;
>  	int rw = rq_data_dir(rq);
>  
> +	if (blk_do_io_stat(rq)) {

part and rw probably should move inside this branch.
