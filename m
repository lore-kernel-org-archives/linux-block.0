Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3B78F34;
	Wed, 11 Jun 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644220; cv=none; b=hyQ5ZRKegvAK6p/wEWX+KvmTeLN77Rjf3uWUCZZEf7Z9snG8VxQwa1ta5IOYAw2WS9mzrIik96NG+zaFLmL9DEQ6muFGdRHxQ9wquLpaNrjRuvZV49Tt4goWviF1ckWlH6rWF8WuronK1HbT3QJmXgavDQ7ymIH70s6fmG4S69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644220; c=relaxed/simple;
	bh=2fgo+DfYW6hkb8u8dSOtf7+gmhcII4bUlVTgpcygRbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZs53l41/2ypuMu81ckoH52AwzbdyCbcpNP6738wd1yFr+DY2Nj/Z/TYp4wV8wcxW0VnaCBxc5XnPLj9ryffH2k4C6qzLxuUTdL31GkHCbG0RaiV+yc3PNZJb9d1y6IPUEtVELn8UlbzSXaZozaeCNrmVI7xbqVsQyvHfw7x2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ftFRl3nH; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ftFRl3nH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749644218; x=1781180218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4ji9po20KtVxaeun/VeETG8Hky3+gtaCUe9OwsWfc0=;
  b=ftFRl3nHGkMmMMGA7v/gX7WPNBMMKAEx8asCfi+Z9B/8WW3NJ7sfn2OF
   1v9BE5XL5otu6rJyMUtOli5XVNalb2zRYw+BMZRPUsJrYWl5WNsigM7zK
   sqERkvCrAixTX/JY4Bg5h15dSPGbO4mcicXyN32go0C/s6DtukOMc7PSm
   d27W0BIod/AGP9yLp3Jr5vKbln9ri5eYsppRP6IbDYrI7SQsnV2q+olmT
   EX+jV0a16Q7yY0+g4MopM9E9ejvwHI8YFsfSIUklS8WmIqFeE4j5U1NqY
   qZ0S/2VPduyjraMDZuSg85eCLu8CoJotmG0CA61dKaxfcXEnvZeJ3ujna
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="500409699"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:16:55 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:23515]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.131:2525] with esmtp (Farcaster)
 id 59df4382-3cb2-4f51-a171-145e622f87ad; Wed, 11 Jun 2025 12:16:54 +0000 (UTC)
X-Farcaster-Flow-ID: 59df4382-3cb2-4f51-a171-145e622f87ad
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 12:16:54 +0000
Received: from dev-dsk-abuehaze-1c-21d23c85.eu-west-1.amazon.com
 (10.13.244.41) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14; Wed, 11 Jun 2025 12:16:48 +0000
From: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
To:
CC: <abuehaze@amazon.com>, <stable@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>, Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu
	<shaoyi@amazon.com>, Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>
Subject: [PATCH] Revert "block: don't reorder requests in blk_add_rq_to_plug"
Date: Wed, 11 Jun 2025 12:14:54 +0000
Message-ID: <20250611121626.7252-1-abuehaze@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.

Commit <e70c301faece> ("block: don't reorder requests in
blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
list, this had significant impact on bio merging with requests exist on
the plug list. This impact has been reported in [1] and could easily be
reproducible using 4k randwrite fio benchmark on an NVME based SSD without
having any filesystem on the disk.

My benchmark is:

    fio --time_based --name=benchmark --size=50G --rw=randwrite \
	--runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
	--randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
	--verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
	--group_reporting

On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.

Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
--------------+---------------------+--------------------
6.15.1        |   362               |  2KiB
6.15.1+revert |   660 (+82%)        |  4KiB
--------------+---------------------+--------------------

I have run iostat while the fio benchmark was running and was able to
see that the I/O size seen on the disk is shown as 2KB without this revert
while it's 4KB with the revert. In the bad case the write bandwidth
is capped at around 362MiB/sec which almost 2KiB * 180K IOPS so we are
hitting the SSD Disk IOPS limit which is 180K. After the revert the I/O
size has been doubled to 4KiB hence the bandwidth has been almost doubled
as we no longer hit the Disk IOPS limit.

I have done some tracing using bpftrace & bcc and was able to conclude that
the reason behind the I/O size discrepancy with the revert is that this
fio benchmark is subimitting each 4k I/O as 2 contiguous 2KB bios.

In the good case each 2 bios are merged in a 4KB request that's then been
submitted to the disk while in the bad case 2K bios are submitted to the
disk without merging because blk_attempt_plug_merge() failed to merge
them as seen below.

**Without the revert**

[12:12:28]
r::blk_attempt_plug_merge():int:$retval
         COUNT      EVENT
         5618       $retval = 1
         176578     $retval = 0

**With the revert**

[12:11:43]
r::blk_attempt_plug_merge():int:$retval
        COUNT      EVENT
        146684     $retval = 0
        146686     $retval = 1

In blk_attempt_plug_merge() we are iterating ithrought the plug list
from head to tail looking for a request with which we can merge the
most recently submitted bio.

With commit <e70c301faece> ("block: don't reorder requests in
blk_add_rq_to_plug") the most recent request will be at the tail so
blk_attempt_plug_merge() will fail because it tries to merge bio with
the plug list head. In blk_attempt_plug_merge() we don't iterate across
the whole plug list because as we exit the loop once we fail merging in
blk_attempt_bio_merge().

In commit <bc490f81731> ("block: change plugging to use a singly linked
list") the plug list has been changed to single linked list so there's
no way to iterate the list from tail to head which is the only way to
mitigate the impact on bio merging if we want to keep commit <e70c301faece>
("block: don't reorder requests in blk_add_rq_to_plug").

Given that moving plug list to a single linked list was mainly for
performance reason then let's revert commit <e70c301faece> ("block: don't
reorder requests in blk_add_rq_to_plug") for now to mitigate the
reported performance regression.

[1] https://lore.kernel.org/lkml/202412122112.ca47bcec-lkp@intel.com/

Cc: stable@vger.kernel.org      # 6.12
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Hagar  Hemdan <hagarhem@amazon.com>
Reported-and-bisected-by: Shaoying Xu <shaoyi@amazon.com>
Signed-off-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
---
 block/blk-mq.c             | 4 ++--
 drivers/block/virtio_blk.c | 2 +-
 drivers/nvme/host/pci.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2697db59109..28965cac19fb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1394,7 +1394,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	 */
 	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
 		plug->has_elevator = true;
-	rq_list_add_tail(&plug->mq_list, rq);
+	rq_list_add_head(&plug->mq_list, rq);
 	plug->rq_count++;
 }
 
@@ -2846,7 +2846,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 			rq_list_add_tail(&requeue_list, rq);
 			continue;
 		}
-		list_add_tail(&rq->queuelist, &list);
+		list_add(&rq->queuelist, &list);
 		depth++;
 	} while (!rq_list_empty(&plug->mq_list));
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7cffea01d868..7992a171f905 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -513,7 +513,7 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
 		vq = this_vq;
 
 		if (virtblk_prep_rq_batch(req))
-			rq_list_add_tail(&submit_list, req);
+			rq_list_add_head(&submit_list, req); /* reverse order */
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f1dd804151b1..5f7da42f9dac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1026,7 +1026,7 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 		nvmeq = req->mq_hctx->driver_data;
 
 		if (nvme_prep_rq_batch(nvmeq, req))
-			rq_list_add_tail(&submit_list, req);
+			rq_list_add_head(&submit_list, req); /* reverse order */
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}
-- 
2.47.1

