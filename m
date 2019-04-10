Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BDFC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFA420854
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 14:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfDJOWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:22:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49652 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732656AbfDJOWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 10:22:25 -0400
Received: (qmail 1860 invoked by uid 2102); 10 Apr 2019 10:22:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Apr 2019 10:22:24 -0400
Date:   Wed, 10 Apr 2019 10:22:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Seth Bollinger <Seth.Bollinger@digi.com>,
        Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Bug: VHCI + USB 3.0
In-Reply-To: <1554883329.21725.1.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1904101018330.1629-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 10 Apr 2019, Oliver Neukum wrote:

> On Di, 2019-04-09 at 15:57 -0400, Alan Stern wrote:
> > On Tue, 9 Apr 2019, Bollinger, Seth wrote:
> > 
> > > I will do that as a test.  However, I’m concerned that we’re solving only a specific case.  Won’t it fail in a similar way if a different subsystem does the same thing (USB modem or video drivers, etc.)?
> > 
> > Those other drivers don't use the block device interface, as far as I 
> > know.  So they would have to use other methods for addressing the 
> > potential problems in any case.  usb-storage is perhaps distinct in 
> > that it doesn't generate the scatter-gather lists that it uses, but 
> > instead has to work with whatever the block layer provides.
> 
> UAS, too. But I can pick up the corresponding fix.
> Are you sure about sound though?

Yes; I just did a quick check for occurrences of "blk_queue" under 
sound/.

Besides, sound drivers use the ALSA interface to userspace.  The 
devices don't show up as regular block devices.

Alan Stern

