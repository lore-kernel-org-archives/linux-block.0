Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B828E7;
	Tue, 22 Apr 2025 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285291; cv=none; b=ZgMWtTjoMbOivTQWVpWP5nYhfYCl6KWOq4nJsCd8oUp7lRLb499pgJVeiprxCNklZMcjky0PsNP/HCFfyc2FzkFOAGrfhF59Wy8AjLLwG1ll8IPvQ/SGgS6xB2k0hHW4CWJIjJoPRgLcWFi0i33mEQDUCaSEwwQgmGNUZWnoZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285291; c=relaxed/simple;
	bh=nn33IC7GZ/Qaed8ufVwx/6yqba3Rxu170mvlRR9kvH8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MsgLfXOp3JC/t2io3ifDJY+mLjWOdfy7q8HEXxVxM7fFYVWqXHvaxxES+/tuMoMSBCEBAbJWnvMVPk/MSvX9MRmm2ena+25tbxahf4IwCuj2ZQaNH37qm19qEfmC7eetJPjabW1jCoMdFCOn0QsT2Y2V1FDBc1p9zQrwWLTnLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZhPk95GVLz4f3jkr;
	Tue, 22 Apr 2025 09:27:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4CCD41A19ED;
	Tue, 22 Apr 2025 09:28:04 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+i8AZoDwPEKA--.5830S3;
	Tue, 22 Apr 2025 09:28:04 +0800 (CST)
Subject: Re: 10x I/O await times in 6.12
To: Keith Busch <kbusch@kernel.org>, Matt Fleming <mfleming@cloudflare.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ad67b397-9483-d3c3-203e-687cefb9e481@huaweicloud.com>
Date: Tue, 22 Apr 2025 09:28:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+i8AZoDwPEKA--.5830S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4UAr17tFy5try7ur48Zwb_yoWDXrc_W3
	s8GFyDGr17Zrs2kFyfCw45ZrZFqr1rZFy7XrWUJrnrXwn7ZasrWFsFg3sIvFZxGrW0grsr
	urWDK34jqr9akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/21 23:22, Keith Busch Ð´µÀ:
> On Mon, Apr 21, 2025 at 09:53:10AM +0100, Matt Fleming wrote:
>> Hey there,
>>
>> We're moving to 6.12 at Cloudflare and noticed that write await times
>> in iostat are 10x what they were in 6.6. After a bit of bpftracing
>> (script to find all plug times above 10ms below), it seems like this
>> is an accounting error caused by the plug->cur_ktime optimisation
>> rather than anything more material.
>>
>> It appears as though a task can enter __submit_bio() with ->plug set
>> and a very stale cur_ktime value on the order of milliseconds. Is this
>> expected behaviour? It looks like it leads to inaccurate I/O times.
> 
> There are places with a block plug that call cond_resched(), which
> doesn't invalidate the plug's cached ktime. You could end up with a
> stale ktime if your process is scheduled out.

This is wrong, scheduled out will clear cached ktime. You can check
it easily since there are not much caller to clear ktime.

Thanks,
Kuai

> 
> .
> 

