Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D553635;
	Thu,  9 Oct 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030395; cv=pass; b=VuhrCmcUxhql+Lnky6ouIHsiVjpoAXhXRL+BZRS8p0KcFTN+VDm/SXgKkpoyBltSmZq9TBQoW2Eqlc2Z6AIxjjojH5mcw2s7uzYhyB3fqHwtFVdp2kjhqjXGCd55PWGoZuuLZQnreute2MiYsHh2xrmgaPDBFwd3zUI/QoxtsKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030395; c=relaxed/simple;
	bh=7FPDDD92oAuD6ndvDFa18xSOKAXQVvQ8VDmbSmdS1Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1G/14HOFDsPJlDIRFaRtJZOGKPuT2y9n8QnUmIJf/eAmYVHLw12DDTI+eKx2UZduHUO2oJJMf9F6Vaf44ly07axoHEMJY/IXHZoTmUM9cb3AJCHmeWdNK+4pAhwoVMqgKMR0RZdtcymSyvyhvnKx3XO9NRCvWmFJyoxe3yi+x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=VUqyU8aj; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="VUqyU8aj"
ARC-Seal: i=1; a=rsa-sha256; t=1760030367; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QjcJkgK5C6xjkLu/L/U3nJk/pbB9hsi88U9EVXTOnJtQJN6Z80baezHjHeKE0gximB6aSAXuZbvv/wTdKiu5QZOf7Zklv0vjsXtCulaeR4aKniCm/9eqsRRIDpkBvekENqw0iUaa3clBwE3Wo1+8IotifFM5nBP61TXJbhbqCvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760030367; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7FPDDD92oAuD6ndvDFa18xSOKAXQVvQ8VDmbSmdS1Dc=; 
	b=QYk2zy5SwCQlv69bVInb8o8/SwwnXNLkb2u1Ga2Kyi/M4YgIN1TnBx2aVH6p0iR+R4OtPTLiSXzBVe0XD4DGiOhUwMZMmQhl4m7hcs0/JBTwllVY04jTX/a7rN121sFNuLYnS+XfU5OXC/vJli066ubf7DFw3A28WNJM6Hpt47M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760030366;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7FPDDD92oAuD6ndvDFa18xSOKAXQVvQ8VDmbSmdS1Dc=;
	b=VUqyU8ajYBwpBLSpGhFzDudmWeQyRZIOyLIjw+K5qbCDGTaoY2W728Kd4Wbm9bnU
	BPiVNPSeftV0Mr7bhDXSM+lfjHr2c/qlZlWmLHFuh/gB/OZKA9TRV4wlDx2zr4C0jT+
	HsthALQjTQxk6A3lf5hAUcnO1yIU2ljhDvPDJhvQ=
Received: by mx.zohomail.com with SMTPS id 1760030361880859.4371394836448;
	Thu, 9 Oct 2025 10:19:21 -0700 (PDT)
Message-ID: <3efdee9c-6605-424c-953d-17242c3a5314@yukuai.org.cn>
Date: Fri, 10 Oct 2025 01:19:11 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 3/7] blk-mq: add a new queue sysfs attribute
 async_depth
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, ming.lei@redhat.com, nilay@linux.ibm.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-4-yukuai1@huaweicloud.com>
 <49647ccf-5d19-4ede-87b4-0f7ff8e9f5ea@acm.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <49647ccf-5d19-4ede-87b4-0f7ff8e9f5ea@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/10/10 1:05, Bart Van Assche 写道:
> On 10/9/25 12:46 AM, Yu Kuai wrote:
>> +static ssize_t queue_async_depth_show(struct gendisk *disk, char *page)
>> +{
>> +    ssize_t ret;
>> +
>> +    mutex_lock(&disk->queue->elevator_lock);
>> +    ret = queue_var_show(disk->queue->async_depth, page);
>> +    mutex_unlock(&disk->queue->elevator_lock);
>> +    return ret;
>> +}
>
> Functions like the above can be simplified by using guard(mutex)(...) or
> scoped_guard(mutex, ...).

Yeah, sounds good. I'm still not used to this.

Thanks,
Kuai

>
> Thanks,
>
> Bart.
>
