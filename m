Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB44C433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A0C207F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iHV+wqoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2R3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2R3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 13:29:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40798C061794
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mu6OJOdC0P3joJmalDqfOgVzBKFyyZYaXiANYfUgff8=; b=iHV+wqoHtT87JKzkyzOf0iC38/
        DxkhKsBao0zxki6IH1iBE8HiaQvSUfLCtZvHsraFhSz+D5bf69NlwbPMqGqfIceFKBhAhVNcYha6v
        c5BSc2OYwkJzVUemsqklKunJq/9L8f697IFXnVIwbAbjgfpavDtxOILxvzI9fPqa6cchh9skPESK4
        qWJvj+FTgUgs6SjTHs0cJZ1URztmrAdbkpj6eeCn/nuAv1V7WdD4xvPikY5QQuIlc6JaD4deeEg4G
        BPVyuruT6OeYQsG5/IoFW/Eu+ApHz4mhSpZblfxwafouXhS/YWmpWGlTL/wl0UWoJfzlrquFkym8j
        /xsvO8lQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0ptC-0003PI-D4; Wed, 29 Jul 2020 17:29:14 +0000
Date:   Wed, 29 Jul 2020 18:29:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200729172914.GA13002@infradead.org>
References: <20200729170952.GA21060@infradead.org>
 <fa539a99-31a0-81cc-0d7b-3952721b2b22@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa539a99-31a0-81cc-0d7b-3952721b2b22@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 11:22:18AM -0600, Jens Axboe wrote:
> On 7/29/20 11:09 AM, Christoph Hellwig wrote:
> > The following changes since commit adc99fd378398f4c58798a1c57889872967d56a6:
> > 
> >   nvme-tcp: fix possible hang waiting for icresp response (2020-07-26 17:24:27 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git nvme-5.8
> > 
> > for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:
> > 
> >   nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)
> > 
> > ----------------------------------------------------------------
> > Christoph Hellwig (1):
> >       nvme: add a Identify Namespace Identification Descriptor list quirk
> > 
> > Kai-Heng Feng (1):
> >       nvme-pci: prevent SK hynix PC400 from using Write Zeroes command
> > 
> >  drivers/nvme/host/core.c | 15 +++------------
> >  drivers/nvme/host/nvme.h |  7 +++++++
> >  drivers/nvme/host/pci.c  |  4 ++++
> >  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> There seems to be more here than what is in the pull request:
> 
>  drivers/nvme/host/core.c | 15 +++------------
>  drivers/nvme/host/nvme.h |  7 +++++++
>  drivers/nvme/host/pci.c  |  4 ++++
>  drivers/nvme/host/tcp.c  |  3 +++
>  4 files changed, 17 insertions(+), 12 deletions(-)
> 
> In particular, this one:
> 
> nvme-tcp: fix possible hang waiting for icresp response

Ooops, yes.  I send the PR with the wrong start commit, will resend.
