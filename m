Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F3C38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJXJtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiJXJtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 05:49:07 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4210F6290C
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 02:49:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VSx-Uyn_1666604938;
Received: from 30.97.56.52(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VSx-Uyn_1666604938)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 17:48:59 +0800
Message-ID: <8a225315-3932-62a6-2bc6-8e81e672fd9d@linux.alibaba.com>
Date:   Mon, 24 Oct 2022 17:48:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] ublk_drv: don't call task_work_add for queueing io
 commands
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20221023093807.201946-1-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221023093807.201946-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/23 17:38, Ming Lei wrote:
> task_work_add() is used for waking ubq daemon task with one batch
> of io requests/commands queued. However, task_work_add() isn't
> exported for module code, and it is still debatable if the symbol
> should be exported.
> 
> Fortunately we still have io_uring_cmd_complete_in_task() which just
> can't handle batched wakeup for us.
> 
> Add one one llist into ublk_queue and call io_uring_cmd_complete_in_task()
> via current command for running them via task work.
> 
> This way cleans up current code a lot, meantime allow us to wakeup
> ubq daemon task after queueing batched requests/io commands.
> 


Hi, Ming

This patch works and I have run some tests to compare current version(ucmd)
with your patch(ucmd-batch).

iodepth=128 numjobs=1 direct=1 bs=4k

--------------------------------------------
ublk loop target, the backend is a file.
IOPS(k)

type		ucmd		ucmd-batch
seq-read	54.7		54.2	
rand-read	52.8		52.0

--------------------------------------------
ublk null target
IOPS(k)

type		ucmd		ucmd-batch
seq-read	257		257
rand-read	252		253


I find that io_req_task_work_add() puts task_work node into a llist
first, then it may call task_work_add() to run batched task_works. So do we really
need such llist in ublk_drv? I think io_uring has already considered task_work batch
optimization.

BTW, task_work_add() in ublk_drv achieves
higher IOPS(about 5-10% on my machine) than io_uring_cmd_complete_in_task()
in ublk_drv.

Regards,
Zhang
