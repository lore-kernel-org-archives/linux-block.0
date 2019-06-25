Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F83EC48BD4
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733D620652
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfFYCOx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:14:53 -0400
Received: from mail2.tencent.com ([163.177.67.195]:40700 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfFYCOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 22:14:53 -0400
Received: from EXHUB-SZMAIL02.tencent.com (unknown [10.14.6.23])
        by mail2.tencent.com (Postfix) with ESMTP id 4AFED8E7A9;
        Tue, 25 Jun 2019 10:14:47 +0800 (CST)
Received: from EX-SZ013.tencent.com (10.28.6.37) by EXHUB-SZMAIL02.tencent.com
 (10.14.6.23) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 25 Jun 2019
 10:14:47 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ013.tencent.com
 (10.28.6.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Jun
 2019 10:14:46 +0800
Received: from EX-SZ005.tencent.com ([fe80::80ab:5a24:b62e:8246]) by
 EX-SZ005.tencent.com ([fe80::80ab:5a24:b62e:8246%4]) with mapi id
 15.01.1713.004; Tue, 25 Jun 2019 10:14:46 +0800
From:   =?iso-2022-jp?B?d2VuYmluemVuZygbJEJBPUo4SUwbKEIp?= 
        <wenbinzeng@tencent.com>
To:     Ming Lei <ming.lei@redhat.com>, Wenbin Zeng <wenbin.zeng@gmail.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "hare@suse.com" <hare@suse.com>, "osandov@fb.com" <osandov@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet
 mail)
Thread-Topic: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet
 mail)
Thread-Index: AQHVKqDurKLV/sXBPUypS6FtYdqWkaarFq+AgACG9yA=
Date:   Tue, 25 Jun 2019 02:14:46 +0000
Message-ID: <fe4f40e7bbf74311a47c9f3b981f8c53@tencent.com>
References: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
 <20190625015512.GC23777@ming.t460p>
In-Reply-To: <20190625015512.GC23777@ming.t460p>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.251]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

> -----Original Message-----
> From: Ming Lei <ming.lei@redhat.com>
> Sent: Tuesday, June 25, 2019 9:55 AM
> To: Wenbin Zeng <wenbin.zeng@gmail.com>
> Cc: axboe@kernel.dk; keith.busch@intel.com; hare@suse.com; osandov@fb.com;
> sagi@grimberg.me; bvanassche@acm.org; linux-block@vger.kernel.org;
> linux-kernel@vger.kernel.org; wenbinzeng(曾文斌) <wenbinzeng@tencent.com>
> Subject: Re: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet mail)
> 
> On Mon, Jun 24, 2019 at 11:24:07PM +0800, Wenbin Zeng wrote:
> > Currently hctx->cpumask is not updated when hot-plugging new cpus,
> > as there are many chances kblockd_mod_delayed_work_on() getting
> > called with WORK_CPU_UNBOUND, workqueue blk_mq_run_work_fn may run
> 
> There are only two cases in which WORK_CPU_UNBOUND is applied:
> 
> 1) single hw queue
> 
> 2) multiple hw queue, and all CPUs in this hctx become offline
> 
> For 1), all CPUs can be found in hctx->cpumask.
> 
> > on the newly-plugged cpus, consequently __blk_mq_run_hw_queue()
> > reporting excessive "run queue from wrong CPU" messages because
> > cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) returns false.
> 
> The message means CPU hotplug race is triggered.
> 
> Yeah, there is big problem in blk_mq_hctx_notify_dead() which is called
> after one CPU is dead, but still run this hw queue to dispatch request,
> and all CPUs in this hctx might become offline.
> 
> We have some discussion before on this issue:
> 
> https://lore.kernel.org/linux-block/CACVXFVN729SgFQGUgmu1iN7P6Mv5+puE78STz8hj
> 9J5bS828Ng@mail.gmail.com/
> 

There is another scenario, you can reproduce it by hot-plugging cpus to kvm guests via qemu monitor (I believe virsh setvcpus --live can do the same thing), for example:
(qemu) cpu-add 1
(qemu) cpu-add 2
(qemu) cpu-add 3

In such scenario, cpu 1, 2 and 3 are not visible at boot, hctx->cpumask doesn't get synced when these cpus are added.

> >
> > This patch added a cpu-hotplug handler into blk-mq, updating
> > hctx->cpumask at cpu-hotplug.
> 
> This way isn't correct, hctx->cpumask should be kept as sync with
> queue mapping.

Please advise what should I do to deal with the above situation? Thanks a lot.

> 
> Thanks,
> Ming

