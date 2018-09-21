Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 21 Sep 2018 10:28:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Storage fixes for 4.19-rc5
Message-ID: <20180921082826.GA6453@kroah.com>
References: <23e4fede-4dc5-ab36-fc83-bf0509cab12b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23e4fede-4dc5-ab36-fc83-bf0509cab12b@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 20, 2018 at 03:50:53PM -0600, Jens Axboe wrote:
> Hi Greg,
> 
> Three fixes that should go into this series. This pull request
> contains:
> 
> - Fix for leaking kernel pointer in floppy ioctl (Andy Whitcroft)
> 
> - NVMe pull request from Christoph, and a single ANA log page fix
>   (Hannes)
> 
> - Regression fix for libata qd32 support, where we trigger an illegal
>   active command transition. This fixes a CD-ROM detection issue that
>   was reported, but could also trigger premature completion of the
>   internal tag (me)
> 
> 
> Please pull!
> 
> 
>   git://git.kernel.dk/linux-block.git tags/for-linus-20180920

Now pulled, thanks.

greg k-h
