Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB4C2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 06:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA20C20809
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 06:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UNIoczlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbgI1GDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 02:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1GDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 02:03:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8137C0613CE
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2020 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H1jCAJMm4J8LmBRHVdZbbYlzCjgFbz5dqsdyvaDkPKY=; b=UNIoczlfB/KWNLph2sfsB+HeYn
        yQr5ThHJmagmUubfYlw5aSwJ4wVNbQbrzL0o9hgzRjU85p5fC6VNj8m2YtmHKhFXuionDHxs6FwHZ
        uWIl4a1e/syqb96cpUnx99effABKPl71VtLxgtuWMXxZrFCxHYBgyoZkymu3oqlwLt1J9HzQz1+hM
        GUWPtxSNMceEGOtD7r25C2qUwxw628r0bKUoKr1Y7Vn7JyLqXiP1xKOpVedeCjO66dcGfW3tLBNbU
        uF4L8BhZLvh0iiI5C4PORqnVBAuW9vsQTQm2RlDi9IKPajxryP2zbiv1Wg4jjPTtkw2vx2HWW2TxK
        3fCiugAg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMmG5-0002DK-Fh; Mon, 28 Sep 2020 06:03:33 +0000
Date:   Mon, 28 Sep 2020 07:03:33 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [GIT PULL] nvme updates for 5.10
Message-ID: <20200928060333.GA7431@infradead.org>
References: <20200927072343.GA381603@infradead.org>
 <CY4PR04MB3751593431168AD25F312A1CE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751593431168AD25F312A1CE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 28, 2020 at 01:53:46AM +0000, Damien Le Moal wrote:
> >  - support ZNS in nvmet passthrough mode (Chaitanya Kulkarni)
> >  - fix nvme_ns_report_zones (me)
> 
> Shouldn't this one go into 5.9-rc7 as a fix ?

It is a fix, but not a critical one given that ZNS has just shown up
and does not have any real products yet.  I'd still go for 5.9 if we
didn't have dependencies on it that are going to shop up for 5.10.

So 5.10 for now. 5.9-stable pretty soon.
