Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86964F;
	Mon,  3 Jun 2024 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717381210; cv=none; b=HMgiJcxfviH6yFDn8OqsObEF5xDu9qkyjuOwcEQVyh4q6CBJNoFfjmOuKI6y9gnUNeExRcX7MhH+AJ9vklUbK6wIi6glEtz01A8jqi8+wyOo+83SLXL3dyXBwh7vnNoHzaWQFSuLTW7oe1iiJGY5pj8jUO+bXkBtNULjBGL0vkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717381210; c=relaxed/simple;
	bh=mWSfs4wqgd3pgY2XnMo1sXFI0l9SAIXMQk+DIvDZn5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sihQkihVHpM4pXbHAyQSR+XCCXhh9lo3IVxFB2HLzYjoPTvf9mlYnSB9Kmj7GmZpi2J2rHgi0rnlz7OgqBXaxg/c7U0O+MMIIKTFVwZvDFM1b1bCSwWWtupUHFylLk7iyhE4scEO7t4z0s1JP3S9YKhW+c75oiAjPWLrL/hD4RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vsy9N3mNxz4f3kKh;
	Mon,  3 Jun 2024 10:19:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BF58E1A0199;
	Mon,  3 Jun 2024 10:19:58 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAtGKF1m7AwgOw--.17601S3;
	Mon, 03 Jun 2024 10:19:58 +0800 (CST)
Message-ID: <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
Date: Mon, 3 Jun 2024 10:19:50 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, ZiyangZhang@linux.alibaba.com, czhong@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <Zl0QpCbYVHIkKa/H@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnmAtGKF1m7AwgOw--.17601S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF1kWFWDGFWkZFy3Ar47Jwb_yoWDKrX_uw
	1vvrZ7Xw4DCF4Fk3ZrKFy5Zr97tF4kXw1kKFWYvrZav34UA3ZrZFyxZrn3Ga18ZrWrCFnx
	uw13tw40qF18AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI
	0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
	6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17DG7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/6/3 8:39, Ming Lei 写道:

[...]

>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 4e159948c912..99b621b2d40f 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>>   {
>>   	int i;
>>   
>> -	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
>> +	if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
>> +		return;
> 
> Yeah, it is one bug. However, it could be addressed by adding the check in
> ublk_ctrl_start_recovery() and return immediately in case of NULL ubq->ubq_daemon,
> what do you think about this way?
> 

Check ub->nr_queues_ready seems better. How about:

@@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct 
ublk_device *ub,
         mutex_lock(&ub->mutex);
         if (!ublk_can_use_recovery(ub))
                 goto out_unlock;
+       if (!ub->nr_queues_ready)
+               goto out_unlock;
         /*
          * START_RECOVERY is only allowd after:
          *

> 
> Thanks,
> Ming

-- 
Thanks,
Nan

