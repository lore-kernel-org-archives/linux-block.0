Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3061EC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C3208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeYdkmll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKPSzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:55:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeKPSzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VGLodjckTTnMddNX6sNXtZ78BD3DUXCjNNVQwJzaoSY=; b=OeYdkmll7Y/3VYUVkhHAdl07k
        uCf+hD1jDT56dMVYZ4oYhYtlEwBT4CPlt+9EWAfO9+z+xs6z9r8KIoEKtMs8znuLEkQFYLNm6Gjiu
        YqJ11q/128sNZy25hpTy4VtsS0+rXsOz4FOO/9at0BzyJTRouHqhYf0DjIgf+DRP8c7pLVoOf2c6C
        UgXRwA8XmkVQZqN+niQto9PUs0zyLNsUbLkXxoCadJJwQyS0El+vaiAQEG7sx8uvzh54Uqz30jBhN
        bPmD8LqnGDe+z8WYQrK+tsKcCivLnj+uTgLIkXgAtcjYspCbuBoaAg18YjCJRrAw2i8kb4+cG7cDJ
        ZWpo+EkXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZjD-00064p-KQ; Fri, 16 Nov 2018 08:43:51 +0000
Date:   Fri, 16 Nov 2018 00:43:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 07/11] blk-mq: when polling for IO, look for any
 completion
Message-ID: <20181116084351.GH9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115195135.22812-8-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:51:31PM -0700, Jens Axboe wrote:
> If we want to support async IO polling, then we have to allow
> finding completions that aren't just for the one we are
> looking for. Always pass in -1 to the mq_ops->poll() helper,
> and have that return how many events were found in this poll
> loop.

Well, if we always put -1 in we can as well remove the argument,
especially given that you change the prototype in the patch before
this one.

Still digesting the rest of this.
