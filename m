Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BD145A05
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573278; cv=none; b=GA/D+ZWdO1VBlUEAIiYFBju4baiStrJel/6TRo+Wy9dp6kDiHm7KU5+4g/xuRwAiuolDyXEKU2KAslV7I47/V0VCsftNYfHoVskqN/QL8s49fyUeH3WdQwqQOPTFlH8s6a0HbCUc6h+NCgKNr8vl7H7Nn7Z0+1p1HSX7SDhegPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573278; c=relaxed/simple;
	bh=+nh5ik/bBOdjUmd+UPI99egxFPB8L88IQHnryBCONQ4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c+kScdLWdZXdOuzz68vNSQltR8o9S0R/2HKevh075GEsS/g+TGdzzmNvjBg/5x4NuTOc8bsTJ/nvEhUxNrOUUflFBa9jLMDd239xh1B3EVjhzXOIaiygqUJpF0D+6PBbmsID5VGDXAFrmo6YnjTZ7UrLin3KHRM8JVXw8LlucVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMp5y3dmvzKHNKS
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 14:47:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C6DC81A26AF
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 14:47:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCX4o6VcMJoHj58CA--.13079S3;
	Thu, 11 Sep 2025 14:47:50 +0800 (CST)
Subject: Re: [bug report][regression] blktests throtl/ triggered kmemleak in
 blk_throtl_init
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 hanguangjiang@lixiang.com, "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kVwCrV6ZvRovrr9Z+HA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d657831b-469a-998b-7493-eef4baea9bc9@huaweicloud.com>
Date: Thu, 11 Sep 2025 14:47:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kVwCrV6ZvRovrr9Z+HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX4o6VcMJoHj58CA--.13079S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1UtFy7Kr1xGF18tr48Xrb_yoW5Ar4xpF
	y0gw4qka18tF1DAr4IkayfXFyrZFWxAF17J393Grn3AryF9F1DJFyUXry7Wa1DXFZrXr4I
	yas5t3s0g345Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/11 14:14, Yi Zhang 写道:
> Hi
> 
> The following  kmemleak issue was observed in the latest
> linux-block/for-next, It seems a regression issue. Please help check
> it and let me know if you need any info/test for it, thanks.
> 
> unreferenced object 0xffff888160f75c00 (size 512):
>    comm "check", pid 29719, jiffies 4302480465
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 5c f7 60 81 88 ff ff  .........\.`....
>      08 5c f7 60 81 88 ff ff 18 5c f7 60 81 88 ff ff  .\.`.....\.`....
>    backtrace (crc dc08e6b1):
>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>      blk_throtl_init+0xa2/0x6a0
>      tg_set_limit+0x5ac/0x720
>      cgroup_file_write+0x1ab/0x670
>      kernfs_fop_write_iter+0x3a3/0x5a0
>      vfs_write+0x525/0xfd0
>      ksys_write+0xf9/0x1d0
>      do_syscall_64+0x94/0x8d0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff888111280c00 (size 512):
>    comm "check", pid 30240, jiffies 4302503636
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 0c 28 11 81 88 ff ff  ..........(.....
>      08 0c 28 11 81 88 ff ff 18 0c 28 11 81 88 ff ff  ..(.......(.....
>    backtrace (crc 2d0490fe):
>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>      blk_throtl_init+0xa2/0x6a0
>      tg_set_limit+0x5ac/0x720
>      cgroup_file_write+0x1ab/0x670
>      kernfs_fop_write_iter+0x3a3/0x5a0
>      vfs_write+0x525/0xfd0
>      ksys_write+0xf9/0x1d0
>      do_syscall_64+0x94/0x8d0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff888187ac6400 (size 512):
>    comm "check", pid 30484, jiffies 4302512625
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 64 ac 87 81 88 ff ff  .........d......
>      08 64 ac 87 81 88 ff ff 18 64 ac 87 81 88 ff ff  .d.......d......
>    backtrace (crc 4a3a862a):
>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>      blk_throtl_init+0xa2/0x6a0
>      tg_set_limit+0x5ac/0x720
>      cgroup_file_write+0x1ab/0x670
>      kernfs_fop_write_iter+0x3a3/0x5a0
>      vfs_write+0x525/0xfd0
>      ksys_write+0xf9/0x1d0
>      do_syscall_64+0x94/0x8d0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff88822cbf3800 (size 512):
>    comm "check", pid 30715, jiffies 4302520405
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 38 bf 2c 82 88 ff ff  .........8.,....
>      08 38 bf 2c 82 88 ff ff 18 38 bf 2c 82 88 ff ff  .8.,.....8.,....
>    backtrace (crc 7eb87e87):
>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>      blk_throtl_init+0xa2/0x6a0
>      tg_set_limit+0x5ac/0x720
>      cgroup_file_write+0x1ab/0x670
>      kernfs_fop_write_iter+0x3a3/0x5a0
>      vfs_write+0x525/0xfd0
>      ksys_write+0xf9/0x1d0
>      do_syscall_64+0x94/0x8d0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> 

+CC Han Guangjiang

Thanks for the test, clearly this is because blkg_destroy_all() already
clear the policy bit, and later blk_throtl_exit() fail the
blk_throtl_activated() test.

I think we should call blk_throtl_exit() before blkg_destroy_all().

Thanks,
Kuai

