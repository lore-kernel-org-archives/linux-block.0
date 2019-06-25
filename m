Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B745C4646B
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6AF20665
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 01:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfFYBz0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:55:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729450AbfFYBz0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 21:55:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 037DE308626C;
        Tue, 25 Jun 2019 01:55:26 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2CE5C277;
        Tue, 25 Jun 2019 01:55:17 +0000 (UTC)
Date:   Tue, 25 Jun 2019 09:55:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wenbin Zeng <wenbin.zeng@gmail.com>
Cc:     axboe@kernel.dk, keith.busch@intel.com, hare@suse.com,
        osandov@fb.com, sagi@grimberg.me, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenbin Zeng <wenbinzeng@tencent.com>
Subject: Re: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug
Message-ID: <20190625015512.GC23777@ming.t460p>
References: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 25 Jun 2019 01:55:26 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 24, 2019 at 11:24:07PM +0800, Wenbin Zeng wrote:
> Currently hctx->cpumask is not updated when hot-plugging new cpus,
> as there are many chances kblockd_mod_delayed_work_on() getting
> called with WORK_CPU_UNBOUND, workqueue blk_mq_run_work_fn may run

There are only two cases in which WORK_CPU_UNBOUND is applied:

1) single hw queue

2) multiple hw queue, and all CPUs in this hctx become offline

For 1), all CPUs can be found in hctx->cpumask.

> on the newly-plugged cpus, consequently __blk_mq_run_hw_queue()
> reporting excessive "run queue from wrong CPU" messages because
> cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) returns false.

The message means CPU hotplug race is triggered.

Yeah, there is big problem in blk_mq_hctx_notify_dead() which is called
after one CPU is dead, but still run this hw queue to dispatch request,
and all CPUs in this hctx might become offline.

We have some discussion before on this issue:

https://lore.kernel.org/linux-block/CACVXFVN729SgFQGUgmu1iN7P6Mv5+puE78STz8hj9J5bS828Ng@mail.gmail.com/

> 
> This patch added a cpu-hotplug handler into blk-mq, updating
> hctx->cpumask at cpu-hotplug.

This way isn't correct, hctx->cpumask should be kept as sync with
queue mapping.

Thanks,
Ming
