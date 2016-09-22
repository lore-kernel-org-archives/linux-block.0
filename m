Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbcIVKGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2016 06:06:55 -0400
Subject: Re: [Query] increased latency observed in cpu hotplug path
To: Akinobu Mita <akinobu.mita@gmail.com>
References: <CAC5umyj04kkoufz3me17Xqk_b-eqxPqocJHmRAKr+UkBawV+xQ@mail.gmail.com>
 <34042993-30f9-81e0-622d-9cd4283624b4@codeaurora.org>
 <65516437-cf7a-4728-50d1-6d3c4b5a9adc@codeaurora.org>
 <faa0cfa9-46e5-f580-654c-5ec7dcc8f977@codeaurora.org>
 <7364b95c-a2ef-4c5c-d593-9cdd4501bcc4@codeaurora.org>
 <CAC5umygHWDE4t77o29XdVgqNrurHgy+JwpFuc2RDUn2uLRXPTg@mail.gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        tsoni@codeaurora.org, kaushalk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: "Khan, Imran" <kimran@codeaurora.org>
Message-ID: <e3775a70-6c07-b661-7121-db1ab380d71f@codeaurora.org>
Date: Thu, 22 Sep 2016 15:36:47 +0530
MIME-Version: 1.0
In-Reply-To: <CAC5umygHWDE4t77o29XdVgqNrurHgy+JwpFuc2RDUn2uLRXPTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 9/21/2016 9:26 PM, Akinobu Mita wrote:
> 2016-09-21 23:06 GMT+09:00 Khan, Imran <kimran@codeaurora.org>:
> 
>>>> commit 084ee793ec1ff4e2171b481642bfbdaa2e10664c
>>>> Author: Imran Khan <kimran@codeaurora.org>
>>>> Date:   Thu Sep 15 16:44:02 2016 +0530
>>>>
>>>>     blk-mq: use static mapping
>>>>
>>>>     blk-mq layer performs a remapping between s/w and h/w contexts and also
>>>>     between h/w contexts and CPUs, whenever a CPU hotplug event happens.
>>>>     This remapping has to wait for queue freezing which may take tens of
>>>>     miliseconds, resulting in a high latency in CPU hotplug path.
>>>>     This patch makes the above mentioned mappings static so that we can
>>>>     avoid remapping when CPU hotplug event happens and this results in
>>>>     improved CPU hotplug latency.
>>>>
>>>>     Change-Id: Idf38cb6c4e78c91fda3c86608c6d0441f01ab435
>>>>     Signed-off-by: Imran Khan <kimran@codeaurora.org>
>>>>
>>>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
>>>> index 8764c24..85fdb88 100644
>>>> --- a/block/blk-mq-cpumap.c
>>>> +++ b/block/blk-mq-cpumap.c
>>>> @@ -52,18 +52,13 @@ int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
>>>>
>>>>      queue = 0;
>>>>      for_each_possible_cpu(i) {
>>>> -            if (!cpumask_test_cpu(i, online_mask)) {
>>>> -                    map[i] = 0;
>>>> -                    continue;
>>>> -            }
>>>> -
>>>>              /*
>>>>               * Easy case - we have equal or more hardware queues. Or
>>>>               * there are no thread siblings to take into account. Do
>>>>               * 1:1 if enough, or sequential mapping if less.
>>>>               */
>>>> -            if (nr_queues >= nr_cpus || nr_cpus == nr_uniq_cpus) {
>>>> -                    map[i] = cpu_to_queue_index(nr_cpus, nr_queues, queue);
>>>> +            if (nr_queues >= nr_cpu_ids) {
>>>> +                    map[i] = cpu_to_queue_index(nr_cpu_ids, nr_queues, queue);
>>>>                      queue++;
>>>>                      continue;
>>>>              }
>>>> @@ -75,7 +70,7 @@ int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
>>>>               */
>>>>              first_sibling = get_first_sibling(i);
>>>>              if (first_sibling == i) {
>>>> -                    map[i] = cpu_to_queue_index(nr_uniq_cpus, nr_queues,
>>>> +                    map[i] = cpu_to_queue_index(nr_cpu_ids, nr_queues,
>>>>                                                      queue);
>>>>                      queue++;
>>>>              } else
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 6d6f8fe..0753fdf 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -1783,10 +1783,6 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>>>>              INIT_LIST_HEAD(&__ctx->rq_list);
>>>>              __ctx->queue = q;
>>>>
>>>> -            /* If the cpu isn't online, the cpu is mapped to first hctx */
>>>> -            if (!cpu_online(i))
>>>> -                    continue;
>>>> -
>>>>              hctx = q->mq_ops->map_queue(q, i);
>>>>
>>>>              /*
>>>> @@ -1820,12 +1816,9 @@ static void blk_mq_map_swqueue(struct request_queue *q,
>>>>       * Map software to hardware queues
>>>>       */
>>>>      queue_for_each_ctx(q, ctx, i) {
>>>> -            /* If the cpu isn't online, the cpu is mapped to first hctx */
>>>> -            if (!cpumask_test_cpu(i, online_mask))
>>>> -                    continue;
>>>> -
>>>>              hctx = q->mq_ops->map_queue(q, i);
>>>> -            cpumask_set_cpu(i, hctx->cpumask);
>>>> +            if (cpumask_test_cpu(i, online_mask))
>>>> +                    cpumask_set_cpu(i, hctx->cpumask);
>>>>              ctx->index_hw = hctx->nr_ctx;
>>>>              hctx->ctxs[hctx->nr_ctx++] = ctx;
>>>>      }
>>>> @@ -1863,17 +1856,22 @@ static void blk_mq_map_swqueue(struct request_queue *q,
>>>>
>>>>              /*
>>>>               * Initialize batch roundrobin counts
>>>> +             * Set next_cpu for only those hctxs that have an online CPU
>>>> +             * in their cpumask field. For hctxs that belong to few online
>>>> +             * and few offline CPUs, this will always provide one CPU from
>>>> +             * online ones. For hctxs belonging to all offline CPUs, their
>>>> +             * cpumask will be updated in reinit_notify.
>>>>               */
>>>> -            hctx->next_cpu = cpumask_first(hctx->cpumask);
>>>> -            hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>>>> +            if(cpumask_first(hctx->cpumask) < nr_cpu_ids) {
>>>> +                    hctx->next_cpu = cpumask_first(hctx->cpumask);
>>>> +                    hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>>>> +            }
>>>>      }
>>>>
>>>>      queue_for_each_ctx(q, ctx, i) {
>>>> -            if (!cpumask_test_cpu(i, online_mask))
>>>> -                    continue;
>>>> -
>>>>              hctx = q->mq_ops->map_queue(q, i);
>>>> -            cpumask_set_cpu(i, hctx->tags->cpumask);
>>>> +            if (cpumask_test_cpu(i, online_mask))
>>>> +                    cpumask_set_cpu(i, hctx->tags->cpumask);
>>>>      }
>>>>  }
>>>>
>>>> @@ -2101,31 +2099,12 @@ void blk_mq_free_queue(struct request_queue *q)
>>>>      blk_mq_free_hw_queues(q, set);
>>>>  }
>>>>
>>>> -/* Basically redo blk_mq_init_queue with queue frozen */
>>>> -static void blk_mq_queue_reinit(struct request_queue *q,
>>>> -                            const struct cpumask *online_mask)
>>>> -{
>>>> -    WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
>>>> -
>>>> -    blk_mq_sysfs_unregister(q);
>>>> -
>>>> -    blk_mq_update_queue_map(q->mq_map, q->nr_hw_queues, online_mask);
> 
> Now blk_mq_update_queue_map() is only used in block/blk-mq-cpumap.c,
> so you can make blk_mq_update_queue_map() static function.
> 
>>>> -
>>>> -    /*
>>>> -     * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
>>>> -     * we should change hctx numa_node according to new topology (this
>>>> -     * involves free and re-allocate memory, worthy doing?)
>>>> -     */
>>>> -
>>>> -    blk_mq_map_swqueue(q, online_mask);
>>>> -
>>>> -    blk_mq_sysfs_register(q);
>>>> -}
>>>> -
>>>>  static int blk_mq_queue_reinit_notify(struct notifier_block *nb,
>>>>                                    unsigned long action, void *hcpu)
>>>>  {
>>>>      struct request_queue *q;
>>>> +    struct blk_mq_hw_ctx *hctx;
>>>> +    int i;
>>>>      int cpu = (unsigned long)hcpu;
>>>>      /*
>>>>       * New online cpumask which is going to be set in this hotplug event.
>>>> @@ -2155,43 +2134,29 @@ static int blk_mq_queue_reinit_notify(struct notifier_block *nb,
>>>>      case CPU_DEAD:
>>>>      case CPU_UP_CANCELED:
>>>>              cpumask_copy(&online_new, cpu_online_mask);
>>>> +            list_for_each_entry(q, &all_q_list, all_q_node) {
>>>> +                    queue_for_each_hw_ctx(q, hctx, i) {
>>>> +                            cpumask_clear_cpu(cpu, hctx->cpumask);
>>>> +                            cpumask_clear_cpu(cpu, hctx->tags->cpumask);
>>>> +                    }
>>>> +            }
> 
> Do we need to hold all_q_mutex while iterating through all_q_list?
> 
Yes, we need to hold all_q_mutex here.
>>>>              break;
>>>>      case CPU_UP_PREPARE:
>>>>              cpumask_copy(&online_new, cpu_online_mask);
>>>>              cpumask_set_cpu(cpu, &online_new);
>>>> +            /* Update hctx->cpumask for newly onlined CPUs */
>>>> +            list_for_each_entry(q, &all_q_list, all_q_node) {
>>>> +                    queue_for_each_hw_ctx(q, hctx, i) {
>>>> +                            cpumask_set_cpu(cpu, hctx->cpumask);
>>>> +                            hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>>>> +                            cpumask_set_cpu(cpu, hctx->tags->cpumask);
>>>> +                    }
>>>> +            }
>>>>              break;
>>>>      default:
>>>>              return NOTIFY_OK;
>>>>      }
>>>>
>>>> -    mutex_lock(&all_q_mutex);
>>>> -
>>>> -    /*
>>>> -     * We need to freeze and reinit all existing queues.  Freezing
>>>> -     * involves synchronous wait for an RCU grace period and doing it
>>>> -     * one by one may take a long time.  Start freezing all queues in
>>>> -     * one swoop and then wait for the completions so that freezing can
>>>> -     * take place in parallel.
>>>> -     */
>>>> -    list_for_each_entry(q, &all_q_list, all_q_node)
>>>> -            blk_mq_freeze_queue_start(q);
>>>> -    list_for_each_entry(q, &all_q_list, all_q_node) {
>>>> -            blk_mq_freeze_queue_wait(q);
>>>> -
>>>> -            /*
>>>> -             * timeout handler can't touch hw queue during the
>>>> -             * reinitialization
>>>> -             */
>>>> -            del_timer_sync(&q->timeout);
>>>> -    }
>>>> -
>>>> -    list_for_each_entry(q, &all_q_list, all_q_node)
>>>> -            blk_mq_queue_reinit(q, &online_new);
>>>> -
>>>> -    list_for_each_entry(q, &all_q_list, all_q_node)
>>>> -            blk_mq_unfreeze_queue(q);
>>>> -
>>>> -    mutex_unlock(&all_q_mutex);
> 
> This change makes 'online_new' cpumask useless in blk_mq_queue_reinit_notify(),
> so you can remove it completely.
> 

Will remove this in the new patch set.
Thanks for the review comments. I will take into account the review comments and
send a new patch set.

>>>>      return NOTIFY_OK;
>>>>  }
>>>>
>>>>
>>>>
>>>>
>>> With the patch I have collected some numbers, running some android monkey tests along with
>>> an app that does random hootplugging of CPUs. The numbers obtained are as below:
>>>
>>> CPU UP time(in micro seconds):
>>>          default blk-mq: 58629 54207 61792 58458 59286
>>> blk-mq with above patch: 2755  2588  3412  3239  3010
>>>
>>> CPU DOWN time(in micros seconds):
>>>          default blk-mq: 95990  103379 103686 93214  128274
>>> blk-mq with above patch: 67178  49876  70027  61261  59656
>>>
>> Could someone please review the patch and provide some feedback?
>> Even if the feedback is about the approach we are trying here or some
>> suggestions to move ahead in that direction.
>>>>>> Did you tried Tejun's percpu_ref patchset that I said in the last email?
>>>>>> (http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg984823.html)
>>>>>>
>>>>>>
>>>>> I have tried the suggested patch but did not see any improvements in cpu
>>>>> hotplug latencies
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>> --
>> Imran Khan
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a\nmember of the Code Aurora Forum, hosted by The Linux Foundation


-- 
Imran Khan
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a\nmember of the Code Aurora Forum, hosted by The Linux Foundation
