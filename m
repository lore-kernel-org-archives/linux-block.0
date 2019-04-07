Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10926C10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 07:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C503320B1F
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 07:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="loulSaEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfDGH4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 03:56:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfDGH4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 03:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZyAoGdJIcm7sg0eSG8FWsirQc/HAc+bIGnFR6kTCjc8=; b=loulSaEyqxWcZvg/j609ISiWq
        KL4N/O/gEWWo/LW3IKfRLXNjLnk3xWr0BQP1FwhkbA18YnczBs0EM2g79CsQg01r40JO2X4XTdEEE
        wH+nqABs6Zi2OIxSA0xdF/Zv14LIIIKZGLUZ+iU2BHQ6OSb4h6LL+rE1q5KX4IkfcuxG5qMhoDyM2
        xYrr0zj/3wfOOcvlo950gIWBirNc7h6WQvdUjpigF5ECD/oH2ewdqeewc1xp+9s25xxBgVATQVEBl
        P4lLck5htjdo/xvEfvTV5QaWEqUcIkNDmz4fJlbO13VbNiSL3MgtglpAp2UzsQEAEJpcWTzsnEF/l
        kA7uM/vBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hD2fb-0007OO-Su; Sun, 07 Apr 2019 07:56:51 +0000
Date:   Sun, 7 Apr 2019 00:56:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alex Lyakas <alex@zadara.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
Message-ID: <20190407075651.GA23397@infradead.org>
References: <1554555800-14392-1-git-send-email-alex@zadara.com>
 <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 06, 2019 at 12:58:54PM -0600, Jens Axboe wrote:
> On 4/6/19 7:03 AM, Alex Lyakas wrote:
> > Commit dac56212e8127dbc0bff7be35c508bc280213309 titled
> > "bio: skip atomic inc/dec of ->bi_cnt for most use cases"
> > made __bi_cnt dependent on the new BIO_REFFED flag.
> > 
> > bio_reset() does not reset __bi_cnt, but it does reset the BIO_REFFED flag.
> > But __bi_cnt depends now on the BIO_REFFED flag, so bio_reset()
> > needs to preserve this flag.
> 
> Looks good to me, applied, thanks.

Uh-oh.  While this fix isn't wrong per se I think it is confusing and
set a dnagerous precedence.

We have BIO_RESET_BITS to indicate which flags survive.  So any flag
that is supposed to survive the reset should be be added to that
instead of specifically worked around.
