Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB1C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhKWSte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhKWStc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:49:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79220C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b0r+0jKhcZxcT7bgxwtiWbCW8kQTUJfsPXT/6hTddfQ=; b=yuK12t8w7qsueDVO16hcB/zkBt
        4o+ERfJpHDnX0mp3OZUZyeE449X/7mCIalgzVr8yM504PnZ14rYnbTpPfbVdU5e/1KRUgIKaVmx2U
        ZXEqU/0qyxDY2Aq3GNdjypQQljAi9HWC835YIcm4WiSuL1pi/dwRJZ6LCdevBPPgCYqQMRZbE3C/6
        S4LyQSzfcF+Q1+B1FEhbM9CU2sYKpSgqgctk6XgIAXiq5iAuTU7eDCrE89JtVtm+w4knFNaGMMqxQ
        2tCAP0z7/uPeoYUskfO2uAmXQ4sbYz7VZLMSlVPJ9csSRsM6ECapFdCL2KG+HY8znJvf4gTmgCkGR
        xanDQVlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpaoC-003Ed1-1C; Tue, 23 Nov 2021 18:46:24 +0000
Date:   Tue, 23 Nov 2021 10:46:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: move io_context creation into where it's
 needed
Message-ID: <YZ03AMGXFVAGoiUo@infradead.org>
References: <20211123171058.346084-1-axboe@kernel.dk>
 <20211123171058.346084-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123171058.346084-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 23, 2021 at 10:10:56AM -0700, Jens Axboe wrote:
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -286,6 +286,7 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(create_task_io_context);

No need to export this now.
