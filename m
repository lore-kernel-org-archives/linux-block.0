Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892C3947AC
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735241; cv=none; b=hdE6aumvRM/hnjhqVtsZRVZWwConZumc1Bn8WyI14GLgOLXRasS/KVBasBHQJfg4/pMZgjqQYSNPEr//TrrkImHi0YGbRRupSs0p4cKSbsHUzMaE72UsYoEabBRp3sXKuf0oAHESUaqLzkx+oDYy+XArL8cKw5l30ARYQBWJsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735241; c=relaxed/simple;
	bh=S5TsBvBSErp0VfCbfX7JBR9fifqaCus9lWHmv1i3Mrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aG12O7/XtVzNeBalzsv/IaRlid4gtanNSHE74n+LkqW2H7NSvb4LIiX1l2TJ/RgfJ/Qzg40wj+zpUY8V45x+85D5LfiEAnv6E0ZUONDIGZc3HJmRXE+ygk/AebbkXhbmELhhd/06aksAGsBXJ4BfZfj/WF79DPhdOkizXuvpaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fZl7v02lTzYQv46
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:12:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F6144057D
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:13:56 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with SMTP id cCh0CgC3utpCDblp21_XBA--.60399S3;
	Tue, 17 Mar 2026 16:13:56 +0800 (CST)
Message-ID: <bc5dda8a-7b43-45e2-8888-cf8c37f53483@huaweicloud.com>
Date: Tue, 17 Mar 2026 16:13:54 +0800
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
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <abkEKqXG_FkZe-l_@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3utpCDblp21_XBA--.60399S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13Ar1ktF1xAF13tFWrZrb_yoW8Xw18pF
	W7W390kF48Ar9Ikrn3ta1aqay3X3yrJrZIkrn5AF4fWFn0vry5Kr1I93409FZYkasruaya
	93yYqryfJ3WUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/3/17 15:37, Shinichiro Kawasaki 写道:
> On Mar 16, 2026 / 16:44, Zizhi Wo wrote:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> This series contains two minor patches for blk-throttle.
>>
>> Patch1: simple cleanup
>> Patch2: fix timer scheduled on tg_flush_bios()
>>
>> Zizhi Wo (2):
>>    blk-throttle: remove leftover carryover checks in
>>      tg_within_[bps/iops]_limit
>>    blk-throttle: fix timer scheduled on wrong service_queue in
>>      tg_flush_bios
> 
> Hello ZiZhi, just FYI. Blktests CI trial run found that this series triggered
> the failure of the test case throtl/004 with sdebug:
> 
> throtl/004 (nullb) (delete disk while IO is throttled)
> throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
>      runtime    ...  1.667s
> throtl/004 (sdebug) (delete disk while IO is throttled)
> throtl/004 (sdebug) (delete disk while IO is throttled)      [failed]
>      runtime    ...  3.273s
>      --- tests/throtl/004.out	2026-03-16 10:29:46.761897543 +0000
>      +++ /home/fedora/blktests/results/nodev_sdebug/throtl/004.out.bad	2026-03-16 13:31:54.355173644 +0000
>      @@ -1,3 +1,2 @@
>       Running throtl/004
>      -Input/output error
>       Test complete

Hi, I'm very sorry for my oversight. I have already identified the issue
with the first patch in the patch set and replied to it myself. I will
review more carefully next time. Please ignore the first patch (although
the throtl test case did pass locally...)

I'd like to ask whether applying only the second patch can pass the
corresponding tests in your environment?

Thanks,
Zizhi Wo

