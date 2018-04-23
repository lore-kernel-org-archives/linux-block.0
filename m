Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: testing io.low limit for blk-throttle
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Shaohua Li <shli@fb.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <180654d2-17ef-0d25-bef6-f526e9ec4ea3@oracle.com>
 <0AAB1A24-0E2E-4054-8D7F-6C1D69379A1F@linaro.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <cbd82e3d-4465-864d-c057-898135626362@oracle.com>
Date: Mon, 23 Apr 2018 10:19:30 +0800
MIME-Version: 1.0
In-Reply-To: <0AAB1A24-0E2E-4054-8D7F-6C1D69379A1F@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Paolo

As I said, I used to meet similar scenario.
After dome debug, I found out 3 issues.

Here is my setup command:
mkdir test0 test1
echo "259:0 riops=150000" > test0/io.max 
echo "259:0 riops=150000" > test1/io.max 
echo "259:0 riops=150000" > test2/io.max 
echo "259:0 riops=50000 wiops=50000 rbps=209715200 wbps=209715200 idle=200 latency=10" > test0/io.low 
echo "259:0 riops=50000 wiops=50000 rbps=209715200 wbps=209715200 idle=200 latency=10" > test1/io.low 

My NVMe card's max bps is ~600M, and max iops is ~160k.
Two cgroups' io.low is bps 200M and 50k. io.max is iops 150k

1. I setup 2 cgroups test0 and test1, one process per cgroup.
Even if only the process in test0 does IO, its iops is just 50k.
This is fixed by following patch.
https://marc.info/?l=linux-block&m=152325457607425&w=2 

2. Let the process in test0 and test1 both do IO.
Sometimes, the iops of both cgroup are 50k, look at the log, blk-throl's upgrade always fails.
This is fixed by following patch:
https://marc.info/?l=linux-block&m=152325456307423&w=2

3. After applied patch 1 and 2, still see that one of cgroup's iops will fall down to 30k ~ 40k but
blk-throl doesn't downgrade. It is due to even if the iops has been lower than the io.low limit for some time,
but the cgroup is idle, so downgrade fails. More detailed, it is due to the code segment in throtl_tg_is_idle

            (tg->latency_target && tg->bio_cnt &&
		tg->bad_bio_cnt * 5 < tg->bio_cnt)

I fixed it with following patch.
But I'm not sure about this patch, so I didn't submit it.
Please also try it. :)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b5ba845..c9a43a4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1819,7 +1819,7 @@ static unsigned long tg_last_low_overflow_time(struct throtl_grp *tg)
        return ret;
 }
 
-static bool throtl_tg_is_idle(struct throtl_grp *tg)
+static bool throtl_tg_is_idle(struct throtl_grp *tg, bool latency)
 {
        /*
         * cgroup is idle if:
@@ -1836,7 +1836,7 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
              tg->idletime_threshold == DFL_IDLE_THRESHOLD ||
              (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
              tg->avg_idletime > tg->idletime_threshold ||
-             (tg->latency_target && tg->bio_cnt &&
+             (tg->latency_target && tg->bio_cnt && latency &&
                tg->bad_bio_cnt * 5 < tg->bio_cnt);
        throtl_log(&tg->service_queue,
                "avg_idle=%ld, idle_threshold=%ld, bad_bio=%d, total_bio=%d, is_idle=%d, scale=%d",
@@ -1867,7 +1867,7 @@ static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 
        if (time_after_eq(jiffies,
                tg_last_low_overflow_time(tg) + tg->td->throtl_slice) &&
-           throtl_tg_is_idle(tg))
+           throtl_tg_is_idle(tg, true))
                return true;
        return false;
 }
@@ -1983,7 +1983,7 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
        if (time_after_eq(now, td->low_upgrade_time + td->throtl_slice) &&
            time_after_eq(now, tg_last_low_overflow_time(tg) +
                                        td->throtl_slice) &&
-           (!throtl_tg_is_idle(tg) ||
+           (!throtl_tg_is_idle(tg, false) ||
             !list_empty(&tg_to_blkg(tg)->blkcg->css.children)))
                return true;
        return false;



On 04/22/2018 11:53 PM, Paolo Valente wrote:
> 
> 
>> Il giorno 22 apr 2018, alle ore 15:29, jianchao.wang <jianchao.w.wang@oracle.com> ha scritto:
>>
>> Hi Paolo
>>
>> I used to meet similar issue on io.low.
>> Can you try the following patch to see whether the issue could be fixed.
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D152325456307423-26w-3D2&d=DwIFAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=asJMDy9zIe2AqRVpoLbe9RMjsdZOJZ0HrRWTM3CPZeA&s=AZ4kllxCfaXspjeSylBpK8K7ai6IPjSiffrGmzt4VEM&e=
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D152325457607425-26w-3D2&d=DwIFAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=asJMDy9zIe2AqRVpoLbe9RMjsdZOJZ0HrRWTM3CPZeA&s=1EhsoSMte3kIxuVSYBFSE9W2jRKrIWI5z7-stlZ80H4&e=
>>
> 
> Just tried. Unfortunately, nothing seems to change :(
> 
> Thanks,
> Paolo
> 
>> Thanks
>> Jianchao
>>
>> On 04/22/2018 05:23 PM, Paolo Valente wrote:
>>> Hi Shaohua, all,
>>> at last, I started testing your io.low limit for blk-throttle.  One of
>>> the things I'm interested in is how good throttling is in achieving a
>>> high throughput in the presence of realistic, variable workloads.
>>>
>>> However, I seem to have bumped into a totally different problem.  The
>>> io.low parameter doesn't seem to guarantee what I understand it is meant
>>> to guarantee: minimum per-group bandwidths.  For example, with
>>> - one group, the interfered, containing one process that does sequential
>>>  reads with fio
>>> - io.low set to 100MB/s for the interfered
>>> - six other groups, the interferers, with each interferer containing one
>>>  process doing sequential read with fio
>>> - io.low set to 10MB/s for each interferer
>>> - the workload executed on an SSD, with a 500MB/s of overall throughput
>>> the interfered gets only 75MB/s.
>>>
>>> In particular, the throughput of the interfered becomes lower and
>>> lower as the number of interferers is increased.  So you can make it
>>> become even much lower than the 75MB/s in the example above.  There
>>> seems to be no control on bandwidth.
>>>
>>> Am I doing something wrong?  Or did I simply misunderstand the goal of
>>> io.low, and the only parameter for guaranteeing the desired bandwidth to
>>> a group is io.max (to be used indirectly, by limiting the bandwidth of
>>> the interferers)?
>>>
>>> If useful for you, you can reproduce the above test very quickly, by
>>> using the S suite [1] and typing:
>>>
>>> cd thr-lat-with-interference
>>> sudo ./thr-lat-with-interference.sh -b t -w 100000000 -W "10000000 10000000 10000000 10000000 10000000 10000000" -n 6 -T "read read read read read read" -R "0 0 0 0 0 0"
>>>
>>> Looking forward to your feedback,
>>> Paolo
>>>
>>> [1] 
>>>
> 
> 
