Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF1179BD
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741056414; cv=none; b=DcBtLOoa17OoAENChbtfg11bZdbziYNNrSPyqN3wRX7tY86PV2HehEQ8IR1MA0dBX+8FvsXqzmycPANRoXMSVmvbWGznIJ+J1ix9FyBdKtP9i7ppx0A+sw0d1oHajBuy3Aw+sUJNpPbtNhYFweuB54uCfEoaD+Dy3Wwe+Y1OUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741056414; c=relaxed/simple;
	bh=US0pACHIooNQLrO9dOJoRBchZWYyUlJ7WsFFdZguFZE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IVCGBILj0TiZnYMdbqlCoUB+IthkPJ6DEsbd7I0rDu9XRhEzfGKWuxP1NEEzwD/62Mu///qHNI/ZLESizwkUL3RXbQcgtF6rRcwM8OaiVex5art0ye4J4xPAj+e6W6yNM/OS+UJ8VZZ2sqoZKSqhdgBBuzyz8OVKTzqZEt92Ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z6KnR6F1Mz4f3jR5
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 10:46:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E80D11A084E
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 10:46:41 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGCQacZnRSzvFQ--.39862S3;
	Tue, 04 Mar 2025 10:46:41 +0800 (CST)
Subject: Re: [PATCH] tests/throtl: add a new test 006
To: Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250224095945.1994997-1-ming.lei@redhat.com>
 <94ad8a55-97a7-d75a-7cfd-08cbce159bed@huaweicloud.com>
 <CAFj5m9KZqaVb_ZGgtdHxNxpuccuBcAVxcYOxaTGkuvuAQSf5Xw@mail.gmail.com>
 <d0013f94-65a0-684f-6122-d8e98eb3e9bf@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7ff7166f-3069-59ae-6820-98e8b76057d6@huaweicloud.com>
Date: Tue, 4 Mar 2025 10:46:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d0013f94-65a0-684f-6122-d8e98eb3e9bf@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGCQacZnRSzvFQ--.39862S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4fKryfKrWkKFW7tr47urg_yoW3CFc_Za
	17Zr4kK3y5Aw4Dt3yqqr1YvrZ7Ga1Iyry8Xw1j9F4UGFWrXr1DGFnxGrZ5Z39xCFs5Jr1S
	kryqqFyfKF17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/25 10:07, Yu Kuai 写道:
> Hi,
> 
> 在 2025/02/24 21:54, Ming Lei 写道:
>>> Do you run this test without the kernel patch? If I remembered
>>> correctly, ext4 issue the meta IO from jbd2 by default, which is from
>>> root cgroup, and root cgroup can only throttled from cgroup v1.
>> It passes on v6.14-rc1, does META/SWAP IO only route from cgroup v1?
> 
> Of course not, it's just ext4 will issue such IO from root cgroup, and
> there is no IO can be throttled here.
> 
> You might want to bind jbd2 to the test cgroup as well.

I think the test will be OK this way.

Thanks,
Kuai

> 
> Thanks,
> Kuai
> 
>>
>>    static inline bool bio_issue_as_root_blkg(struct bio *bio)
>>    {
>>            return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
>>    }
>>
>> Thanks,
>> Ming
> 
> .
> 

