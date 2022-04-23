Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7A1C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Apr 2022 16:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiDWQx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Apr 2022 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiDWQxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Apr 2022 12:53:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD322B193;
        Sat, 23 Apr 2022 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6+CLbpMx/ve0mzjYA+bQZvMpMnQ6Kjb+uZjL0u4PgmY=; b=J7r+mvK7/5smwt7EsHkWSC9t5H
        Vl1HUPvUFqEV0H1qXCMoLldJaRm513Uy75L3Z4ShfutUKIQ57Eu1HzscTMt7fRHRbHJBuUPd+du1T
        th7kfe1BbekwZdLQauiiyHJ8escRFhSJ1eidq2DJCTitvQebPsf0+DvTq7/pYgp8Ut5zunxseLixi
        K6ysV1YPhvEoZq3AnxCWvdk2t/aJXmMCjMGDXD9oTKnof+v5Cp6euOVXajgt1B3Es0lIUEBka7kcq
        tOIkAc8XgVV6Qgc5y8TBJo9c+PQIclnO12GMG1a/9rbxCDW1+eMgT0eWU2WS5FAtis6qE5cI2BM55
        VsxubOUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niIxk-004g2R-Af; Sat, 23 Apr 2022 16:50:24 +0000
Date:   Sat, 23 Apr 2022 09:50:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pankaj Malhotra <pankaj1.m@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Message-ID: <YmQuUM4A0dB3KgLt@infradead.org>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
 <YmGaGoz2+Kdqu05l@bombadil.infradead.org>
 <YmJDqceT1AiePyxj@infradead.org>
 <YmLEeUhTImWKIshO@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmLEeUhTImWKIshO@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 22, 2022 at 08:06:33AM -0700, Luis Chamberlain wrote:
> It begs the question if the same wish should apply to fstests.

xfstests generally works fine except for a handful test that explicitly
want module removal but _notrun gracefully in that case.  Unlike
blktests which just explodes.

> If we want to *not* rely on module removal then the right thing to do I
> think would be to replace module removal on these debug modules
> (scsi_debug) with an API as null_blk has which uses configfs to *add* /
> *remove* devices.

scsi_debug has runtime writable module parameters that cover just
about everything.
