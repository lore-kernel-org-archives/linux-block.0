Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34211 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdFSTOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 15:14:49 -0400
Date: Mon, 19 Jun 2017 15:14:46 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 11/12] blktrace: add an option to allow displying
 cgroup path
Message-ID: <20170619191446.GM12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <6943a743192fd1ceb591e60fa02e5347f0320b18.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6943a743192fd1ceb591e60fa02e5347f0320b18.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Jun 15, 2017 at 11:17:19AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> By default we output cgroup id in blktrace. This adds an option to
> display cgroup path. Since get cgroup path is a relativly heavy
> operation, we don't enable it by default.
> 
> with the option enabled, blktrace will output something like this:
> dd-1353  [007] d..2   293.015252:   8,0   /test/level  D   R 24 + 8 [dd]
> 
> Signed-off-by: Shaohua Li <shli@fb.com>
> @@ -613,6 +613,9 @@ static inline struct kernfs_node_id *cgroup_get_node_id(struct cgroup *cgrp)
>  {
>  	return &cgrp->kn->id;
>  }
> +
> +void cgroup_path_from_node_id(const struct kernfs_node_id *id,
> +					char *buf, size_t buflen);

Maybe cgroup_path_from_kernfs_id()?  We eventually can replace
cgrp->id w/ kernfs id and drop the kernfs qualifier.

Thanks.

-- 
tejun
