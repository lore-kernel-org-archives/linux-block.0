Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Dec 2016 13:37:33 -0500
From: Tejun Heo <tj@kernel.org>
To: Adam Manzanares <adam.manzanares@hgst.com>
Cc: axboe@kernel.dk, hare@suse.de, mchristi@redhat.com,
	dan.j.williams@intel.com, martin.petersen@oracle.com,
	toshi.kani@hpe.com, damien.lemoal@hgst.com, ming.lei@canonical.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	Adam Manzanares <adam.manzanares@wdc.com>
Subject: Re: [PATCH v7 0/4] Enabling ATA Command Priorities
Message-ID: <20161206183733.GA26314@mtj.duckdns.org>
References: <1481044685-2803-1-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481044685-2803-1-git-send-email-adam.manzanares@hgst.com>
List-ID: <linux-block@vger.kernel.org>

Adam,

On Tue, Dec 06, 2016 at 09:18:01AM -0800, Adam Manzanares wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> This patch builds ATA commands with high priority if the iocontext of a process
> is set to real time. The goal of the patch is to improve tail latencies of 
> workloads that use higher queue depths. This requires setting the iocontext 
> ioprio on the request when it is initialized
> 
> This patch has been tested with an Ultrastar HE8 HDD and cuts the 
> the p99.99 tail latency of foreground IO from 2s down to 72ms when
> using the deadline scheduler. This patch works independently of the
> scheduler so it can be used with all of the currently available 
> request based schedulers. 
> 
> Foreground IO, for the previously described results, is an async fio job 
> submitting 4K read requests at a QD of 1 to the HDD. The foreground IO is set 
> with the iopriority class of real time. The background workload is another fio
> job submitting read requests at a QD of 32 to the same HDD with default 
> iopriority.
> 
> This feature is enabled for ATA devices by setting the ata ncq_prio_enable 
> device attribute to 1. An ATA device is also checked to see if the device 
> supports per command priority.
> 
> v7:
>  - Run ncq prio support check when sysfs variable set (zero day bug fix)
>  - Fixes from TJ merged in
>  - Merge fix for linux-next incorporated

The previous version has already been merged into libata/for-4.10.
Can you please send me an incremental patch on top of it?  The tree
can be fetched from

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.10

Thanks.

-- 
tejun
