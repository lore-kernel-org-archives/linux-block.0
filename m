Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42421 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdF1PDw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 11:03:52 -0400
Date: Wed, 28 Jun 2017 18:03:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org
Subject: Re: [bug report] lightnvm: pblk: sched. metadata on write thread
Message-ID: <20170628150342.wnwfbistfzbmjqpv@mwanda>
References: <20170628142645.khaab3l43vzd5fpt@mwanda>
 <41E89B64-A0CF-43C9-B5CF-B7DFAF6891F6@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <41E89B64-A0CF-43C9-B5CF-B7DFAF6891F6@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 04:46:02PM +0200, Javier Gonz�lez wrote:
> > On 28 Jun 2017, at 16.26, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > Hello Javier Gonz�lez,
> > 
> > The patch dd2a43437337: "lightnvm: pblk: sched. metadata on write
> > thread" from Jun 26, 2017, leads to the following static checker
> > warning:
> > 
> > 	drivers/lightnvm/pblk-init.c:822 pblk_lines_init()
> > 	warn: 'pblk->lines' double freed
> > 
> 
> Thanks for reporting Dan. Do you want to put a patch together fixing it?
> Or should I?

I wasn't sure which kfree() I should remove...  Can you send the patch?

regards,
dan carpenter
