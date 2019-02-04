Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78398C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AE7214DA
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bgV+e/f9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBDOrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:47:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfBDOrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GFe7JWKLeWD3je6/Ne9DsmqJqEcOpTZ0txE5VfFDKn0=; b=bgV+e/f92tU1Ag5iNZK6vzvoi
        x/BIOGe6+Sh1uWKyhK61nkj2ZThTaNR2sIQaTZW1EFTVcmyC73mpYv7sBDyg1uZTBSeibMjSxxmk1
        rEfTeZZyg7hDR2YvzXvSbe3NKeCCGK59JKta4QA4jxEi9SMMMwtd+OwJ79H3elKc9eJ6UCs3ZDibh
        i8AHHUYl1I7kldRiJGPIQ4aLl0sdwGIsV2AuPxNfB4DGh/bsI73DhXB++zmJv3W9IhEXYpF2cA6xV
        qZTdilp925woY+YasT1R6D/xO4r24rlQOoFKtVzNEc11dYGgppqpPz2lVtW73PVwgUyfN1Q1DvyoT
        Z2sgf3IHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfWT-0001Q6-PB; Mon, 04 Feb 2019 14:46:57 +0000
Date:   Mon, 4 Feb 2019 06:46:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 08/16] block: sed-opal: print failed function address
Message-ID: <20190204144657.GH31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-9-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-9-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:15PM +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Add function address (and if available its symbol) to the message if a
> step function fails.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
