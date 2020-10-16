Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090AFC433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 07:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953F52084C
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 07:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DY6ChfUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404529AbgJPHUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404508AbgJPHUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 03:20:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950DC061755;
        Fri, 16 Oct 2020 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hr64Vn0+HOozpsku169KlWnz5smy9iW/9D6WwYh/U4U=; b=DY6ChfUU+XuHd8pI3W8vg66Skt
        hpkSqI7Jb5NYjnCvzyTg/pgLU3QYTkLO8duny6oxc8mWj1GOZ3FoiBbPkNDlYgTAEBbLEHmlvNUR1
        fmTp4R5h7zAtTUZKWvSkN6jsMAaJs90n3QJ6dl02zXqLyf2XoZxm+66Cbl1Uac9Fzj/ftCmDXAjra
        /s3Pz9WFFnyYOKXXuMBxn4Ofnd3r3IltTDgR0KtHyIZVEUbCmV9ELXsHJUueQhvF7GmjVofirFjE4
        G+vHY+nP9wKmqFrdPbM5Zi6ayYn/qt017fZTBhJP5oRCvFfMEuy9FgdM8UibVypz4+IV/BdF8rVaL
        j7Wf1V4A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTK2e-0004IG-WD; Fri, 16 Oct 2020 07:20:45 +0000
Date:   Fri, 16 Oct 2020 08:20:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 1/4] block: keyslot-manager: Introduce passthrough
 keyslot manager
Message-ID: <20201016072044.GB14885@infradead.org>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015214632.41951-2-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

And this just validates my argument that calling the inline crypto work
directly from the block layer instead of just down below in blk-mq was
wrong.  We should not require any support from stacking drivers at the
keyslot manager level.
