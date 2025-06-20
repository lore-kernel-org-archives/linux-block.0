Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE602222D2
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402039; cv=none; b=Ovvi/mPPTnB4Zxebf/CbrHIDlZHW1hnuYx8MTm5uG1LwFuSxXZZW3U7eNhG7j8xOb2GNSh6S04sqGLjuN2KLwdv1CB/E+341irtC+inC4RXXoN5+99peJwjLmberGgscQ+RGbNzRzddv5ce7VromuRBI4gkf6VV2u9wxma1NPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402039; c=relaxed/simple;
	bh=bbignwNhkLSQ2rQHCc2aXDm64cVVqcDFNeFb17RUf5k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tdhZBM1jpGxkvp8iisaEszjVEO6t2qsezYz0oCEyUv027GXJa2A2Sy+nAgVmaDdQLJH5syiqPb6rdrrbrCodZjWsADrtI4gLe0YNi6kErwdrw3SM01U9OMapL3q6OYIotg5EerLc8xC4DQxMQ26e2BnV91CVnfnRcQYs3fxIrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bNp1Z0v5WzKHMh1
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 14:47:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 787FE1A018D
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 14:47:12 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2DuA1Vo8IpTQA--.6271S3;
	Fri, 20 Jun 2025 14:47:12 +0800 (CST)
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Calvin Owens <calvin@wbinvd.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
 <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
Date: Fri, 20 Jun 2025 14:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2DuA1Vo8IpTQA--.6271S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45tF1kXw43Xr47WF4rKrg_yoWrJFy8pr
	WUua9IkrZrWrn5Xr4kJan3Zr18ta1YkryxZrZ8CF1avFsrKrs2qFy0va1FqrySvFZ7CrW8
	W3WYkFZrZw4q937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/20 12:10, Calvin Owens 写道:
> I dumped all the similar WARNs I've seen here (blk-warn-%d.txt):
> 
>      https://github.com/jcalvinowens/lkml-debug-616/tree/master

These reports also contain both request-based and bio-based disk, I
think perhaps following concurrent scenario is possible:

While bdev_count_inflight is interating all cpu, some IOs are issued
from traversed cpu and then completed from the cpu that is not traversed
yet.

cpu0
		cpu1
		bdev_count_inflight
		 //for_each_possible_cpu
		 // cpu0 is 0
		 infliht += 0
// issue a io
blk_account_io_start
// cpu0 inflight ++

				cpu2
				// the io is done
				blk_account_io_done
				// cpu2 inflight --
		 // cpu 1 is 0
		 inflight += 0
		 // cpu2 is -1
		 inflight += -1
		 ...

In this case, the total inflight will be -1.

Yi and Calvin,

Can you please help testing the following patch, it add a WARN_ON_ONCE()
using atomic operations, if the new warning is not reporduced while
the old warning is reporduced, I think it can be confirmed the above
analyze is correct, and I will send a revert for the WARN_ON_ONCE()
change in bdev_count_inflight().

Thanks,
Kuai

diff --git a/block/blk-core.c b/block/blk-core.c
index b862c66018f2..2b033caa74e8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1035,6 +1035,8 @@ unsigned long bdev_start_io_acct(struct 
block_device *bdev, enum req_op op,
         part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
         part_stat_unlock();

+       atomic_inc(&bdev->inflight[op_is_write(op)]);
+
         return start_time;
  }
  EXPORT_SYMBOL(bdev_start_io_acct);
@@ -1065,6 +1067,8 @@ void bdev_end_io_acct(struct block_device *bdev, 
enum req_op op,
         part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
         part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
         part_stat_unlock();
+
+       WARN_ON_ONCE(atomic_dec_return(&bdev->inflight[op_is_write(op)]) 
< 0);
  }
  EXPORT_SYMBOL(bdev_end_io_acct);

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..ff15276d277f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -658,6 +658,8 @@ static void blk_account_io_merge_request(struct 
request *req)
                 part_stat_local_dec(req->part,
                                     in_flight[op_is_write(req_op(req))]);
                 part_stat_unlock();
+
+ 
WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(req))]) 
< 0);
         }
  }

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..94e728ff8bb6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1056,6 +1056,8 @@ static inline void blk_account_io_done(struct 
request *req, u64 now)
                 part_stat_local_dec(req->part,
                                     in_flight[op_is_write(req_op(req))]);
                 part_stat_unlock();
+
+ 
WARN_ON_ONCE(atomic_dec_return(&req->part->inflight[op_is_write(req_op(req))]) 
< 0);
         }
  }

@@ -1116,6 +1118,8 @@ static inline void blk_account_io_start(struct 
request *req)
         update_io_ticks(req->part, jiffies, false);
         part_stat_local_inc(req->part, 
in_flight[op_is_write(req_op(req))]);
         part_stat_unlock();
+
+       atomic_inc(&req->part->inflight[op_is_write(req_op(req))]);
  }

  static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c..a81110c07426 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -43,6 +43,7 @@ struct block_device {
         sector_t                bd_nr_sectors;
         struct gendisk *        bd_disk;
         struct request_queue *  bd_queue;
+       atomic_t                inflight[2];
         struct disk_stats __percpu *bd_stats;
         unsigned long           bd_stamp;
         atomic_t                __bd_flags;     // partition number + flags

