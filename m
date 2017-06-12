Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35375 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbdFLStH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2017 14:49:07 -0400
Date: Mon, 12 Jun 2017 14:49:04 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 08/11] block: always attach cgroup info into bio
Message-ID: <20170612184904.GL19206@htj.duckdns.org>
References: <cover.1496432591.git.shli@fb.com>
 <f998a0a4d1117f7438dea22c565aeb799d112d31.1496432591.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f998a0a4d1117f7438dea22c565aeb799d112d31.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 02, 2017 at 02:54:01PM -0700, Shaohua Li wrote:
> @@ -691,6 +691,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
>  	rcu_read_lock();
>  	blkcg = bio_blkcg(bio);
>  
> +	bio_associate_blkcg(bio, &blkcg->css);
> +

Let's please note that this only established the fallback mapping when
the bio hasn't been associated yet and doesn't override the existing
association.

Thanks.

-- 
tejun
