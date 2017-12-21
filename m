Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/3] Performance enhancements
Date: Thu, 21 Dec 2017 13:46:33 -0700
Message-Id: <20171221204636.2924-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

A few IO micro-optimizations for IO polling and NVMe. I'm really working
to close the performance gap with userspace drivers, and this gets me
halfway there on latency. The fastest hardware I could get measured
roundtrip read latency at 5usec with this series that was previously
measuring 5.7usec.

Note with NVMe, you really need to crank up the interrupt coalescing to
see the completion polling benefit.

Test pre-setup:

  echo performance | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
  echo 0 > /sys/block/nvme0n1/queue/iostats
  echo -1 > /sys/block/nvme0n1/queue/io_poll_delay
  nvme set-feature /dev/nvme0 -f 8 -v 0x4ff

fio profile:

  [global]
  ioengine=pvsync2
  rw=randread
  norandommap
  direct=1
  bs=4k
  hipri

  [hi-pri]
  filename=/dev/nvme0n1
  cpus_allowed=2

Keith Busch (3):
  nvme/pci: Start request after doorbell ring
  nvme/pci: Remove cq_vector check in IO path
  block: Polling completion performance optimization

 drivers/nvme/host/pci.c | 14 +++-----------
 fs/block_dev.c          |  5 ++++-
 2 files changed, 7 insertions(+), 12 deletions(-)

-- 
2.13.6
