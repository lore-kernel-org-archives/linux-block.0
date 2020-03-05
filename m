Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E454C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC432146E
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEOFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgCEOFU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 09:05:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F14206D5;
        Thu,  5 Mar 2020 14:05:19 +0000 (UTC)
Date:   Thu, 5 Mar 2020 09:05:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blktrace: fix dereference after null check
Message-ID: <20200305090518.728d8cc5@gandalf.local.home>
In-Reply-To: <20200304105818.11781-1-cengiz@kernel.wtf>
References: <20200304105818.11781-1-cengiz@kernel.wtf>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed,  4 Mar 2020 13:58:19 +0300
Cengiz Can <cengiz@kernel.wtf> wrote:

> There was a recent change in blktrace.c that added a RCU protection to
> `q->blk_trace` in order to fix a use-after-free issue during access.
> 
> However the change missed an edge case that can lead to dereferencing of
> `bt` pointer even when it's NULL:
> 
> Coverity static analyzer marked this as a FORWARD_NULL issue with CID
> 1460458.
> 
> ```
> /kernel/trace/blktrace.c: 1904 in sysfs_blk_trace_attr_store()
> 1898            ret = 0;
> 1899            if (bt == NULL)
> 1900                    ret = blk_trace_setup_queue(q, bdev);
> 1901
> 1902            if (ret == 0) {
> 1903                    if (attr == &dev_attr_act_mask)
> >>>     CID 1460458:  Null pointer dereferences  (FORWARD_NULL)
> >>>     Dereferencing null pointer "bt".  
> 1904                            bt->act_mask = value;
> 1905                    else if (attr == &dev_attr_pid)
> 1906                            bt->pid = value;
> 1907                    else if (attr == &dev_attr_start_lba)
> 1908                            bt->start_lba = value;
> 1909                    else if (attr == &dev_attr_end_lba)
> ```
> 
> Added a reassignment with RCU annotation to fix the issue.
> 
> Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>


Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
> 
>     Patch Changelog
>     * v2: Added RCU annotation to assignment
> 
>  kernel/trace/blktrace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 4560878f0bac..ca39dc3230cb 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1896,8 +1896,11 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>  	}
> 
>  	ret = 0;
> -	if (bt == NULL)
> +	if (bt == NULL) {
>  		ret = blk_trace_setup_queue(q, bdev);
> +		bt = rcu_dereference_protected(q->blk_trace,
> +				lockdep_is_held(&q->blk_trace_mutex));
> +	}
> 
>  	if (ret == 0) {
>  		if (attr == &dev_attr_act_mask)
> --
> 2.25.1

