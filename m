Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCECC433DF
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3705D20791
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ahNlIQ1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgHNG0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgHNG0Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:26:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5405EC061757
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4JoPqPZjnvBTojdhTyAx9HOA3E3l882P503Yr2BISQk=; b=ahNlIQ1f9tkmSpGsu7R3vlOxi8
        hgS1l+4Q6O71sBUZKIQRoYKaEuqOhJU4ZTFqPJ8Ri88lw7jyLXzGNYJfNiToI3foCJJiCHln/AwoK
        RZHwfc8J5LyiWS7nDN0BZOMj+3wk2qeyJmwuBYdc5LYuHG2ShWZJHHx6oFTaV74m/yJp7dd/IcERr
        csXrm/pvn0j/ww+NKGQSPbp5hpTBBKcNVp553+gJZvsHFKpGCz3z477wmQ0ZTfIPtJXOEr9bOiqAO
        XtMyu4qfyKOgyd1WSqT/l45RXsCIRYWWqrgoihFPJMaV45GBXDP5RTS7e+YdQw28pjL9q6Sx0TUFj
        o+xeDpiw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6TAS-0006Is-51; Fri, 14 Aug 2020 06:26:20 +0000
Date:   Fri, 14 Aug 2020 07:26:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritika Srivastava <ritika.srivastava@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
Message-ID: <20200814062620.GA24167@infradead.org>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 03:47:57PM -0700, Ritika Srivastava wrote:
> Replace returning legacy errno codes with blk_status_t in
> blk_cloned_rq_check_limits().
> 
> Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
