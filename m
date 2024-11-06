Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6D383;
	Wed,  6 Nov 2024 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861935; cv=none; b=j+IA1KBpRcwCKktDXbL9iHZ+GAp+nM+EZ2uV9ohLp5dw1OdoEJA3kvsiVv3X8ZmZrzw8A7gaVzh/h23P4xT+ihufO3Nl0FdFgOA9qAHAVO007u4SdgfMJeY6RT6UC87XKS0A2/redGai4fYG1WLHw3jfeRUcgIbz6WGOFrmcBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861935; c=relaxed/simple;
	bh=AQMoefxoaZUlBpcqyIZvT6CqLuUXN/W5jn9ZUn4XXXg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hs1Ygw9pV3N1buK6NCmg08dNpuqA3pMxYR8EXVUVfDEl4/klBd9Q4T1ITmRU1H7Amt77l/mFc6v7nGv830sad3z+rr4RYN3aiLqOncMOvmkusYHE5clGlNFvHA0WwtEnxVB6lTdmPY3ZdqRv4J5S/lQDQqZStUgHcCHcuCWFceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xjqdq2WkMz4f3lW5;
	Wed,  6 Nov 2024 10:58:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2FFF01A0F73;
	Wed,  6 Nov 2024 10:58:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4dg2ypns8TqAw--.25494S3;
	Wed, 06 Nov 2024 10:58:42 +0800 (CST)
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <Zyn_RGV2i9COvNQl@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <217f242b-b4e2-89f7-3b0f-3337c251a603@huaweicloud.com>
Date: Wed, 6 Nov 2024 10:58:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zyn_RGV2i9COvNQl@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4dg2ypns8TqAw--.25494S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45KF1kZr1UZw17XF4ktFb_yoW8GrWkpF
	ZxKa15KrZ5Cr92kFs7A3yxXFySvwn7JFZ5JF1Yy34SvFnrWF10gFy2kF4FvFW8Jrs3J3yS
	gr4jvr9Fvry0y3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,Ming and Christoph

ÔÚ 2024/11/05 19:19, Christoph Hellwig Ð´µÀ:
> On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
>> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
>> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
>> atomic mode after del_gendisk"), hence for disk like scsi, following
>> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
>> cause following uaf that is found by our syzkaller for v6.6:
> 
> Which means we leave the flush request lingering after del_gendisk,
> which sounds like the real bug.  I suspect we just need to move the
> call to blk_mq_clear_flush_rq_mapping so that it is called from
> del_gendisk and doesn't leave the flush tag lingering around.
> 

This remind me that del_gendisk is still too late to do that. Noted that
flush_rq can acquire different tags, so if the multiple flush_rq is done
and those tags are not reused, the flush_rq can exist in multiple
entries in tags->rqs[]. The consequence I can think of is that iterating
tags can found the same flush_rq multiple times, and the flush_rq can be
inflight.

Therefor, I think the best solution is to clear the flush_rq mapping
when flush request is done.

Thanks,
Kuai
> .
> 

