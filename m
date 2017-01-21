Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdAUJEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2017 04:04:00 -0500
Date: Sat, 21 Jan 2017 10:03:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Josef Bacik <jbacik@fb.com>
Cc: arnd@arndb.de, axboe@fb.com, nbd-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/4] miscdevice: add a minor number for nbd-control
Message-ID: <20170121090346.GA27048@kroah.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
 <1484949412-6903-2-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484949412-6903-2-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 20, 2017 at 04:56:50PM -0500, Josef Bacik wrote:
> NBD is moving to a loop-control esque way of managing it's device
> creation and deletion.  Reserver a minor number for the new device.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  include/linux/miscdevice.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index ed30d5d..7e5c140 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -44,6 +44,7 @@
>  #define MISC_MCELOG_MINOR	227
>  #define HPET_MINOR		228
>  #define FUSE_MINOR		229
> +#define NBD_CTRL_MINOR		230

Ick, really?  Why not just use a dynamic one?  What 1990's-based systems
are you running that you would need a static misc device number for?

thanks,

greg k-h
