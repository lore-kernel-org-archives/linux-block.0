Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60977C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 14:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C22214D8
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V+/CUF8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfB1ONU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:13:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfB1ONU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 09:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o+5OVL9LQ8ni7RXxItlbA5vVHahyNN2zOIrSJB0GmmY=; b=V+/CUF8ios5SVgvXXeBHKTZtm
        Gp2hc9ZPmvC9Q1KSO7J+YyqvChmF2A0526C3IlClm6UVgOhz9zbgKA7/X4nGKku1BLfu9txJbuPDE
        4brsPmfZqfmAnBR9Sk+LBHSJ+kU5++3Z4MByCTx0e9gf6e2HgcM9p1f33uELvMIPmGcJU4x31rBxs
        fTqVEyU+Y1Y7h3i0sS4UAgXOfD3maAXYq2T82H36aJoayAjwSXTk0vYVcetWudkWEw76HvFmPVRnH
        1oMlmjZ7j65Rv6lDknyzvfCBz+u008QP1kkVfSm0YSBAfqNguF+HbFlXlA3Z3EoVG9rWo0ZFJDcFN
        DLpHXUyIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzMR5-0004l0-DP; Thu, 28 Feb 2019 14:13:19 +0000
Date:   Thu, 28 Feb 2019 06:13:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: introduce mp_bvec_for_each_page() for
 iterating over page
Message-ID: <20190228141319.GA18069@infradead.org>
References: <20190227124013.4828-1-ming.lei@redhat.com>
 <20190227124013.4828-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227124013.4828-5-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 27, 2019 at 08:40:13PM +0800, Ming Lei wrote:
> mp_bvec_for_each_segment() is a bit big for the iteration, so introduce
> a light-weight helper for iterating over pages, then 32bytes stack
> space can be saved.

The version in Jens' tree seems to add this helper, but no actual
users..
