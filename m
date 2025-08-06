Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F014A8B
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471758; cv=none; b=hLjMJjHoR94B+REbQNZNzU5CAyQ7jBpDW9L/bCI4dvzk35q1QqR9gfHs1Gjjj66GZiiF2j1XQVD5XWCU5xYODbjYjjWgOMzihxJpxNm5KCqnIjbOYnLZ7nu698XG29W1qniYWw2ausS3pqwepOJRVSETVwVDQVzVRQTOhh6wVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471758; c=relaxed/simple;
	bh=Tg1i6wcvV6xO6GxWiqDTQYJu2lQYPsYIchneTJVnY4E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=teOATEpD7C0aKF1+tb5ByrikbAA4fR6aGKyfDWDRwPcGzkwDS4PhnoEypSxyud2TiC/0GqV1kn2rBiXzknE1vedadB8RHhhgV3Vy6iRD1RwHdVgreauth/p15cqmcmVb+F65dVhcsj5DQcT2rHF0F4YTEvt24kkwZCcdfXVX93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxl5P6vVWzKHLsn
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:15:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 033EA1A13FA
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:15:53 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAHzw9IHZNofPMGCw--.32705S3;
	Wed, 06 Aug 2025 17:15:52 +0800 (CST)
Subject: Re: [PATCH 3/5] blk-mq: Defer freeing of tags page_list to SRCU
 callback
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-4-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c4fc58cd-3f42-604a-0d2d-19a638603727@huaweicloud.com>
Date: Wed, 6 Aug 2025 17:15:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250801114440.722286-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHzw9IHZNofPMGCw--.32705S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWkZw1UZw47CF17ury8Krg_yoW8Jw45pF
	WfKa13Crn5Jrn3ZrsxJws7Ga4Sqws3Xr45Gr9rGa4rCrn8CryxtryIyws5ua4kX3ykAF4a
	qF1jkryUCF1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUotCzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/01 19:44, Ming Lei Ð´µÀ:
> Tag iterators can race with the freeing of the request pages(tags->page_list),
> potentially leading to use-after-free issues.
> 
> Defer the freeing of the page list and the tags structure itself until
> after an SRCU grace period has passed. This ensures that any concurrent
> tag iterators have completed before the memory is released. With this
> way, we can replace the big tags->lock in tags iterator code path with
> srcu for solving the issue.
> 
> This is achieved by:
> - Adding a new `srcu_struct tags_srcu` to `blk_mq_tag_set` to protect
>    tag map iteration.
> - Adding an `rcu_head` to `struct blk_mq_tags` to be used with
>    `call_srcu`.
> - Moving the page list freeing logic and the `kfree(tags)` call into a
>    new callback function, `blk_mq_free_tags_callback`.
> - In `blk_mq_free_tags`, invoking `call_srcu` to schedule the new
>    callback for deferred execution.
> 
> The read-side protection for the tag iterators will be added in a
> subsequent patch.
> 
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c     | 24 +++++++++++++++++++++++-
>   block/blk-mq.c         | 26 +++++++++++++-------------
>   include/linux/blk-mq.h |  2 ++
>   3 files changed, 38 insertions(+), 14 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

