Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA92629;
	Fri,  6 Sep 2024 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585358; cv=none; b=UD76dfHVAJ6Iqwx2ws6kR4eE6lQmSAgD/Lu8RMvKm224mfd1RQLY+PKCWyUnJD7WPK0y15gdNofIj1GNs/ksDvrWDO+WHO7LSrAfDSxfH/5BaLj/dcI+gBDU9tilDYBNmsbzjnEXDUoZk4dnjHzv2jObY2TkSHWWT9+Jo1Psp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585358; c=relaxed/simple;
	bh=TBA3ilCxtdhiAOltHQHU8UQ92UNOF33QFyAM88vsijQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HzYnvbDYOXS9PTGkD33yTPzcxRZZFJFrJ4+rHwRPJsSP5EB6kV/O11AA0e2+jdafwy1GWui8cuveg9Bm6aL8DjcoQsakUORAKuZbHGRKXQ1bp8djP9XnSYCdMgL3zj3W3ET5b4bHE1skpNiG776m+po2tS4r1iLKx3htMWPtNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X0JFN5sqBz4f3jdG;
	Fri,  6 Sep 2024 09:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E396E1A018D;
	Fri,  6 Sep 2024 09:15:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMjGV9pmD48QAg--.40063S3;
	Fri, 06 Sep 2024 09:15:51 +0800 (CST)
Subject: Re: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, Paolo Valente <paolo.valente@unimore.it>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240905164344.186880-1-ulf.hansson@linaro.org>
 <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk>
 <CAPDyKFrgzuuDBMWjBDVFAzwTP30JeD+zP2mVo+E=P0MZwUepHA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2f2bd13d-933b-da9d-7ea0-5f875dec574b@huaweicloud.com>
Date: Fri, 6 Sep 2024 09:15:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrgzuuDBMWjBDVFAzwTP30JeD+zP2mVo+E=P0MZwUepHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnXMjGV9pmD48QAg--.40063S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw17CF15Cr4xZFy3Cr4kJFb_yoWkZFbE93
	4DAwn7Gw1DJFW2kanFyr90yrW2gr9xWr17Za4UXa47Zr90yFZxAF95KryfuF1Fkr4Ykrn8
	KF1kX3y3tF13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/09/06 0:56, Ulf Hansson 写道:
> On Thu, 5 Sept 2024 at 18:49, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/5/24 10:43 AM, Ulf Hansson wrote:
>>> To not give up entirely on maintenance of BFQ, add myself and Linus Walleij
>>> as maintainers for BFQ. Although, as both of us has limited bandwidth for
>>> this, let's reflect that by changing the state to Odd Fixes. If there are
>>> anybody else that would be interested to help with maintenance of BFQ,
>>> please let us know.
>>
>> We don't add maintainers that haven't actually worked on the code. As it
>> so happens, we already have a good candidate for this, who knows the
>> block layer code and does many fixes there, Yu Kuai. And they recently
>> sent in real fixes too. So that's likely the way the needle will swing.
> 
> I would certainly appreciate it if Yu Kuai could step in and help,
> that's why I cced him too.
> 
> Although, me and Linus were thinking that helping with "Odd Fixes" is
> better than nothing. Ohh, well, let's see what Yu Kuai thinks, then.

I appreciate the opportunity and am willing to help with maintaining
BFQ.

Thank you for considering me for this role.
Kuai

> 
> Kind regards
> Uffe
> .
> 

