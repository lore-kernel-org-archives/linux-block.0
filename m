Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAB3A1DB
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984660; cv=none; b=cXKJMrdN8uzU4WpIy7GlOGN0zGV0pjhrC3rPq2AoYA4w0M3ZQ3QR6MuU6wh87Gb8QBoS7Q0dLCifoGH2ZvQewmlS90QNfYtrnIz5LjA6A8mE6ZIp4KsrVlKBF4wmJwhcNsQMF5kM3d7A27/DLrcEh2KMxAyqEHEONJ3tfEtv5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984660; c=relaxed/simple;
	bh=B104AO/2vZlVC6H6wI56hNqobjz6+BkizPVgDTPx8RI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aj/RWo/Vhg2siE55dc0xuB+Zc+dajx5sHsRar0E0xVQCKUuaxKRgi/E7QZOC6fy8zsSafz5+qal+jtPxEvixzsi/tZvoMNxDMkHE9TAiq+9UdHWPktugrZwL35QWXGBqn7Sg5v2IWDGeAF+zpKRjXCNKoNxvCM7q2VICyv4UqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cQkF22QdYzKHMjf
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 09:04:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F044E1A01A4
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 09:04:06 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY6Ft8hoxsCaCg--.12284S3;
	Tue, 16 Sep 2025 09:04:06 +0800 (CST)
Subject: Re: [bug report][regression] blktests throtl/ triggered kmemleak in
 blk_throtl_init
To: Yu Kuai <yukuai1@huaweicloud.com>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 hanguangjiang@lixiang.com, "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kVwCrV6ZvRovrr9Z+HA@mail.gmail.com>
 <d657831b-469a-998b-7493-eef4baea9bc9@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <725a1568-3bbb-a7c5-a929-10b0c13fbc14@huaweicloud.com>
Date: Tue, 16 Sep 2025 09:04:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d657831b-469a-998b-7493-eef4baea9bc9@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY6Ft8hoxsCaCg--.12284S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF17uF4xCw1rXw1ktr1fWFg_yoWrJryUpF
	yvq347CrWrCr1kJr4UtF4rWFyUJr4xA3WDJrWrGF9rZFW8CryqqFWUWryqgF4DXFs7Jr4x
	A3WUJr9Fvry5Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/11 14:47, Yu Kuai 写道:
> Hi,
> 
> 在 2025/09/11 14:14, Yi Zhang 写道:
>> Hi
>>
>> The following  kmemleak issue was observed in the latest
>> linux-block/for-next, It seems a regression issue. Please help check
>> it and let me know if you need any info/test for it, thanks.
>>
>> unreferenced object 0xffff888160f75c00 (size 512):
>>    comm "check", pid 29719, jiffies 4302480465
>>    hex dump (first 32 bytes):
>>      00 00 00 00 00 00 00 00 08 5c f7 60 81 88 ff ff  .........\.`....
>>      08 5c f7 60 81 88 ff ff 18 5c f7 60 81 88 ff ff  .\.`.....\.`....
>>    backtrace (crc dc08e6b1):
>>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>>      blk_throtl_init+0xa2/0x6a0
>>      tg_set_limit+0x5ac/0x720
>>      cgroup_file_write+0x1ab/0x670
>>      kernfs_fop_write_iter+0x3a3/0x5a0
>>      vfs_write+0x525/0xfd0
>>      ksys_write+0xf9/0x1d0
>>      do_syscall_64+0x94/0x8d0
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> unreferenced object 0xffff888111280c00 (size 512):
>>    comm "check", pid 30240, jiffies 4302503636
>>    hex dump (first 32 bytes):
>>      00 00 00 00 00 00 00 00 08 0c 28 11 81 88 ff ff  ..........(.....
>>      08 0c 28 11 81 88 ff ff 18 0c 28 11 81 88 ff ff  ..(.......(.....
>>    backtrace (crc 2d0490fe):
>>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>>      blk_throtl_init+0xa2/0x6a0
>>      tg_set_limit+0x5ac/0x720
>>      cgroup_file_write+0x1ab/0x670
>>      kernfs_fop_write_iter+0x3a3/0x5a0
>>      vfs_write+0x525/0xfd0
>>      ksys_write+0xf9/0x1d0
>>      do_syscall_64+0x94/0x8d0
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> unreferenced object 0xffff888187ac6400 (size 512):
>>    comm "check", pid 30484, jiffies 4302512625
>>    hex dump (first 32 bytes):
>>      00 00 00 00 00 00 00 00 08 64 ac 87 81 88 ff ff  .........d......
>>      08 64 ac 87 81 88 ff ff 18 64 ac 87 81 88 ff ff  .d.......d......
>>    backtrace (crc 4a3a862a):
>>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>>      blk_throtl_init+0xa2/0x6a0
>>      tg_set_limit+0x5ac/0x720
>>      cgroup_file_write+0x1ab/0x670
>>      kernfs_fop_write_iter+0x3a3/0x5a0
>>      vfs_write+0x525/0xfd0
>>      ksys_write+0xf9/0x1d0
>>      do_syscall_64+0x94/0x8d0
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> unreferenced object 0xffff88822cbf3800 (size 512):
>>    comm "check", pid 30715, jiffies 4302520405
>>    hex dump (first 32 bytes):
>>      00 00 00 00 00 00 00 00 08 38 bf 2c 82 88 ff ff  .........8.,....
>>      08 38 bf 2c 82 88 ff ff 18 38 bf 2c 82 88 ff ff  .8.,.....8.,....
>>    backtrace (crc 7eb87e87):
>>      __kmalloc_cache_node_noprof+0x3b1/0x4d0
>>      blk_throtl_init+0xa2/0x6a0
>>      tg_set_limit+0x5ac/0x720
>>      cgroup_file_write+0x1ab/0x670
>>      kernfs_fop_write_iter+0x3a3/0x5a0
>>      vfs_write+0x525/0xfd0
>>      ksys_write+0xf9/0x1d0
>>      do_syscall_64+0x94/0x8d0
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>
> 
> +CC Han Guangjiang
> 
> Thanks for the test, clearly this is because blkg_destroy_all() already
> clear the policy bit, and later blk_throtl_exit() fail the
> blk_throtl_activated() test.
> 
> I think we should call blk_throtl_exit() before blkg_destroy_all().
> 

Still no response from Han Guangjiang, I'll send a fix ASAP today.

Thanks,
Kuai

> Thanks,
> Kuai
> 
> .
> 

