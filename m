Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbdF2MvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 08:51:16 -0400
Date: Thu, 29 Jun 2017 14:51:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, hch@lst.de, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 05/12] kernfs: introduce kernfs_node_id
Message-ID: <20170629125114.GE26046@kroah.com>
References: <cover.1498666964.git.shli@fb.com>
 <094edc476ec5e726e5834f14e479036e0e478e37.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <094edc476ec5e726e5834f14e479036e0e478e37.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:55AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> inode number and generation can identify a kernfs node. We are going to
> export the identification by exportfs operations, so put ino and
> generation into a separate structure. It's convenient when later patches
> use the identification.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
