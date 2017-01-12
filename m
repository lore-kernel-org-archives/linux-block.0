Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Message-ID: <7742bcaf65d9f4dc3c0dfede53a85b84.squirrel@webmail.raithlin.com>
Date: Wed, 11 Jan 2017 23:09:13 -0600
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] IO completion polling for block drivers
From: "Stephen Bates" <sbates@raithlin.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Sagi Grimberg" <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi

I'd like to discuss the ongoing work in the kernel to enable high priority
IO via polling for completion in the blk-mq subsystem.

Given that iopoll only really makes sense for low-latency, low queue depth
environments (i.e. down below 10-20us) I'd like to discuss which drivers
we think will need/want to be upgraded (aside from NVMe ;-)).

I'd also be interested in discussing how best to enable and disable
polling. In the past some of us have pushed for a "big hammer" to turn
polling on for a given device or HW queue [1]. I'd like to discuss this
again as well as looking at other methods above and beyond the preadv2
system call and the HIPRI flag.

Finally I'd like to discuss some of the recent work to improve the
heuristics around when to poll and when not to poll. I'd like to see if we
can come up with more optimal balance between CPU load and average
completion times [2].

Stephen Bates

[1] http://marc.info/?l=linux-block&m=146307410101827&w=2
[2] http://marc.info/?l=linux-block&m=147803441801858&w=2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
