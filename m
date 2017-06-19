Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32769 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbdFSTAD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 15:00:03 -0400
Date: Mon, 19 Jun 2017 15:00:00 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 04/12] kernfs: don't set dentry->d_fsdata
Message-ID: <20170619190000.GI12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <1442e3c6160a06186d7071bd594bdff81b0050b8.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442e3c6160a06186d7071bd594bdff81b0050b8.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 15, 2017 at 11:17:12AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> When working on adding exportfs operations in kernfs, I found it's hard
> to initialize dentry->d_fsdata in the exportfs operations. Looks there
> is no way to do it without race condition. Look at the kernfs code
> closely, there is no point to set dentry->d_fsdata. inode->i_private
> already points to kernfs_node, and we can get inode from a dentry. So
> this patch just delete the d_fsdata usage.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
