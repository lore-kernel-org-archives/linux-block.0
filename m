Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:32957 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbdFSTBS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 15:01:18 -0400
Date: Mon, 19 Jun 2017 15:01:15 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 05/12] kernfs: introduce kernfs_node_id
Message-ID: <20170619190115.GJ12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <e64e8b71ea7665cd0ba84c0136d75d8780f9e0db.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e64e8b71ea7665cd0ba84c0136d75d8780f9e0db.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Jun 15, 2017 at 11:17:13AM -0700, Shaohua Li wrote:
> +/* represent a kernfs node */
> +struct kernfs_node_id {
> +	u32			ino;
> +	u32			generation;
> +} __attribute__((packed));

Can we just make it a u64?  kernfs cares about the details but for
everyone else it can just be a unique 64bit id.

Thanks.

-- 
tejun
