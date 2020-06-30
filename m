Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C9C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 04:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83BC206A1
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 04:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ooDjVEPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgF3E4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgF3E4r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 00:56:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17E3C061755
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 21:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJFlH19Sx6ndb0X0LWrjHEErYs5RfqyIe4bxlJObSCM=; b=ooDjVEPi7xxmeXJrrCthdjp3FE
        T4pGvDA1XfbWTlWfiK4FqyDsXF32GGKZIQJXZxRE8/DVuHVccE6fiK9RCsuA7RaViPNGHMACWYKTQ
        vC+KTrBRuIEMyoeWmix2/m8Y9PSuu4r3d/6sMS/zSIPMBkbH0+PPgBVAufrQLU1OVIa5SVYJE1kxT
        cfp30CGyfqPTSLOMCk9fQFP1kF4DyhHg3LmLZh4Zmdhso3R74dy+qWh4ZxXYRd6Wop2KaAqazMpB4
        tlSuUdIGwLub1ZD2ryzNvPe2U1cWwB4SswI35r4XCNcddytOZOFE3zk6fs15d2iX71v8O3Z6VXJPR
        SoYy5PnA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq8K5-0004r1-R3; Tue, 30 Jun 2020 04:56:45 +0000
Date:   Tue, 30 Jun 2020 05:56:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH V6 6/6] blk-mq: support batching dispatch in case of io
 scheduler
Message-ID: <20200630045645.GB17653@infradead.org>
References: <20200624230349.1046821-1-ming.lei@redhat.com>
 <20200624230349.1046821-7-ming.lei@redhat.com>
 <20200629090452.GA4892@infradead.org>
 <20200629103239.GB1881343@T590>
 <20200630005730.GA2049266@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630005730.GA2049266@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 30, 2020 at 08:57:30AM +0800, Ming Lei wrote:
> Hi Christoph,
> 
> Follows the revised patch, and will post it as V7 if you are fine:

Looks ok.
