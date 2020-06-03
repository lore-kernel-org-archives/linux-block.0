Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD34C433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E1E20679
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 16:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AdVqigCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgFCQYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:24:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFCQYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 12:24:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053GGTF4010338;
        Wed, 3 Jun 2020 16:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PaPbtInXwCDIAc2IoG+7wf0xKv2XiaYkTrHhHA9qwlg=;
 b=AdVqigCX3BRvbGFZJWiZlBVeIX38Y0sQ6wAdQXMOyDfZYxVhm1oqYFDOIUC4gOGum/zX
 KoQEiPv0BjzCpygk5dAb3K6bExqw3OdhT+Wv+kUxx0v6Pj5N+zCUUVp0S6z1IDRhHMlh
 OjUqOCxKtVxaqZqX2N9U1pNqCIGZ5Q/ugsbLqTJ9/sh3UQzc6I/sKKLv2uR7RU78IxUs
 LJK13S0B7zB8Q7vHk5N7GFkY1szuQn5XJpjByRYvs7ZVePMxuyLBymWjx0kgxEqqW2NH
 0gjv+NLrgy0a4dCxJKuaEJ8erP3Zrrz3xhxoIHbJkKmnD7ZdFvHItGJXykuUC7H2Qfou 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfema66g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 16:23:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053GI3Pb011584;
        Wed, 3 Jun 2020 16:23:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31dju3gg6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 16:23:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053GNlPo032435;
        Wed, 3 Jun 2020 16:23:50 GMT
Received: from [10.159.230.80] (/10.159.230.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 09:23:47 -0700
Subject: Re: [PATCH 1/1] blk-mq: get ctx in order to handle BLK_MQ_S_INACTIVE
 in blk_mq_get_tag()
To:     John Garry <john.garry@huawei.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hare@suse.de, dwagner@suse.de,
        ming.lei@redhat.com, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20200602061749.32029-1-dongli.zhang@oracle.com>
 <2114e1a8-253b-9ad7-0991-afc15df365bd@huawei.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <39dd930b-839d-5d74-afb6-5a8bb1d2f0da@oracle.com>
Date:   Wed, 3 Jun 2020 09:23:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2114e1a8-253b-9ad7-0991-afc15df365bd@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030129
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi John,

On 6/3/20 4:59 AM, John Garry wrote:
> On 02/06/2020 07:17, Dongli Zhang wrote:
>> When scheduler is set, we hit below page fault when we offline cpu.
>>
>> [ 1061.007725] BUG: kernel NULL pointer dereference, address: 0000000000000040
>> [ 1061.008710] #PF: supervisor read access in kernel mode
>> [ 1061.009492] #PF: error_code(0x0000) - not-present page
>> [ 1061.010241] PGD 0 P4D 0
>> [ 1061.010614] Oops: 0000 [#1] SMP PTI
>> [ 1061.011130] CPU: 0 PID: 122 Comm: kworker/0:1H Not tainted 5.7.0-rc7+ #2'
>> ... ...
>> [ 1061.013760] Workqueue: kblockd blk_mq_run_work_fn
>> [ 1061.014446] RIP: 0010:blk_mq_put_tag+0xf/0x30
>> ... ...
>> [ 1061.017726] RSP: 0018:ffffa5c18037fc70 EFLAGS: 00010287
>> [ 1061.018475] RAX: 0000000000000000 RBX: ffffa5c18037fcf0 RCX: 0000000000000004
>> [ 1061.019507] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff911535dc1180
>> ... ...
>> [ 1061.028454] Call Trace:
>> [ 1061.029307]  blk_mq_get_tag+0x26e/0x280
>> [ 1061.029866]  ? wait_woken+0x80/0x80
>> [ 1061.030378]  blk_mq_get_driver_tag+0x99/0x110
>> [ 1061.031009]  blk_mq_dispatch_rq_list+0x107/0x5e0
>> [ 1061.031672]  ? elv_rb_del+0x1a/0x30
>> [ 1061.032178]  blk_mq_do_dispatch_sched+0xe2/0x130
>> [ 1061.032844]  __blk_mq_sched_dispatch_requests+0xcc/0x150
>> [ 1061.033638]  blk_mq_sched_dispatch_requests+0x2b/0x50
>> [ 1061.034239]  __blk_mq_run_hw_queue+0x75/0x110
>> [ 1061.034867]  process_one_work+0x15c/0x370
>> [ 1061.035450]  worker_thread+0x44/0x3d0
>> [ 1061.035980]  kthread+0xf3/0x130
>> [ 1061.036440]  ? max_active_store+0x80/0x80
>> [ 1061.037018]  ? kthread_bind+0x10/0x10
>> [ 1061.037554]  ret_from_fork+0x35/0x40
>> [ 1061.038073] Modules linked in:
>> [ 1061.038543] CR2: 0000000000000040
>> [ 1061.038962] ---[ end trace d20e1df7d028e69f ]---
>>
>> This is because blk_mq_get_driver_tag() would be used to allocate tag once
>> scheduler (e.g., mq-deadline) is set. 
> 
> I tried mq-deadline and I did not see this. Anyway else special or specific
> about your test?
> 

I think you just hit the issue as mentioned in another thread.

To reproduce the issue reproduce to hit the condition that:

1. blk_mq_hctx_notify_offline() BLK_MQ_S_INACTIVE with the barrier ...

... while ...

2. blk_mq_get_tag() gets the tag but BLK_MQ_S_INACTIVE is already set.
Therefore, it would put the tag to release it.

Dongli Zhang
