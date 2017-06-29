Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbdF2Mvo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 08:51:44 -0400
Date: Thu, 29 Jun 2017 14:51:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, hch@lst.de, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 02/12] kernfs: implement i_generation
Message-ID: <20170629125141.GG26046@kroah.com>
References: <cover.1498666964.git.shli@fb.com>
 <327539f91326b971b9071d518a32435f41013550.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <327539f91326b971b9071d518a32435f41013550.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:52AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Set i_generation for kernfs inode. This is required to implement
> exportfs operations. The generation is 32-bit, so it's possible the
> generation wraps up and we find stale files. To reduce the posssibility,
> we don't reuse inode numer immediately. When the inode number allocation
> wraps, we increase generation number. In this way generation/inode
> number consist of a 64-bit number which is unlikely duplicated. This
> does make the idr tree more sparse and waste some memory. Since idr
> manages 32-bit keys, idr uses a 6-level radix tree, each level covers 6
> bits of the key. In a 100k inode kernfs, the worst case will have around
> 300k radix tree node. Each node is 576bytes, so the tree will use about
> ~150M memory. Sounds not too bad, if this really is a problem, we should
> find better data structure.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
