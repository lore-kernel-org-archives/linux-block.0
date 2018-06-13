Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934619AbeFMQov (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 12:44:51 -0400
Date: Wed, 13 Jun 2018 18:44:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [Backport request] blkdev_report_zones_ioctl(): Use vmalloc() to
 allocate large buffers
Message-ID: <20180613164428.GB19257@kroah.com>
References: <021c1029a42253c749a182a38d9709c2cd8db0df.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <021c1029a42253c749a182a38d9709c2cd8db0df.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 13, 2018 at 03:36:42PM +0000, Bart Van Assche wrote:
> Hello stable kernel maintainers,
> 
> Please backport patch 327ea4adcfa3 ("blkdev_report_zones_ioctl():
> Use vmalloc() to allocate large buffers") to at least the v4.17.x and
> v4.14.y stable kernel series. That patch fixes a bug introduced in
> kernel v4.10. The entire patch is shown below.

It's already in my queue to apply, and I normally wait until after it
shows up in a -rc release before queueing it up.

But I'll go do so now, thanks.

greg k-h
