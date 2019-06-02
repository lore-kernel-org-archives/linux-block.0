Return-Path: <SRS0=BT6h=UB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E05C282DC
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 07:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAC720863
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 07:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfFBHSP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jun 2019 03:18:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFBHSP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Jun 2019 03:18:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F6AE37EEA;
        Sun,  2 Jun 2019 06:42:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1EFA5C220;
        Sun,  2 Jun 2019 06:42:18 +0000 (UTC)
Date:   Sun, 2 Jun 2019 14:42:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 8/9] scsi: megaraid: convert private reply queue to
 blk-mq hw queue
Message-ID: <20190602064202.GA2731@ming.t460p>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-9-ming.lei@redhat.com>
 <7819e1a523b9e8227e3a9d188ee1e083@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7819e1a523b9e8227e3a9d188ee1e083@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 02 Jun 2019 06:42:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Kashyap,

Thanks for your test.

On Sun, Jun 02, 2019 at 03:11:26AM +0530, Kashyap Desai wrote:
> > SCSI's reply qeueue is very similar with blk-mq's hw queue, both
> assigned by
> > IRQ vector, so map te private reply queue into blk-mq's hw queue via
> > .host_tagset.
> >
> > Then the private reply mapping can be removed.
> >
> > Another benefit is that the request/irq lost issue may be solved in
> generic
> > approach because managed IRQ may be shutdown during CPU hotplug.
> 
> Ming,
> 
> I quickly tested this patch series on MegaRaid Aero controller. Without
> this patch I can get 3.0M IOPS, but once I apply this patch I see only
> 1.2M IOPS (40% Performance drop)
> HBA supports 5089 can_queue.
> 
> <perf top> output without  patch -
> 
>     3.39%  [megaraid_sas]  [k] complete_cmd_fusion
>      3.36%  [kernel]        [k] scsi_queue_rq
>      3.26%  [kernel]        [k] entry_SYSCALL_64
>      2.57%  [kernel]        [k] syscall_return_via_sysret
>      1.95%  [megaraid_sas]  [k] megasas_build_and_issue_cmd_fusion
>      1.88%  [kernel]        [k] _raw_spin_lock_irqsave
>      1.79%  [kernel]        [k] gup_pmd_range
>      1.73%  [kernel]        [k] _raw_spin_lock
>      1.68%  [kernel]        [k] __sched_text_start
>      1.19%  [kernel]        [k] irq_entries_start
>      1.13%  [kernel]        [k] scsi_dec_host_busy
>      1.08%  [kernel]        [k] aio_complete
>      1.07%  [kernel]        [k] read_tsc
>      1.01%  [kernel]        [k] blk_mq_get_request
>      0.93%  [kernel]        [k] __update_load_avg_cfs_rq
>      0.92%  [kernel]        [k] aio_read_events
>      0.91%  [kernel]        [k] lookup_ioctx
>      0.91%  fio             [.] fio_gettime
>      0.87%  [kernel]        [k] set_next_entity
>      0.87%  [megaraid_sas]  [k] megasas_build_ldio_fusion
> 
> <perf top> output with  patch -
> 
>     11.30%  [kernel]       [k] native_queued_spin_lock_slowpath

I guess there must be one global lock required in megaraid submission path,
could you run 'perf record -g -a' to see which lock is and what the stack
trace is?


Thanks,
Ming
