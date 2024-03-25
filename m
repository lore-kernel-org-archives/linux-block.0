Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AE3DABFF
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374734; cv=none; b=rFatrwdD+MIOXeZyh9K2OtV/86kagclG5ovbT4UOMA1yi1NXaqmpZ3NX8gi7zcv0xgWCDXRDZZrOZkbkNxnO8S3n0wKoXokckazQmR16sUK5hXRbY2hPQk9wnvK7H+o2oKfhGepx3C/WSFm2E7X7IJAOF7Bgh4acUVZkyzmRyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374734; c=relaxed/simple;
	bh=tTaMjAy8VHExI+ugmEcOhE+W9MzDMvvUXxdC/E4G+r8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j1GHk2L8jySaxzw2AUltm+/hmhnMhQj2cbkCKEGFBV/cjZS8oDPiAp0hpa5vO8dueiur00WIoogKSkFi5/rjSiepuPfkGWMGfqryXoBNRoCFbcRP6nTdVTmR1YGHc7IImzO6TVgnfcDWiVkeyzmJKTHjtMjBkMeTEq+0NXS+SiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3DrK0lsKz4f3kj0
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 21:52:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 43C311A0172
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 21:52:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCFgQFm3e8sIA--.28489S3;
	Mon, 25 Mar 2024 21:52:07 +0800 (CST)
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
To: Christian Brauner <brauner@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <3594bd44-4c6b-d079-1209-f069353ccd58@huaweicloud.com>
 <20240325-ziehung-angetan-2703b0225ae5@brauner>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3e3eaa23-f0e0-f377-5d7b-f5f5889d8c44@huaweicloud.com>
Date: Mon, 25 Mar 2024 21:52:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325-ziehung-angetan-2703b0225ae5@brauner>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCFgQFm3e8sIA--.28489S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kryrury7XFWxCFy8Ar1UWrg_yoW8Ar18p3
	48WFs8Ar9xKrn7Kas7u3W8XFna9r4ktw45WFyqgrnrZ3y5AF97Xa12qw1q9FyDAr1xX3Wj
	vayru34UJa4Fkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/25 20:04, Christian Brauner 写道:
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
> 
> sb_open_mode() does
> 
> #define sb_open_mode(flags) \
>          (BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
>           (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))

Yes, you're right, thanks for the notice. And the problem that I
described should also exist.

BTW, do you agree that using O_EXCL is not correct here?

Thanks,
Kuai
> .
> 

