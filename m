Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA48C07E94
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 13:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203E961008
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 13:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFDNiS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDNiS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Jun 2021 09:38:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1265B613F9;
        Fri,  4 Jun 2021 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622813780;
        bh=+PjA/ZBMXZCoThYQZw0o1YAsWQxXDE5Dv6q3hC+0snk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TB9JzMtG67vssHBSn+DG7i/OA8BADd0qP7/eCYGICJ268ccd+rIzPeNwW2MyhshzJ
         PC7g6r3DxtVktxAZw/XxNGJYQe9OQ9PaOeWQVwTKg7MZxju3r4AfwSmdweHStxY2Yc
         /R8EqYubb4nYEiOzOjUBMcSy8MdmukEXULhIGpQo=
Date:   Fri, 4 Jun 2021 15:36:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] remove the raw driver
Message-ID: <YLosUTCR+XX+xJF9@kroah.com>
References: <20210531072526.97052-1-hch@lst.de>
 <YLSSgyznnaUPmRaT@kroah.com>
 <CAK8P3a0sctUYZnRBxS+PLted8_O1mT8JisLqO4jMHQaU=Q5iNw@mail.gmail.com>
 <3665636f-6a74-e24f-e4b7-ff7790ebb3e4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3665636f-6a74-e24f-e4b7-ff7790ebb3e4@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 31, 2021 at 10:24:33AM +0200, Hannes Reinecke wrote:
> On 5/31/21 10:21 AM, Arnd Bergmann wrote:
> > On Mon, May 31, 2021 at 9:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Mon, May 31, 2021 at 10:25:26AM +0300, Christoph Hellwig wrote:
> > > > The raw driver used to provide direct unbuffered access to block devices
> > > > before O_DIRECT was invented.  It has been obsolete for more than a
> > > > decade.
> > > 
> > > What?  Really?  We can finally do this?  Yes!
> > > 
> > > For some reason, I thought there was some IBM userspace tools that
> > > relied on this device, if not, then great!
> > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Link: https://lore.kernel.org/lkml/Pine.LNX.4.64.0703180754060.6605@CPE00045a9c397f-CM001225dbafb6/
> > 
> > The discussion from 2007 is the last one I could find on lore that has
> > useful information on when and why this was not removed in the past.
> > The driver was scheduled from a 2005 removal in 2004, but not removed
> > because both Red Hat and SuSE relied on the feature in their distros.
> > 
> >  From what I could find out, this continued to be the case in Red Hat
> > Enterprise Linux 6 and SUSE Linux Enterprise server 11 that were
> > supported between 2009 and 2020, but the following versions dropped
> > the support.
> > 
> Which I can confirm for SUSE.

Thanks, I've queued this up now.

greg k-h
