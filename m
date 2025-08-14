Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551E2E92D7
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161973; cv=none; b=Nk8iHrc/GehUI+PmvFxhBB9+LlAieK1xGuwsiF8S43ix6y46GQusC4wVSA+SiWERU8105V3461oKb+WqZxvPWgoX9TaxkoQ/w6o5TA+RzMCRpjB0XBUpa+IMMEcT+jmrtPh2RF5sz/9Xg7F9yK20LiP9VSh/tG9gvc36jgsZSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161973; c=relaxed/simple;
	bh=TnrYykhKcyOzAkBundgEbnUHq+7HR8DH+jdCHk9gi2Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EGFMwg/ZEB68WhWLqfeHYJZ8gp3ZIabyYfXiGo/qDOqbcy61d3XNbYVXUCHKB/Pmpvej1k/MI9hWGd5XbBDQq24RuU6Flwg0uKLLOaEKqbkyuseEVejudsjBolQvd/+Syk3SQHQseiPsmKEilol2u5OIiM1FIqZ2s4Zis0P8Xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2fLn5bG1zYQtnv
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 16:59:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 616FE1A106E
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 16:59:28 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnrxBvpZ1owBmRDg--.17064S3;
	Thu, 14 Aug 2025 16:59:28 +0800 (CST)
Subject: Re: [PATCHv3 1/3] block: skip q->rq_qos check in rq_qos_done_bio()
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com, yukuai1@huaweicloud.com,
 hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-2-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <22d89557-d434-ab1d-d690-4148bb4cab9d@huaweicloud.com>
Date: Thu, 14 Aug 2025 16:59:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814082612.500845-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnrxBvpZ1owBmRDg--.17064S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7V
	UbE_M3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/



ÔÚ 2025/08/14 16:24, Nilay Shroff Ð´µÀ:
> If a bio has BIO_QOS_THROTTLED or BIO_QOS_MERGED set,
> it implicitly guarantees that q->rq_qos is present.
> Avoid re-checking q->rq_qos in this case and call
> __rq_qos_done_bio() directly as a minor optimization.
> 
> Suggested-by : Yu Kuai<yukuai1@huaweicloud.com>
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/blk-rq-qos.h | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

