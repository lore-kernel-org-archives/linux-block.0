Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E6C43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04A0207E0
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 18:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567708391;
	bh=jVlKfCd+qY1ZMlZKQZC0N52YZ/f64nAiresv87D2w18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NJEA9nU3Moicba1Pc2d3NmntVegHjnyHvGc9bp3wTPYLqolZ14vHejPkJWkCN/+PG
	 YCNTxXwu20ILdb1sFAVhzagaw9XUFiTquGEvJX4l1ibvS3IO9Wxuvo0XM51bZw9xlp
	 U5runGyh6x8WhRCvrEST/8vc4zqoN/cWoZFLJsSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbfIESdJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbfIESdJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 14:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC4E02070C;
        Thu,  5 Sep 2019 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567708389;
        bh=jVlKfCd+qY1ZMlZKQZC0N52YZ/f64nAiresv87D2w18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhI+Y9mhigPn0bUCjMQereobGTo3zyer/TQE6Tnsf04J8cctxB0llAFNgQzshmgrQ
         M6BvzjTPQGymnf7SrY1tLgz1eu3m06iQgAPqRpt36Q6sWGGqm/kq5fFWudAhTsFYQg
         vdELB8xvMqEI9muuvwe1UlG0MhMO4T0SDSNK2A1Q=
Date:   Thu, 5 Sep 2019 20:33:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, rstrode@redhat.com,
        swhiteho@redhat.com, nicolas.dichtel@6wind.com, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Why add the general notification queue and its sources
Message-ID: <20190905183305.GA22877@kroah.com>
References: <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <17703.1567702907@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17703.1567702907@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 05, 2019 at 06:01:47PM +0100, David Howells wrote:
>  (2) USB notifications.
> 
>      GregKH was looking for a way to do USB notifications as I was looking to
>      find additional sources to implement.  I'm not sure how he wants to use
>      them, but I'll let him speak to that himself.

We are getting people asking for all sorts of "error reporting" events
that can happen in the USB subsystem that we have started to abuse the
KOBJ_CHANGE uevent notification for.  At the same time your patches were
submitted, someone else submitted yet-another-USB-error patchset.  This
type of user/kernel interface is much easier to use than abusing uevents
for USB errors and general notifications about what happened with USB
devices (more than just add/remove that uevents have).

So yes, I would like this, and I am sure the ChromeOS people would like
it too given that I rejected their patcheset with the assumption that
this could be done with the notification queue api "soon" :)

thanks,

greg k-h
