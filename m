Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005914F102
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361754; cv=none; b=hNwh8DDmvKYCNsFNOne8fnBfd1d8Dz1HdBCqXifJzClYLdaw05EWpS8z1RxJ98a8L9DxhoK+008INKUy+LO8tEAGotAdDYpuSGJRysRK6pzUKIi8FoLVY59S1wC3WgDaPUojXrm4MxtaERAkc+iGqrNuWNYC5NiI5DlUl7LthM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361754; c=relaxed/simple;
	bh=vG0P6R0UWjCaahI7aUT+t+QGnHLGXug0vHBEi7mI51E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IWiIbq8b1T6L0+/qbR9ASwVbDmsZsw8S7GkhoIBcBllSXG77UILfrYYk43y33PmPw5BDIoKKuVcudpX/VOACF398S+psWi6o4ureNsUPwyhVrPZfmUjhWbQWtFD7lk3bQ1PeV8hbuR6Fx6uH6v0gqqJ/ezv5448mFWky0O5Mbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XfGg36g2Yz4f3lVd
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 16:02:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 80E831A0568
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 16:02:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4eOOSNnAN3GAQ--.60536S3;
	Thu, 31 Oct 2024 16:02:24 +0800 (CST)
Subject: Re: [PATCH v3 blktests 0/5] add new tests for blk-throttle
To: Yu Kuai <yukuai1@huaweicloud.com>, saranyamohan@google.com,
 tj@kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com,
 Ming Lei <ming.lei@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240420084505.3624763-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <05380f47-13a0-cd25-8f34-003fc1a85729@huaweicloud.com>
Date: Thu, 31 Oct 2024 16:02:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240420084505.3624763-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4eOOSNnAN3GAQ--.60536S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF15Aw48AF15Kr4UtFWDurg_yoW8ur45p3
	y5GF4rKa1xJFnrJ3W3GanrKrWrXw4rGr47Aw17Xr13ZF10v3y7Gry29w1ftFWSyF17WryU
	Z3Wvqr4rG3WUZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUG0PhUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Tejun and Shinichiro

And +CC Ming

ÔÚ 2024/04/20 16:45, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> changes in v3:
>   - lots of style changes suggested by Shinichiro
> 
> changes in v2:
>   - move lots of functions to rc
> 
> Yu Kuai (5):
>    tests/throtl: add first test for blk-throttle
>    tests/throtl: add a new test 002
>    tests/throtl: add a new test 003
>    tests/throtl: add a new test 004
>    tests/throtl: add a new test 005

Do you guys have any suggestions on these tests? Our clients
report a problem that iops limit will cause IO hang, root cause
is the same as [1], and this behaviour is introduced by commit
9f5ede3c01f9 ("block: throttle split bio in case of iops limit"),
splited IO will be re throttled at the tail of bio list.

And we're planing to fix this(Our clients don't accept this behaviour),
by spliting bio-list into a bps throttled list and iops throttled list,
so if iops is within limit, splited IO can be dispatched directly. And
it'll be good to still have a place upstream for functional tests.

[1] https://lore.kernel.org/all/20240812150049.8252-1-ioworker0@gmail.com/

Thanks,
Kuai

> 
>   tests/throtl/001     | 39 ++++++++++++++++++
>   tests/throtl/001.out |  6 +++
>   tests/throtl/002     | 30 ++++++++++++++
>   tests/throtl/002.out |  4 ++
>   tests/throtl/003     | 32 +++++++++++++++
>   tests/throtl/003.out |  4 ++
>   tests/throtl/004     | 37 +++++++++++++++++
>   tests/throtl/004.out |  4 ++
>   tests/throtl/005     | 37 +++++++++++++++++
>   tests/throtl/005.out |  3 ++
>   tests/throtl/rc      | 96 ++++++++++++++++++++++++++++++++++++++++++++
>   11 files changed, 292 insertions(+)
>   create mode 100755 tests/throtl/001
>   create mode 100644 tests/throtl/001.out
>   create mode 100755 tests/throtl/002
>   create mode 100644 tests/throtl/002.out
>   create mode 100755 tests/throtl/003
>   create mode 100644 tests/throtl/003.out
>   create mode 100755 tests/throtl/004
>   create mode 100644 tests/throtl/004.out
>   create mode 100755 tests/throtl/005
>   create mode 100644 tests/throtl/005.out
>   create mode 100644 tests/throtl/rc
> 

