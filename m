Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE291F0E2D
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121310; cv=none; b=pPYdUZ4NHYQdWEVqhF89IukY2EKpRLKryM77JBNRDCwbONiAbehg5reObmpZrplIk2A0bCzkO8MRqifNdk6fNaHXU7ZH80ysFE9DdqN0coj4BA3DYWp/ksVAor6uPP3rk93pX3p2yWwAFvBtMJXxdXQ9PrTjRlOGvmJJJC+ntro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121310; c=relaxed/simple;
	bh=I0B5cI8vwYMFJkwICCQC1+sytlx+0wbuHC5G+/c/kig=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tsTXNL4KHuNSwggOWUGNj/qqs5gnSSXIbORvqpsDIyfJ7z5XtcTTULRGGMVA+uNNDAQPxtxyQfOzYxZyBV5KOMirx37/7tL8zi/VwKxOc5SNW8BTXhUt62bTPqFk1WjsAEU+9TVzYJAaOd4WdBzRyf6+yjhTv7QNCgrFjMPUwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZxSkf0PFWzYQtt0
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 15:28:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 571331A0933
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 15:28:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2CX9CJoqYETMQ--.13250S3;
	Tue, 13 May 2025 15:28:25 +0800 (CST)
Subject: Re: [PATCH] block: Split bios in LBA order
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250512225623.243507-1-bvanassche@acm.org>
 <20250513064434.GA1199@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <35de5e1e-1594-d861-7836-78c4a04dd73e@huaweicloud.com>
Date: Tue, 13 May 2025 15:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250513064434.GA1199@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2CX9CJoqYETMQ--.13250S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15Ww1rGF17KFy8CFW3KFg_yoW8Jw47pF
	yq9a4fCFs8JFs3KwnrXr4Ut3ZYy3Z8Wr1UJFWFgrZxJrn0qF1Ikr47JF1Yvas5Jr18u34x
	X340va45Kan8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/05/13 14:44, Christoph Hellwig Ð´µÀ:
> On Mon, May 12, 2025 at 03:56:23PM -0700, Bart Van Assche wrote:
>> The block layer submits bio fragments in opposite LBA order. Fix this as
>> follows:

I don't understand this as well, for example, if bio is 8k and it splits
at 4k: bio: 0->4k, split_bio 4k->8k. And then split_bio is added to
current->bio_list while the old bio is submitted first.

Thanks,
Kuai

>> - Introduce a new function bio_split_to_limits_and_submit() that has the
>>    same behavior as the existing bio_split_to_limits() function. This
>>    involves splitting a bio and submitting the fragment with the highest
>>    LBA by calling submit_bio_noacct().
>> - Use the new function bio_split_to_limits_and_submit() in all drivers
>>    that are fine with submitting split bios in opposite LBA order.
> 
> If you have to rename a user visible symbol, please do that in a
> preparation patch.
> 
> Also how do you determine some drivers are fine with one order while
> others are not?
> 
>> - Modify blk_mq_submit_bio() and dm_split_and_process_bio() such that
>>    bio fragments are submitted in LBA order.
> 
> blk_mq_submit_bio calls __bio_split_to_limits, which returns the
> bio split off the beginning of the passed in bio by bio_submit_split.
> I don't see how that would reorder anything.
> 
> 
> .
> 

