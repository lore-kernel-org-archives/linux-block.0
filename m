Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B0C06513
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8C5218A0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562174191;
	bh=wAY71ePpwrDaNFkq0PM1Dpq4LuZP2NtIHZTtqRudRyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=14PXjeCsbyj29tdeA6D2/8MIaAa69fJ/BWIYk1N54xgeNc2dW6u0tutM4dHG//zI6
	 3YTygUITnnJQVUfC8+GWc0M5BJ0o++z696tzsjITxJtDjKGyxpuVsyI6ASUS9o21ux
	 Df0m8X8ToRMMrwTrCeIG+fvMB/7LmFH7C6Y4xpYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfGCRQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCRQ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jul 2019 13:16:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2A721881;
        Wed,  3 Jul 2019 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562174185;
        bh=wAY71ePpwrDaNFkq0PM1Dpq4LuZP2NtIHZTtqRudRyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXCzjGovYsJE9GxJZUFPNADxn+l7zIN2HKBArp3F1hPAV1IK7L1Ern/YQCbbMW7mH
         li5SzyGQ3VrRvnV0s/pRv+iwUEYWuuJb6KbZ6lAhZc2mdfHSVQKi5Sz9AAoqhd4ZbB
         4GBlGioG7fpE8qE7mMpzcsyL+8lfUf4ATvsaDI0g=
Date:   Wed, 3 Jul 2019 19:16:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] Add a general, global device notification watch list
 [ver #5]
Message-ID: <20190703171623.GD24672@kroah.com>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
 <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:30PM +0100, David Howells wrote:
> Create a general, global watch list that can be used for the posting of
> device notification events, for such things as device attachment,
> detachment and errors on sources such as block devices and USB devices.
> This can be enabled with:
> 
> 	CONFIG_DEVICE_NOTIFICATIONS
> 
> To add a watch on this list, an event queue must be created and configured:
> 
>         fd = open("/dev/event_queue", O_RDWR);
>         ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);
> 
> and then a watch can be placed upon it using a system call:
> 
>         watch_devices(fd, 12, 0);
> 
> Unless the application wants to receive all events, it should employ
> appropriate filters.

What "filter"?  Who is going to use this and why a new system call for
this?  You can do this today with udev/netlink/hotplug/whatever so why
create yet-another-way?

I don't think this is a good idea unless we really nail down the api and
who is going to be using it.

thanks,

greg k-h
