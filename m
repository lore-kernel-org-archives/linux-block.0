Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6B3BD62C
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749657; cv=none; b=P1WkZ0BKcCdkgDGQxPvmsjWXD1z7vwBy1GaOImeNW7R3QQUlsnJCahTikJ1k6QgXG1W16zQEoN+am34+uZd+4nYIICcn/Sbr8Qzst2V59O9XPOs4dvTdvtfE+T0YwMjCK9nIz2R2wOQQkqSxdwEKeMdL2FKazdl7oDrtpzdhwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749657; c=relaxed/simple;
	bh=McV1kPhilBdgtJZQD0Sj2c6QUB9bHsSHosTvVUM88VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeySOkhXtRhIWEYZ4UzxLx7LDHiQGMkkxHACXUeIUZe+iP3o6A5vqD0lZUukcQ9DkBdUA4jFQ4t9h6Wr04nZyV2OKVe7EN4NHCzXHr5Wk4zCDWnMiswmXsV0/K9XyAwUMd/avGnCznPrLsfoANBSwOM08ZQpsdwMJ6zrTUT3nXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fZr751SzPzYQthV
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 19:57:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BF5D44058C
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 19:58:34 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with SMTP id cCh0CgCHitrpQblpkm_qBA--.65349S3;
	Tue, 17 Mar 2026 19:58:34 +0800 (CST)
Message-ID: <12cbc935-f2b3-4d8a-bf73-0baae3ff6857@huaweicloud.com>
Date: Tue, 17 Mar 2026 19:58:32 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] blk-throttle: minor fixes and cleanup
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "yukuai@fnnas.com"
 <yukuai@fnnas.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>
References: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
 <abkEKqXG_FkZe-l_@shinmob>
 <bc5dda8a-7b43-45e2-8888-cf8c37f53483@huaweicloud.com>
 <abk8PK0cOI_CxieN@shinmob>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <abk8PK0cOI_CxieN@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHitrpQblpkm_qBA--.65349S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF48XFWUWFW8Zw4kWFy3Arb_yoW5GF4DpF
	W7Wa98tr4kJrn0kr1ftanxXayav3yfJryDXrn5JF4fWFn0v3WUKF1a9ry09FWv9F9ru3yS
	vw45XryxX3WUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/3/17 19:41, Shinichiro Kawasaki 写道:
> On Mar 17, 2026 / 16:13, Zizhi Wo wrote:
>>
>>
>> 在 2026/3/17 15:37, Shinichiro Kawasaki 写道:
>>> On Mar 16, 2026 / 16:44, Zizhi Wo wrote:
>>>> From: Zizhi Wo <wozizhi@huawei.com>
>>>>
>>>> This series contains two minor patches for blk-throttle.
>>>>
>>>> Patch1: simple cleanup
>>>> Patch2: fix timer scheduled on tg_flush_bios()
>>>>
>>>> Zizhi Wo (2):
>>>>     blk-throttle: remove leftover carryover checks in
>>>>       tg_within_[bps/iops]_limit
>>>>     blk-throttle: fix timer scheduled on wrong service_queue in
>>>>       tg_flush_bios
>>>
>>> Hello ZiZhi, just FYI. Blktests CI trial run found that this series triggered
>>> the failure of the test case throtl/004 with sdebug:
>>>
>>> throtl/004 (nullb) (delete disk while IO is throttled)
>>> throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
>>>       runtime    ...  1.667s
>>> throtl/004 (sdebug) (delete disk while IO is throttled)
>>> throtl/004 (sdebug) (delete disk while IO is throttled)      [failed]
>>>       runtime    ...  3.273s
>>>       --- tests/throtl/004.out	2026-03-16 10:29:46.761897543 +0000
>>>       +++ /home/fedora/blktests/results/nodev_sdebug/throtl/004.out.bad	2026-03-16 13:31:54.355173644 +0000
>>>       @@ -1,3 +1,2 @@
>>>        Running throtl/004
>>>       -Input/output error
>>>        Test complete
>>
>> Hi, I'm very sorry for my oversight. I have already identified the issue
>> with the first patch in the patch set and replied to it myself. I will
>> review more carefully next time. Please ignore the first patch (although
>> the throtl test case did pass locally...)
> 
> Thanks for the explanation, no problem for me.
> 
>>
>> I'd like to ask whether applying only the second patch can pass the
>> corresponding tests in your environment?
> 
> Sure, I ran throtl/004 on the kernel v7.0-rc4 + the second patch "blk-throttle:
> fix timer scheduled on wrong service_queue in tg_flush_bios" only.
> Unfortunately, I still see the test case fails for scsi_debug.

Oh, that is strange. I wasn't able to reproduce it locally. Based on
theoretical analysis, the tg should be placed into
sq->parent_sq->pending_tree for scheduling (tg_service_queue_add), and I
haven't been able to identify the root cause :(

__del_gendisk() will set GD_DEAD first, then call
blk_throtl_cancel_bios->tg_flush_bios; bio_io_error() will set EIO. So
I'm not sure why the current test case doesn't show an "Input/output
error" — it seems like the bio was submitted early or got lost? There
may be some cases I haven't considered. In any case, thanks for
providing the test.

Thanks,
Zizhi Wo

