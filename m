Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C7C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0123D21927
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+bjWLUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgJHO4S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbgJHO4S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 10:56:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9CC061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mvs3fADzgkCcGR26Zeo/XCY+wu47PGGXRXwKmEJQoaM=; b=p+bjWLUugdwcPB0UxP8LJpA6UB
        ZWJ4DimINecNmcZ9dNcTnV7eYNykXL631aX6jg5iAysQvDdPfcS8coVKYY4GVanX5hYRZ5YksFXdN
        UCTm/dA6+cbzs3I55NbWTR1/r/8Msrbd4+agisBVFtXAbgW7flMDw5PX/IjK7FbTAUahmSGDiCWmU
        UbPvGRdv4FNEG4wj06NXVXXrAS7NkGXwyy+kGOdmBmgfZwKcDV8HELz5uxEwHZgUA6rlb5DYmXG9B
        vkvPOm9YPND4XUzugkQXXgmlC5gmgkM5m0b76MEpzYc+SZgzo6mbkdi27fiJvSNjbw8l4/9rqKrtO
        BDPDMlKw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQXL4-0006BF-Ua; Thu, 08 Oct 2020 14:56:14 +0000
Date:   Thu, 8 Oct 2020 15:56:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme updates for 5.10
Message-ID: <20201008145614.GA23622@infradead.org>
References: <20201008141041.GA1493538@infradead.org>
 <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 08, 2020 at 08:52:50AM -0600, Jens Axboe wrote:
> On 10/8/20 8:10 AM, Christoph Hellwig wrote:
> > The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
> > 
> >   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08
> > 
> > for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:
> > 
> >   nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)
> > 
> > ----------------------------------------------------------------
> > nvme update for 5.8:
> > 
> >  - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
> >  - misc cleanups (Chaitanya Kulkarni)
> >  - major refactoring of the scanning code (me)
> 
> Seems to be a typo here, 5.8?

should be 5.10 of course.

Do you want a resend as this is also in the tag?
