Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B884B048C
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933226; cv=none; b=fCKJdaTUZzkViL0shCJOr3d66Z6qdf06F7XidW1wKv8kCq0A+3sPyHdsRocGmLpE6wRkR66pNUbV9dWywUTrRsVdlWzquQEu9spoKCayKpAe3Swvd/pF5n9EA0h8BXeRUi9XTrsqCHJyKt02GDxGJL0CIEjKnhyNI3LQ0nUyP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933226; c=relaxed/simple;
	bh=h+PpOmic0ViWuTebbFD6sWSEF6LbRp74N1Je0546QIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVAeo/IaMaHS4GconeSGGk5QU7T1L8rMQ8+7/lJcKdrJZ2LYc5KBiJJ3cUrj4Y7XvqcKKbB1rgpAo0WWApDjDpDuzCVp0W6gDayl7piHWMg7rn0qJCUQolpugJobGMTvKH3FmSwCYVRCi6N/y9KjHIEA2VSZtf/HwXqPRyO/Ggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hNc3l40MlzKHMTY
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 10:19:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id ABAA040A1C
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 10:20:12 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCnlkXab4JqsidjCg--.45875S3;
	Mon, 17 Aug 2026 10:20:12 +0800 (CST)
Message-ID: <36f09506-21d5-49d8-974b-da99c16a09a6@huaweicloud.com>
Date: Mon, 17 Aug 2026 10:20:10 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/10] null_blk: fix init/exit races and memleaks
To: Bart Van Assche <bvanassche@acm.org>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, dlemoal@kernel.org, nilay@linux.ibm.com, yukuai@fygo.io,
 kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
 <d16887c3-8ebe-4bf3-8a11-9cecb39e315b@huaweicloud.com>
 <5aa41f8f-91e2-4883-8706-5bd5c1a8d273@acm.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <5aa41f8f-91e2-4883-8706-5bd5c1a8d273@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnlkXab4JqsidjCg--.45875S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF48XrWUGw1UCw43uFy8Zrb_yoWDKrX_u3
	9YkFy8Cw4jqr47Xrs7JFnxZrsrua9Fgr18Ja48GF97K348trWDXanYkFnavw1rKr4fJFnx
	KF98tayIyw4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/


在 2026/8/15 22:53, Bart Van Assche 写道:
> On 8/14/26 7:13 PM, Zizhi Wo wrote:
>> Gentle ping on this series.
>>
>> It's been a while since I posted it back in July. The series fixes
>> several issues in null_blk. Most of the patches have already collected
>> Reviewed-by tags.
>>
>> In the meantime, I've noticed others starting to send patches for the
>> same problems, which suggests these fixes may have gone unnoticed.
>> Reviews on the remaining patches would be very welcome so the series can
>> move forward.
> 
> Hi Zizhi,
> 
> If no feedback from a maintainer has been received after two weeks, a
> good way to draw the attention of that maintainer is to rebase, retest
> and repost your patch series.
> 
> If Linus Torvalds releases kernel 7.2 this weekend then the merge window
> for kernel 7.3 will open on Monday. Reposting of this series probably
> should wait until the merge window for kernel 7.3 has closed.
> 
> Thanks,
> 
> Bart.
> 

Hi Bart,

Thanks a lot for the guidance on how to handle a stalled series :) I'll
keep this approach in mind for future submissions.

Thanks,
Zizhi Wo

