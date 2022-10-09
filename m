Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD43C433FE
	for <linux-block@archiver.kernel.org>; Sun,  9 Oct 2022 06:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJIGOP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Oct 2022 02:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJIGOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Oct 2022 02:14:14 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613E2FC2D;
        Sat,  8 Oct 2022 23:14:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MlWsR6RgGzKDcs;
        Sun,  9 Oct 2022 14:11:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnJ4etZkJjBhoCCA--.24524S3;
        Sun, 09 Oct 2022 14:14:07 +0800 (CST)
Subject: Re: [LKP] Re: [blk] 8c5035dfbb: fio.read_iops -10.6% regression
To:     Yin Fengwei <fengwei.yin@intel.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <202210081045.77ddf59b-yujie.liu@intel.com>
 <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
 <de2cc259-727a-3707-6738-1c5ab41075a2@intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e6d191e7-eda6-2511-1764-221b6f868cc8@huaweicloud.com>
Date:   Sun, 9 Oct 2022 14:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <de2cc259-727a-3707-6738-1c5ab41075a2@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnJ4etZkJjBhoCCA--.24524S3
X-Coremail-Antispam: 1UD129KBjvJXoWfGw15WrW5ZryUJFy7ZrWfAFb_yoWkJw4fpr
        n3tFyxJry5Gr1kJr1jyr1UJryUGr1UJ3WUJry8GF18JrWjyF1jgr4UXryqgryDJrW8Ar1U
        Jr15Gr1UZr1UJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2022/10/09 13:47, Yin Fengwei 写道:
> Hi Kuai,
> 
> On 10/8/22 16:00, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/10/08 10:50, kernel test robot 写道:
>>> Greeting,
>>>
>>> FYI, we noticed a -10.6% regression of fio.read_iops due to commit:
>>
>> I don't know how this is working but I'm *sure* this commit won't affect
>> performance. Please take a look at the commit, only wbt initialization
>> is touched, which is done while creating the device:
>>
>> device_add_disk
>>   blk_register_queue
>>    wbt_enable_default
>>     wbt_init
>>
>> And io path is the same with or without this commit.
>>
>> By the way, wbt should only work for write.
> Some information here:
> It looks like the line
>      wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
> matters.
> 
> If move only this line to original position based on 8c5035dfbb,
> the regression is gone.
> 
> If move only this line before ret = rq_qos_add() (just like your patch
> did, but only with this line) based on 8c5035dfbb, the regression can
> be reproduced.
> 

Thanks for the information, but I still don't understand if there is any
difference after wbt_init() is done, and how does read is afftected by
wbt. 🙁
> 
> Regards
> Yin, Fengwei
> 
>>
>> Thanks,
>> Kuai
>>>
>>> commit: 8c5035dfbb9475b67c82b3fdb7351236525bf52b ("blk-wbt: call rq_qos_add() after wb_normal is initialized")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: fio-basic
>>> on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 192G memory
>>> with following parameters:
>>>
>>>      runtime: 300s
>>>      nr_task: 8t
>>>      disk: 1SSD
>>>      fs: btrfs
>>>      rw: randread
>>>      bs: 2M
>>>      ioengine: sync
>>>      test_size: 256g
>>>      cpufreq_governor: performance
>>>
>>> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
>>> test-url: https://github.com/axboe/fio
>>>
>>>
>>> Details are as below:
>>>
>>> =========================================================================================
>>> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
>>>     2M/gcc-11/performance/1SSD/btrfs/sync/x86_64-rhel-8.3/8t/debian-11.1-x86_64-20220510.cgz/300s/randread/lkp-csl-2ap4/256g/fio-basic
>>>
>>> commit:
>>>     f7de4886fe ("rnbd-srv: remove struct rnbd_dev")
>>>     8c5035dfbb ("blk-wbt: call rq_qos_add() after wb_normal is initialized")
>>>
>>> f7de4886fe8f008a 8c5035dfbb9475b67c82b3fdb73
>>> ---------------- ---------------------------
>>>            %stddev     %change         %stddev
>>>                \          |                \
>>>         0.03 ±106%      +0.2        0.22 ± 80%  fio.latency_20ms%
>>>         0.02 ± 33%      -0.0        0.01 ± 12%  fio.latency_4ms%
>>>         2508           -10.6%       2243        fio.read_bw_MBps
>>>      6717440           +17.6%    7897088        fio.read_clat_90%_us
>>>      6892202           +19.0%    8202922        fio.read_clat_95%_us
>>>      7602176 ±  4%     +18.4%    9000277 ±  3%  fio.read_clat_99%_us
>>>      6374238           +11.8%    7127450        fio.read_clat_mean_us
>>>       363825 ± 10%     +74.9%     636378 ±  5%  fio.read_clat_stddev
>>>         1254           -10.6%       1121        fio.read_iops
>>>       104.97           +11.8%     117.32        fio.time.elapsed_time
>>>       104.97           +11.8%     117.32        fio.time.elapsed_time.max
>>>        13731            +5.6%      14498 ±  4%  fio.time.maximum_resident_set_size
>>>       116.00            -8.2%     106.50        fio.time.percent_of_cpu_this_job_got
>>>    1.998e+10           +11.4%  2.226e+10        cpuidle..time
>>>         3.27 ±  3%      +4.6%       3.42        iostat.cpu.iowait
>>>         4.49 ± 68%      -2.1        2.38 ±152%  perf-profile.children.cycles-pp.number
>>>         4.49 ± 68%      -2.5        1.98 ±175%  perf-profile.self.cycles-pp.number
>>>       557763            +5.4%     587781        proc-vmstat.pgfault
>>>        25488            +3.1%      26274        proc-vmstat.pgreuse
>>>      2459048           -10.1%    2209482        vmstat.io.bi
>>>       184649 ±  5%     -10.4%     165526 ±  7%  vmstat.system.cs
>>>       111733 ± 30%     +61.8%     180770 ± 21%  numa-meminfo.node0.AnonPages
>>>       113221 ± 30%     +60.2%     181416 ± 21%  numa-meminfo.node0.Inactive(anon)
>>>        11301 ± 24%    +164.5%      29888 ±117%  numa-meminfo.node2.Active(file)
>>>       104911 ± 39%     -80.5%      20456 ±100%  numa-meminfo.node3.AnonHugePages
>>>       131666 ± 27%     -67.9%      42297 ± 82%  numa-meminfo.node3.AnonPages
>>>       132698 ± 26%     -67.5%      43158 ± 81%  numa-meminfo.node3.Inactive(anon)
>>>        27934 ± 30%     +61.8%      45196 ± 21%  numa-vmstat.node0.nr_anon_pages
>>>        28306 ± 30%     +60.2%      45358 ± 21%  numa-vmstat.node0.nr_inactive_anon
>>>        28305 ± 30%     +60.2%      45357 ± 21%  numa-vmstat.node0.nr_zone_inactive_anon
>>>         6291 ± 24%     +68.0%      10567 ± 26%  numa-vmstat.node2.workingset_nodes
>>>        32925 ± 27%     -67.9%      10571 ± 82%  numa-vmstat.node3.nr_anon_pages
>>>        33182 ± 26%     -67.5%      10786 ± 81%  numa-vmstat.node3.nr_inactive_anon
>>>        33182 ± 26%     -67.5%      10786 ± 81%  numa-vmstat.node3.nr_zone_inactive_anon
>>>       161.78 ±  4%     -28.2%     116.10 ± 30%  sched_debug.cfs_rq:/.runnable_avg.avg
>>>       161.46 ±  4%     -28.2%     115.85 ± 30%  sched_debug.cfs_rq:/.util_avg.avg
>>>       426382           +11.0%     473345 ±  6%  sched_debug.cpu.clock.avg
>>>       426394           +11.0%     473357 ±  6%  sched_debug.cpu.clock.max
>>>       426370           +11.0%     473331 ±  6%  sched_debug.cpu.clock.min
>>>       426139           +10.9%     472586 ±  6%  sched_debug.cpu.clock_task.avg
>>>       426368           +11.0%     473130 ±  6%  sched_debug.cpu.clock_task.max
>>>       416196           +11.1%     462228 ±  6%  sched_debug.cpu.clock_task.min
>>>         1156 ±  7%     -10.8%       1031 ±  6%  sched_debug.cpu.curr->pid.stddev
>>>       426372           +11.0%     473334 ±  6%  sched_debug.cpu_clk
>>>       425355           +11.0%     472318 ±  6%  sched_debug.ktime
>>>       426826           +11.0%     473787 ±  6%  sched_debug.sched_clk
>>>    1.263e+09            -7.9%  1.164e+09 ±  3%  perf-stat.i.branch-instructions
>>>       190886 ±  5%     -10.8%     170290 ±  7%  perf-stat.i.context-switches
>>>    1.979e+09            -8.8%  1.804e+09 ±  2%  perf-stat.i.dTLB-loads
>>>    8.998e+08            -8.2%  8.257e+08 ±  2%  perf-stat.i.dTLB-stores
>>>    6.455e+09            -8.0%  5.938e+09 ±  3%  perf-stat.i.instructions
>>>        21.78            -8.4%      19.95        perf-stat.i.metric.M/sec
>>>      7045315 ±  4%     -14.0%    6057863 ±  6%  perf-stat.i.node-load-misses
>>>      2658563 ±  7%     -21.9%    2077647 ± 12%  perf-stat.i.node-loads
>>>       414822 ±  4%     -12.9%     361455 ±  3%  perf-stat.i.node-store-misses
>>>    1.251e+09            -7.8%  1.154e+09 ±  3%  perf-stat.ps.branch-instructions
>>>       189082 ±  5%     -10.7%     168849 ±  7%  perf-stat.ps.context-switches
>>>     1.96e+09            -8.8%  1.789e+09 ±  2%  perf-stat.ps.dTLB-loads
>>>    8.912e+08            -8.1%  8.187e+08 ±  2%  perf-stat.ps.dTLB-stores
>>>    6.393e+09            -7.9%  5.888e+09 ±  3%  perf-stat.ps.instructions
>>>      6978485 ±  4%     -13.9%    6006510 ±  6%  perf-stat.ps.node-load-misses
>>>      2633627 ±  7%     -21.8%    2060033 ± 12%  perf-stat.ps.node-loads
>>>       410822 ±  4%     -12.8%     358289 ±  3%  perf-stat.ps.node-store-misses
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> | Reported-by: kernel test robot <yujie.liu@intel.com>
>>> | Link: https://lore.kernel.org/r/202210081045.77ddf59b-yujie.liu@intel.com
>>>
>>>
>>> To reproduce:
>>>
>>>           git clone https://github.com/intel/lkp-tests.git
>>>           cd lkp-tests
>>>           sudo bin/lkp install job.yaml           # job file is attached in this email
>>>           bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>           sudo bin/lkp run generated-yaml-file
>>>
>>>           # if come across any failure that blocks the test,
>>>           # please remove ~/.lkp and /lkp dir to run from a clean state.
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are provided
>>> for informational purposes only. Any difference in system hardware or software
>>> design or configuration may affect actual performance.
>>>
>>>
>> _______________________________________________
>> LKP mailing list -- lkp@lists.01.org
>> To unsubscribe send an email to lkp-leave@lists.01.org
> 
> .
> 

