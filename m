Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1E15D1;
	Sat,  9 Nov 2024 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731122619; cv=none; b=P5OeghnmaO3GW4/YSFfKxLsnK0MLt7daovVGYeT/Wr6dwgl9iQ2bOA0lyxA0UqOF7/tzT3XXGdjMdQJCoH/sSdp0/10akWNXdgpCm9mLW/xQaEdNDAVGB9CwWlUAiop7x4FISaxkUshYRhh5A1tdfF4NVC106QwLQIACrGnDolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731122619; c=relaxed/simple;
	bh=AsKNVvSMcxfnrg62ydkf1xT38juZLumz5klU0TsEHK8=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BF+68yJoKunbKKDcXRs+sQUIk/WHepbFJvg4q9BfxT1p3yyAw00CKJ+EMeF1yoG5OLINunNQtRp5RV12t1BXC8ZaEGnrf4Uc+OXX6MXMB4S2Cu3mmZ7eRYg86ycrKreuxkSthanXu5E5zGJ7GWIr4KG8vGjHII5xpvW49EnyuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xlh1S0NgYz1SF1H;
	Sat,  9 Nov 2024 11:21:48 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 242771402E1;
	Sat,  9 Nov 2024 11:23:33 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 kwepemg200013.china.huawei.com (7.202.181.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 Nov 2024 11:23:32 +0800
Subject: Re: [PATCH] zram: fix NULL pointer in comp_algorithm_show()
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20241108100147.3776123-1-liushixin2@huawei.com>
 <20241109011249.GA549125@google.com>
CC: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <d1f5f56e-536f-5ce0-471e-4d340378170a@huawei.com>
Date: Sat, 9 Nov 2024 11:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241109011249.GA549125@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200013.china.huawei.com (7.202.181.64)



On 2024/11/9 9:12, Sergey Senozhatsky wrote:
> On (24/11/08 18:01), Liu Shixin wrote:
>> LTP reported a NULL pointer dereference as followed:
>>
>>  CPU: 7 UID: 0 PID: 5995 Comm: cat Kdump: loaded Not tainted 6.12.0-rc6+ #3
>>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>  pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>  pc : __pi_strcmp+0x24/0x140
>>  lr : zcomp_available_show+0x60/0x100 [zram]
>>  sp : ffff800088b93b90
>>  x29: ffff800088b93b90 x28: 0000000000000001 x27: 0000000000400cc0
>>  x26: 0000000000000ffe x25: ffff80007b3e2388 x24: 0000000000000000
>>  x23: ffff80007b3e2390 x22: ffff0004041a9000 x21: ffff80007b3e2900
>>  x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
>>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>  x11: 0000000000000000 x10: ffff80007b3e2900 x9 : ffff80007b3cb280
>>  x8 : 0101010101010101 x7 : 0000000000000000 x6 : 0000000000000000
>>  x5 : 0000000000000040 x4 : 0000000000000000 x3 : 00656c722d6f7a6c
>>  x2 : 0000000000000000 x1 : ffff80007b3e2900 x0 : 0000000000000000
>>  Call trace:
>>   __pi_strcmp+0x24/0x140
>>   comp_algorithm_show+0x40/0x70 [zram]
>>   dev_attr_show+0x28/0x80
>>   sysfs_kf_seq_show+0x90/0x140
>>   kernfs_seq_show+0x34/0x48
>>   seq_read_iter+0x1d4/0x4e8
>>   kernfs_fop_read_iter+0x40/0x58
>>   new_sync_read+0x9c/0x168
>>   vfs_read+0x1a8/0x1f8
>>   ksys_read+0x74/0x108
>>   __arm64_sys_read+0x24/0x38
>>   invoke_syscall+0x50/0x120
>>   el0_svc_common.constprop.0+0xc8/0xf0
>>   do_el0_svc+0x24/0x38
>>   el0_svc+0x38/0x138
>>   el0t_64_sync_handler+0xc0/0xc8
>>   el0t_64_sync+0x188/0x190
> The explanation below is more than enough, I think this stack trace
> doesn't really show anything new or interesting.
>
>> The zram->comp_algs[ZRAM_PRIMARY_COMP] can be NULL in zram_add() if
>> comp_algorithm_set() has not been called. User can access the zram device
>> by sysfs after device_add_disk(), so there is a time window to trigger
>> the NULL pointer dereference. Move it ahead device_add_disk() to make sure
>> when user can access the zram device, it is ready. comp_algorithm_set() is
>> protected by zram->init_lock in other places and no such problem.
>>
>> Fixes: 7ac07a26dea7 ("zram: preparation for multi-zcomp support")
> So I think this fixes something much older, probably around e46b8a030d76d
> time (2014).

The NULL pointer is introduced when zram->compressor is changed to zram->comp_algs in
7ac07a26dea, where the former is an array of chars and the latter is an array of pointers.
Before that, if we cat comp_algorithm int the time window, we will get a message with no
algorithm selected like this:

    cat /sys/block/zram1/comp_algorithm
    lzo lz4

>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> .
>

Thanks,
.
