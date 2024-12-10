Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0411863E;
	Tue, 10 Dec 2024 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795413; cv=none; b=GlpaBkbrMj9urD2MjlnIjle/LbvJcM2opAOZeecucnM8sqLggT5S+8HP66CX3GuDjob+Yk36IOQWzCsZCLDsjdW13KahAw48sHKxvhlEdDBF+AbClhfvmh6+77k7sUbtvmBtaB3oDqi+LiDrBda+Y9w7i26I57gdEiLbhPER48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795413; c=relaxed/simple;
	bh=seff3xHAWroiHiG59IU/R+uWJCXG6BxNtXbPtWfqUPA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kakLE18QafScx14RwadXL2J6ajFOiVSTDk+mYXz7w4zkHH6Uvh9r55wHPSndQfbzeCx0A+pX3dqUuzh/RpKKnWwnrnJbKT8+M2fQ5kY2DhG58kaM0Ea+ONgEnBfO8iYQnGgSAYO7FgsqbYpe6R31MyhTHZRT2LNOsQyml16EP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6hW41MR7z4f3jks;
	Tue, 10 Dec 2024 09:49:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 60BA71A058E;
	Tue, 10 Dec 2024 09:50:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDnwoZMnldnu5alEA--.59586S3;
	Tue, 10 Dec 2024 09:50:06 +0800 (CST)
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 ming.lei@redhat.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com>
 <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6e384b29-50d2-64bd-0d08-fc0f086c1cbd@huaweicloud.com>
Date: Tue, 10 Dec 2024 09:50:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnwoZMnldnu5alEA--.59586S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4Utry3tw4rKryDKF4fAFb_yoW5Jw17pF
	45t3ZrKr10qF4kWFWjy3y3Zr1xWws8WryfGFyft393CF1Fvan3JF1FgF13WFZ3JrZxCw42
	kr4qqa97Ar98tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/10 2:02, Bart Van Assche 写道:
> This is not correct. dd->async_depth can be modified via sysfs.

How about the following patch to fix min_shallow_depth for deadline?

Thanks,
Kuai

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a9cf8e19f9d1..040ebb0b192d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -667,8 +667,7 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
         struct blk_mq_tags *tags = hctx->sched_tags;

         dd->async_depth = q->nr_requests;
-
-       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
+       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 
dd->async_depth);
  }

  /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
@@ -1012,6 +1011,47 @@ SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
  #undef SHOW_INT
  #undef SHOW_JIFFIES

+static ssize_t deadline_async_depth_store(struct elevator_queue *e,
+                                         const char *page, size_t count)
+{
+       struct deadline_data *dd = e->elevator_data;
+       struct request_queue *q = dd->q;
+       struct blk_mq_hw_ctx *hctx;
+       unsigned long i;
+       int v;
+       int ret = kstrtoint(page, 0, &v);
+
+       if (ret < 0)
+               return ret;
+
+       if (v < 1)
+               v = 1;
+       else if (v > dd->q->nr_requests)
+               v = dd->q->nr_requests;
+
+       if (v == dd->async_depth)
+               return count;
+
+       blk_mq_freeze_queue(q);
+       blk_mq_quiesce_queue(q);
+
+       dd->async_depth = v;
+       if (blk_mq_is_shared_tags(q->tag_set->flags)) {
+               sbitmap_queue_min_shallow_depth(
+                       &q->sched_shared_tags->bitmap_tags, 
dd->async_depth);
+       } else {
+               queue_for_each_hw_ctx(q, hctx, i)
+                       sbitmap_queue_min_shallow_depth(
+                               &hctx->sched_tags->bitmap_tags,
+                               dd->async_depth);
+       }
+
+       blk_mq_unquiesce_queue(q);
+       blk_mq_unfreeze_queue(q);
+
+       return count;
+}
+
  #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV) 
         \
  static ssize_t __FUNC(struct elevator_queue *e, const char *page, 
size_t count)        \
  {                                                                      \
@@ -1037,7 +1077,6 @@ STORE_JIFFIES(deadline_write_expire_store, 
&dd->fifo_expire[DD_WRITE], 0, INT_MA
  STORE_JIFFIES(deadline_prio_aging_expire_store, 
&dd->prio_aging_expire, 0, INT_MAX);
  STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, 
INT_MAX);
  STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
-STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
  STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
  #undef STORE_FUNCTION
  #undef STORE_INT

