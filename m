Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3C4C433E5
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 11:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3039D22B4E
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 11:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eGLeUV9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGTLIm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGTLIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 07:08:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD4C061794
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+1VKiIB05OSw8wxWIRmyLFmYP2GWy1n4g8zJvXo4pr4=; b=eGLeUV9pVFpUJUTE+IamCe8hzD
        QS/XDaXHa9gjoG2SjvLzk3y6DpcUVgXwHDjqlpdRnBhwdOe13ipRv8MI1v3nYGbrxB0YHe2bSXles
        YfSRyGLJJZoPZs4MlwZ7xv+VyBEH4v/ObRoTMaBZK8Nb+qTbIFgSuDOcTPZU3nOdSAOdRR15qHi9F
        4yc/gvcfTZaN8YsNZp3aaHpkIXlD+1OliqiD+dxFiaLTOcS+FRTVFLEOcTnVstNeqehL/4fsrkeY7
        QBbMmQCw/EMNckhVe5lpSQkDPh9BoHibP2BYDdrgtCITejmlt5vdl2V25i/0E+RaiFeqp4DR+/7Nj
        ojF4BoeQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxTep-0007Z1-9I; Mon, 20 Jul 2020 11:08:31 +0000
Date:   Mon, 20 Jul 2020 12:08:31 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Message-ID: <20200720110831.GA28284@infradead.org>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
 <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717091124.GC670561@T590>
 <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717100232.GD670561@T590>
 <CY4PR04MB3751B7720950B99A50CEF485E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751B7720950B99A50CEF485E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 17, 2020 at 10:55:49AM +0000, Damien Le Moal wrote:
> > 
> > 2) add one new limit for write on seq zone, such as: zone_write_block_size
> > 
> > Then the two cases can be dealt with in same way, and physical block
> > size is usually a hint as Christoph mentioned, looks a bit weird to use
> > it in this way, or at least the story should be documented.
> 
> Yeah, but zone_write_block_size would end up always being equal to the physical
> block size for SMR. For ZNS and nullblk, logical block size == physical block
> size, always, so it would not be useful. I do not think such change is necessary.

I think we should add a write_block_size (or write_granularity) field.
There have been some early stage NVMe proposal to add that even for
conventional random/write namespaces.
