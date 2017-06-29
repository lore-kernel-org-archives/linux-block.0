Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbdF2MvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 08:51:16 -0400
Date: Thu, 29 Jun 2017 14:51:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, hch@lst.de, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 04/12] kernfs: don't set dentry->d_fsdata
Message-ID: <20170629125104.GD26046@kroah.com>
References: <cover.1498666964.git.shli@fb.com>
 <e85bcd9d41636fa2a14dee94db212c3e17e70612.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e85bcd9d41636fa2a14dee94db212c3e17e70612.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:54AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> When working on adding exportfs operations in kernfs, I found it's hard
> to initialize dentry->d_fsdata in the exportfs operations. Looks there
> is no way to do it without race condition. Look at the kernfs code
> closely, there is no point to set dentry->d_fsdata. inode->i_private
> already points to kernfs_node, and we can get inode from a dentry. So
> this patch just delete the d_fsdata usage.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
