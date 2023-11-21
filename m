Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7916F126
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 03:36:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZMlh2Nytz4f3n5r
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 19:36:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 83F821A03F4
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 19:36:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhBCllxl5jgiBg--.48821S3;
	Tue, 21 Nov 2023 19:36:36 +0800 (CST)
Subject: Re: [PATCH] block: move .bd_inode into 1st cacheline of block_device
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
References: <20231121101156.378105-1-ming.lei@redhat.com>
 <b07d6d9b-7926-d5b1-71ab-29640e2a84f8@huaweicloud.com>
 <ZVySp9kcDmpqcd9n@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b26a5acf-f421-dfc9-1eee-6faa4c1b6eb0@huaweicloud.com>
Date: Tue, 21 Nov 2023 19:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZVySp9kcDmpqcd9n@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhBCllxl5jgiBg--.48821S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7JFyxZFykCrW3ZrW7twb_yoW8Ww1rpF
	ZrJay7Gw48Kry7uas7A3WfZrySgFs7Cw1Ygry7WFy0yry3tF1vgw18Jrn0kF9F9rs2krW2
	qF4UXFWru3sFvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/11/21 19:21, Ming Lei 写道:
> On Tue, Nov 21, 2023 at 07:12:44PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/11/21 18:11, Ming Lei 写道:
>>> The .bd_inode field of block_device is used in IO fast path of
>>> blkdev_write_iter() and blkdev_llseek(), so it is more efficient to keep
>>> it into the 1st cacheline.
>>>
>>> .bd_openers is only touched in open()/close(), and .bd_size_lock is only
>>> for updating bdev capacity, which is in slow path too.
>>>
>>> So swap .bd_inode layout with .bd_openers & .bd_size_lock to move
>>> .bd_inode into the 1st cache line.
>>
>> This patch looks good, do you want me do take it for a v3 for the
>> other patchset?
> 
> Yeah, please take it.

Ok
> 
>>
>> And by the way, can we also move 'int bd_writers' to near 'atomic_t
>> bd_fsfreeze_count' to save 8 bytes(int 64bit platform)?
>>
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 07abd0165226..a47ab9249bdd 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -63,11 +63,11 @@ struct block_device {
>>          int                     bd_holders;
>>          struct kobject          *bd_holder_dir;
>>
>> +       int                     bd_writers;
>>          atomic_t                bd_fsfreeze_count; /* number of freeze
>> requests */
>>          struct mutex            bd_fsfreeze_mutex; /* serialize freeze/thaw
>> */
>>
>>          struct partition_meta_info *bd_meta_info;
>> -       int                     bd_writers;
> 
> Which tree are you talking about? I don't see 'bd_writers' in both
> linus tree and block-6.7, and for-6.8/block isn't open yet.

This is introduced from commit dc85fbc92365 ("block: Add config option
to not allow writing to mounted devices") from linux-next by Jan.

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> .
> 

