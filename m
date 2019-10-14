Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538ABC4CECE
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 15:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307CB2133F
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 15:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbfJNPNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:13:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47083 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1733176AbfJNPNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 11:13:19 -0400
Received: (qmail 31375 invoked by uid 500); 14 Oct 2019 11:13:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2019 11:13:18 -0400
Date:   Mon, 14 Oct 2019 11:13:18 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: Lockup on USB and block devices
In-Reply-To: <1571054381.19529.16.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1910141112031.28937-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 14 Oct 2019, Oliver Neukum wrote:

> Am Dienstag, den 01.10.2019, 14:31 -0400 schrieb Alan Stern:
> > It looks like a problem with your xHCI USB host controller.  Normally a
> > usb-storage transfer would be aborted after 90 seconds.  But if the
> > host controller (or its driver) isn't working right, and the abort
> > never completes, you end up with a situation like this -- usb-storage
> > and the higher SCSI and block layers waiting indefinitely for an event
> > that won't occur.
> 
> Hi,
> 
> that would imply that usb_unlink_urb() is malfunctioning
> without taking down the whole bus. Is that likely?

Mathias is a better person to ask than me.  But yes, as far as I know,
something like that can happen.

Alan Stern

