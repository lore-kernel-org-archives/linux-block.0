Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] genirq/affinity: irq vector spread among online CPUs as far as possible
Date: Tue,  6 Feb 2018 20:17:37 +0800
Message-Id: <20180206121742.29336-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

This patchset tries to spread among online CPUs as far as possible, so
that we can avoid to allocate too less irq vectors with online CPUs
mapped.

For example, in a 8cores system, 4 cpu cores(4~7) are offline/non present,
on a device with 4 queues:

1) before this patchset
	irq 39, cpu list 0-2
	irq 40, cpu list 3-4,6
	irq 41, cpu list 5
	irq 42, cpu list 7

2) after this patchset
	irq 39, cpu list 0,4
	irq 40, cpu list 1,6
	irq 41, cpu list 2,5
	irq 42, cpu list 3,7

Without this patchset, only two vectors(39, 40) can be active, but there
can be 4 active irq vectors after applying this patchset.

One disadvantage is that CPUs from different NUMA node can be mapped to
one same irq vector. Given generally one CPU should be enough to handle
one irq vector, it shouldn't be a big deal. Especailly more vectors have
to be allocated, otherwise performance can be hurt in current
assignment.

Thanks
Ming

Ming Lei (5):
  genirq/affinity: rename *node_to_possible_cpumask as *node_to_cpumask
  genirq/affinity: move actual irq vector spread into one helper
  genirq/affinity: support to do irq vectors spread starting from any
    vector
  genirq/affinity: irq vector spread among online CPUs as far as
    possible
  nvme: pci: pass max vectors as num_possible_cpus() to
    pci_alloc_irq_vectors

 drivers/nvme/host/pci.c |   2 +-
 kernel/irq/affinity.c   | 145 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 95 insertions(+), 52 deletions(-)

-- 
2.9.5
