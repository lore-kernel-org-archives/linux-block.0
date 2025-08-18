Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57F1DFD9A;
	Mon, 18 Aug 2025 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484229; cv=none; b=auzqENvLP2qwle1GvcYctmmuk49rmy6UwiR5fFyCLCXFGn3XsSy4UM4utZQzrgnofaF6y32baWvhy1iHVqysFy3l8c0Kr3vpzjvIi5BtCri6NYeRq9D6X/gCP4toXbDuXB+wxP7cJ7bhA02+GbWZQXGaUkF0mUY596G6ImbqmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484229; c=relaxed/simple;
	bh=lv/ZJoS9DcMSb+dsAgeD3iAzmuvdsYvlKeTUiqpiYIw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sweid3J4JTF8qpuF9VQ/sxGJX41wkohNR6b2Jx4KXXFsDgtgpUjtx2sV+A/xwoJI6qsFicDgKQWd7o8FSph1pmCm+j9BfVUY4oFruM4Ak/IVT5KaDzWXAFTzgeP/lq2/32Y7hq6kTVzDrwJgZf4Hbvsywg/w3IQpuR0/4j1whDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c4xX06t6zzKHMrg;
	Mon, 18 Aug 2025 10:30:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5948A1A0DE2;
	Mon, 18 Aug 2025 10:30:24 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxM_kKJowp05EA--.7127S3;
	Mon, 18 Aug 2025 10:30:24 +0800 (CST)
Subject: Re: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size
To: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814191004.60340-1-rajeevm@hpe.com>
 <20250814191004.60340-2-rajeevm@hpe.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a5c57306-d271-c45e-7b5d-295096276a19@huaweicloud.com>
Date: Mon, 18 Aug 2025 10:30:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814191004.60340-2-rajeevm@hpe.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxM_kKJowp05EA--.7127S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
	xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF
	0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/15 3:10, Rajeev Mishra Ð´µÀ:
> - Use vfs_getattr_nosec() instead of i_size_read() in lo_calculate_size.
> - Improves accuracy for network/distributed filesystems.
> 
> Signed-off-by: Rajeev Mishra<rajeevm@hpe.com>
> ---
>   drivers/block/loop.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

