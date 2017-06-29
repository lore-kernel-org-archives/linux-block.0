Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752904AbdF2MvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 08:51:15 -0400
Date: Thu, 29 Jun 2017 14:50:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, hch@lst.de, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 06/12] kernfs: add exportfs operations
Message-ID: <20170629125058.GC26046@kroah.com>
References: <cover.1498666964.git.shli@fb.com>
 <794fb2699d1b3cb85ff7746da20cb9890d42adea.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <794fb2699d1b3cb85ff7746da20cb9890d42adea.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:56AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Now we have the facilities to implement exportfs operations. The idea is
> cgroup can export the fhandle info to userspace, then userspace uses
> fhandle to find the cgroup name. Another example is userspace can get
> fhandle for a cgroup and BPF uses the fhandle to filter info for the
> cgroup.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
