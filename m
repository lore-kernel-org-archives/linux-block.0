Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80093C3A5A8
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 06:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6183D22CF8
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 06:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfICGdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:33:55 -0400
Received: from verein.lst.de ([213.95.11.211]:55592 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfICGdz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Sep 2019 02:33:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C62D5227A8A; Tue,  3 Sep 2019 08:33:50 +0200 (CEST)
Date:   Tue, 3 Sep 2019 08:33:50 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v10 3/4] block: add a helper function to merge the
 segments
Message-ID: <20190903063350.GA16908@lst.de>
References: <1566995743-5614-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1566995743-5614-4-git-send-email-yoshihiro.shimoda.uh@renesas.com> <e549e8e7-9dfe-6f68-2148-f49a9089db37@kernel.dk> <TYAPR01MB454492ADBC8561C0BEC6F449D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB454492ADBC8561C0BEC6F449D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 04:59:59AM +0000, Yoshihiro Shimoda wrote:
> Hi Christoph,
> 
> Now this patch series got {Ack,Review}ed-by from each maintainer.
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=166501
> 
> So, would you pick this up through the dma-mapping tree as you said before?

I've applied it to the dma-mapping tree for 5.4 now, thanks a lot!
