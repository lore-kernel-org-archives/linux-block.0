Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ECEC34022
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 04:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727D324670
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 04:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgBSEYb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:24:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32959 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgBSEYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 23:24:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so12071143pgk.0
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2020 20:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X5+7NmxCA2sk1IPU3J3ebSnZtm/gDxEi287hZegmWtI=;
        b=UPHEo8oLazKAW+Q22GuAK9JxfnCATE8739+o3mmHxqeDaro5ifuiqirl3AZtaJ02bS
         P9bODMhESI5HW2tVLJpvwj4ioi3gU1GWmN4B7y+IlY59w1B499C/M79YKe4VMBBajZUY
         Sksswria+gCrACc1bUa/9Sc6+5nbnynOA9lGg/nnTfgT4nsdtWKUSNcTnMh3ugqDwWjc
         l6ZgUMqV3aL9/eR1VxkKo7jLEw8+Fkar1iacIMJPlIXAMK2Y0v+ih8CrYjkcyRkTo8y+
         Fhs+n6IH6ZT0ihLVqHzqU+nHqK4BINMtq6U5mMhKfh0yIqKKkTk8oa5E3gN4XirxFzGD
         1XTw==
X-Gm-Message-State: APjAAAXVl85vy/HKjoLSPxFI+3zDdvUOVmZb+qOzjkvjwZkphX4kdFZG
        ulo1Tw769npMg89VcZVEe4Vf8MWXUgE=
X-Google-Smtp-Source: APXvYqyZ64jaLj+CU8kWfoIA/6Dq9sBh3kOTJbQgY6vNvK53ZyFZHJ71hDlAltKDgvrs1J/5/WiGKg==
X-Received: by 2002:a63:4525:: with SMTP id s37mr25766678pga.418.1582086270414;
        Tue, 18 Feb 2020 20:24:30 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:ede5:c6f1:47ba:512c? ([2601:647:4000:d7:ede5:c6f1:47ba:512c])
        by smtp.gmail.com with ESMTPSA id a18sm607466pfl.138.2020.02.18.20.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 20:24:29 -0800 (PST)
Subject: Re: [PATCH 2/5] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
References: <20200217210839.28535-1-bvanassche@acm.org>
 <20200217210839.28535-3-bvanassche@acm.org>
 <20200218031643.GB30750@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <ebe274b1-a59b-ffd1-9331-66d07f7f2ba2@acm.org>
Date:   Tue, 18 Feb 2020 20:24:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218031643.GB30750@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-17 19:16, Ming Lei wrote:
> I guess the issue can be fixed by the following change, and we do not
> need to touch each queue map:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5f5c43ae3792..f7340afb89ec 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3046,6 +3046,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
>                 return set->ops->map_queues(set);
>         } else {
>                 BUG_ON(set->nr_maps > 1);
> +               set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
>                 return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
>         }
>  }

Every caller of blk_mq_map_queues() needs to set the number of queues
in the default queue map so I would like to make the number of queues an
argument. How about the (untested) patch below?

Thanks,

Bart.

---
 block/blk-mq-cpumap.c                 |  5 +++--
 block/blk-mq-rdma.c                   |  2 +-
 block/blk-mq-virtio.c                 |  2 +-
 block/blk-mq.c                        |  6 ++++--
 drivers/block/virtio_blk.c            |  5 +++--
 drivers/nvme/host/pci.c               |  2 +-
 drivers/nvme/host/rdma.c              |  5 ++---
 drivers/nvme/host/tcp.c               | 11 ++++++-----
 drivers/scsi/qla2xxx/qla_os.c         |  8 +++++---
 drivers/scsi/scsi_lib.c               |  3 ++-
 drivers/scsi/smartpqi/smartpqi_init.c |  5 +++--
 drivers/scsi/virtio_scsi.c            |  1 +
 include/linux/blk-mq.h                |  2 +-
 13 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 0157f2b3485a..4c0d5768305a 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -32,12 +32,13 @@ static int get_first_sibling(unsigned int cpu)
 	return cpu;
 }

-int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
+int blk_mq_map_queues(struct blk_mq_queue_map *qmap, unsigned int nr_queues)
 {
 	unsigned int *map = qmap->mq_map;
-	unsigned int nr_queues = qmap->nr_queues;
 	unsigned int cpu, first_sibling, q = 0;

+	qmap->nr_queues = nr_queues;
+
 	for_each_possible_cpu(cpu)
 		map[cpu] = -1;

diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 14f968e58b8f..c32af1231244 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -39,6 +39,6 @@ int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 	return 0;

 fallback:
-	return blk_mq_map_queues(map);
+	return blk_mq_map_queues(map, map->nr_queues);
 }
 EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 488341628256..b5911cb43974 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -41,6 +41,6 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,

 	return 0;
 fallback:
-	return blk_mq_map_queues(qmap);
+	return blk_mq_map_queues(qmap, qmap->nr_queues);
 }
 EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f298500e6dda..bbd9edde2b6f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3046,7 +3046,8 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		return set->ops->map_queues(set);
 	} else {
 		BUG_ON(set->nr_maps > 1);
-		return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+		return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT],
+					 set->nr_hw_queues);
 	}
 }

@@ -3339,7 +3340,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			pr_warn("Increasing nr_hw_queues to %d fails, fallback to %d\n",
 					nr_hw_queues, prev_nr_hw_queues);
 			set->nr_hw_queues = prev_nr_hw_queues;
-			blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+			blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT],
+					  set->nr_hw_queues);
 			goto fallback;
 		}
 		blk_mq_map_swqueue(q);
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 54158766334b..61d6482a0b9e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -595,9 +595,10 @@ static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
 static int virtblk_map_queues(struct blk_mq_tag_set *set)
 {
 	struct virtio_blk *vblk = set->driver_data;
+	struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];

-	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-					vblk->vdev, 0);
+	qmap->nr_queues = set->nr_hw_queues;
+	return blk_mq_virtio_map_queues(qmap, vblk->vdev, 0);
 }

 static const struct blk_mq_ops virtio_mq_ops = {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index da392b50f73e..7531a6950736 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -438,7 +438,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		if (i != HCTX_TYPE_POLL && offset)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
-			blk_mq_map_queues(map);
+			blk_mq_map_queues(map, map->nr_queues);
 		qoff += map->nr_queues;
 		offset += map->nr_queues;
 	}
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a47c6c5007e..27d00bc7a746 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1844,12 +1844,11 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)

 	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
 		/* map dedicated poll queues only if we have queues left */
-		set->map[HCTX_TYPE_POLL].nr_queues =
-				ctrl->io_queues[HCTX_TYPE_POLL];
 		set->map[HCTX_TYPE_POLL].queue_offset =
 			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
 			ctrl->io_queues[HCTX_TYPE_READ];
-		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
+		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL],
+				  ctrl->io_queues[HCTX_TYPE_POLL]);
 	}

 	dev_info(ctrl->ctrl.device,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6d43b23a0fc8..c05ca7dec661 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2192,17 +2192,18 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 			ctrl->io_queues[HCTX_TYPE_DEFAULT];
 		set->map[HCTX_TYPE_READ].queue_offset = 0;
 	}
-	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
-	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT],
+			  set->map[HCTX_TYPE_DEFAULT].nr_queues);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_READ],
+			  set->map[HCTX_TYPE_READ].nr_queues);

 	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
 		/* map dedicated poll queues only if we have queues left */
-		set->map[HCTX_TYPE_POLL].nr_queues =
-				ctrl->io_queues[HCTX_TYPE_POLL];
 		set->map[HCTX_TYPE_POLL].queue_offset =
 			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
 			ctrl->io_queues[HCTX_TYPE_READ];
-		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
+		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL],
+				  ctrl->io_queues[HCTX_TYPE_POLL]);
 	}

 	dev_info(ctrl->ctrl.device,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b520a980d1dc..71058bec7d98 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7114,10 +7114,12 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];

-	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
-		rc = blk_mq_map_queues(qmap);
-	else
+	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase) {
+		rc = blk_mq_map_queues(qmap, shost->tag_set.nr_hw_queues);
+	} else {
+		qmap->nr_queues = shost->tag_set.nr_hw_queues;
 		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
+	}
 	return rc;
 }

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 610ee41fa54c..45a4b115dadf 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1775,7 +1775,8 @@ static int scsi_map_queues(struct blk_mq_tag_set *set)

 	if (shost->hostt->map_queues)
 		return shost->hostt->map_queues(shost);
-	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT],
+				 set->nr_hw_queues);
 }

 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index b7492568e02f..18ae5ce129b2 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -5826,9 +5826,10 @@ static int pqi_slave_alloc(struct scsi_device *sdev)
 static int pqi_map_queues(struct Scsi_Host *shost)
 {
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];

-	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-					ctrl_info->pci_dev, 0);
+	qmap->nr_queues = shost->tag_set.nr_hw_queues;
+	return blk_mq_pci_map_queues(qmap, ctrl_info->pci_dev, 0);
 }

 static int pqi_getpciinfo_ioctl(struct pqi_ctrl_info *ctrl_info,
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bfec84aacd90..9b9da0409643 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -705,6 +705,7 @@ static int virtscsi_map_queues(struct Scsi_Host *shost)
 	struct virtio_scsi *vscsi = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];

+	qmap->nr_queues = shost->tag_set.nr_hw_queues;
 	return blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
 }

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 31344d5f83e2..c63b315ed0c8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -516,7 +516,7 @@ void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);

-int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+int blk_mq_map_queues(struct blk_mq_queue_map *qmap, unsigned int nr_queues);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);

 void blk_mq_quiesce_queue_nowait(struct request_queue *q);

