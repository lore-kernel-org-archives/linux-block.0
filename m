Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAC6FA7
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W-k6n3n_1705370243;
Received: from 30.178.82.220(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-k6n3n_1705370243)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 09:57:24 +0800
Message-ID: <9e279490-a4b2-442b-9d78-be030d7b4c28@linux.alibaba.com>
Date: Tue, 16 Jan 2024 09:57:22 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] test/nvme/050: test the reservation feature
Content-Language: en-GB
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kch@nvidia.com" <kch@nvidia.com>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240114092611.69075-1-kanie@linux.alibaba.com>
 <5ktqzlnoez2ux2loizs7zcr3eix4om5a2hscopbm4uhcpftber@ohbagb53mkgb>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <5ktqzlnoez2ux2loizs7zcr3eix4om5a2hscopbm4uhcpftber@ohbagb53mkgb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Shinichiro:

     Thanks for the patient reply.

在 2024/1/15 13:15, Shinichiro Kawasaki 写道:
> Hello Guixin, thanks for the patch. Good to have new tests for new features :)
>
> I think this test depends on the kernel side patches you posted [1]. So the test
> case should be skipped when the kernel does not have the patches. I suggest to
> check it using "resv_enable" configfs file. Please refer to nvme/048 which does
> similar check and sets SKIP_REASONS.
Agree, it will be changed in v2.
>
> [1] https://lore.kernel.org/linux-nvme/20240114092314.63694-1-kanie@linux.alibaba.com/
>
> When I ran the test case on my system using the kernel v6.7 + the [1] patches,
> I observed the kernel BUG below. It looks kmalloc() in nvmet_execute_pr_report()
> needs care.
OK, I will take a look.
>
> [  262.402130] run blktests nvme/050 at 2024-01-15 13:21:44
> [  262.465068] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  262.520959] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  262.525398] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> [  262.528334] nvme nvme1: creating 4 I/O queues.
> [  262.531269] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [  262.655310] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> [  262.657489] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 233, name: kworker/1:3
> [  262.658976] preempt_count: 1, expected: 0
> [  262.660158] RCU nest depth: 0, expected: 0
> [  262.661372] 4 locks held by kworker/1:3/233:
> [  262.662526]  #0: ffff888135f04538 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x679/0x1260
> [  262.664235]  #1: ffff88812524fd90 ((work_completion)(&iod->work)){+.+.}-{0:0}, at: process_one_work+0x6da/0x1260
> [  262.665963]  #2: ffff888133caa870 (&subsys->lock#2){+.+.}-{3:3}, at: nvmet_execute_pr_report+0x197/0xbd0 [nvmet]
> [  262.667622]  #3: ffff888136cdd230 (&ns->pr.pr_lock){.+.+}-{2:2}, at: nvmet_execute_pr_report+0x1b4/0xbd0 [nvmet]
> [  262.669369] Preemption disabled at:
> [  262.669371] [<0000000000000000>] 0x0
> [  262.671748] CPU: 1 PID: 233 Comm: kworker/1:3 Tainted: G        W          6.7.0+ #141
> [  262.673226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
> [  262.674789] Workqueue: nvmet-wq nvme_loop_execute_work [nvme_loop]
> [  262.676142] Call Trace:
> [  262.677234]  <TASK>
> [  262.678241]  dump_stack_lvl+0x71/0x90
> [  262.679336]  __might_resched+0x3d5/0x5f0
> [  262.680482]  ? __pfx___might_resched+0x10/0x10
> [  262.681675]  __kmem_cache_alloc_node+0x2ef/0x340
> [  262.682960]  ? nvmet_execute_pr_report+0x313/0xbd0 [nvmet]
> [  262.684275]  ? nvmet_execute_pr_report+0x313/0xbd0 [nvmet]
> [  262.685638]  __kmalloc+0x50/0x160
> [  262.686779]  nvmet_execute_pr_report+0x313/0xbd0 [nvmet]
> [  262.688040]  ? lock_is_held_type+0xce/0x120
> [  262.689221]  process_one_work+0x74c/0x1260
> [  262.690480]  ? __pfx_lock_acquire+0x10/0x10
> [  262.691644]  ? __pfx_process_one_work+0x10/0x10
> [  262.692893]  ? assign_work+0x16c/0x240
> [  262.694063]  worker_thread+0x723/0x1300
> [  262.695216]  ? lockdep_hardirqs_on+0x7d/0x100
> [  262.696461]  ? __kthread_parkme+0xbd/0x1f0
> [  262.697587]  ? __pfx_worker_thread+0x10/0x10
> [  262.698812]  kthread+0x2f1/0x3d0
> [  262.700000]  ? _raw_spin_unlock_irq+0x24/0x50
> [  262.701179]  ? __pfx_kthread+0x10/0x10
> [  262.702340]  ret_from_fork+0x30/0x70
> [  262.703427]  ? __pfx_kthread+0x10/0x10
> [  262.704560]  ret_from_fork_asm+0x1b/0x30
> [  262.705718]  </TASK>
> [  262.891548] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
>
>
> Also please find my comments in line.
>
> On Jan 14, 2024 / 17:26, Guixin Liu wrote:
>> Test the reservation feature, includes register, acquire, release
>> and report.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   tests/nvme/050     |  67 ++++++++++++++++++++++++++
>>   tests/nvme/050.out | 114 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/rc      |   3 ++
>>   3 files changed, 184 insertions(+)
>>   create mode 100644 tests/nvme/050
>>   create mode 100644 tests/nvme/050.out
>>
>> diff --git a/tests/nvme/050 b/tests/nvme/050
>> new file mode 100644
>> index 0000000..a499f66
>> --- /dev/null
>> +++ b/tests/nvme/050
>> @@ -0,0 +1,67 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Guixin Liu
>> +# Copyright (C) 2024 Alibaba Group.
>> +#
>> +# Test the reservation
> Nit: looks too short. How about "Test the NVMe reservaction feature"?
OK.
>> +#
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test the reservation"
> Nit: How about "test the reservation feature"?
>
Same sure.
>> +QUICK=1
>> +
>> +requires() {
>> +	_nvme_requires
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	local nvmedev
>> +
>> +	_nvmet_target_setup --blkdev file
>> +
>> +	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
>> +
>> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
>> +
>> +	echo "Register"
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
> Recent nvme-cli, probably since v2.0 in Apr/2022, replaced this --cdw11 option
> of the "nvme resv-report" command with --eds option. To allow this test case
> run regardless of the nvme-cli version, I suggest to check "nvme resv-report"
> command output at the beginning of the test case and see if it contains the
> string "--eds". Depending on the check result, we can change the option for the
> "nvme resv-report" commands in this test case.
My nvme-cli is v1.16, I will update it to the newest version to take a look.
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
>> +
>> +	echo "Replace"
>> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
>> +
>> +	echo "Unregister"
>> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
>> +
>> +	echo "Acquire"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
>> +
>> +	echo "Preempt"
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
>> +
>> +	echo "Release"
>> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
>> +
>> +	echo "Clear"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
>> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
>> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rrela=1
>> +
>> +	_nvme_disconnect_subsys "${def_subsysnqn}"
>> +
>> +	_nvmet_target_cleanup
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/nvme/050.out b/tests/nvme/050.out
>> new file mode 100644
>> index 0000000..3be417d
>> --- /dev/null
>> +++ b/tests/nvme/050.out
>> @@ -0,0 +1,114 @@
>> +Running nvme/050
>> +Register
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 0
>> +rtype     : 0
>> +regctl    : 0
>> +ptpls     : 0
>> +
>> +NVME Reservation  success
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 1
>> +rtype     : 0
>> +regctl    : 1
>> +ptpls     : 0
>> +regctlext[0] :
>> +  cntlid     : 1
>> +  rcsts      : 0
>> +  rkey       : 4
>> +  hostid     : f1fb429f7f4856b0b351e6b8de349
> When I ran the test case on my system, it failed because of hostid mismatch.
> Actually, we are trying to make the nvme test cases independent from hostid. To
> not check the hostid lines for this test case, I suggest to add
> "| grep -v hostid" to the "nvme resv-report" commands.
OK, I miss that def_hostid is not same for different system.
>> +
>> +Replace
>> +NVME Reservation  success
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 2
>> +rtype     : 0
>> +regctl    : 1
>> +ptpls     : 0
>> +regctlext[0] :
>> +  cntlid     : 1
>> +  rcsts      : 0
>> +  rkey       : 5
>> +  hostid     : f1fb429f7f4856b0b351e6b8de349
>> +
>> +Unregister
>> +NVME Reservation  success
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 3
>> +rtype     : 0
>> +regctl    : 0
>> +ptpls     : 0
>> +
>> +Acquire
>> +NVME Reservation  success
>> +NVME Reservation Acquire success
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 4
>> +rtype     : 1
>> +regctl    : 1
>> +ptpls     : 0
>> +regctlext[0] :
>> +  cntlid     : 1
>> +  rcsts      : 1
>> +  rkey       : 4
>> +  hostid     : f1fb429f7f4856b0b351e6b8de349
>> +
>> +Preempt
>> +NVME Reservation Acquire success
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 5
>> +rtype     : 2
>> +regctl    : 1
>> +ptpls     : 0
>> +regctlext[0] :
>> +  cntlid     : 1
>> +  rcsts      : 1
>> +  rkey       : 4
>> +  hostid     : f1fb429f7f4856b0b351e6b8de349
>> +
>> +Release
>> +NVME Reservation Release success
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 5
>> +rtype     : 0
>> +regctl    : 1
>> +ptpls     : 0
>> +regctlext[0] :
>> +  cntlid     : 1
>> +  rcsts      : 0
>> +  rkey       : 4
>> +  hostid     : f1fb429f7f4856b0b351e6b8de349
>> +
>> +Clear
>> +NVME Reservation  success
>> +NVME Reservation Acquire success
>> +
>> +NVME Reservation status:
>> +
>> +gen       : 6
>> +rtype     : 1
>> +regctl    : 1
>> +ptpls     : 0
>> +regctlext[0] :
>> +  cntlid     : 1
>> +  rcsts      : 1
>> +  rkey       : 4
>> +  hostid     : f1fb429f7f4856b0b351e6b8de349
>> +
>> +NVME Reservation Release success
>> +disconnected 1 controller(s)
>> +Test complete
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index b0ef1ee..8de59e2 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -670,6 +670,9 @@ _create_nvmet_ns() {
>>   	mkdir "${ns_path}"
>>   	printf "%s" "${blkdev}" > "${ns_path}/device_path"
>>   	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
>> +	if [[ -f "${ns_path}/resv_enable" ]]; then
>> +		printf 1 > "${ns_path}/resv_enable"
>> +	fi
> I think this operation is required only for this test case, so resv_enable
> should not be set for other test cases. So, it is the better to add an optional
> argument like "--resv_enable" to _nvmet_target_setup() and propagate it to
> _create_nvmet_subsystem() and _create_nvmet_ns(). It's the better to make
> it a separated patch.
Yeah, sure, it will be changes in v2.
>>   	printf 1 > "${ns_path}/enable"
>>   }
>>   
>> -- 
>> 2.30.1 (Apple Git-130)
>>
