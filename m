Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A82AC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430992082E
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDGubLNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfBDPET (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:04:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfBDPET (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 10:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ukXHAUHMzzqR+dHngAc8/YZVP39WH0TdFdjZtWLYbH8=; b=NDGubLNTzZIBCYniDK2bu7fuK
        vcPjBJsucOT2G+aEVtg+hvRWCRvGKgEYbI/7IrOxpwl2gDxkfVJdCvqjP8S2ZbaHOta206awGGm/D
        0lAnwg3gB7Gzt9dq9YcAVQPe2TcM7mbevoIFaP1YrDww4nF0F3kflyepdGyWQ3zHuDux2Fj2bjqb5
        6BUGHDbTF/96ZffefHuyDGSSVpBVlmCwyj+o00SIDuX9pBVDnw5c6QYjBLMnvKXN4I89S9nMYmfrP
        1LivZpIQJ9Vx7FipGjVsPu7aJiRlLta+RXC+RMk/2BYCmsCE4sOQmxN6/fvFWOWiGlpmvYwcOccL4
        ILultQV+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfnD-0006xV-TN; Mon, 04 Feb 2019 15:04:15 +0000
Date:   Mon, 4 Feb 2019 07:04:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 00/16] block: sed-opal: support shadow MBR done flag
 and write
Message-ID: <20190204150415.GO31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:07PM +0100, David Kozub wrote:
> This patch series extends SED OPAL support: it adds IOCTL for setting the shadow
> MBR done flag which can be useful for unlocking an OPAL disk on boot and it adds
> IOCTL for writing to the shadow MBR. Also included are some minor fixes and
> improvements.

Actually most of it is really useful cleanups and small fixes for the
existing OPAL code.  Any chance you could resend just those bits as
a first series ASAP?  I'll try to spend some time to to review the
actual feature additions in the meantime.

> There is a fork of sed-opal-temp that can use these new IOCTLs.[2] I tested
> these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.

Which brings up another question:  how do we get a properly maintained
version of the sed-opal tool up ASAP?  It's been a bit bitrotting
unfortunately, and the documentation and error handling hasn't been all
that great to start with.  Are we going to find a good home for it?
Util-linux for example?
