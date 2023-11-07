Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6E12E4B
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942C410A;
	Tue,  7 Nov 2023 01:44:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPjxK1NmSz4f3l78;
	Tue,  7 Nov 2023 17:44:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 37E621A0175;
	Tue,  7 Nov 2023 17:44:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhAUB0plLuQVAQ--.51858S3;
	Tue, 07 Nov 2023 17:44:54 +0800 (CST)
Subject: Re: [PATCH] blk-core: use pr_warn_ratelimited() in bio_check_ro()
To: "yebin (H)" <yebin10@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@lst.de, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Ming Lei <ming.lei@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
 <6549B3FC.1010700@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <43db8d24-aa70-3902-cee6-2879f8e8ff5e@huaweicloud.com>
Date: Tue, 7 Nov 2023 17:44:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6549B3FC.1010700@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhAUB0plLuQVAQ--.51858S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWDtry8Cr15Ww4UAFW7XFb_yoW8Cw48pr
	s7KF1rCrWj9r1kua1UJF17JFyrKF4UJw48Ar1UZF15tr45Gryjgr1xXr1vgF48tr4xWr4U
	XF10yry3ZF1UAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/11/07 11:50, yebin (H) 写道:
> 
> 
> On 2023/11/7 19:12, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> If one of the underlying disks of raid or dm is set to read-only, then
>> each io will generate new log, which will cause message storm. This
>> environment is indeed problematic, however we can't make sure our
>> naive custormer won't do this, hence use pr_warn_ratelimited() to
>> prevent message storm in this case.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 9d51e9894ece..fdf25b8d6e78 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -501,8 +501,8 @@ static inline void bio_check_ro(struct bio *bio)
>>       if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
>>           if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
>>               return;
>> -        pr_warn("Trying to write to read-only block-device %pg\n",
>> -            bio->bi_bdev);
>> +        pr_warn_ratelimited("Trying to write to read-only 
>> block-device %pg\n",
>> +                    bio->bi_bdev);
> Acctually, before commit  57e95e4670d1 ("block: fix and cleanup 
> bio_check_ro") , there's only print warning once.
> I wrote a patch earlier, set GD_ROWR_WARNED flag for disk after emit 
> warning. You can look at the patch in the
> attachment, Is it possible to solve your problem.

Yes, this can work, other than that I think the flag should be in
block_device instead of gendisk.

However, I'm not sure which is better for now, hope Christoph or Ming
or anyone can give some advise.

Thanks,
Kuai
>>           /* Older lvm-tools actually trigger this */
>>       }
>>   }
> 

