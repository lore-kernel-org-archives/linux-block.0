Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5567CC6FA82
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiI0Qwl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0QwC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 12:52:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5405A7B7B0
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sbZo7r2JVmJsIx422n3p/ty8TYJGZKV4mXZ7Qhmy9Jc=; b=f3uNofaXWfCGe5wsLA4VAiXazq
        ESeCeTGi1voRqe4bsGrZQEXaO47yMBhyZRXTPhP/HP1RE3ZYartVxLFjJ0CvOdLzgt1TKJuJXsgJf
        ouk+ADDZ17Nbil0Pf7KjTbIQ6LNao4VUm4lL7/7/28j//FMF+GjVUuSlwS0uzsq6XrAMXWVe7viE2
        Z6ORXCqQrEbNNizZQrPEQKQ44cQ8GDqSPFETQWC8Lbz/GGAGMyBsocWW+92NgDKF1xeS7PXUDyxdq
        bO3Znj0Fe0BCgB6vs/6552xzwUKigv/6GzqV7rsmASw15lzdw470IGr+BsW7tLEDyHUtSpZHzCEWl
        hvHzf6dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odDnV-00Bqel-7R; Tue, 27 Sep 2022 16:51:05 +0000
Date:   Tue, 27 Sep 2022 09:51:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Message-ID: <YzMp+SIsv6Aw4bFW@infradead.org>
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
 <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 27, 2022 at 10:04:19AM -0600, Jens Axboe wrote:
> Ah yes, good point. We used to have this notion of 'fs' request, don't
> think we do anymore. Because it really should just be:

A fs request is a !passthrough request.

> if (zoned && (op & REQ_OP_WRITE) && fs_request)
>          return NULL;
> 
> for that condition imho. I guess we could make it:
> 
> if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
>          return NULL;

Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
REQ_OP_WRITE_ZEROES.  So this should be:

	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
		return NULL;

