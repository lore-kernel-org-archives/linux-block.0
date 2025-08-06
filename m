Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CE1114
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443560; cv=none; b=dxUuABomKLm2RnVw0XAoEqbEZAIiWL5S924ugQtbj8yuHoVO3J/VejFHa9/sLoURIRSVWWgOxKiiiok1mJB3N3vw3pdsXT8LMfqQSzZ7amPblaroT6PBmMX52hNWn77DxOOZb4XEw2OtvSs0xMBnsvhN/w39Uwvp4uec4sm1PMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443560; c=relaxed/simple;
	bh=jbsIcwO+4y2LZLwlMze1XtbV9mxo1DLZ7WL4E/BF3w0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rFxdMg6O7vsI9+Hywi9U16jSlLiMg8V6+H2O3JAQnGegpBG56TmMw7p/GUV9jT6nISWyWsHLS3EVm8ftoeLrtNow8TmFnih5lCLGUeZcJiAOL6NMTWW4bicuGcKVQm3bzYXyuUDymeY9xsV4ez+aqD2N/3VZP6NSKftRAMg+jXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bxXg83skWzYQtpv
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:25:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 363DB1A171B
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:25:55 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chMhr5JoT67eCg--.47559S3;
	Wed, 06 Aug 2025 09:25:55 +0800 (CST)
Subject: Re: [PATCHv2 2/2] block: clear QUEUE_FLAG_QOS_ENABLED in rq_qos_del()
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250805171749.3448694-1-nilay@linux.ibm.com>
 <20250805171749.3448694-3-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4e13ce83-51a7-488e-e7ca-eadb431ff001@huaweicloud.com>
Date: Wed, 6 Aug 2025 09:25:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250805171749.3448694-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chMhr5JoT67eCg--.47559S3
X-Coremail-Antispam: 1UD129KBjvJXoW7GF4xCF4fKw43Jw4ktFyxZrb_yoW8JF18pa
	95KF13Cw42qFs5WaykGw4fXrW7ArZIkr45ur43Jr1fZFy7CF12vFy0yF40grZ2grZIkrWI
	vw1UXF4jqF1UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/06 1:17, Nilay Shroff Ð´µÀ:
> When a QoS function is removed via rq_qos_del(), and it happens to be the
> last QoS function on the request queue, q->rq_qos becomes NULL. In this
> case, the QUEUE_FLAG_QOS_ENABLED bit should also be cleared to reflect
> that no QoS hooks remain active.
> 
> This patch ensures that the QUEUE_FLAG_QOS_ENABLED flag is cleared if the
> queue no longer has any associated rq_qos policies. Failing to do so
> could cause unnecessary dereferences of a now-null q->rq_qos pointer in
> the I/O path.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-rq-qos.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
There is no fixtag, and can be missing during backport easily.

I feel it's better to fix missing static_branch_dec() in rq_qos_del()
first, and then fix the deadlock problem.

Thanks,
Kuai

> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 460c04715321..654478dfbc20 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -375,6 +375,8 @@ void rq_qos_del(struct rq_qos *rqos)
>   			break;
>   		}
>   	}
> +	if (!q->rq_qos)
> +		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>   	blk_mq_unfreeze_queue(q, memflags);
>   
>   	mutex_lock(&q->debugfs_mutex);
> 

