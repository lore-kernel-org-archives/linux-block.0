Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbdF2Muk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 08:50:40 -0400
Date: Thu, 29 Jun 2017 14:50:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, hch@lst.de, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 03/12] kernfs: add an API to get kernfs node from
 inode number
Message-ID: <20170629125038.GB26046@kroah.com>
References: <cover.1498666964.git.shli@fb.com>
 <39b16490e3f39fb0f576a0b72d2458d164296766.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39b16490e3f39fb0f576a0b72d2458d164296766.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:53AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Add an API to get kernfs node from inode number. We will need this to
> implement exportfs operations.
> 
> This API will be used in blktrace too later, so it should be as fast as
> possible. To make the API lock free, kernfs node is freed in RCU
> context. And we depend on kernfs_node count/ino number to filter out
> stale kernfs nodes.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
