Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6189CC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410B022309
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKSBZj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:25:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbfKSBZi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 20:25:38 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9649D429704EF0A9917D;
        Tue, 19 Nov 2019 09:25:36 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 09:25:30 +0800
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
To:     Ming Lei <ming.lei@redhat.com>, <lkml@sdf.org>,
        <tglx@linutronix.de>
Subject: The irq Affinity is changed after the patch(Fixes: b1a5a73e64e9
 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio"))
CC:     <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Message-ID: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>
Date:   Tue, 19 Nov 2019 09:25:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

There are 128 cpus and 16 irqs for SAS controller in my system, and 
there are 4 Nodes, every 32 cpus are for one node (cpu0-31 for node0, 
cpu32-63 for node1, cpu64-95 for node2, cpu96-127 for node3).
We use function pci_alloc_irq_vectors_affinity() to set the affinity of 
irqs.

I find that  before the patch (Fixes: b1a5a73e64e9 ("genirq/affinity: 
Spread vectors on node according to nr_cpu ratio")), the relationship 
between irqs and cpus is: irq0 bind to cpu0-7, irq1 bind to cpu8-15,
irq2 bind to cpu16-23, irq3 bind to cpu24-31,irq4 bind to cpu32-39... 
irq15 bind to cpu120-127. But after the patch, the relationship is 
changed: irq0 bind to cpu32-39,
irq1 bind to cpu40-47, ..., irq11 bind to cpu120-127, irq12 bind to 
cpu0-7, irq13 bind to cpu8-15, irq14 bind to cpu16-23, irq15 bind to 
cpu24-31.

I notice that before calling the sort() in function 
alloc_nodes_vectors(), the id of array node_vectors[] is from 0,1,2,3. 
But after function sort(), the index of array node_vectors[] is 1,2,3,0.
But i think it sorts according to the numbers of cpus in those nodes, so 
it should be the same as before calling sort() as the numbers of cpus in 
every node are 32.

Is it a bug of sort() or the usage of sort()?

Thanks,
Shawn

