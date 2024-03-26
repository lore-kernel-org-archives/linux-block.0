Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B881CFB2
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416774; cv=none; b=ZM9WKrvJbvH2C6xKREDAvvChh6xk8rFTpRygR4dcglXMOyXfiAv6U+KRhyX2MPJd1nB/CCakfX30qDPeEvf/4TThBmw1sHhfGAuRmXbd9G/E0UMZOg3TTb6W14HX/YoRcsqFAiqjlS1huY/1jcn8k+yyMLfMW8YfQsL3OOy+75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416774; c=relaxed/simple;
	bh=FQTD2jL1kqgNVhP8nXZTPbgoM134O0Gc9E7vDPgx55g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A1jeLVcY7KCzD4437moE7/uQebjNKc3paDqD5eIvj5rmI8to2hgqZ0qU0W8OUhsA5k68dKJIhqog3cYNJ4G0qVPuiNOHtq/PAzcmvHEFJqO4Ph6b2gLm8UBq9qtja4WRdekvgYim50R/IQWDJUCqAMFDT3QrCQkQMcAqN+rOrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3XNh3tQCz4f3js2
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 09:32:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B3D0E1A08FC
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 09:32:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g64JQJmNEBeIA--.15779S3;
	Tue, 26 Mar 2024 09:32:42 +0800 (CST)
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
To: Christian Brauner <brauner@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <3594bd44-4c6b-d079-1209-f069353ccd58@huaweicloud.com>
 <20240325-entsolidarisierung-kapital-5897091cdd25@brauner>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <38ea7bc9-4d6c-c76c-e546-ffe7ceea27cb@huaweicloud.com>
Date: Tue, 26 Mar 2024 09:32:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325-entsolidarisierung-kapital-5897091cdd25@brauner>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g64JQJmNEBeIA--.15779S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4rJF4kAw43Ary7XryUGFg_yoW5Ar1xp3
	yrua1qkrn8Crn2k3ZrZ3WxXF1Fkr4Dtwn8uFyqgr9rA3y5Zrn7Xa1Igw1Y9FyUArs7Xw4j
	qFs5uryxJ34Fk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/25 21:54, Christian Brauner 写道:
> On Mon, Mar 25, 2024 at 07:51:27PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/03/24 0:11, Christian Brauner 写道:
>>> Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
>>> default this option is set. When it is set the long-standing behavior
>>> of being able to write to mounted block devices is enabled.
>>>
>>> But in order to guard against unintended corruption by writing to the
>>> block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
>>> off. In that case it isn't possible to write to mounted block devices
>>> anymore.
>>>
>>> A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
>>> which disallows concurrent BLK_OPEN_WRITE access. When we still had the
>>> bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
>>> the mode was passed around. Since we managed to get rid of the bdev
>>> handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
>>> on whether the file was opened writable and writes to that block device
>>> are blocked. That logic doesn't work because we do allow
>>> BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
>>
>> I don't get it here, looks like there are no such use case. All users
>> passed in BLK_OPEN_RESTRICT_WRITES together with BLK_OPEN_WRITE.
>>
>> Is the following root cause here?
>>
>> 1) t1 open with BLK_OPEN_WRITE
>> 2) t2 open with BLK_OPEN_RESTRICT_WRITES, with bdev_block_writes(), yes
>> we don't wait for t1 to close;
>> 3) t1 close, after the commit, bdev_unblock_writes() is called
>> unexpected.
>>
>> Following openers will succeed although t2 doesn't close;
>>>
>>> So fix the detection logic. Use O_EXCL as an indicator that
>>> BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
>>> for pidfds where O_EXCL means that this is a pidfd that refers to a
>>> thread. For userspace open paths O_EXCL will never be retained but for
>>> internal opens where we open files that are never installed into a file
>>> descriptor table this is fine.
>>
>>  From the path blkdev_open(), the file is from devtmpfs, and user can
>> pass in O_EXCL for that file, and that file will be used later in
>> blkdev_release() -> bdev_release() -> bdev_yield_write_access().
> 
> It can't because the VFS strips O_EXCL after the file has been opened.
> Only internal opens can retain this flag. See do_dentry_open(). Or do
> you mean something else?

Yes, I see that now, thanks for the explanation and forgive me that I'm
not that familiar with vfs code. :(

Now I think the patch can actually fix the problem, blkdev_open() and
blkdev_release() is not affected, and O_EXCL is not used from
bdev_file_open_by_dev() before. This is not straightforward, however I
can't find a better solution myself, so feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> 

