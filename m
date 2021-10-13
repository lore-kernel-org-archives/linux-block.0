Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F20C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CAC610FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhJMJMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbhJMJMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:12:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF86C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jhDHaTzSK9KQOEMInSsXneLpEtrDxAhCmbDe22iRirg=; b=ilZqHN670JySAZmSriiA+vwbSL
        lmzAZ9M8xYEEbFghBmWhdXn0tdA4LpDzEtVh+dZrPRiyUlOZu7DRoRKDMZnnNLseKeyKh1c5fONzC
        3oWYkqZGJAaSVB1YPt70LLLjcLsKnvyHNfXXllrn1usgmS9IKvAp+8/5u+tuxZVkCColMPv/pfTE6
        S5/L9qN0Tys/ZAsj+fh/rLS37re/mt72k9ro/db3QY34Mtht+mG8dBLcQsZOeNxWNKcOaF7R++Q1/
        RHMd0HdIdAPS7YN3gcWR//HY+EHwFBOufcyFgVLgYpgAUOCJJxNPY/+fFDyWC5b3yleyMnkbyDoUE
        7eTjIkzA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maaFy-007HmI-Nl; Wed, 13 Oct 2021 09:09:23 +0000
Date:   Wed, 13 Oct 2021 10:09:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: Re: kernel NULL pointer triggered with blktests block/025 on latest
 linux-block/for-next
Message-ID: <YWaiLsQkwe9aq8pE@infradead.org>
References: <CAHj4cs8poXTLdC+j6u7zypLKR7RpAaG-vxK4dWDz6bCMfPOjsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8poXTLdC+j6u7zypLKR7RpAaG-vxK4dWDz6bCMfPOjsQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 04:50:13PM +0800, Yi Zhang wrote:
> Hello
> The below NULL pointer issue was triggered on the latest
> linux-block/for-next with blktests, is it one known issue?

Please try this patchset:

https://lore.kernel.org/linux-block/20210929071241.934472-1-hch@lst.de/T/#m6591be7882bf30f3538a8baafbac1712f0763ebb
