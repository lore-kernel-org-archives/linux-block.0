Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbdHaQwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 12:52:44 -0400
Date: Thu, 31 Aug 2017 18:52:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernfs: checking for IS_ERR() instead of NULL
Message-ID: <20170831165247.GA26219@kroah.com>
References: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830140456.7n6sfogqb7mvjmrm@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 30, 2017 at 05:04:56PM +0300, Dan Carpenter wrote:
> The kernfs_get_inode() returns NULL on error, it never returns error
> pointers.
> 
> Fixes: aa8188253474 ("kernfs: add exportfs operations")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Hm, I don't know what tree aa8188253474 is in, but it's not mine, so I
can't take this patch :(

thanks,

greg k-h
