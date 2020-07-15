Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70BC433E3
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 06:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6DC20663
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 06:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PikKUoj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGOGs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 02:48:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D0C061755;
        Tue, 14 Jul 2020 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Xu0wDeMJVr4Fso9VMDrFXFtdZDxizg0iRDFYzL7qxg=; b=PikKUoj5RJk+gJSIrWoefNe2LO
        MYOdcsUH5TxR9dW7uwJKsy17jAfuJ68+U0y8Qd2Boo79ZpjG7i+/mGPnPuUhHrn1X9OVT8OCn7CkE
        HGUV+gjxVRrEBumyrkMN8s8w4drtjOo1QxCdtRfY50bc9dr1Ndg4ujsY2TrzrqQWT3aNS4YOoUQ/J
        ctjMTk/gE2+9zKkomv0jMdroxC7KQu4Pu4ID3wlCIt7PB69AXfRkb4eF8hUnivTE4hFAKPa+gKwZb
        VHplUcokz24V5bF+MDO9RaOMyHyBdIqySdrMkdGCMTbA0jrrTda/wBy+NjUkFUp48yLWPhE6mj2hH
        OktsMzUw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvbDq-0001Vp-VP; Wed, 15 Jul 2020 06:48:55 +0000
Date:   Wed, 15 Jul 2020 07:48:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
Message-ID: <20200715064854.GA5409@infradead.org>
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
 <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 14, 2020 at 02:12:27PM -0600, Jens Axboe wrote:
> Just curious, any reason this isn't just using bio_alloc()?

The dasd_diag_bio doesn't seem to have anything to do with the
block layer struct bio..
