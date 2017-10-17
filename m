Return-Path: <chenxiang66@hisilicon.com>
To: <hch@infradead.org>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: [bug report] A race between blk_cleanup_queue and blk_timeout_work
Message-ID: <d96fa515-32cb-8064-93e3-ff405b1923f5@hisilicon.com>
Date: Tue, 17 Oct 2017 09:55:58 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Jens, Christoph,

There is a scenario: unplug this disks when running IO in disk, we will 
find IO is blocked all the times as follows:
......
Jobs: 3 (f=3): [M_MM__] [89.7% done] [0K/0K /s] [0 /0  iops] [eta 00m:36s]
......
I find there is a race between blk_cleanup_queue and blk_timeout_work 
(kernel is 4.14.0-rc1):
(1)Remove disks process
When unplug disk, it will call scsi_remove_target to delete disk:
scsi_remove_target------>
      __scsi_remove_target---->
         scsi_remove_device--->
             __scsi_remove_device--->
                 blk_cleanup_queue
                     blk_freeze_queue
                     .....
                     __blk_drain_queue
scsi_remove_target will call blk_cleanup_queue, and blk_cleanup_queue 
will call blk_freeze_queue and __blk_drain_queue.
In blk_freeze_queue, for !blk_mq (our driver satifies this) it will kill 
q->q_usage_counter.
In __blk_drain_queue, it is a loop with condition=true, only when 
drain=0 can this function will be existed.If all the IOs
are ended, it will be existed, or it will wait and query no-finished IOs 
every 10ms.
(2) Timeout process
For every IO from block layer,if timeout, it will call blk_timeout_work. 
In blk_timeout_work, it checks blk_queue_enter first.
In blk_queue_enter, it trys to get q->q_usage_counter, so if failed, it 
will return directly and will not enter timeout process.

So when unplug disk, removing disk process will kill q->q_usage_counter 
in blk_cleanup_queue, if there are IOs which are not finished,
they will wait for timeout, when timeout, they will try to get 
q->q_usage_counter in blk_timeout_work, as q->q_usage_counter is killed
in blk_freeze_queue already at that time, so it failed, it will not 
enter timeout process and this IO will be not processed.
But in __blk_drain_queue it will loop forever as there are IOs which are 
still not ended.

I add printk in function blk_timeout_work as follows, . when this issue 
occurs, i can see this printk happens:

void blk_timeout_work(struct work_struct *work)
{
         struct request_queue *q =
                 container_of(work, struct request_queue, timeout_work);
         unsigned long flags, next = 0;
         struct request *rq, *tmp;
         int next_set = 0;

         if (blk_queue_enter(q, true)) {
                 pr_err("%s %d\n", __func__, 
__LINE__);---------------------> i add printk here
                 return;
         }

         spin_lock_irqsave(q->queue_lock, flags);


         list_for_each_entry_safe(rq, tmp, &q->timeout_list, timeout_list)
                 blk_rq_check_expired(rq, &next, &next_set);

         if (next_set)
                 mod_timer(&q->timeout, round_jiffies_up(next));

         spin_unlock_irqrestore(q->queue_lock, flags);

         blk_queue_exit(q);
}


regards,
shawn
