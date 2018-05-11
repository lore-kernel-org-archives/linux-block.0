Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 11 May 2018 14:50:28 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180511205028.GB7772@localhost.localdomain>
References: <20180511122933.27155-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180511122933.27155-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 11, 2018 at 08:29:24PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st patch introduces blk_quiesce_timeout() and blk_unquiesce_timeout()
> for NVMe, meantime fixes blk_sync_queue().
> 
> The 2nd patch covers timeout for admin commands for recovering controller
> for avoiding possible deadlock.
> 
> The 3rd and 4th patches avoid to wait_freeze on queues which aren't frozen.
> 
> The last 5 patches fixes several races wrt. NVMe timeout handler, and
> finally can make blktests block/011 passed. Meantime the NVMe PCI timeout
> mecanism become much more rebost than before.
> 
> gitweb:
> 	https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V5

Hi Ming,

First test with simulated broken links is unsuccessful. I'm getting
stuck here:

[<0>] blk_mq_freeze_queue_wait+0x46/0xb0
[<0>] blk_cleanup_queue+0x78/0x170
[<0>] nvme_ns_remove+0x137/0x1a0 [nvme_core]
[<0>] nvme_remove_namespaces+0x86/0xc0 [nvme_core]
[<0>] nvme_remove+0x6b/0x130 [nvme]
[<0>] pci_device_remove+0x36/0xb0
[<0>] device_release_driver_internal+0x157/0x220
[<0>] nvme_remove_dead_ctrl_work+0x29/0x40 [nvme]
[<0>] process_one_work+0x170/0x350
[<0>] worker_thread+0x2e/0x380
[<0>] kthread+0x111/0x130
[<0>] ret_from_fork+0x1f/0x30


Here's the last parts of the kernel logs capturing the failure:

[  760.679105] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679116] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679120] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679124] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679127] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679131] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679135] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679138] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679141] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679144] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679148] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679151] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679155] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679158] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679161] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679164] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679169] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679172] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679176] nvme nvme1: EH 0: before shutdown
[  760.679177] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679181] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679185] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679189] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679192] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679196] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679199] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679202] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679240] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679243] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.679246] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff

( above repeats a few more hundred times )

[  760.679960] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  760.701468] nvme nvme1: EH 0: after shutdown, top eh: 1
[  760.727099] pci_raw_set_power_state: 62 callbacks suppressed
[  760.727103] nvme 0000:86:00.0: Refused to change power state, currently in D3
[  760.727483] nvme nvme1: EH 0: state 4, eh_done -19, top eh 1
[  760.727485] nvme nvme1: EH 0: after recovery -19
[  760.727488] nvme nvme1: EH: fail controller
[  760.727491] nvme nvme1: Removing after probe failure status: 0
[  760.735138] nvme1n1: detected capacity change from 1200243695616 to 0
