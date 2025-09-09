Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966623ABAF
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406859; cv=none; b=U8I3bIzR7htaj3ZUBwyqEoDmA4++KwI2oQ5OOwawSbgMxNCzGHAcKPGlzfefLd0/uDyvTWHEziM2KBHwdvCzYrPU1dkPOHpayVxcm7o2Ca8LDCs1Oh7czTmqAN6ghQtJI8iL9rti+WWBpPwsO1brCMVC0IXx0vTbKodSi2XAphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406859; c=relaxed/simple;
	bh=BZkU4cU6ZYEEog+repDlS7N9UQO2euRjHtBNr4Hsvf8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ErnN5xup6iEBLmc/QGlSH8XVETsZlwkoS8h5lcffzAJKruno4NSDZF2Sl4zWitPANIlzKT7UDfmnP6osOUbq5UZNMtJ5SOX82tbjMj6gX7yIv1zkBjtBiukiGUWRWSroIhu4OlmchKWCMF3L+r5/eIXp1kLBCy4PAdIedZfUfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cLcYg5wftzYQvFG
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:34:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54E121A0D06
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:34:14 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY6F5r9oTI2gBw--.25299S3;
	Tue, 09 Sep 2025 16:34:14 +0800 (CST)
Subject: Re: [PATCH 1/2] block: add a bio_init_inline helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250908105653.4079264-1-hch@lst.de>
 <20250908105653.4079264-2-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1113a7d3-dc6c-06c3-f58f-1a12454ebb4f@huaweicloud.com>
Date: Tue, 9 Sep 2025 16:34:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250908105653.4079264-2-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY6F5r9oTI2gBw--.25299S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF13AF17Gr1DGw15uFWruFg_yoWDCFbE9F
	1rXFZFqrn3Wr17ZF4UCF97ZrWj9as5uryIqFW2yay3XF13ZFyxG34kWw18Aw4YvFWkuFy5
	ZFyUtrWvyry0gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/09/08 18:56, Christoph Hellwig Ð´µÀ:
> Just a simpler wrapper around bio_init for callers that want to
> initialize a bio with inline bvecs.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---
>   block/bio.c                        | 7 +++++--
>   block/blk-crypto-fallback.c        | 3 +--
>   block/blk-map.c                    | 8 ++++----
>   drivers/md/bcache/debug.c          | 3 +--
>   drivers/md/bcache/io.c             | 3 +--
>   drivers/md/bcache/journal.c        | 2 +-
>   drivers/md/bcache/movinggc.c       | 2 +-
>   drivers/md/bcache/super.c          | 2 +-
>   drivers/md/bcache/writeback.c      | 2 +-
>   drivers/md/dm-bufio.c              | 2 +-
>   drivers/md/dm-flakey.c             | 2 +-
>   drivers/md/raid1.c                 | 2 +-
>   drivers/md/raid10.c                | 4 ++--
>   drivers/target/target_core_pscsi.c | 2 +-
>   fs/bcachefs/btree_io.c             | 2 +-
>   fs/bcachefs/journal.c              | 2 +-
>   fs/bcachefs/journal_io.c           | 2 +-
>   fs/bcachefs/super-io.c             | 2 +-
>   fs/squashfs/block.c                | 2 +-
>   include/linux/bio.h                | 5 +++++
>   20 files changed, 32 insertions(+), 27 deletions(-)

For raid1 and raid10

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Thanks

