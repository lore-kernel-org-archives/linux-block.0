Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5723B62B
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426387; cv=none; b=qXRmTKfeV84Otg44A9f7VhnaPYMo+O6SkkLmsBsl7MvpQ6LkLgq7qNNoK7e+exBB19eh9N6CFr8ly6+X4VfdWYgd9Hu3W+ee2WStgmt4geRHGhOoTTa38paSVbRSmCx2RS+l2TT10cgJ184LGaEkF2LhB9O8w1UIOigNHQOPLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426387; c=relaxed/simple;
	bh=gIhKN4Zf8ykey467qRQgXKt0nHFDtwqw588/0Y3F8RI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XMQf3dCB0gPQMLyozm0uPhpm9h70i+u+ujDVxsB/Kt1PIKUVckmBuBVG6prwz1ekGNNLR9cf8kma2IAG+GTq6PvwAc5MAoJ9Yy6dtBeNZEXKJQyWM/yNDVfOPGMoLyIjclqKy5fhJainnpL/on6jEYCQ1LcfbHkyVyoyRgz0Ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cm5Dh3fXJzYQtmn
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 15:19:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2AACF1A10A9
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 15:19:41 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgD3TUaK+e1oAqJHAQ--.27073S3;
	Tue, 14 Oct 2025 15:19:39 +0800 (CST)
Subject: Re: [PATCH blktests 0/4] throtl: support test with scsi_debug
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e7f5e12e-5409-cb78-9990-f4c0b3142cc9@huaweicloud.com>
Date: Tue, 14 Oct 2025 15:19:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3TUaK+e1oAqJHAQ--.27073S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWkAFW3tw45ur1xZw47urg_yoWrZw48pa
	yUW3yrKr4xJF9I9rnIyanIqFWrJ395Ar47C343u345ZF4q9342gr12v34jgFZayF9rWryU
	Zw1kXFyfGF1UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUU
	U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/10/10 16:19, Shin'ichiro Kawasaki Ð´µÀ:
> Currently, the throtl test cases set up null_blk devices as test
> targets. It is desired to run the tests with scsi_debug devices also
> to expand test coverage and identify failures that do not surface with
> null_blk [1].
> 
> Per suggestion by Yu Kuai, this series supports running the throtl test
> cases with scsi_debug [2]. The first two patches prepare for the
> scsi_debug support. The third patch introduces the scsi_debug support.
> The forth patch supports running tests with both null_blk and scsi_debug
> in a single run.
> 
> Of note is that currently throtl/002 fails with scsi_debug. This needs
> further debug effort.
> 
> [1] https://lore.kernel.org/linux-block/20250918085341.3686939-1-yukuai1@huaweicloud.com/
> 
> [2] blktests console
> 
> $ sudo bash -c "THROTL_BLKDEV_TYPES='nullb sdebug' ./check throtl/"
> throtl/001 (nullb) (basic functionality)                     [passed]
>      runtime  4.479s  ...  4.541s
> throtl/001 (sdebug) (basic functionality)                    [passed]
>      runtime  5.276s  ...  5.426s
> throtl/002 (nullb) (iops limit over IO split)                [passed]
>      runtime  2.473s  ...  2.569s
> throtl/002 (sdebug) (iops limit over IO split)               [failed]
>      runtime  5.541s  ...  5.732s
>      --- tests/throtl/002.out    2025-09-23 14:05:35.011885439 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev_sdebug/throtl/002.out.bad    2025-10-10 16:53:39.032380883 +0900
>      @@ -1,4 +1,4 @@
>       Running throtl/002
>      -1
>      -1
>      +3
>      +2
>       Test complete

Thanks for the patch, I add some debug info and comfirm that the test
fail because the device max_sector_kb is not expected for scsi_debug,
we set it to page_size for null_blk, however, it's 4MB for scsi_debug.

cat /sys/block/${THROTL_DEV}/queue/max_sectors_kb

I didn't found how to set max_hw_sectors_kb for scsi_debug, however, we
can still set max_sector_kb like following:

diff --git a/tests/throtl/002 b/tests/throtl/002
index b082b99..8e52726 100755
--- a/tests/throtl/002
+++ b/tests/throtl/002
@@ -28,7 +28,13 @@ test() {
         fi

         io_size_kb=$(($(_throtl_get_max_io_size) * 1024))
-       block_size=$((iops * io_size_kb))
+       if [ ${io_size_kb} -gt ${page_size} ]; then
+               _throtl_set_max_io_size $((page_size / 1024))
+       fi
+
+       block_size=$((iops * page_size))
+
+       echo "io_size_kb $io_size_kb iops $iops"

         _throtl_set_limits wiops="${iops}"
         _throtl_test_io write "${block_size}" 1
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 70254f7..6c58d08 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -167,6 +167,10 @@ _throtl_get_max_io_size() {
         cat "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
  }

+_throtl_set_max_io_size() {
+       echo $1 > "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
+}
+

With this change, throtl/002 can pass for scsi_debug.

Thanks,
Kuai

> throtl/003 (nullb) (bps limit over IO split)                 [passed]
>      runtime  2.444s  ...  2.411s
> throtl/003 (sdebug) (bps limit over IO split)                [passed]
>      runtime  2.953s  ...  3.027s
> throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
>      runtime  1.087s  ...  1.044s
> throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
>      runtime  1.441s  ...  1.586s
> throtl/005 (nullb) (change config with throttled IO)         [passed]
>      runtime  3.405s  ...  3.412s
> throtl/005 (sdebug) (change config with throttled IO)        [passed]
>      runtime  3.972s  ...  4.162s
> throtl/006 (nullb) (test if meta IO has higher priority than data IO) [passed]
>      runtime  12.810s  ...  12.777s
> throtl/006 (sdebug) (test if meta IO has higher priority than data IO) [passed]
>      runtime  5.842s  ...  5.611s
> throtl/007 (nullb) (bps limit with iops limit over io split) [passed]
>      runtime  4.442s  ...  4.541s
> throtl/007 (sdebug) (bps limit with iops limit over io split) [passed]
>      runtime  4.959s  ...  4.986s
> 
> 
> Shin'ichiro Kawasaki (4):
>    throtl: introduce helper functions to manage test target block devices
>    throtl/004: adjust to scsi_debug
>    throtl/rc: support test with scsi_debug
>    throtl: support tests with both null_blk and scsi_debug in a single
>      run
> 
>   Documentation/running-tests.md |  17 ++++++
>   tests/throtl/001               |   4 ++
>   tests/throtl/002               |   9 ++-
>   tests/throtl/003               |   9 ++-
>   tests/throtl/004               |  10 ++-
>   tests/throtl/004.out           |   3 +-
>   tests/throtl/005               |   4 ++
>   tests/throtl/006               |   6 +-
>   tests/throtl/007               |   9 ++-
>   tests/throtl/rc                | 108 ++++++++++++++++++++++++++++++---
>   10 files changed, 157 insertions(+), 22 deletions(-)
> 

