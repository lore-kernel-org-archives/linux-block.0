Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40169 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbcITMNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2016 08:13:24 -0400
Date: Tue, 20 Sep 2016 14:13:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Wenwei Tao <ww.tao0320@gmail.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>, stable@vger.kernel.org
Subject: Re: [4.4-stable] lightnvm: put bio before return
Message-ID: <20160920121330.GA28357@kroah.com>
References: <1474373138.31504.13.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474373138.31504.13.camel@codethink.co.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 20, 2016 at 01:05:38PM +0100, Ben Hutchings wrote:
> Please cherry-pick:
> 
> commit 16c6d048d7b74249a4387700887e8adb13028866
> Author: Wenwei Tao <ww.tao0320@gmail.com>
> Date:   Thu Feb 4 15:13:23 2016 +0100
> 
>     lightnvm: put bio before return
> 
> for 4.4-stable only.  (It is included in 4.5 and no earlier stable
> branch has lightnvm.)  This is a follow-up to commit 3bfbc6adbc50
> "lightnvm: add check after mempool allocation" which you already
> cherry-picked in 4.4.21.

Now applied, thanks.

greg k-h
