Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A44C76
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449270; cv=none; b=a4ySI1H8vamuksKwOr3ZkInAH85y0XmF7ag4n87FBC3kllVtiJARBER7ZRlbe9U9Tiv2slL+FsU9Hf6XmcFXnyCMicGP33n071BwEzhMTMwSH1M5piQpDjC+pHIovDbhZNPw32TA0oKSIRnlOxcDBcWicOPiNbnqAba66EDds0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449270; c=relaxed/simple;
	bh=WeIhsdYu3q8safv/Kt7vD7Xn71m31+hqm7dzNRTS738=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JNc5zWasj53anobsuTUIA8Lys1R4Q34Ceg/Df12mQOLW2/Fv+CZdzm2ouVUimezK2kVx61WTnIlAs+U/7MTugHDKUz3QmDgQ4q/h2vUzLPcq/yJGWoCFEAQask4uG7Osg5Xg5XOBZxtG4x34kpVLHJTWWUKwtciWG1BI0B/fjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z21Fb71YBz4f3jXJ
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 10:07:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C37BE1A06D7
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 10:07:37 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1_pJb1nHZVGEw--.63834S3;
	Tue, 25 Feb 2025 10:07:37 +0800 (CST)
Subject: Re: [PATCH] tests/throtl: add a new test 006
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250224095945.1994997-1-ming.lei@redhat.com>
 <94ad8a55-97a7-d75a-7cfd-08cbce159bed@huaweicloud.com>
 <CAFj5m9KZqaVb_ZGgtdHxNxpuccuBcAVxcYOxaTGkuvuAQSf5Xw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d0013f94-65a0-684f-6122-d8e98eb3e9bf@huaweicloud.com>
Date: Tue, 25 Feb 2025 10:07:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFj5m9KZqaVb_ZGgtdHxNxpuccuBcAVxcYOxaTGkuvuAQSf5Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1_pJb1nHZVGEw--.63834S3
X-Coremail-Antispam: 1UD129KBjvdXoWrCFykurW3Cw1DCF18CFyUWrg_yoWxXrb_W3
	srJr4vk3yDuwsrGa1ktr1aqFZ7Can7Kry8Xw1UK3WUCFy8Ar1UJ3ZrGr4kZasxZFs5Jr1f
	C34DXFyIyr9rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
	r21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUYNVyDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/24 21:54, Ming Lei 写道:
>> Do you run this test without the kernel patch? If I remembered
>> correctly, ext4 issue the meta IO from jbd2 by default, which is from
>> root cgroup, and root cgroup can only throttled from cgroup v1.
> It passes on v6.14-rc1, does META/SWAP IO only route from cgroup v1?

Of course not, it's just ext4 will issue such IO from root cgroup, and
there is no IO can be throttled here.

You might want to bind jbd2 to the test cgroup as well.

Thanks,
Kuai

> 
>    static inline bool bio_issue_as_root_blkg(struct bio *bio)
>    {
>            return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
>    }
> 
> Thanks,
> Ming

