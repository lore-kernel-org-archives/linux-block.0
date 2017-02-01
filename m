Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35435 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdBAIbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2017 03:31:45 -0500
Received: by mail-pg0-f54.google.com with SMTP id 194so107465302pgd.2
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2017 00:31:45 -0800 (PST)
Date: Wed, 1 Feb 2017 00:31:15 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/6] block: fix blk-mq debugfs vs. blktrace
Message-ID: <20170201083115.GA16278@vader>
References: <cover.1485902856.git.osandov@fb.com>
 <20170201081608.GB18278@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201081608.GB18278@kroah.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 01, 2017 at 09:16:08AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 31, 2017 at 02:53:16PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > When I moved the blk-mq debugging information to debugfs, I didn't
> > realize that blktrace also created directories in debugfs that
> > conflicted with the blk-mq directories. This series fixes that.
> > 
> > Patch 1 adds a new debugfs helper needed for patch 6. Greg, could I get
> > an ack on that if it makes sense? Jens and I went back and forth on this
> > for a little while, but patch 6 has more of the rationale on why we
> > decided that this approach was the cleanest.
> 
> I can't find patch 6, you only cc:ed me on the first patch :(
> 
> Care to bounce them all to me?
> 
> thanks,
> 
> greg k-h

Gah, I forgot --cc-cover to git-send-email. The series is all here:
http://marc.info/?l=linux-block&r=1&b=201701&w=2. I can also send the
patches directly to you if you prefer that.
