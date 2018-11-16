Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE74C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C4D206BA
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f78zHGn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C4D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeKPS7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:59:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbeKPS7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BUHZqrM9PTyvV6REfR2IzgWS2U+rzAbaf/ragCkoZjU=; b=f78zHGn+tYuUesW4EZxc4upJB
        mktec/aSRzIy8J6HLyWlvnDcFAxcBCYGbprkOJ4GV7Z8ZOrCdseyjJueuMQgT6uNctYW2Ex1GV/Tr
        Nx+RapYhNGUlu7H5psMoyhf1DWSX9gv6lbgyR8y6JM6xEOFXhDgp4GF2Xy+Q1caC/o+a1pfccKOXJ
        V68s1joynz9SXxUuZIKgSuiXeubJSisZZjQLKs24zJAQgqwdN+aHJSY/rwdxpiqp5hi9N1v+z5ExX
        EYWSRAtIP32wSlhjiVu2Z8+QG8HvcsQXy77k27BOTUFaEE9d78wRbx8bwe8VT8di4irNO82q5+Gki
        ZO/gETXLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZmu-0007dW-2P; Fri, 16 Nov 2018 08:47:40 +0000
Date:   Fri, 16 Nov 2018 00:47:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 10/11] block: for async O_DIRECT, mark us as polling if
 asked to
Message-ID: <20181116084739.GI9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-11-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115195135.22812-11-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:51:34PM -0700, Jens Axboe wrote:
> Inherit the iocb IOCB_HIPRI flag, and pass on REQ_HIPRI for
> those kinds of requests.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
