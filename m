Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55448C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FAC21881
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 17:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfICRRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:17:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33028 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730199AbfICRRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 13:17:08 -0400
Received: (qmail 5101 invoked by uid 2102); 3 Sep 2019 13:17:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Sep 2019 13:17:07 -0400
Date:   Tue, 3 Sep 2019 13:17:07 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     David Howells <dhowells@redhat.com>
cc:     Guenter Roeck <linux@roeck-us.net>, <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <nicolas.dichtel@6wind.com>, <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        <keyrings@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
In-Reply-To: <Pine.LNX.4.44L0.1909031303500.1859-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.44L0.1909031316130.1859-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 3 Sep 2019, Alan Stern wrote:

> On Tue, 3 Sep 2019, David Howells wrote:
> 
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > > > > This added call to usbdev_remove() results in a crash when running
> > > > > the qemu "tosa" emulation. Removing the call fixes the problem.
> > > > 
> > > > Yeah - I'm going to drop the bus notification messages for now.
> > > > 
> > > It is not the bus notification itself causing problems. It is the
> > > call to usbdev_remove().
> > 
> > Unfortunately, I don't know how to fix it and don't have much time to
> > investigate it right now - and it's something that can be added back later.
> 
> The cause of your problem is quite simple:
> 
>  static int usbdev_notify(struct notifier_block *self,
>  			       unsigned long action, void *dev)
>  {
>  	switch (action) {
>  	case USB_DEVICE_ADD:
> +		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_ADD, 0);
>  		break;
>  	case USB_DEVICE_REMOVE:
> +		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_REMOVE, 0);
> +		usbdev_remove(dev);
> +		break;
> +	case USB_BUS_ADD:
> +		post_usb_bus_notification(dev, NOTIFY_USB_BUS_ADD, 0);
> +		break;
> +	case USB_BUS_REMOVE:
> +		post_usb_bus_notification(dev, NOTIFY_USB_BUS_REMOVE, 0);
>  		usbdev_remove(dev);
>  		break;
>  	}
> 
> The original code had usbdev_remove(dev) under the USB_DEVICE_REMOVE
> case.  The patch mistakenly moves it, putting it under the
------------------------------^^^^^

Sorry, I should have said "duplicates" it.

Alan Stern

> USB_BUS_REMOVE case.
> 
> If the usbdev_remove() call were left where it was originally, the 
> problem would be solved.
> 
> Alan Stern

