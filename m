Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 00/16] Introduce the BFQ I/O scheduler
Date: Tue, 11 Apr 2017 15:42:59 +0200
Message-Id: <20170411134315.44135-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi,
new patch series, addressing (both) issues raised by Bart [1].

Thanks,
Paolo

[1] https://lkml.org/lkml/2017/3/31/393

Arianna Avanzini (4):
  block, bfq: add full hierarchical scheduling and cgroups support
  block, bfq: add Early Queue Merge (EQM)
  block, bfq: reduce idling only in symmetric scenarios
  block, bfq: handle bursts of queue activations

Paolo Valente (12):
  block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
  block, bfq: improve throughput boosting
  block, bfq: modify the peak-rate estimator
  block, bfq: add more fairness with writes and slow processes
  block, bfq: improve responsiveness
  block, bfq: reduce I/O latency for soft real-time applications
  block, bfq: preserve a low latency also with NCQ-capable drives
  block, bfq: reduce latency during request-pool saturation
  block, bfq: boost the throughput on NCQ-capable flash-based devices
  block, bfq: boost the throughput with random I/O on NCQ-capable HDDs
  block, bfq: remove all get and put of I/O contexts
  block, bfq: split bfq-iosched.c into multiple source files

 Documentation/block/00-INDEX        |    2 +
 Documentation/block/bfq-iosched.txt |  531 ++++
 block/Kconfig.iosched               |   21 +
 block/Makefile                      |    1 +
 block/bfq-cgroup.c                  | 1139 ++++++++
 block/bfq-iosched.c                 | 5047 +++++++++++++++++++++++++++++++++++
 block/bfq-iosched.h                 |  942 +++++++
 block/bfq-wf2q.c                    | 1616 +++++++++++
 include/linux/blkdev.h              |    2 +-
 9 files changed, 9300 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/block/bfq-iosched.txt
 create mode 100644 block/bfq-cgroup.c
 create mode 100644 block/bfq-iosched.c
 create mode 100644 block/bfq-iosched.h
 create mode 100644 block/bfq-wf2q.c

--
2.10.0
