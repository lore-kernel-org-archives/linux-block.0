Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751604AbdGEH7L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jul 2017 03:59:11 -0400
Date: Wed, 5 Jul 2017 09:59:05 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: hch@lst.de, sagi@grimberg.me, Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, bvanassche@acm.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, vladimirk@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
Message-ID: <20170705075905.GB4076@linux-x5ow.site>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 03:44:40PM +0300, Max Gurtovoy wrote:
> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).

Christoph/Sagi/Keith,

any updates on this patch? Without it I' not able to run NVMf on a box with 44
Cores and 88 Threads w/o adding -i 44 to the nvme connect statement.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
