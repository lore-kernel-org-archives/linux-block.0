Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36005 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdF1SHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 14:07:07 -0400
Date: Wed, 28 Jun 2017 14:07:04 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 03/12] kernfs: add an API to get kernfs node from
 inode number
Message-ID: <20170628180704.GA24647@htj.duckdns.org>
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

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
