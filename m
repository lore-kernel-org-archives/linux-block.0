Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DEC211F
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756082535; cv=none; b=gObV06j7T/UP4PisGR47RqR4vznc3AD0X/5W+KLvqMun5uzg/nkTqLnH5BeYONKOLX20MkGO+OdAPCSh6c1rgmuaaEr0ZYGbmEmYyuPglzu5UNS/8zV7Tx9IeF4W8wNRiJJzox3aJ+8XoIvMuFgSeLNu1xlsYZtHxES0ROFI2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756082535; c=relaxed/simple;
	bh=RM1RcV3i+3kNrRpVNWATLOe1VYDX6UVr2Rj8aKUJO5k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qvGHC60Uzo43Ny7VskbVRwWaWJs4bv9Zh7bn5Kp9HSLzqu56rDsTE9/phuuR6i4RqZ2/SxBOS9Egg4Eiy30MrvwEodvS/81ga9PLDwyh6bdFvEFilODgQsgESLYhDBNp9EI60wmkjZaLwsfBRr49EskB0G0IPe5V+YfMpeGnX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9Bnl1RkVzYQvdv
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 08:42:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BCCA31A1ABC
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 08:42:01 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY5WsatoSQnGAA--.52001S3;
	Mon, 25 Aug 2025 08:41:59 +0800 (CST)
Subject: Re: [bug report][regression] blktests loop/004 failed
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
Cc: rajeevm@hpe.com, Ming Lei <ming.lei@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs8+9S7_4H03_dcNS-wMrT_9iUpSWPF+ic5gRHmfC4dx+Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <68e71471-46cb-2b77-c9cf-e1710c4ce762@huaweicloud.com>
Date: Mon, 25 Aug 2025 08:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHj4cs8+9S7_4H03_dcNS-wMrT_9iUpSWPF+ic5gRHmfC4dx+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY5WsatoSQnGAA--.52001S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13ZFWkXrW7WrWrury3urg_yoW8Kry7pr
	W7Xa1Ikr1rZr17CF1Ika98JFy8ZrZ8JFWUJw1fG34kJr12y3s3Ar93G3y8AFZ7A39xXF1U
	uFnrCFyUAr4kJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/24 22:05, Yi Zhang 写道:
> Hi
> 
> I found the blktests loop/004[1] failed on the latest
> linux-block/for-next, and it was introduced from the commit[2] from my
> testing,
> please help check it and let me know if you need any info/testing, thanks.
> 
> [1]
> # ./check loop/004
> loop/004 (combine loop direct I/O mode and a custom block size) [failed]
>      runtime  2.770s  ...  5.375s
>      --- tests/loop/004.out 2025-08-24 01:41:06.768628600 -0400
>      +++ /root/blktests/results/nodev/loop/004.out.bad 2025-08-24
> 10:01:44.489825116 -0400
>      @@ -1,4 +1,5 @@
>       Running loop/004
>       1
>      -769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78  -
>      +pwrite: No space left on device
>      +e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  -
>       Test complete

This looks like the same as:

https://lore.kernel.org/all/79ab5533-82d1-4f06-461b-689e94f738ec@huaweicloud.com/

However, I'm not sure if people will agree to change file size for block
inode returned by syscall from 0 to disk size. I'll send a patch later
today.

Thanks,
Kuai
> [2]
> 47b71abd5846 loop: use vfs_getattr_nosec for accurate file size
> [3] dmesg
> [  279.880860] run blktests loop/004 at 2025-08-24 10:01:38
> [  280.249598] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> poll_queues to 0. poll_q/nr_hw = (0/1)
> [  280.259112] scsi host10: scsi_debug: version 0191 [20210520]
>                   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  280.289850] scsi 10:0:0:0: Direct-Access     Linux    scsi_debug
>     0191 PQ: 0 ANSI: 7
> [  280.302147] scsi 10:0:0:0: Power-on or device reset occurred
> [  280.336792] sd 10:0:0:0: Attached scsi generic sg5 type 0
> [  280.342300] sd 10:0:0:0: [sdf] 2048 4096-byte logical blocks: (8.39
> MB/8.00 MiB)
> [  280.343809] sd 10:0:0:0: [sdf] Write Protect is off
> [  280.343925] sd 10:0:0:0: [sdf] Mode Sense: 73 00 10 08
> [  280.347889] sd 10:0:0:0: [sdf] Write cache: enabled, read cache:
> enabled, supports DPO and FUA
> [  280.355174] sd 10:0:0:0: [sdf] permanent stream count = 5
> [  280.359355] sd 10:0:0:0: [sdf] Preferred minimum I/O size 4096 bytes
> [  280.359503] sd 10:0:0:0: [sdf] Optimal transfer size 4194304 bytes
> [  280.506461] sd 10:0:0:0: [sdf] Attached SCSI disk
> [  285.158954] sd 10:0:0:0: [sdf] Synchronizing SCSI cache
> 

