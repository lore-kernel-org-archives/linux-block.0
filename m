Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F71A28D
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709358; cv=none; b=gR2uJKLs+9bjw1dHtDkwYDpv56/xyzkevpUFzeQlQEAHxu0HZhzLtHNfG5uWEL938WxG4lPva/WgCRMLxxPCwKoKF9bE79lptlZxI/kIUCRwgcC1Fl27l7HQ2PNJg56LtDazJhnPmWuhyWuP6BkEefRRK3Do9Y4+/aZSHieoews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709358; c=relaxed/simple;
	bh=x9w1Ut/fnhHpblsUDSYibRgelltoD7TmJPq23xzc09o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EIpZ+CEqB64L3WjNkcpOEv0DEMbjK+kPPcJU9kN1/SpeqD1eotJkGlCl2o+olrnkIDMl5yEgdYeez3GGLkc6bqDVQBQcEM2yqxGyickc4SfSOOB00UFSsQkTfMrBaG5jx9+iPSzYxaTswaokdayAvTSooXeECxbfgGzK5yGXghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3sRM5f6zz4f3jLG
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 10:22:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 25CBF1A16EF
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 10:22:31 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGDlHcFnZwRrFA--.49268S3;
	Fri, 28 Feb 2025 10:22:31 +0800 (CST)
Message-ID: <0ef71f91-eaec-f268-7d29-521fdcecc5ca@huaweicloud.com>
Date: Fri, 28 Feb 2025 10:22:29 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To: linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>,
 "wanghai (M)" <wanghai38@huawei.com>
From: Li Nan <linan666@huaweicloud.com>
Subject: [BUG report] WARNING of sysfs in __blk_mq_update_nr_hw_queues()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGDlHcFnZwRrFA--.49268S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy7Cr1kArW7ZF1DZw48Xrb_yoWDKwb_Cr
	yFk3sYqw1Ygr43KFnFk3Z5Xr9FyrZ2v3yYga95XFZYyrn7tw4rGw47urnxWr40g3yIgFsI
	yr43Ga40yw4fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
	AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07Al
	zVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU8Y0P3UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

Hi,

In __blk_mq_update_nr_hw_queues(), we don't check the return value of
blk_mq_sysfs_register_hctxs(). When sysfs creation fails, there's no
proper error handling. This leads to a kernel warning during subsequent
__blk_mq_update_nr_hw_queues() calls or disk removal:

```
kernfs: can not remove 'nr_tags', no directory
WARNING: CPU: 2 PID: 805 at fs/kernfs/dir.c:1703 
kernfs_remove_by_name_ns+0x12e/0x140
Call Trace:
  <TASK>
  remove_files+0x39/0xb0
  sysfs_remove_group+0x48/0xf0
  sysfs_remove_groups+0x31/0x60
  __kobject_del+0x23/0xf0
  kobject_del+0x17/0x40
  blk_mq_unregister_hctx+0x5d/0x80
  blk_mq_sysfs_unregister_hctxs+0x89/0xd0
  blk_mq_update_nr_hw_queues+0x31c/0x820
  nullb_update_nr_hw_queues+0x71/0xe0 [null_blk]
  nullb_device_submit_queues_store+0xa4/0x130 [null_blk]
```

Should we add error checking for blk_mq_sysfs_register_hctxs() and
propagate the error to abort the update operation when it fails? This
would prevent subsequent operations from hitting invalid sysfs entries.

-- 
Thanks,
Nan

