Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CFC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 06:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCFD20863
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 06:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfEUGIO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 02:08:14 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59162 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfEUGIN (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Tue, 21 May 2019 02:08:13 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 08:08:11 +0200
Subject: Re: [RESEND PATCH v4] blk-mq: fix hang caused by freeze/unfreeze
 sequence
To:     Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        jinpuwang@gmail.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
References: <20190521032555.31993-1-bob.liu@oracle.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <707da8fa-18e7-df07-48ff-91cfe1023546@suse.com>
Date:   Tue, 21 May 2019 08:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521032555.31993-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/21/19 5:25 AM, Bob Liu wrote:
> The following is a description of a hang in blk_mq_freeze_queue_wait().
> The hang happens on attempt to freeze a queue while another task does
> queue unfreeze.
> 
> The root cause is an incorrect sequence of percpu_ref_resurrect() and
> percpu_ref_kill() and as a result those two can be swapped:
> 
>   CPU#0                         CPU#1
>   ----------------              -----------------
>   q1 = blk_mq_init_queue(shared_tags)
> 
>                                  q2 = blk_mq_init_queue(shared_tags):
>                                    blk_mq_add_queue_tag_set(shared_tags):
>                                      blk_mq_update_tag_set_depth(shared_tags):
> 				     list_for_each_entry()
>                                        blk_mq_freeze_queue(q1)
>                                         > percpu_ref_kill()
>                                         > blk_mq_freeze_queue_wait()
> 
>   blk_cleanup_queue(q1)
>    blk_mq_freeze_queue(q1)
>     > percpu_ref_kill()
>                   ^^^^^^ freeze_depth can't guarantee the order
> 
>                                        blk_mq_unfreeze_queue()
>                                          > percpu_ref_resurrect()
> 
>     > blk_mq_freeze_queue_wait()
>                   ^^^^^^ Hang here!!!!
> 
> This wrong sequence raises kernel warning:
> percpu_ref_kill_and_confirm called more than once on blk_queue_usage_counter_release!
> WARNING: CPU: 0 PID: 11854 at lib/percpu-refcount.c:336 percpu_ref_kill_and_confirm+0x99/0xb0
> 
> But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
> which waits for a zero of a q_usage_counter, which never happens
> because percpu-ref was reinited (instead of being killed) and stays in
> PERCPU state forever.
> 
> How to reproduce:
>   - "insmod null_blk.ko shared_tags=1 nr_devices=0 queue_mode=2"
>   - cpu0: python Script.py 0; taskset the corresponding process running on cpu0
>   - cpu1: python Script.py 1; taskset the corresponding process running on cpu1
> 
>   Script.py:
>   ------
>   #!/usr/bin/python3
> 
> import os
> import sys
> 
> while True:
>      on = "echo 1 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
>      off = "echo 0 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
>      os.system(on)
>      os.system(off)
> ------
> 
> This bug was first reported and fixed by Roman, previous discussion:
> [1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
> [2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org
> [3] https://patchwork.kernel.org/patch/9268199/
> 
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-core.c       |  3 ++-
>   block/blk-mq.c         | 19 ++++++++++---------
>   include/linux/blkdev.h |  7 ++++++-
>   3 files changed, 18 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
