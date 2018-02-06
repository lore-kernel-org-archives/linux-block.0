Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] nvme: pci: pass max vectors as num_possible_cpus() to pci_alloc_irq_vectors
Date: Tue,  6 Feb 2018 20:17:42 +0800
Message-Id: <20180206121742.29336-6-ming.lei@redhat.com>
In-Reply-To: <20180206121742.29336-1-ming.lei@redhat.com>
References: <20180206121742.29336-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
has switched to do irq vectors spread among all possible CPUs, so
pass num_possible_cpus() as max vecotrs to be assigned.

For example, in a 8 cores system, 0~3 online, 4~8 offline/not present,
see 'lscpu':

        [ming@box]$lscpu
        Architecture:          x86_64
        CPU op-mode(s):        32-bit, 64-bit
        Byte Order:            Little Endian
        CPU(s):                4
        On-line CPU(s) list:   0-3
        Thread(s) per core:    1
        Core(s) per socket:    2
        Socket(s):             2
        NUMA node(s):          2
        ...
        NUMA node0 CPU(s):     0-3
        NUMA node1 CPU(s):
        ...

1) before this patch, follows the allocated vectors and their affinity:
	irq 47, cpu list 0,4
	irq 48, cpu list 1,6
	irq 49, cpu list 2,5
	irq 50, cpu list 3,7

2) after this patch, follows the allocated vectors and their affinity:
	irq 43, cpu list 0
	irq 44, cpu list 1
	irq 45, cpu list 2
	irq 46, cpu list 3
	irq 47, cpu list 4
	irq 48, cpu list 6
	irq 49, cpu list 5
	irq 50, cpu list 7

Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6fe7af00a1f4..f778426c93d5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1903,7 +1903,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	int result, nr_io_queues;
 	unsigned long size;
 
-	nr_io_queues = num_present_cpus();
+	nr_io_queues = num_possible_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.9.5
