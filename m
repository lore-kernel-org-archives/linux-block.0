Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34609 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdBTCVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2017 21:21:23 -0500
Received: by mail-pg0-f52.google.com with SMTP id z67so33701441pgb.1
        for <linux-block@vger.kernel.org>; Sun, 19 Feb 2017 18:20:37 -0800 (PST)
Date: Sun, 19 Feb 2017 18:19:58 -0800
From: Omar Sandoval <osandov@osandov.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@fb.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: Manual driver binding and unbinding broken for SCSI
Message-ID: <20170220021958.GA26238@vader>
References: <20170218003015.GA19776@vader.DHCP.thefacebook.com>
 <1487378636.4351.45.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487378636.4351.45.camel@HansenPartnership.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 04:43:56PM -0800, James Bottomley wrote:
> This seems to be related to a 0day test we got on the block tree,
> details here:
> 
> http://marc.info/?t=148624068800001
> 
> I root caused the above to something not being released when it should
> be, so it looks like you have the same problem.  It seems to be a
> recent commit in the block tree, so could you bisect it since you have
> a nice reproducer?

These appear to actually be two separate issues.

The unbind followed by bind crash only happens with scsi-mq. It reproes
since at least 4.0.

The unbind followed by a new device coming up crash happens both with
and without scsi-mq. The earliest version I was able to check for that
was 4.6, which did reproduce.

I'll see if I can get some more info on these two issues separately.
