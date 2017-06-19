Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36091 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbdFSSwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 14:52:23 -0400
Date: Mon, 19 Jun 2017 14:52:06 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 01/12] kernfs: use idr instead of ida to manage inode
 number
Message-ID: <20170619185206.GF12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <6a120b12b501ca4f4821271009d4df14c9248c85.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6a120b12b501ca4f4821271009d4df14c9248c85.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 15, 2017 at 11:17:09AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> kernfs uses ida to manage inode number. The problem is we can't get
> kernfs_node from inode number with ida. Switching to use idr, next patch
> will add an API to get kernfs_node from inode number.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
