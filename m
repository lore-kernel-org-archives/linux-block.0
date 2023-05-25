Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29610C77B7C
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 02:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEYCN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 22:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjEYCN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 22:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F074139
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 19:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684980759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeTp35xCF/Zw31mWFIk0j/31+kkQUEqxUlQdZLnVNag=;
        b=WhytWK4NudxMjbf0dVniGXkaNHeR/Ah5+iWbqJtJg8yZ9eAv++XlLLJ1V7V3D/TAmLEVS7
        ClC7K0MTtuJzM0Bl5SBv5jn+rXXopYsoGq/o6dmhpr+xt037H84kbifEOq3OCZimdoyyQd
        hrBadlN5ymqygEAOh9Wwfi2D8+tjGe0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-QqZ-wcvNPzuU5_3kiz7YaA-1; Wed, 24 May 2023 22:12:37 -0400
X-MC-Unique: QqZ-wcvNPzuU5_3kiz7YaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15BCE800B2A;
        Thu, 25 May 2023 02:12:37 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE7BB492B00;
        Thu, 25 May 2023 02:12:31 +0000 (UTC)
Date:   Thu, 25 May 2023 10:12:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tian Lan <tilan7663@gmail.com>
Cc:     hare@suse.de, axboe@kernel.dk, horms@kernel.org,
        linux-block@vger.kernel.org, lkp@intel.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, tian.lan@twosigma.com
Subject: Re: [PATCH] blk-mq: fix blk_mq_hw_ctx active request accounting
Message-ID: <ZG7ECteMoJah+UqU@ovpn-8-21.pek2.redhat.com>
References: <1c9fc9df-817c-e6cb-1375-2013c0c5a9bb@suse.de>
 <20230515122643.597546-1-tilan7663@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515122643.597546-1-tilan7663@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 15, 2023 at 08:26:43AM -0400, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> The nr_active counter continues to increase over time which causes the
> blk_mq_get_tag to hang until the thread is rescheduled to a different
> core despite there are still tags available.
> 
> kernel-stack
> 
>   INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
>   Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:inboundIORe state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
>     Call Trace:
>     <TASK>
>     __schedule+0x351/0xa20
>     scheduler+0x5d/0xe0
>     io_schedule+0x42/0x70
>     blk_mq_get_tag+0x11a/0x2a0
>     ? dequeue_task_stop+0x70/0x70
>     __blk_mq_alloc_requests+0x191/0x2e0
> 
> kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
> __blk_mq_free_request being called.
> 
>   320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0
>          b'__blk_mq_free_request+0x1 [kernel]'
>          b'bt_iter+0x50 [kernel]'
>          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
>          b'blk_mq_timeout_work+0x7c [kernel]'
>          b'process_one_work+0x1c4 [kernel]'
>          b'worker_thread+0x4d [kernel]'
>          b'kthread+0xe6 [kernel]'
>          b'ret_from_fork+0x1f [kernel]'
> 
> The issue is caused by the difference between blk_mq_free_request() and
> blk_mq_end_request_batch() wrt. when to call __blk_mq_dec_active_requests().
> The former does it before calling req_ref_put_and_test(), and the latter
> decreases the active request after req_ref_put_and_test().
> 
> - Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
> 
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Hello Jens,

Looks this fix is missed, can you take a look?


Thanks,
Ming

