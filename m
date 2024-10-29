Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44E201008
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171580; cv=none; b=BFZHMor+WpS2zufNuCRtUAJBrpz10Ozhwdt1WBdmCIiwfRBLfyY7r9rMEKLcDCxe8tEuR3xkC0/WWuXFUowtNOvI4qUldUxDD5W830lv01hbavAh2tSE8xT0HRM5sCHPHWxJE9KqmtQKjVof1x9DHSrmnE/aDpUAuFCz5H5qBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171580; c=relaxed/simple;
	bh=rVAgwJn/Vqj5PwA+4fHUkJraIoHdmrFVvcvHFesiVy8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J0oxH3ftazwxl5Ld+u8j5Cq3blZoRYLrRESiLXGIlscJ24yV7uaQmYUALZIFCeTA5XMhW2x1yx88RRFJg8erbMSb8dXCsGQN70IloSvNQTXlYAPEes2O4ajokEbG05OXfz7ogfDcmCW1AYnzOSlMFaovm6KWaT5lPmdF/Echygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XcwKw37Qnz4f3jrg
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 11:12:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1BDC41A0197
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 11:12:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCngYW0UiBncPz3AA--.36869S3;
	Tue, 29 Oct 2024 11:12:53 +0800 (CST)
Subject: Re: [PATCH] brd: defer automatic disk creation until module
 initialization succeeds
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Yang Erkun <yangerkun@huaweicloud.com>, axboe@kernel.dk,
 ulf.hansson@linaro.org, houtao1@huawei.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-block@vger.kernel.org,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241028090726.2958921-1-yangerkun@huaweicloud.com>
 <20241028094409.GA31248@lst.de>
 <c2ec4267-6cd6-43ec-2857-287d4610441c@huaweicloud.com>
 <20241028161346.GA29122@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f4d6b3c2-649f-9ea1-ed4c-eec3dbc53ec5@huaweicloud.com>
Date: Tue, 29 Oct 2024 11:12:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241028161346.GA29122@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYW0UiBncPz3AA--.36869S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYt7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUd
	HUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/10/29 0:13, Christoph Hellwig Ð´µÀ:
> On Mon, Oct 28, 2024 at 07:29:54PM +0800, Yu Kuai wrote:
>> I don't quite understand this, if the gendisk already exists,
>> the probe callback won't be called from the open path, because
>> ilookup() from blkdev_get_no_open() will found the bdev inode.
>> Hence there will only be a small race windown for concurrent
>> create on open callers to return -EEXIST here.
> 
> True.  I'd still avoid the noice printk for that corner case, though.
> 

ok, then I'm fine with remove this printk or move it to brd_init(), I
don't have strong preference.

Thanks,
Kuai

> .
> 

