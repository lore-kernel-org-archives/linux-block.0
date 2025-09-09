Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3251E5207
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406712; cv=none; b=DFFicsLai9spfWf0p8ekrTlqC9naVWNZXdCqRQCnVSEhUvJ4VAYiDqH2/sXeFpeDBnAWapB7anh8jE5VC+Z1eS6VtVbPahdCaMrToz3JwxPOJoQq5VMc39Ifbb4wtCIWT3BJwAfCnfVWNEbxlPbhCNix5zrjiQsSSkn7EhE9tMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406712; c=relaxed/simple;
	bh=ZHUwDNIS7BPCsYwlhBI5oXSK8Ru0cfQ2nbqr4xbGi9M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=my+PlVRTYUqU0bxDrrzQDJruDXNPVeY1Q8mAjIDv3DGyt/igmVJEMiE6Z7KXOxGeiZvdqU286+R7658VToIKBJEGdfATSwEHDwpp+WPDIKd7BtpdD8JgwC0pF7+zQqgMCcwZsX9yO7Ymz3+F2yxa7GYjPEkeHhOxfPDAHCSYqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cLcVs5049zYQvGf;
	Tue,  9 Sep 2025 16:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3549F1A1CAB;
	Tue,  9 Sep 2025 16:31:48 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIzy5b9obFugBw--.8058S3;
	Tue, 09 Sep 2025 16:31:47 +0800 (CST)
Subject: Re: [GIT PULL] md-6.17-20250909
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, inux-raid@vger.kernel.org, song@kernel.org
Cc: linan122@huawei.com, xni@redhat.com, colyli@kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c7631240-4818-44c1-75c1-7670a43444ba@huaweicloud.com>
Date: Tue, 9 Sep 2025 16:31:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIzy5b9obFugBw--.8058S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18Zr1UCryrGr15tw43ZFb_yoW5ZF43p3
	9xJ34agw15JF47XF13JryUCF1rXwn7tr9xtrn7Cw1rWa4DZF9xJr48GF18J3srWry5JF1D
	Jr15JFn8Wr15XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens

ÔÚ 2025/09/09 16:20, Yu Kuai Ð´µÀ:
> Hi, Jens
> 
> Please consider pulling following changes on your for-6.18/block branch,
> this pull request contains:
> 
>   - add kconfig for internal bitmap;
>   - introduce new experimental feature lockless bitmap;
> 
> Thanks,
> Kuai
> 

Please ignore the typo in tittle, it's md-6.18-20250909 :)

Thanks,
Kuai

> The following changes since commit ba28afbd9eff2a6370f23ef4e6a036ab0cfda409:
> 
>    blk-mq: fix blk_mq_tags double free while nr_requests grown (2025-09-05 13:52:52 -0600)
> 
> are available in the Git repository at:
> 
>    https://kernel.googlesource.com/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.18-20250909
> 
> for you to fetch changes up to 5ab829f1971dc99f2aac10846c378e67fc875abc:
> 
>    md/md-llbitmap: introduce new lockless bitmap (2025-09-06 17:27:51 +0800)
> 
> ----------------------------------------------------------------
> Yu Kuai (24):
>        md/md-bitmap: remove the parameter 'init' for bitmap_ops->resize()
>        md/md-bitmap: merge md_bitmap_group into bitmap_operations
>        md/md-bitmap: add a new parameter 'flush' to bitmap_ops->enabled
>        md/md-bitmap: add md_bitmap_registered/enabled() helper
>        md/md-bitmap: handle the case bitmap is not enabled before start_sync()
>        md/md-bitmap: handle the case bitmap is not enabled before end_sync()
>        md/raid1: check bitmap before behind write
>        md/raid1: check before referencing mddev->bitmap_ops
>        md/raid10: check before referencing mddev->bitmap_ops
>        md/raid5: check before referencing mddev->bitmap_ops
>        md/dm-raid: check before referencing mddev->bitmap_ops
>        md: check before referencing mddev->bitmap_ops
>        md/md-bitmap: introduce CONFIG_MD_BITMAP
>        md: add a new parameter 'offset' to md_super_write()
>        md: factor out a helper raid_is_456()
>        md/md-bitmap: support discard for bitmap ops
>        md: add a new mddev field 'bitmap_id'
>        md/md-bitmap: add a new sysfs api bitmap_type
>        md/md-bitmap: delay registration of bitmap_ops until creating bitmap
>        md/md-bitmap: add a new method skip_sync_blocks() in bitmap_operations
>        md/md-bitmap: add a new method blocks_synced() in bitmap_operations
>        md: add a new recovery_flag MD_RECOVERY_LAZY_RECOVER
>        md/md-bitmap: make method bitmap_ops->daemon_work optional
>        md/md-llbitmap: introduce new lockless bitmap
> 
>   Documentation/admin-guide/md.rst |   86 +++++---
>   drivers/md/Kconfig               |   29 +++
>   drivers/md/Makefile              |    4 +-
>   drivers/md/dm-raid.c             |   18 +-
>   drivers/md/md-bitmap.c           |   89 ++++----
>   drivers/md/md-bitmap.h           |  107 +++++++++-
>   drivers/md/md-cluster.c          |    2 +-
>   drivers/md/md-llbitmap.c         | 1626 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/md/md.c                  |  378 +++++++++++++++++++++++++++-------
>   drivers/md/md.h                  |   24 ++-
>   drivers/md/raid1-10.c            |    2 +-
>   drivers/md/raid1.c               |   79 ++++---
>   drivers/md/raid10.c              |   49 ++---
>   drivers/md/raid5.c               |   64 ++++--
>   14 files changed, 2313 insertions(+), 244 deletions(-)
>   create mode 100644 drivers/md/md-llbitmap.c
> 
> .
> 

