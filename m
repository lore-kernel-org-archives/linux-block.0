Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329481B043C
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923739; cv=none; b=iObJ9pk2RG2/30Nq8qQtRBO8GxF+maEqybpWZCSkVZ8f068xH1U0xMYXof7c0OKDYak7Ge393oIyiCVWC/CFBlha/vvDxGhHYr/am9rLPPIrLNnBrdLAwwKenKEVTZ7ReYNfBsA3y/WUqXt3bEY1nCtFgp/QAakmud77t+J9nJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923739; c=relaxed/simple;
	bh=AVkCsjSDa3bry7V5bBTWoZti3N6B4uxlnWVB8MJrmdA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K5PwaiaErVSd2i6rrBIHiB13HmwDi0qVWhw9em9G0Jg8ObdPV4eYhPNpmWhsG2ziv1h8DHfrsPA6jRTbJCetFJGTMump6hZrUYFa1cQDynnReaxLQd6hyQUuHoqQ0XyRFAj+XzLCGQE3tK/tdEslPiPpwiEbHdxmZ2OyyyIoli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bSVy948X8zKHMrK
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 15:42:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ED3ED1A0AD3
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 15:42:07 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl_P+VxofPHIQg--.28917S3;
	Thu, 26 Jun 2025 15:42:07 +0800 (CST)
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Yi Zhang <yi.zhang@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
 <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
 <f320c94e-3a94-d645-8f7b-80f958c50fbe@huaweicloud.com>
 <CAHj4cs_+dauobyYyP805t33WMJVzOWj=7+51p4_j9rA63D9sog@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a499af9e-6ba2-a81d-20b3-bb4dc5d6adca@huaweicloud.com>
Date: Thu, 26 Jun 2025 15:42:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_+dauobyYyP805t33WMJVzOWj=7+51p4_j9rA63D9sog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl_P+VxofPHIQg--.28917S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4xJFyfWrW8XF1fAFWxXrb_yoW8trWDpF
	13Jr4Ykr40qr17tr4UJr1UtF1UGasrua4xJw42qryUJ3WUW3WUA34UJr40qr98twn09rW7
	Jw1DJw1xtrn5XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/26 12:41, Yi Zhang 写道:
> Seems both the original and new warning are triggered, here is the full log:
> 
[...]

> [ 1022.263295] CPU: 12 UID: 0 PID: 466 Comm: kworker/12:1H Tainted: G
>        W           6.16.0-rc3.yu+ #2 PREEMPT(voluntary)
> [ 1022.291560] nvme nvme0: NVME-FC{0}: controller connect complete
> [ 1022.356344] Tainted: [W]=WARN
> [ 1022.356348] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
> 2.22.2 09/12/2024
> [ 1022.356352] Workqueue: kblockd blk_mq_run_work_fn
> [ 1022.744652] RIP: 0010:bdev_end_io_acct+0x494/0x5c0
> [ 1022.749466] Code: 22 fd ff ff 48 c7 44 24 08 10 00 00 00 41 be 30
> 00 00 00 48 c7 04 24 50 00 00 00 e9 c3 fb ff ff 0f 1f 44 00 00 e9 f5
> fd ff ff <0f> 0b 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc
> cc 48
> [ 1022.768235] RSP: 0018:ffffc9000f9f78e8 EFLAGS: 00010297
> [ 1022.773484] RAX: 00000000ffffffff RBX: ffff88a922776e64 RCX: ffffffffb003853f
> [ 1022.780632] RDX: ffffed15244eedcd RSI: 0000000000000004 RDI: ffff88a922776e64
> [ 1022.787784] RBP: ffffe8d448a4e440 R08: 0000000000000001 R09: ffffed15244eedcc
> [ 1022.794934] R10: ffff88a922776e67 R11: 0000000000000000 R12: ffff88a922776e68
> [ 1022.802101] R13: 0000000000000001 R14: 0000000000000028 R15: 0000000000007e42
> [ 1022.809251] FS:  0000000000000000(0000) GS:ffff889c3c5a7000(0000)
> knlGS:0000000000000000
> [ 1022.817352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1022.823114] CR2: 0000562e119bd048 CR3: 0000003661478001 CR4: 00000000007726f0
> [ 1022.830265] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1022.837418] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1022.844561] PKRU: 55555554
> [ 1022.847293] Call Trace:
> [ 1022.849762]  <TASK>
> [ 1022.851898]  nvme_end_req+0x4d/0x70 [nvme_core]
> [ 1022.856494]  nvme_failover_req+0x3bd/0x530 [nvme_core]
> [ 1022.861692]  nvme_fail_nonready_command+0x12c/0x170 [nvme_core]
> [ 1022.867666]  nvme_fc_queue_rq+0x463/0x720 [nvme_fc]

Thanks for the test, so nvme-mpath do have real problems. However, it's
still not clear to me and I'll send the revert first, because lots of
false warning are reported.

Kuai

