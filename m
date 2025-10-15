Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601212FB0A0;
	Wed, 15 Oct 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545994; cv=pass; b=W8xzMggDsYklI9X+Lq+/eKrM69p/Fqx8aGH1pJXMyhsqvWTN80aVSXvkNg5Y6/Sze5N7Nqz8DIAcRr7xgtFVru8sS6kUMPAMnWcG23yYZQ0WZlwrmw4A42mHGMxinUmYiEo2SaNG2WiOXq8JyHFs7G3NopwsI32Hhj/XU510vkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545994; c=relaxed/simple;
	bh=Qka5rRhiNu7gh1nkT/r1uncAJ4L+oiWYE0y+7wUupjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBask8wghLUHE7ijHVoiRKF0ZmRLu1hi04HKI9kN5e4BL97Cbc9XDXX62m3crU9pH+XMX+vCx2osIM2crgVG2yKCjNkRb40o9YJl+xmg2Gr5os2CPfipuAQf1O2B9Yr4h4uhJAeZd5Y3uWTlYNzMFBmGw9CEXP5L/FXtHNei0C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=VTzxjGh4; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="VTzxjGh4"
ARC-Seal: i=1; a=rsa-sha256; t=1760545977; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sk5NK4I5qjCiaEtdSwMzYM8S5i2snkN1RU3ln5hzeumEQEdN0KJKbimOrBoi+fGvIkCliC3uv/7AS6vx/Db7vckFwcAi+fMWEqyYvScvUZBgmGXF9t5VHbIEvSzZndJ8XZqSYbOgmRbVoYhC2QWxrh3ZVTWKzRsgmWW4iIOWy40=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760545977; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qka5rRhiNu7gh1nkT/r1uncAJ4L+oiWYE0y+7wUupjE=; 
	b=OdJJlmVX8do9fqFs5A/747Iu8XTrjH0BurY4v0H5n6bDIYuzKmJ1oifoTvswXIZix1rCtF/8XktFsIEBI6O90GLJlJ4PjJeAhAJx0hKw4JbAfvhi6Vtt0xGxr9M4XmmANVhlPmj3Jo9pEoBtTJa5dXm9l1h24Z8maCXFlFA4HYM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760545977;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Qka5rRhiNu7gh1nkT/r1uncAJ4L+oiWYE0y+7wUupjE=;
	b=VTzxjGh4dRchFFbhi9R4YCyjByTFHdUoiy4UVOG65xJOTdk+Xj8j8omFvx/GUsYj
	fKXql4m0xk/NNE2irntYXUnLT0S3A/VjlaQBCVeElWPWFH839r19nhbI9xpvu0RHvas
	MUIASdyTfwo6hhUmPiR3Cc3R0X1zAqG3T1OtMd5s=
Received: by mx.zohomail.com with SMTPS id 1760545972179630.4411747898575;
	Wed, 15 Oct 2025 09:32:52 -0700 (PDT)
Message-ID: <ccf8a93f-2948-4774-87e5-acf7c03b9941@yukuai.org.cn>
Date: Thu, 16 Oct 2025 00:32:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in
 blk_mq_update_nr_requests()
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>, clm@meta.com,
 nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251015014827.2997591-1-yukuai3@huawei.com>
 <9e775775-940f-477b-879f-dd7389f0be31@kernel.dk>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <9e775775-940f-477b-879f-dd7389f0be31@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/10/15 21:48, Jens Axboe 写道:
> On 10/14/25 7:48 PM, Yu Kuai wrote:
>> Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
>> blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
>> before q->nr_requests is updated, however, it's still using the old
>> q->nr_requests to resize tag depth.
>>
>> Fix this problem by passing in expected new tag depth.
> Fix looks fine, but you really should add a Link to the bug report, and
> also a Reported-by tag. I'll add those.

Thanks! Sorry that I do forget about this.
Kuai

