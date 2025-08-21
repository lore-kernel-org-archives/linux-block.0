Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A324230981;
	Thu, 21 Aug 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788278; cv=none; b=Du0oO+nKk/Tnjxa1qPYfbHn7oKuYLExzkrB2vSCSTl0WwOGs6QwqwjmQ2U3fZFw+G3Hm0wfSQn4PFbCveKIOuSF06Bp1dpcVUSZmtVTBt+qs7WhSAJwmRvHeTyTPcCv3WacQIZ4X4ei+PoZh6iZhE77mCi4SQmX5/l/6RC7Evcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788278; c=relaxed/simple;
	bh=btb8OpSIDzaYwIh5DloBXgKGwd5YBFL6xZNrbtcwjJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaedhIERE59KTczwAHwy0Fk8ZUMEwovqIkVzp0QRTpeiOwg8/VCLC6rxY7PKzTN0zL8tgscC7qizG0ULdFUyEKgWyC72p/Qoo0Qy/jfE7uSsgUpyf1vhtdLc/3egBkKKE5hluTXdJ0UzQ2zci9Z7jka4CrFQfTFk0eeXaZvwGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c75z52z5KzKHN9N;
	Thu, 21 Aug 2025 22:57:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD4F31A0E60;
	Thu, 21 Aug 2025 22:57:52 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxDuM6do7NLKEQ--.32491S3;
	Thu, 21 Aug 2025 22:57:51 +0800 (CST)
Message-ID: <1366b2ec-cce5-632a-09a6-fba528d11f03@huaweicloud.com>
Date: Thu, 21 Aug 2025 22:57:50 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
 bvanassche@acm.org, ming.lei@redhat.com, nilay@linux.ibm.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <20250821060612.1729939-3-yukuai1@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20250821060612.1729939-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxDuM6do7NLKEQ--.32491S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWkKrW5Cw1xuw13WFWDXFb_yoWDKrXEv3
	yFkr97J3s5JF1Ikw1FqrnIvFWkGw45tFZ5Ga4DXrWfGFnxJF93GFn5KFZ5AF47GwsavayD
	X3Z3Zan0v3yjvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0eH
	DUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/8/21 14:06, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the case user trigger tags grow by queue sysfs attribute nr_requests,
> hctx->sched_tags will be freed directly and replaced with a new
> allocated tags, see blk_mq_tag_update_depth().
> 
> The problem is that hctx->sched_tags is from elevator->et->tags, while
> et->tags is still the freed tags, hence later elevator exit will try to
> free the tags again, causing kernel panic.
> 
> Fix this problem by replacing et->tags with new allocated tags as well.
> 
> Noted there are still some long term problems that will require some
> refactor to be fixed thoroughly[1].
> 
> [1] https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/
> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Nilay Shroff<nilay@linux.ibm.com>
> ---

LGTM

Reviewed-by: Li Nan <linan122@huawei.com>

-- 
Thanks,
Nan

