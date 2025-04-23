Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A178199FC1
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745378822; cv=none; b=GkoDLWr8gWQuVEOKF/VkOAq3P2vMrM/FPyiKjPyka46hkvBeC/5uLyO/k5PZX5mo9jz9CaVgelZcmnR5+NLn12XqRDXbNidNBz20kFHnNAB/pW35qF8m7T0C55J69xOsNoKPiSpSh9kiKFSUD+cAJ82hY1GYIzTuwf5Gnd2CMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745378822; c=relaxed/simple;
	bh=ZtEmcRYnUBpNhGedFdNKKLxVGW04RvCrCVtKXVBObf0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QEmkyEJ86905a5/A/aw0DFVJgvOh0kDvioczsrpn4UCF8YPHy2bNFMIHKm8l+Hy5oY35fxi/HEQgd9uwCDdrmpoq5pim0Cl5d7FkCo79LB4vGp4P2rSN1eMz1d5ywV6DmxzUzHDNTgE9cM4M0MTL7ueO6/xzjTRoNurOwv5tnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zj4Jl4xsQz4f3lDF
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 11:26:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2D2411A018D
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 11:26:57 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl__XQhoNScwKQ--.29017S3;
	Wed, 23 Apr 2025 11:26:57 +0800 (CST)
Subject: Re: [PATCH 5/5] brd: use memcpy_{to,from]_page in brd_rw_bvec
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-6-hch@lst.de>
 <1f084ee5-098f-6588-5f13-068240682c8b@huaweicloud.com>
 <20250422135033.GB23131@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <342d42e7-6fe6-f3ae-c479-9bd282138e0c@huaweicloud.com>
Date: Wed, 23 Apr 2025 11:26:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250422135033.GB23131@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl__XQhoNScwKQ--.29017S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2
	V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAV
	WUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/22 21:50, Christoph Hellwig Ð´µÀ:
> On Tue, Apr 22, 2025 at 07:18:05PM +0800, Yu Kuai wrote:
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> If you think some or all of this is useful for your discard fixes feel
> free to pull some or all of it into that.  Otherwise I'll repost on top
> of that once it is finalized.

ok, I'll try to send a v2 soon.

Thanks,
Kuai

> 
> .
> 

