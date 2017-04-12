Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [kbuild-all] [PATCH V2 16/16] block, bfq: split bfq-iosched.c into multiple source files
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <0313304F-A998-4C5F-BA32-E34C6F85A8CF@linaro.org>
Date: Wed, 12 Apr 2017 18:05:23 +0200
Cc: kbuild test robot <lkp@intel.com>,
 Jens Axboe <axboe@kernel.dk>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org,
 Fabio Checconi <fchecconi@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 kbuild-all@01.org,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 Tejun Heo <tj@kernel.org>
Message-Id: <5C8F18AE-1E8A-46AF-AA18-3FA49276AA09@linaro.org>
References: <201704021757.C1wjX07L%fengguang.wu@intel.com> <C9AEA3F6-14A1-4D81-A33C-1C38FD1E1F45@linaro.org> <20170412083948.GF31394@yexl-desktop> <0313304F-A998-4C5F-BA32-E34C6F85A8CF@linaro.org>
To: Ye Xiaolong <xiaolong.ye@intel.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 12 apr 2017, alle ore 11:24, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 12 apr 2017, alle ore 10:39, Ye Xiaolong =
<xiaolong.ye@intel.com> ha scritto:
>>=20
>> On 04/11, Paolo Valente wrote:
>>>=20
>>>> Il giorno 02 apr 2017, alle ore 12:02, kbuild test robot =
<lkp@intel.com> ha scritto:
>>>>=20
>>>> Hi Paolo,
>>>>=20
>>>> [auto build test ERROR on block/for-next]
>>>> [also build test ERROR on v4.11-rc4 next-20170331]
>>>> [if your patch is applied to the wrong git tree, please drop us a =
note to help improve the system]
>>>>=20
>>>=20
>>> Hi,
>>> this seems to be a false positive.  Build is correct with the tested
>>> tree and the .config.
>>>=20
>>=20
>> Hmm, this error is reproducible in 0day side, and you patches were =
applied on
>> top of 803e16d "Merge branch 'for-4.12/block' into for-next", is it =
the same as
>> yours?
>>=20
>=20
> I have downloaded the offending tree directly from the github page.
>=20
> Here are my steps in super detail.
>=20
> I followed the url:    =
https://github.com/0day-ci/linux/commits/Paolo-Valente/block-bfq-introduce=
-the-BFQ-v0-I-O-scheduler-as-an-extra-scheduler/20170402-100622
> and downloaded the tree ("Browse the repository at this point in
> history" link on the top commit, then "Download ZIP"), plus the
> .config.gz attached to the email.
>=20
> Then I built with no error.
>=20
> To try to help understand where the mistake is, the compilation of the
> files of course fails because each of the offending files does not
> contain the definition of the reported functions.  But that definition
> is contained in one of the other files for the same module.  I mean
> one of the files listed in the following rule in block/Makefile:
> obj-$(CONFIG_IOSCHED_BFQ)       +=3D bfq-iosched.o bfq-wf2q.o =
bfq-cgroup.o
>=20
> Maybe I'm making some mistake in the Makefile, or I forgot to modify
> some other configuration file?
>=20
> Help! :)
>=20

Ok, fortunately I've reproduced it on a different PC.  block/Makefile
was flawed, but, for unknown (to me) reasons, my system was perfectly
happy with the flaw.

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> Thanks,
>> Xiaolong
>>=20
>>> Thanks,
>>> Paolo
>>>=20
>>>> url:    =
https://github.com/0day-ci/linux/commits/Paolo-Valente/block-bfq-introduce=
-the-BFQ-v0-I-O-scheduler-as-an-extra-scheduler/20170402-100622
>>>> base:   =
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git =
for-next
>>>> config: i386-allmodconfig (attached as .config)
>>>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>>>> reproduce:
>>>>      # save the attached .config to linux build tree
>>>>      make ARCH=3Di386=20
>>>>=20
>>>> All errors (new ones prefixed by >>):
>>>>=20
>>>>>> ERROR: "bfq_mark_bfqq_busy" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfqg_stats_update_dequeue" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfq_clear_bfqq_busy" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfq_clear_bfqq_non_blocking_wait_rq" [block/bfq-wf2q.ko] =
undefined!
>>>>>> ERROR: "bfq_bfqq_non_blocking_wait_rq" [block/bfq-wf2q.ko] =
undefined!
>>>>>> ERROR: "bfq_clear_bfqq_wait_request" [block/bfq-wf2q.ko] =
undefined!
>>>>>> ERROR: "bfq_timeout" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfqg_stats_set_start_empty_time" [block/bfq-wf2q.ko] =
undefined!
>>>>>> ERROR: "bfq_weights_tree_add" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfq_put_queue" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfq_bfqq_sync" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfqg_to_blkg" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfqq_group" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfq_weights_tree_remove" [block/bfq-wf2q.ko] undefined!
>>>>>> ERROR: "bfq_bic_update_cgroup" [block/bfq-iosched.ko] undefined!
>>>>>> ERROR: "bfqg_stats_set_start_idle_time" [block/bfq-iosched.ko] =
undefined!
>>>>>> ERROR: "bfqg_stats_update_completion" [block/bfq-iosched.ko] =
undefined!
>>>>>> ERROR: "bfq_bfqq_move" [block/bfq-iosched.ko] undefined!
>>>>>> ERROR: "bfqg_put" [block/bfq-iosched.ko] undefined!
>>>>>> ERROR: "next_queue_may_preempt" [block/bfq-iosched.ko] undefined!
>>>>=20
>>>> ---
>>>> 0-DAY kernel test infrastructure                Open Source =
Technology Center
>>>> https://lists.01.org/pipermail/kbuild-all                   Intel =
Corporation
>>>> <.config.gz>
>>>=20
>>> _______________________________________________
>>> kbuild-all mailing list
>>> kbuild-all@lists.01.org
>>> https://lists.01.org/mailman/listinfo/kbuild-all
