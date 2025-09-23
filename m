Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98A2C1590
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618958; cv=none; b=BoEBMVWRmxSL21oBK2UGDpGsfBpUpXmCdnJwJelhKbezzrE23db10cGb1JnglFK6b1gPAvQ/KY+BGzGr/CHILsq2uLkRAJAlaqfIYquoE59FeeCO8F/9j6jtZ8iOEpRZRbhyZ1O1lURB5lAa4ZS8hG88Bui+mCLcv+SaCn7FlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618958; c=relaxed/simple;
	bh=GUnuzc0xCFE3Z2h7eCKDpGZUK9sy6TddMY50337fpB4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JkJBl8dMF/bzS/5v+qjFvvvI2p0ZGFolv6eQ8we/1OU/6nXfnGWVNhSKrEJmvgYLxLC39vTF+F/H+SYMdu/02UUu6BszGrnAnsvZi8TG2DNEMwYUKxbIQll0fEXEdJ68EzXD/eUZZhC5Kcykx8koNmRC1yiUGlcoD9NIM4UPBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cWDq80LX2zKHMrv
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 17:15:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0729E1A1A13
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 17:15:53 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDX6GBIZdJoyQsrAg--.16722S3;
	Tue, 23 Sep 2025 17:15:52 +0800 (CST)
Subject: Re: [PATCH 0/1] tests/throtl: add a deadlock regression test
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "nilay@linux.ibm.com" <nilay@linux.ibm.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "johnny.chenyi@huawei.com" <johnny.chenyi@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
 <d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzh@coj4djvqosml>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <84b4ee8d-1e79-66a7-9097-16a999a5dcde@huaweicloud.com>
Date: Tue, 23 Sep 2025 17:15:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzh@coj4djvqosml>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDX6GBIZdJoyQsrAg--.16722S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45Wry7GFyUZw17Xr43Wrg_yoWrAr1rpF
	WUWw47Kr1fZr929rnIyan8XFW5Z398JrsxC345W3WUZF1qk340gr9rtw1F9FZ7J3ZrWa48
	Z348XFyxJF1DJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/09/23 16:12, Shinichiro Kawasaki 写道:
> On Sep 18, 2025 / 16:53, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> While I'm looking at another deadlock issue for blk-throtl, it's found
>> during test that lockdep is reporting another issue quite eazy, I'm
>> adding regerssion test for now, if anyone is interested. Otherwise, I'll
>> go back for this after I finish the problem at hand later.
>>
>> BTW, maybe we can support to test for scsi_debug instead of null_blk for
>> all the throtl tests.
> 
> This is a good chance to use blktests' feature to repeat test cases by different
> conditions [1]. Test cases can implement set_conditions() hooks for that
> purpose.
> 
> [1] https://github.com/linux-blktests/blktests/blob/a997ab0ca9b77ddf31b8c632bfe57f7bd75e305e/new#L183
> 
> Yu, FYI, I quickly implemented the set_conditions() hooks for the throtl group,
> and attach it as a patch. When you have time, please try it out. Each test case
> runs twice for null_blk and scsi_debug [2].
> 
> - With this patch, the lockdep splat is recreated at throtl/004. It is
>    observed at throtl/001 also as show in [2].
> - throtl/002 fails for scsi_debug. I guess performance difference between
>    null_blk and scsi_debug is the cause, but not so sure.
> - Results are placed in results/nodev_nullb and results/nodev_sdebug.
> 
> If you think this approach is good, I will prepare a formal patch series.
> 
> 

I do not look into the patch in detail, however, I think this is
perfect.
> [2]
> 
> # ./check throtl
> throtl/001 (nullb) (basic functionality)                     [passed]
>      runtime  4.546s  ...  4.753s
> throtl/001 (sdebug) (basic functionality)                    [failed]
>      runtime  5.386s  ...  5.842s
>      something found in dmesg:
>      [   79.444897] [   T1156] run blktests throtl/001 at 2025-09-23 17:05:22
>      [   79.684859] [   T1260] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
>      [   80.002576] [   T1262] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
>      [   80.003950] [   T1262] scsi host9: scsi_debug: version 0191 [20210520]
>                                  dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
>      [   80.009307] [   T1262] scsi 9:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
>      [   80.011952] [      C2] scsi 9:0:0:0: Power-on or device reset occurred
>      [   80.018583] [   T1262] sd 9:0:0:0: Attached scsi generic sg3 type 0
>      [   80.020594] [    T103] sd 9:0:0:0: [sdd] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
>      [   80.022826] [    T103] sd 9:0:0:0: [sdd] Write Protect is off
>      ...
>      (See '/home/shin/Blktests/blktests/results/nodev_sdebug/throtl/001.dmesg' for the entire message)
> throtl/002 (nullb) (iops limit over IO split)                [passed]
>      runtime  2.586s  ...  2.486s
> throtl/002 (sdebug) (iops limit over IO split)               [failed]
>      runtime  6.137s  ...  6.467s
>      --- tests/throtl/002.out    2025-09-23 14:05:35.011885439 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev_sdebug/throtl/002.out.bad    2025-09-23 17:05:37.209794003 +0900
>      @@ -1,4 +1,4 @@
>       Running throtl/002
>      -1
>      -1
>      +3
>      +3

I don't feel this is related to performance, we'll have to check later.

Thanks,
Kuai

>       Test complete
> throtl/003 (nullb) (bps limit over IO split)                 [passed]
>      runtime  2.554s  ...  2.424s
> throtl/003 (sdebug) (bps limit over IO split)                [passed]
>      runtime  3.075s  ...  2.924s
> throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
>      runtime  1.269s  ...  1.071s
> throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
>      runtime  2.142s  ...  1.471s
> throtl/005 (nullb) (change config with throttled IO)         [passed]
>      runtime  3.345s  ...  3.420s
> throtl/005 (sdebug) (change config with throttled IO)        [passed]
>      runtime  3.905s  ...  3.984s
> throtl/006 (nullb) (test if meta IO has higher priority than data IO) [passed]
>      runtime  13.014s  ...  13.086s
> throtl/006 (sdebug) (test if meta IO has higher priority than data IO) [passed]
>      runtime  5.715s  ...  5.631s
> throtl/007 (nullb) (bps limit with iops limit over io split) [passed]
>      runtime  4.527s  ...  4.476s
> throtl/007 (sdebug) (bps limit with iops limit over io split) [passed]
>      runtime  5.065s  ...  5.043s
> 

