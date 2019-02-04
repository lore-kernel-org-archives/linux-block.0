Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A5C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226A720811
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nVG3I4W2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfBDVJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:09:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfBDVJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 16:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dtwum4NKUIH3r2dGrrFgsPP6PnEZgS22n9APxoZ/nsY=; b=nVG3I4W2IXf2ggRJQZD1+cgul
        SUDYD7ve9LmzUAX0NQ04lLnkS9yfZuhRvtR6F/hCRKX6GmGjuBh9daBbK9VmNG8ZJGCDTeciKC/3f
        RihaafayQJjU5L9sZzeaNaaVTTVdIeXdfPIX+TD53up4kygz2QGSsuRw8Qbhh769jWFrkrDlRW52J
        cnFfjEMZpviBGicT8Tf/Bin7KQ/oKX+Oht81Z5YHPNikWEkWJGE7AMLdgsFqOWuBdpglFpW2nuMiQ
        ZeYCOND75+twFIypYwLEktvpr4DJPkyH1B1rpWj9Cr9TTD8qe3OKE9KiZ4rfxD+NUO1dgYPvqRsrQ
        zTizY0AqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqlUN-0004tz-8D; Mon, 04 Feb 2019 21:09:11 +0000
Date:   Mon, 4 Feb 2019 13:09:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 03/16] block: sed-opal: unify space check in
 add_token_*
Message-ID: <20190204210911.GA18821@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-4-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190204144418.GC31132@infradead.org>
 <alpine.LRH.2.21.1902042145330.10661@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1902042145330.10661@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 04, 2019 at 10:07:09PM +0100, David Kozub wrote:
> It is eventually used for the second time in 11/16 block: sed-opal: ioctl
> for writing to shadow mbr.
> 
> If you feel strongly about this I can exclude it from this commit and
> introduce it in 11/16 (where it then will called from here and from
> write_shadow_mbr).

No problem, just keep it.
