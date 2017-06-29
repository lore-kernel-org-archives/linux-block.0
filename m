Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbdF2Mvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 08:51:31 -0400
Date: Thu, 29 Jun 2017 14:51:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, hch@lst.de, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 01/12] kernfs: use idr instead of ida to manage inode
 number
Message-ID: <20170629125129.GF26046@kroah.com>
References: <cover.1498666964.git.shli@fb.com>
 <5852a3cf1bfcf1900e3453775ccd5d976e300b66.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5852a3cf1bfcf1900e3453775ccd5d976e300b66.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:51AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> kernfs uses ida to manage inode number. The problem is we can't get
> kernfs_node from inode number with ida. Switching to use idr, next patch
> will add an API to get kernfs_node from inode number.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
