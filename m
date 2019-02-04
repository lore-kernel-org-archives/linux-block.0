Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E2DC282CC
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8AA2087C
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e6TdmIIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfBDPCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:02:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfBDPCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 10:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3j6QBJVMtl0IUO2zXomIQgmk2QxMhZEMyipnMVvCWT4=; b=e6TdmIIu7qkhNJnTaML1wX/+C
        ENdSskAcwH2FhVwnLmv9iWTWK6I5pGy+SI8F7/xjw89vc/v64fdvkgu8k/X1s9BWsm19/Pum7O3fM
        9HGGk9NRaoOiqXpb7iDot+smrCiNyyqUiM1ml52P4bpeoen2qbenXSOdXR3aTM89F6Ikidz72OnYY
        PlpSx/ZNZ82bM9cfIfqY/q60+qe5aOERjgJwMny9isbnlvTN6B+7/XwF8031vG+YJWO7C50MImk9v
        UD+bZqZitAuVZ86TAW+KWY3SWM2dD7GBq5Bq8+yr1b2hTwXpQgUFZGWV6XsP0DaTJgQ2UEDm0MYHa
        0s0SztfbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfkz-0006q0-Pm; Mon, 04 Feb 2019 15:01:57 +0000
Date:   Mon, 4 Feb 2019 07:01:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 16/16] block: sed-opal: rename next to execute_steps
Message-ID: <20190204150157.GN31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-17-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-17-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:23PM +0100, David Kozub wrote:
> As the function is responsible for executing the individual steps supplied
> in the steps argument, execute_steps is a more descriptive name than the
> rather generic next.
> 
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
