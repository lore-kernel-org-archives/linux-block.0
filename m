Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450D93;
	Tue, 28 Nov 2023 17:14:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sg1Yd12V3z4f3jXn;
	Wed, 29 Nov 2023 09:13:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1289E1A09AB;
	Wed, 29 Nov 2023 09:13:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBVkGZlMWfjCA--.3057S3;
	Wed, 29 Nov 2023 09:13:58 +0800 (CST)
Subject: Re: [PATCH v4 2/2] block: warn once for each partition in
 bio_check_ro()
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231128123027.971610-1-yukuai1@huaweicloud.com>
 <20231128123027.971610-3-yukuai1@huaweicloud.com>
 <20231128130000.GB7984@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9a6805fd-90ab-62cb-3b7d-d8124faf4f24@huaweicloud.com>
Date: Wed, 29 Nov 2023 09:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231128130000.GB7984@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhBVkGZlMWfjCA--.3057S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrykCrW5KF43Cw48Kw45Wrg_yoW3uFcEqa
	s8Krn7C393Zas7Ka1UKFnIvFZ7Gw4rWrykX3y2qFs7JFW8Xr97tFs3WwnI9F4rJr4vqw42
	vaykZ3yUX39agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
	r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
	U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/11/28 21:00, Christoph Hellwig Ð´µÀ:
> On Tue, Nov 28, 2023 at 08:30:27PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit 1b0a151c10a6 ("blk-core: use pr_warn_ratelimited() in
>> bio_check_ro()") fix message storm by limit the rate, however, there
>> will still be lots of message in the long term. Fix it better by warn
>> once for each partition.
> 
> The new field is in the same dword alignment as bd_make_it_fail and
> could in theory corrupt it, at least on alpha.  I guess we're fine,
> because if you enable CONFIG_FAIL_MAKE_REQUEST on alpha you're asking
> for this.  I still hope we can clean up these non-atomic bools and
> replace them with bitops soon.

Yes, I'm working on this, and thanks for the review!

Kuai
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> .
> 

