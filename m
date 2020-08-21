Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B393EC433E3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 07:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DC52184D
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 07:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgHUHuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:50:37 -0400
Received: from verein.lst.de ([213.95.11.211]:46018 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgHUHug (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 03:50:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EB0868C4E; Fri, 21 Aug 2020 09:50:35 +0200 (CEST)
Date:   Fri, 21 Aug 2020 09:50:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due
 to nvme_set_queue_count timeout
Message-ID: <20200821075034.GB30216@lst.de>
References: <20200820035406.1720-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820035406.1720-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 20, 2020 at 11:54:06AM +0800, Chao Leng wrote:
> A deadlock happens When we test nvme over roce with link blink. The
> reason: link blink will cause error recovery, and then reconnect.If
> reconnect fail due to nvme_set_queue_count timeout, the reconnect
> process will set the queue count as 0 and continue , and then
> nvme_start_ctrl will call nvme_enable_aen, and deadlock happens
> because the admin queue is quiesced.
> 
> log:
> Aug  3 22:47:24 localhost kernel: nvme nvme2: I/O 22 QID 0 timeout
> Aug  3 22:47:24 localhost kernel: nvme nvme2: Could not set queue count
> (881)
> stack:
> root     23848  0.0  0.0      0     0 ?        D    Aug03   0:00
> [kworker/u12:4+nvme-wq]
> [<0>] blk_execute_rq+0x69/0xa0
> [<0>] __nvme_submit_sync_cmd+0xaf/0x1b0 [nvme_core]
> [<0>] nvme_features+0x73/0xb0 [nvme_core]
> [<0>] nvme_start_ctrl+0xa4/0x100 [nvme_core]
> [<0>] nvme_rdma_setup_ctrl+0x438/0x700 [nvme_rdma]
> [<0>] nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]
> [<0>] process_one_work+0x1a7/0x370
> [<0>] worker_thread+0x30/0x380
> [<0>] kthread+0x112/0x130
> [<0>] ret_from_fork+0x35/0x40
> 
> Many functions which call __nvme_submit_sync_cmd treat error code in two
> modes: If error code less than 0, treat as command failed. If erroe code
> more than 0, treat as target not support or other and continue.
> NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
> by host, is not the real error code return from target. So we need set
> the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
> the error to INTR, nvme_set_queue_count will return error, reconnect
> process will terminate instead of continue.

But we could still race with a real completion.  I suspect the right
answer is to translate NVME_SC_HOST_ABORTED_CMD and
NVME_SC_HOST_PATH_ERROR to a negative error code in
__nvme_submit_sync_cmd.
