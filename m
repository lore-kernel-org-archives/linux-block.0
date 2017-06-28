Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36800 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdF1SM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 14:12:59 -0400
Date: Wed, 28 Jun 2017 14:12:56 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 07/12] cgroup: export fhandle info for a cgroup
Message-ID: <20170628181256.GC24647@htj.duckdns.org>
References: <cover.1498666964.git.shli@fb.com>
 <a81d74a4e19be95207d7455ec9abb4fb0b4d1736.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a81d74a4e19be95207d7455ec9abb4fb0b4d1736.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:57AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Add an API to export cgroup fhandle info. We don't export a full 'struct
> file_handle', there are unrequired info. Sepcifically, cgroup is always
> a directory, so we don't need a 'FILEID_INO32_GEN_PARENT' type fhandle,
> we only need export the inode number and generation number just like
> what generic_fh_to_dentry does. And we can avoid the overhead of getting
> an inode too, since kernfs_node_id (ino and generation) has all the info
> required.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
