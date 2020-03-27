Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA10C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AE2206F2
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 13:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xkfKUwEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0Nax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:30:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Nax (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 09:30:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RDSQmt054016;
        Fri, 27 Mar 2020 13:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tDLytqpzwXl+W0+H0jpktiePFXFRy7kuo5npw9C81cg=;
 b=xkfKUwEEWaETnA4Rpo4Th630V3aQ6rfYbO9NbRzXOxrWBj4mKzgr81hM00MJUZ904iSB
 PxlRIT1J7FShYnDXUKL7XY00TlsG1RrLs8NTH6x1DFBClOoub9VzYHXyfIMkcNPlp597
 ycsZfu2sQc9IA1rzUKliF3K4x3hv0oHQ+iWpcVJPp6lC0RFW7SjH/4RDYwTtQJAHeCVB
 Ss9QbaQqKkWTdTKr+I9Af8b/90I9bz08XsKsyeihYf/5c09/9HZrGjVsdb1Go6YWiXql
 g67JBb52eHwCUHoEBNi4Q3ikEWHpbRg++67f+S+tWfNPnqpwRJJnu4ynyN2HYFYyuMEZ Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3019vea72h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 13:30:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RDSaBW119855;
        Fri, 27 Mar 2020 13:30:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yxw4vv63t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 13:30:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02RDUkSi015981;
        Fri, 27 Mar 2020 13:30:46 GMT
Received: from [10.159.249.64] (/10.159.249.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 06:30:46 -0700
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
To:     Bart Van Assche <bvanassche@acm.org>
References: <00000000000047770d05a1c70ecb@google.com>
 <ffabca27-309e-4a6e-eac2-d03a56a7493a@oracle.com>
 <523c2b61-476e-0fb6-12d9-37038d150fb7@acm.org>
Cc:     syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <4a703c7f-3192-6303-87cf-b0db0ebb821a@oracle.com>
Date:   Fri, 27 Mar 2020 06:30:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <523c2b61-476e-0fb6-12d9-37038d150fb7@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/26/20 7:52 PM, Bart Van Assche wrote:
> On 2020-03-26 17:19, Dongli Zhang wrote:
>> I think the issue is because of line 2827, that is, the q->nr_hw_queues is
>> updated too earlier. It is still possible the init would fail later.
>>
>> 2809 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>> 2810                                                 struct request_queue *q)
>> 2811 {
>> 2812         int i, j, end;
>> 2813         struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
>> 2814
>> 2815         if (q->nr_hw_queues < set->nr_hw_queues) {
>> 2816                 struct blk_mq_hw_ctx **new_hctxs;
>> 2817
>> 2818                 new_hctxs = kcalloc_node(set->nr_hw_queues,
>> 2819                                        sizeof(*new_hctxs), GFP_KERNEL,
>> 2820                                        set->numa_node);
>> 2821                 if (!new_hctxs)
>> 2822                         return;
>> 2823                 if (hctxs)
>> 2824                         memcpy(new_hctxs, hctxs, q->nr_hw_queues *
>> 2825                                sizeof(*hctxs));
>> 2826                 q->queue_hw_ctx = new_hctxs;
>> 2827                 q->nr_hw_queues = set->nr_hw_queues;
>> 2828                 kfree(hctxs);
>> 2829                 hctxs = new_hctxs;
>> 2830         }
> 
> Which kernel tree does this syzbot report refer to? Commit
> d0930bb8f46b ("blk-mq: Fix a recently introduced regression in
> blk_mq_realloc_hw_ctxs()") in Jens' tree removed line 2827 shown above.
> 

Thank you very much for sharing this. The below is in Jens' tree for 5.7.

commit d0930bb8f46b8fb4a7d429c0bf1c91b3ed00a7cf
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Mon Mar 9 21:26:18 2020 -0700

    blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()

    q->nr_hw_queues must only be updated once it is known that
    blk_mq_realloc_hw_ctxs() has succeeded. Otherwise it can happen that
    reallocation fails and that q->nr_hw_queues is larger than the number of
    allocated hardware queues. This patch fixes the following crash if
    increasing the number of hardware queues fails:

    BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x775/0x810
    Write of size 8 at addr 0000000000000118 by task check/977

    CPU: 3 PID: 977 Comm: check Not tainted 5.6.0-rc1-dbg+ #8
    Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
    Call Trace:
     dump_stack+0xa5/0xe6
     __kasan_report.cold+0x65/0x99
     kasan_report+0x16/0x20
     check_memory_region+0x140/0x1b0
     memset+0x28/0x40
     blk_mq_map_swqueue+0x775/0x810
     blk_mq_update_nr_hw_queues+0x468/0x710
     nullb_device_submit_queues_store+0xf7/0x1a0 [null_blk]
     configfs_write_file+0x1c4/0x250 [configfs]
     __vfs_write+0x4c/0x90
     vfs_write+0x145/0x2c0
     ksys_write+0xd7/0x180
     __x64_sys_write+0x47/0x50
     do_syscall_64+0x6f/0x2f0
     entry_SYSCALL_64_after_hwframe+0x49/0xbe

    Fixes: ac0d6b926e74 ("block: Reduce the amount of memory required per
request queue")
    Signed-off-by: Bart Van Assche <bvanassche@acm.org>
    Reviewed-by: Ming Lei <ming.lei@redhat.com>
    Cc: Keith Busch <kbusch@kernel.org>
    Cc: Johannes Thumshirn <jth@kernel.org>
    Cc: Hannes Reinecke <hare@suse.com>
    Cc: Christoph Hellwig <hch@infradead.org>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4bd9b961726..37ff8dfb8ab9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2824,7 +2824,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
                        memcpy(new_hctxs, hctxs, q->nr_hw_queues *
                               sizeof(*hctxs));
                q->queue_hw_ctx = new_hctxs;
-               q->nr_hw_queues = set->nr_hw_queues;
                kfree(hctxs);
                hctxs = new_hctxs;
        }


That should be the reason why "init_hctx() fault injection" was introduced.

Thank you very much!

Dongli Zhang
