Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbdBAIQE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2017 03:16:04 -0500
Date: Wed, 1 Feb 2017 09:16:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/6] block: fix blk-mq debugfs vs. blktrace
Message-ID: <20170201081608.GB18278@kroah.com>
References: <cover.1485902856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 31, 2017 at 02:53:16PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When I moved the blk-mq debugging information to debugfs, I didn't
> realize that blktrace also created directories in debugfs that
> conflicted with the blk-mq directories. This series fixes that.
> 
> Patch 1 adds a new debugfs helper needed for patch 6. Greg, could I get
> an ack on that if it makes sense? Jens and I went back and forth on this
> for a little while, but patch 6 has more of the rationale on why we
> decided that this approach was the cleanest.

I can't find patch 6, you only cc:ed me on the first patch :(

Care to bounce them all to me?

thanks,

greg k-h
