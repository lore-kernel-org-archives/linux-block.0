Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33514 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbdFSSw0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 14:52:26 -0400
Date: Mon, 19 Jun 2017 14:52:18 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 02/12] kernfs: implement i_generation
Message-ID: <20170619185218.GG12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <5532cc7d8cac2a1c94b62b63916d1d584ece5078.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5532cc7d8cac2a1c94b62b63916d1d584ece5078.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 15, 2017 at 11:17:10AM -0700, Shaohua Li wrote:
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
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
