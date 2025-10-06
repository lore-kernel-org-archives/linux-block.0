Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348D1E86E;
	Mon,  6 Oct 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759716052; cv=pass; b=uZ8sJ3xjba1Kd7dxdluKoY2pnYnXo3a9GxLxto9CJ0WJa1YgeoJliNQ+ZR4p6R+RhTeECHcXEFYUodNdjvG1Cm8jnd/8douove4lxNKhGiOjmY+fs3DF+dIIHzLLPZgA9f74k4j+p6PnIh8U8xtOf0At1jAyb1VVbO+TKCFJfQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759716052; c=relaxed/simple;
	bh=MQmjzkDsYImA7LkqWmo/Tf4blD/4rYp5gJnAuUsS/aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZxX1jwoNtzySyJ9Yp7WJoSPWqwvc2G9GYJtaUqUg0OANy61nJBBh9wFqg0f9C7iPrrX0YO+Hrcr7gFfmzu+I6znEhfEEQnyV+wShUWXW9CPd3C0phCCRjMYBn/SN6f6e+qWMNc1/12LPD/9JIrZ5pMt5baVpOZTH4gZsSMNQSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=mfAKRSzA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="mfAKRSzA"
ARC-Seal: i=1; a=rsa-sha256; t=1759716031; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ivdPhjUqCSFJHJC9TYxol/HZl9yN46KsOCBqmJVDSx7IikjcnW7Ho31jiytpcFlyrBhplRB05ky18/xAGA9xinGh5eqR7HABfnVwKN5+j/QNJi3HgUupAQn/WAUmGF03MfvklcYVm5QTGOHpUsss0k5lEGk7RcUCs55MhZ6qZJE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759716031; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i6HvTzDFXM2i+hOW7AdoTG+3sf6ePO2MTm2ej+wcfDU=; 
	b=CJF7z+6nPWn997YPFc8rvn5dDRjgeGAUgA6ASOPVvKE7pOSS3S6s96QeswjSJ87KhRv2V6fropHiy4qrDRR1R5V7XIUUr7T+906wiQPcZMenQeIJl+6sDfEnlsHQ03LgKJ0ku6Uy8aPKDpZNF+5malfFOUXW01xogdoqV9MdDpQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759716031;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=i6HvTzDFXM2i+hOW7AdoTG+3sf6ePO2MTm2ej+wcfDU=;
	b=mfAKRSzAA+a1jryzwwiwHGLXq12UJvkDTofDYkgNP93ekL8yEgk4gehdpvQJC5J3
	Z9/vKH/8BhtTcsCeAC+9TLMBRJ5BM2X1yhKuAwybcNxCTnkL7getME0NmwTSgr79Xnp
	TjTuPbOgaDjiu0wDiDMFGS6hW3b2VONXI5C1KQus=
Received: by mx.zohomail.com with SMTPS id 1759716028586169.51610235497185;
	Sun, 5 Oct 2025 19:00:28 -0700 (PDT)
Message-ID: <60a26451-22cd-409b-920d-eb9d8490e246@yukuai.org.cn>
Date: Mon, 6 Oct 2025 10:00:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] blk-mq: add documentation for new queue attribute
 async_dpeth
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
 <20250930071111.1218494-8-yukuai1@huaweicloud.com>
 <cbdb4a5a-a8ca-436b-a2ed-59f650a3dce7@linux.ibm.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <cbdb4a5a-a8ca-436b-a2ed-59f650a3dce7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/10/2 23:12, Nilay Shroff 写道:
>
> On 9/30/25 12:41 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Explain the attribute and the default value in different case.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   Documentation/ABI/stable/sysfs-block | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
>> index 0ed10aeff86b..09b9b3db9a1f 100644
>> --- a/Documentation/ABI/stable/sysfs-block
>> +++ b/Documentation/ABI/stable/sysfs-block
>> @@ -609,6 +609,16 @@ Description:
>>   		enabled, and whether tags are shared.
>>   
>>   
>> +What:		/sys/block/<disk>/queue/async_depth
>> +Date:		August 2025
>> +Contact:	linux-block@vger.kernel.org
>> +Description:
>> +		[RW] This controls how many async requests may be allocated in the
>> +		block layer. If elevator is none, then this value is nr_requests.
>> +		By default, this value is 75% of nr_requests for bfq and kyber,
>> +		abd nr_requests for mq-deadline.
>> +
> Hmm, it seems we need to further elaborate above documentation, seeing the
> way this new sysfs interface is playing out now for different I/O schedulers.
> I'd suggest rewriting this as follow (you may further modify/simplify it based
> on your taste, if needed):
>
> Description:
> [RW] Controls how many asynchronous requests may be allocated in the
> block layer. The value is always capped at nr_requests.
>
>    When no elevator is active (none):
>    - async_depth is always equal to nr_requests.
>
>    For bfq scheduler:
>    - By default, async_depth is set to 75% of nr_requests.
>      Internal limits are then derived from this value:
>      * Sync writes: limited to async_depth (≈75% of nr_requests).
>      * Async I/O: limited to ~2/3 of async_depth (≈50% of nr_requests).
>
>      If a bfq_queue is weight-raised:
>      * Sync writes: limited to ~1/2 of async_depth (≈37% of nr_requests).
>      * Async I/O: limited to ~1/4 of async_depth (≈18% of nr_requests).
>
>    - If the user writes a custom value to async_depth, BFQ will recompute
>      these limits proportionally based on the new value.
>
>    For Kyber:
>    - By default async_depth is set to 75% of nr_requests.
>    - If the user writes a custom value to async_depth, then it override the
>      default and directly control the limit for writes and async I/O.
>
>    For mq-deadline:
>    - By default async_depth is set to nr_requests.
>    - If the user writes a custom value to async_depth, then it override the
>      default and directly control the limit for writes and async I/O.

This is great! I will use this in the next version.

Thanks
Kuai

> Thanks,
> --Nilay
>
>
