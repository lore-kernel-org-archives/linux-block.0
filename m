Return-Path: <maxg@mellanox.com>
Subject: Re: [BUG] nvme driver crash
To: Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@infradead.org>
References: <20170725222408.fq2fncwtid3fhvqh@kernel.org>
 <20170726173443.GA25527@infradead.org>
 <20170726191221.GA22421@vader.DHCP.thefacebook.com>
CC: Shaohua Li <shli@kernel.org>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, sagig <sagi@grimberg.me>, Keith Busch
	<keith.busch@intel.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <53919f26-3886-350a-119b-59e9c4b8ea4d@mellanox.com>
Date: Thu, 27 Jul 2017 16:52:15 +0300
MIME-Version: 1.0
In-Reply-To: <20170726191221.GA22421@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 7/26/2017 10:12 PM, Omar Sandoval wrote:
> On Wed, Jul 26, 2017 at 10:34:43AM -0700, Christoph Hellwig wrote:
>> On Tue, Jul 25, 2017 at 03:24:08PM -0700, Shaohua Li wrote:
>>> Disable CONIFG_SMP, kernel crashes at boot time, here is the log.
>>
>> I can reproduce the issue.  Unfortunately the addresss in the bug
>> doesn't make any sense to me when resolving it using gdb, as t just
>> points to the line where blk_mq_init_queue calls
>> blk_alloc_queue_node.
>>
>> Can you check if you get better results in your build?
>
> It's crashing on that line because ctrl->tagset is NULL, which is
> because...
>
> irq_create_affinity_masks() returns NULL on !CONFIG_SMP
> -> pci_irq_get_affinity() returns NULL
> -> blk_mq_pci_map_queues() returns -EINVAL
> -> blk_mq_alloc_tag_set() returns -EINVAL
> -> nvme_dev_add() doesn't set ctrl->tagset
>
> The two-fold fix would be to make the nvme driver handle
> blk_mq_alloc_tag_set() failing and to fall back to a dumb mapping in
> blk_mq_pci_map_queues(), but I don't know what the best way to do those
> is.
>

Adding Sagi and Keith.

Christoph,
I've send some fix few months ago to that but haven't got a green light:


nvme: don't ignore tagset allocation failures

the nvme_dev_add() function silently ignores failures.
In case blk_mq_alloc_tag_set fails, we hit NULL deref while
calling blk_mq_init_queue during nvme_alloc_ns with tagset == NULL.
Instead, we'll not issue the scan_work in case tagset allocation
failed and leave the ctrl functional.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
  drivers/nvme/host/core.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b3b57f..493722a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2115,9 +2115,9 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
  {
  	/*
  	 * Do not queue new scan work when a controller is reset during
-	 * removal.
+	 * removal or if the tagset doesn't exist.
  	 */
-	if (ctrl->state == NVME_CTRL_LIVE)
+	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
  		schedule_work(&ctrl->scan_work);
  }
  EXPORT_SYMBOL_GPL(nvme_queue_scan);


maybe we can rebase and consider it again ?
