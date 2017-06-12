Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33705 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdFLSoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2017 14:44:10 -0400
Date: Mon, 12 Jun 2017 14:44:07 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 06/11] cgroup: export fhandle info for a cgroup
Message-ID: <20170612184407.GK19206@htj.duckdns.org>
References: <cover.1496432591.git.shli@fb.com>
 <38a747029c2a04d7e49dd7518f3caf2ac8ec24b5.1496432591.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38a747029c2a04d7e49dd7518f3caf2ac8ec24b5.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 02, 2017 at 02:53:59PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Add an API to export cgroup fhandle info. We don't export a full 'struct
> file_handle', there are unrequired info. Sepcifically, cgroup is always
> a directory, so we don't need a 'FILEID_INO32_GEN_PARENT' type fhandle,
> we only need export the inode number and generation number just like
> what generic_fh_to_parent does. And we can avoid the overhead of getting
> an inode too, since kernfs_node has all the info required.

Can't we just make it an integral (optional) part of kernfs?  So that
cgroup just needs to indicate that it wants to expose fhandles when
creating its kernfs instance?

Thanks.

-- 
tejun
