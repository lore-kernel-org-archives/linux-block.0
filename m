Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0DC38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751272075E
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AwwA1p7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGGL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 02:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGGLz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 02:11:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A47C061A0F
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nRm4v5op+vAw1IpOkGTeJInmbZQcX2ew2pNCNyO11bE=; b=AwwA1p7fiBs6YkwgDk6g6ykxCn
        dF2Sl7b25rvfCLT0yJX8v+F33A+KMG9Blw7yI48wFpBP9lOKI4aFg7qQNDR0YuQz3mBxmbUwvBk1Q
        PH3sKJESk7lFgYC85VwNRavQVBcs+ExsQGk6Ti9iIsM6s3DlaSG9TL9+lsap9qiNyeQ2MnaPWe8D4
        MnqVV38JTwqdMZDQe0YGYk0giwkB2dYGExUalfZPwMRxvFQw6jPIciwc2iCY6BAFqjuxngKxTEyk1
        DPmXuGLL48BpCaBUzu5Mv/QRD6yYHJMvniA1/9RFZs6gJtjh/JSZbnWrSzRPB/jJ8b+NDxFZTNh5B
        3g2oJA3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWZlD-00028U-0K; Thu, 07 May 2020 06:11:55 +0000
Date:   Wed, 6 May 2020 23:11:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 5/5] block: rename blk_mq_alloc_rq_maps
Message-ID: <20200507061154.GD23530@infradead.org>
References: <cover.1588660550.git.zhangweiping@didiglobal.com>
 <4902af28b38221ade08940845306c57b5b8f371b.1588660550.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4902af28b38221ade08940845306c57b5b8f371b.1588660550.git.zhangweiping@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 05, 2020 at 02:46:07PM +0800, Weiping Zhang wrote:
> rename blk_mq_alloc_rq_maps to blk_mq_alloc_map_and_requests,
> this function allocs both map and request, make function name align
> with funtion.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
