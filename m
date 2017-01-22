Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdAVLJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Jan 2017 06:09:38 -0500
Date: Sun, 22 Jan 2017 12:09:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Josef Bacik <jbacik@fb.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, Jens Axboe <axboe@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/4] miscdevice: add a minor number for nbd-control
Message-ID: <20170122110949.GB18638@kroah.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-2-git-send-email-jbacik@fb.com>
 <20170121090346.GA27048@kroah.com>
 <6013F363-5561-446C-B78E-66F3B0C3A298@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6013F363-5561-446C-B78E-66F3B0C3A298@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jan 21, 2017 at 01:25:32PM +0000, Josef Bacik wrote:
> 
> > On Jan 21, 2017, at 4:03 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> >> On Fri, Jan 20, 2017 at 04:56:50PM -0500, Josef Bacik wrote:
> >> NBD is moving to a loop-control esque way of managing it's device
> >> creation and deletion.  Reserver a minor number for the new device.
> >> 
> >> Signed-off-by: Josef Bacik <jbacik@fb.com>
> >> ---
> >> include/linux/miscdevice.h | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> >> index ed30d5d..7e5c140 100644
> >> --- a/include/linux/miscdevice.h
> >> +++ b/include/linux/miscdevice.h
> >> @@ -44,6 +44,7 @@
> >> #define MISC_MCELOG_MINOR    227
> >> #define HPET_MINOR        228
> >> #define FUSE_MINOR        229
> >> +#define NBD_CTRL_MINOR        230
> > 
> > Ick, really?  Why not just use a dynamic one?  What 1990's-based systems
> > are you running that you would need a static misc device number for?
> > 
> 
> Honestly I was just doing what loop did, I wasn't sure if there was
> some administration reason for needing a static minor number.  If
> nobody cares then I can just use a dynamic one.  Thanks,

Loop is very legacy, that's why it is that way, please don't duplicate
it...

thanks,

greg k-h
