Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C32C04AB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 15:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9A82083E
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559835114;
	bh=auxbwT7fReJRZ8phkETElOOGx98Nm3DMKGuBNzqK4tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zx8aF9wLLfzLdZzQH8qiUmaR736vFEzQCfao5Nva308nBT/G4zQJLv8N4RiFoXHS4
	 0sBll2yCrdefBIkXqnEqzpgO2EphutQO2MGGd0mAPPxmHtZkpxjjZGEwvBSgnlt+Hm
	 1LEEkikyXgzKGvZTYXQpkvcbcAOQNmthPSnqaKHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfFFPbx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbfFFPbx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jun 2019 11:31:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9A520684;
        Thu,  6 Jun 2019 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559835112;
        bh=auxbwT7fReJRZ8phkETElOOGx98Nm3DMKGuBNzqK4tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sls1Ac8ft0yHOcjrqT/Sogzn929Pqs6//tyMW7eH5G0zrT8QLdNQhIS85jv6VxDzz
         MHZqpcHha72lL1p3LiRLsHd6UO8jnT++nCFM6pgYXW18Vppu62GMNhI2WeA7tVfexV
         UEPrGRlzojOutRXk5dBStG/hmW9kjs1A9pfGreoY=
Date:   Thu, 6 Jun 2019 17:31:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
Message-ID: <20190606153150.GB28997@kroah.com>
References: <20190606143306.GA11294@kroah.com>
 <Pine.LNX.4.44L0.1906061051310.1641-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906061051310.1641-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 06, 2019 at 10:55:24AM -0400, Alan Stern wrote:
> On Thu, 6 Jun 2019, Greg Kroah-Hartman wrote:
> 
> > On Thu, Jun 06, 2019 at 10:24:18AM -0400, Alan Stern wrote:
> > > On Thu, 6 Jun 2019, David Howells wrote:
> > > 
> > > > Add a USB subsystem notification mechanism whereby notifications about
> > > > hardware events such as device connection, disconnection, reset and I/O
> > > > errors, can be reported to a monitoring process asynchronously.
> > > 
> > > USB I/O errors covers an awfully large and vague field.  Do we really
> > > want to include them?  I'm doubtful.
> > 
> > See the other patch on the linux-usb list that wanted to start adding
> > KOBJ_CHANGE notifications about USB "i/o errors".
> 
> That patch wanted to add notifications only for enumeration failures
> (assuming you're talking about the patch from Eugeniu Rosca), not I/O
> errors in general.

Yes, sorry, I was thinking that as a "I/O failed in enumeration" :)

> > So for "severe" issues, yes, we should do this, but perhaps not for all
> > of the "normal" things we see when a device is yanked out of the system
> > and the like.
> 
> Then what counts as a "severe" issue?  Anything besides enumeration 
> failure?

Not that I can think of at the moment, other than the other recently
added KOBJ_CHANGE issue.  I'm sure we have other "hard failure" issues
in the USB stack that people will want exposed over time.

thanks,

greg k-h
