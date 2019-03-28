Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D5C4360F
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6642173C
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g60PnXKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfC1PDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:03:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1PDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GjhD8rceEx3ODdk5n/ZUHNIZkToOOqP4wc7P/26d30M=; b=g60PnXKHnP1EsgrvUmRjdB02u
        2YuhgXuRe8RYqwrVUkW3s8/QadD5cPbefILBpRjUH/QIZbRoFaVx7oLEMKkEZzWeGf0/l2fVtNz72
        V2SOyiGw0Onut77KQ8DJC7BC1rxtazKiZOX/HCkK14iLvXSJjkW+3bUG9BAlOAvMaHwpuS8Pl9vcg
        mn/QiTaaCtnDFaYGHw8ms9PrMd8r4Gp6jT23bcXr0S0Ov33Ni3FAYC5WLihEAeO5NEieWOY7HDVYS
        xi5booSW8utkATO1RH8Bfav9dmtltlGfMlkR3HyBjdbAaICeGwaH6AXVZQeBVn95V/4wIL1Fl9kxn
        UU4RVIGmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9WYq-00035g-LF; Thu, 28 Mar 2019 15:03:20 +0000
Date:   Thu, 28 Mar 2019 08:03:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: clarify that bio_add_page() and related helpers
 can add multi pages
Message-ID: <20190328150320.GB9265@infradead.org>
References: <20190328035001.26276-1-ming.lei@redhat.com>
 <5258cad3-b324-660f-589f-73eb7fb8fa04@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5258cad3-b324-660f-589f-73eb7fb8fa04@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 28, 2019 at 08:21:55AM -0600, Jens Axboe wrote:
> This is going to create a needless conflict between 5.1 and the 5.2
> block tree. I haven't pushed the 5.2 tree out yet, plan to do so
> this week after I've pushed the current 5.1 patches. Can you respin
> this one on top of for-5.2/block when it comes out?

Can we also drop the parameter name rename and just add the comments?
