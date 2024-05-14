Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F926AC6;
	Tue, 14 May 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697983; cv=none; b=sCJoyorFPKwFFR/op7LyphqGQ49sYHu4WjQP42qTG8sZbJT0Zl7kSL5y6dlf+JwycD3XJ5Oz7m9xjIxlTUVWQqMyeACPNJe/N9aaruj8HzMcz5iodjtgE8r4qkFv82x7rQYvzoOeLRaSyny7MpIaARnDqCwf8lmim++wGgXbfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697983; c=relaxed/simple;
	bh=+/x4OZ1CZLk/McL7IH0st3aRYP/5ffwp9KBEA3o8Y38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WveHNmg5f7B+KAIOL520LLthJdzuKHMAJN1lzyikAoHZCYaeL6mV5hkJibJNUQJwAfJBMlvjgXMxxYsvNgQhBSyj+S8Fbw6ZT0kYk/+N0pSON45a70IHLttimQuB+Yg3m028yiBoSbVRbrG9RB3BqL7w8amWT2anEEpXdYuOAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44EEjv03007902;
	Tue, 14 May 2024 23:45:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Tue, 14 May 2024 23:45:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44EEjurA007898
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 May 2024 23:45:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cfe6b902-5e2d-415d-afeb-672cafd8d0b7@I-love.SAKURA.ne.jp>
Date: Tue, 14 May 2024 23:45:57 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Sam Sun <samsun1006219@gmail.com>, Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
References: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
 <20240514103742.3137-1-hdanton@sina.com>
 <CAEkJfYPH3SJ6J3kLSjMGqkWOzgbgKZV_f2Hq05cpZZv7RmhvOg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAEkJfYPH3SJ6J3kLSjMGqkWOzgbgKZV_f2Hq05cpZZv7RmhvOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/14 21:07, Sam Sun wrote:
> I tried to run
> 
> # echo 0 > /proc/sys/kernel/hung_task_all_cpu_backtrace
> 
> before running the reproducer, the kernel stops panic. But still, even
> if I terminate the execution of the reproducer, kernel continues
> dumping task hung logs. After setting bung_task_all_cpu_backtrace back
> to 1, it panic immediately during next dump. So I guess it is still a
> task hung instead of general protection fault.

What execute_one() in the reproducer is doing is only

  int fd1 = open("/dev/sg0", O_RDONLY);
  int fd2 = open("/sys/module/sg/parameters/allow_dio", O_RDWR);
  write(fd2, "100\0", 4); // returns 4
  ioctl(fd1, FIBMAP, 0x20000140); // returns 2

. But your hung task report includes device rescan sequence.

 schedule+0x147/0x310 kernel/sched/core.c:6838
 io_schedule+0x87/0x100 kernel/sched/core.c:9044
 blk_mq_get_tag+0x509/0xba0 block/blk-mq-tag.c:187
 __blk_mq_alloc_requests+0xbc1/0x1710 block/blk-mq.c:499
 blk_mq_alloc_request+0x513/0xbc0 block/blk-mq.c:599
 scsi_alloc_request drivers/scsi/scsi_lib.c:1229 [inline]
 scsi_execute_cmd+0x17a/0x1140 drivers/scsi/scsi_lib.c:304
 scsi_vpd_inquiry drivers/scsi/scsi.c:312 [inline]
 scsi_get_vpd_size+0x2e3/0x6b0 drivers/scsi/scsi.c:363
 scsi_get_vpd_buf+0x89/0x460 drivers/scsi/scsi.c:433
 scsi_attach_vpd+0xdc/0x5e0 drivers/scsi/scsi.c:501
 scsi_rescan_device+0xd8/0x290 drivers/scsi/scsi_scan.c:1698
 ata_scsi_dev_rescan+0x1fe/0x3c0 drivers/ata/libata-scsi.c:4764
 process_one_work kernel/workqueue.c:3254 [inline]

Something is triggering this sequence, and writing to allow_dio interface
confuses the "if (sg_allow_dio && ...)" path in sg_start_req()
in drivers/scsi/sg.c ?

What happens if you disable

  sysfd = write(sysfd, input, hash - input + 1);

line (i.e. stop updating sg_allow_dio value) in the reproducer?

