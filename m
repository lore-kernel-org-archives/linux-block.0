Return-Path: <SRS0=Wa/x=VC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43259C4649B
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183C220989
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 14:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGEOkh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:40:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46908 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725865AbfGEOkh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jul 2019 10:40:37 -0400
Received: (qmail 1961 invoked by uid 2102); 5 Jul 2019 10:40:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Jul 2019 10:40:36 -0400
Date:   Fri, 5 Jul 2019 10:40:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     David Howells <dhowells@redhat.com>, <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        <nicolas.dichtel@6wind.com>, <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        <keyrings@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] Add a general, global device notification watch list
 [ver #5]
In-Reply-To: <20190705084459.GA2579@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1907051038550.1606-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 5 Jul 2019, Greg Kroah-Hartman wrote:

> On Fri, Jul 05, 2019 at 09:04:17AM +0100, David Howells wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > Hm, good point, but there should be some way to test this to verify it
> > > works.  Maybe for the other types of events?
> > 
> > Keyrings is the simplest.  keyutils's testsuite will handle that.  I'm trying
> > to work out if I can simply make every macro in there that does a modification
> > perform a watch automatically to make sure the appropriate events happen.
> 
> That should be good enough to test the basic functionality.  After this
> gets merged I'll see if I can come up with a way to test the USB
> stuff...

You can create USB connect and disconnect events programmatically by
using dummy-hcd with gadget-zero.  Turning off the port's POWER feature
will cause a disconnect, and turning it back on will cause a connect.

Alan Stern

