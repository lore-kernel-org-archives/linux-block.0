Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751489AbdF1OoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:44:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5SEi2qC066466
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 10:44:08 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bcdpvajdf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 10:44:08 -0400
Received: from localhost
        by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Wed, 28 Jun 2017 11:44:05 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
        by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v5SEi2Vk9699506
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 11:44:02 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
        by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v5SEi34a014112
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 11:44:04 -0300
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Max Gurtovoy <maxg@mellanox.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, bvanassche@acm.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: vladimirk@mellanox.com
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 11:43:51 -0300
MIME-Version: 1.0
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <246abb9a-4df1-f5a5-b34a-092d087e42e0@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/28/2017 09:44 AM, Max Gurtovoy wrote:
> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).
> 
> Performance results running fio (72 jobs, 128 iodepth)
> using null_blk (w/w.o patch):
> 
> bs      IOPS(read submit_queues=72)   IOPS(write submit_queues=72)   IOPS(read submit_queues=24)  IOPS(write submit_queues=24)
> -----  ----------------------------  ------------------------------ ---------------------------- -----------------------------
> 512    4890.4K/4723.5K                 4524.7K/4324.2K                   4280.2K/4264.3K               3902.4K/3909.5K
> 1k     4910.1K/4715.2K                 4535.8K/4309.6K                   4296.7K/4269.1K               3906.8K/3914.9K
> 2k     4906.3K/4739.7K                 4526.7K/4330.6K                   4301.1K/4262.4K               3890.8K/3900.1K
> 4k     4918.6K/4730.7K                 4556.1K/4343.6K                   4297.6K/4264.5K               3886.9K/3893.9K
> 8k     4906.4K/4748.9K                 4550.9K/4346.7K                   4283.2K/4268.8K               3863.4K/3858.2K
> 16k    4903.8K/4782.6K                 4501.5K/4233.9K                   4292.3K/4282.3K               3773.1K/3773.5K
> 32k    4885.8K/4782.4K                 4365.9K/4184.2K                   4307.5K/4289.4K               3780.3K/3687.3K
> 64k    4822.5K/4762.7K                 2752.8K/2675.1K                   4308.8K/4312.3K               2651.5K/2655.7K
> 128k   2388.5K/2313.8K                 1391.9K/1375.7K                   2142.8K/2152.2K               1395.5K/1374.2K
> 

Max, thanks for this patch. I was having the same issue, and was
thinking in how to address...

Your patch fixes it for me, just tested it.
I can test any follow-up patch you send, basaed on reviews you got in
the list.

Cheers,


Guilherme
