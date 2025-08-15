Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78935277011
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250470; cv=none; b=Cckt6Xn41ToeIwwouXt9W/qT2T5uZ5iIxWTWF6uGpZFaiEd/mfQlG31fzP+ljGqRtqgODkjpFcTkn5KzBN6BNfT0knUZqxw2FTBa/Xl2zIhyHkqP0NBuq8JLnVtBq2eCM8oQZ8CjA0oVAtFznSvbaRx7eaqfuyPspmwOVXaYwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250470; c=relaxed/simple;
	bh=qB30o0p/0+0vIjcnLNttkm1dHkh1sfCn9dYeReakqOQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZDsG0QXxuFy5kVYXdq6Ta/WUI1tCK7DbGeZg5vZMQp8XVP/HhmjhPw06SCkwnrbBH6hYXcwOb7aDlwhdgP5TSrdeFhGyfO3I3p6AFT41JwdRwPETQIHhhi5dIeZPK2WECrJfZla2THB8q9SAWZIEAqcivCRO8eQtpb2Zympbb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3H4f0DCxzKHMdt
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 17:34:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 572E11A07BB
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 17:34:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxQf_55oMs4FDw--.37685S3;
	Fri, 15 Aug 2025 17:34:25 +0800 (CST)
Subject: Re: [PATCH] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
To: Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250815075636.304660-1-ming.lei@redhat.com>
 <ff5639d3-9a63-e26c-a062-cb8a23c0ed5d@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b4183646-a5cf-1f29-5451-c63fdda7c490@huaweicloud.com>
Date: Fri, 15 Aug 2025 17:34:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ff5639d3-9a63-e26c-a062-cb8a23c0ed5d@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxQf_55oMs4FDw--.37685S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7uryrKryfAFykur1Dtrb_yoW8tFWkpr
	W5Ga9Fkwn2qr48Xa1UAa17W34DGwn2gr43Xrs7AryYkF1IgFZ7Xw18CF17ZF48KrZ3AFsI
	vay8tFW8AFyUXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUejjgDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/15 17:15, Yu Kuai Ð´µÀ:
> Will it be simpler if we move blk_mq_freeze_queue_nomemsave() into
> blk_mq_elv_switch_none(), after elevator is succeed switching to none
> then freeze the queue.
> 
> Later in blk_mq_elv_switch_back we'll know if xa_load() return valid
> elevator_type, related queue is already freezed.

Like following:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9f037a25fe3..3640fae5707b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5010,7 +5010,13 @@ static int blk_mq_elv_switch_none(struct 
request_queue *q,
                 __elevator_get(q->elevator->type);

                 elevator_set_none(q);
+       } else {
+               ret = xa_insert(elv_tbl, q->id, xa_mk_value(1), GFP_KERNEL);
+               if (WARN_ON_ONCE(ret))
+                       return ret;
         }
+
+       blk_mq_freeze_queue_nomemsave(q);
         return ret;
  }

@@ -5045,9 +5051,6 @@ static void __blk_mq_update_nr_hw_queues(struct 
blk_mq_tag_set *set,
                 blk_mq_sysfs_unregister_hctxs(q);
         }

-       list_for_each_entry(q, &set->tag_list, tag_set_list)
-               blk_mq_freeze_queue_nomemsave(q);
-
         /*
          * Switch IO scheduler to 'none', cleaning up the data associated
          * with the previous scheduler. We will switch back once we are 
done
diff --git a/block/elevator.c b/block/elevator.c
index e2ebfbf107b3..9400ea9ec024 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -715,16 +715,21 @@ void elv_update_nr_hw_queues(struct request_queue 
*q, struct elevator_type *e,

         WARN_ON_ONCE(q->mq_freeze_depth == 0);

-       if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
-               ctx.name = e->elevator_name;
-               ctx.et = t;
-
-               mutex_lock(&q->elevator_lock);
-               /* force to reattach elevator after nr_hw_queue is 
updated */
-               ret = elevator_switch(q, &ctx);
-               mutex_unlock(&q->elevator_lock);
+       if (e) {
+               if (!xa_is_value(e) && !blk_queue_dying(q) &&
+                   blk_queue_registered(q)) {
+                       ctx.name = e->elevator_name;
+                       ctx.et = t;
+
+                       mutex_lock(&q->elevator_lock);
+                       /* force to reattach elevator after nr_hw_queue 
is updated */
+                       ret = elevator_switch(q, &ctx);
+                       mutex_unlock(&q->elevator_lock);
+               }
+
+               blk_mq_unfreeze_queue_nomemrestore(q);
         }
-       blk_mq_unfreeze_queue_nomemrestore(q);
+
         if (!ret)
                 WARN_ON_ONCE(elevator_change_done(q, &ctx));
         /*

