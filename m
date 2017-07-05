Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-db5eur01on0086.outbound.protection.outlook.com ([104.47.2.86]:6896
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751604AbdGEILn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jul 2017 04:11:43 -0400
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Johannes Thumshirn <jthumshirn@suse.de>, <hch@lst.de>,
        <sagi@grimberg.me>, Keith Busch <keith.busch@intel.com>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <20170705075905.GB4076@linux-x5ow.site>
CC: <axboe@fb.com>, <bvanassche@acm.org>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <vladimirk@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <fcc21db2-c3fe-48d7-a33a-5eedac00c2bd@mellanox.com>
Date: Wed, 5 Jul 2017 11:11:36 +0300
MIME-Version: 1.0
In-Reply-To: <20170705075905.GB4076@linux-x5ow.site>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 7/5/2017 10:59 AM, Johannes Thumshirn wrote:
> On Wed, Jun 28, 2017 at 03:44:40PM +0300, Max Gurtovoy wrote:
>> This patch performs sequential mapping between CPUs and queues.
>> In case the system has more CPUs than HWQs then there are still
>> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
>> and their siblings to the same HWQ.
>> This actually fixes a bug that found unmapped HWQs in a system with
>> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
>> running NVMEoF (opens upto maximum of 64 HWQs).
>
> Christoph/Sagi/Keith,
>
> any updates on this patch? Without it I' not able to run NVMf on a box with 44
> Cores and 88 Threads w/o adding -i 44 to the nvme connect statement.
>
> Thanks,
> 	Johannes
>

Hi Johannes,
this was merge already to the main tree (Jens add it to his pull request)

Cheers,
	Max.
