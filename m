Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB2273FD
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652246; cv=none; b=MntMb6BuHxdTA9OyCup1UKjj/sObJLmYhxPBuAAL4a4xNAUGvGM8+jvrnveTY14eVRrt/OJB9S185YH2Z8g+zBD/NZnjxkbuhXbGn9A0LThC04J5XRdBOxwEBHUAsUl0DBhIsYiFGjEiub6a3vwBWjebv6TXBsXyXGyahNumUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652246; c=relaxed/simple;
	bh=XT3c1EClRI3RJFi4KbIc5DOd+vsIM5Zf9LzKqRipfQw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iuIlb268Z9cUiRdYGHYcx4VTo9eoK8WC9tuy5qXKEJtfcbc70yghWhFVHILeYX/EUTRt017jsPDrPolFthmv3q4kH3Vp+Q1IXpqsyY3OlFzBXR7I6WuSWqSJToR4uDoQOc7DqSXTwL3BTPDYdxLlerl0I8yZknQQnszx3lS/nHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bhpBj34wnzKHN4J
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 15:50:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 080BE1A0CC3
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 15:50:36 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhPKWXdoK9PAAQ--.2959S3;
	Wed, 16 Jul 2025 15:50:35 +0800 (CST)
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
Date: Wed, 16 Jul 2025 15:50:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhPKWXdoK9PAAQ--.2959S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF4fGrWxJr4DCFyrZF15twb_yoWDtFc_ur
	W0vr18Kw4DJr15KF1qgFyrXr1UGF1xZF1UGaykJr1fAr4Ik3y7Zw4UuF1rWr1jq347AFWq
	9r4UW3Z5X3yagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/16 9:54, Jens Axboe 写道:
> unreferenced object 0xffff8882e7fbb000 (size 2048):
>    comm "check", pid 10460, jiffies 4324980514
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc c47e6a37):
>      __kvmalloc_node_noprof+0x55d/0x7a0
>      sbitmap_init_node+0x15a/0x6a0
>      kyber_init_hctx+0x316/0xb90
>      blk_mq_init_sched+0x416/0x580
>      elevator_switch+0x18b/0x630
>      elv_update_nr_hw_queues+0x219/0x2c0
>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>      blk_mq_update_nr_hw_queues+0x3a/0x60
>      find_fallback+0x510/0x540 [nbd]

This is werid, and I check the code that it's impossible
blk_mq_update_nr_hw_queues() can be called from find_fallback().

Does kmemleak show wrong backtrace?

Thanks,
Kuai

>      nbd_send_cmd+0x24b/0x1480 [nbd]
>      configfs_write_iter+0x2ae/0x470
>      vfs_write+0x524/0xe70
>      ksys_write+0xff/0x200
>      do_syscall_64+0x98/0x3c0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e

