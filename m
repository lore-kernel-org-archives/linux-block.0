Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdAUJFV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2017 04:05:21 -0500
Date: Sat, 21 Jan 2017 10:05:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Josef Bacik <jbacik@fb.com>
Cc: arnd@arndb.de, axboe@fb.com, nbd-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170121090531.GB27048@kroah.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-4-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484949412-6903-4-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 20, 2017 at 04:56:52PM -0500, Josef Bacik wrote:
> This patch mirrors the loop back device behavior with a few changes.  First
> there is no DEL operation as NBD doesn't get as much churn as loop devices do.
> Secondly the GET_NEXT operation can optionally create a new NBD device or not.
> Our infrastructure people want to not allow NBD to create new devices as it
> causes problems for them in containers.  However allow this to be optional as
> things like the OSS NBD client probably doesn't care and would like to just be
> given a device to use.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

A random char device with odd ioctls?  Why?  There's no other
configuration choice you could possibly use?  Where is the userspace
tool that uses this new kernel api?

You aren't passing in structures to the ioctl, so why does this HAVE to
be an ioctl?

thanks,

greg k-h
