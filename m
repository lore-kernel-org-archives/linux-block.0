Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885472FB608;
	Thu,  4 Sep 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983599; cv=pass; b=bFtf9wvnNg2PlGKolVtbZkHEYx2jTZLTNCMKL7Dc1PFjtAQdoeCGXldXZY2Ju8vSiTRVISM127e5Vsyf1PiAJ0+SvbT57gAHXGMiBwOrbN3jOZRbyp2G6df83CnaINs/6OpNw+I50K2tv7Ah8ay2Z3rRnfUK5GEyIMmJqcNif8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983599; c=relaxed/simple;
	bh=tj4bpgROzqe+kysrrtTFTW/8czrJhJvJ4R1wJxckKas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsSWr1bnCU30Cc9w+DOaOJAeEubJc2oB7PkrvnaJislr6UeGhpiKLNsrr0FL5NWl5W+7E7oq+O08XF73AUAaiae7OqQGpgQIHJmVSQOKf0nuucsttWI2G9iVPruJ8nB8CAfD8j9fDhICBX5g/gO46jdf/qoqSjzPQhGKnN00reM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=U2fJRW52; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="U2fJRW52"
ARC-Seal: i=1; a=rsa-sha256; t=1756983571; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XHeyWrbpJooNCQiTlV6hCuyavV0l6DP8+6Rn6vg0+S45Wt8GgvYaWs3n6ggXrSbx3FIRYBKOwPaKgPpSuXVOhryyYofJYi8nNLfImD/rdnUvqiwaYZJr6E5q91ao9Z3+KUgFCzPaXeDxPiDYnjrTFu5Ycguhvp16q+DqUTd+gMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756983571; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O2alNobFBrDQf5QIPdCYH2KS/kRB0TDTmghALol7FC4=; 
	b=Hw7sIM+fYBnQ7bDm2zdzwavTvirjTsIMJa5hr9ziScEvIdLItAyXOMH0FTwOrsJUc2Msk9CHuoBKvGBxPrlXd28vFiamFd7lOsWTA0WwqnRd1i760QGcGEpvwF4tMc/F3FEyl6XVwX8lVL/WKAPkkeMpfk6JDAbJdtF/rOFcahU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756983571;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=O2alNobFBrDQf5QIPdCYH2KS/kRB0TDTmghALol7FC4=;
	b=U2fJRW52X7Ob1Y+FXq+6WC3WdCb3fg9N7QPC9rllj8O3FB2glLYYpgdUzuAQV/Ee
	CQjxBvwMivjqi/ccyz6sNS468sjezZjK+3PzWlO74oICM2IJWBAjvNJ28+UBMRSYRkM
	iOLtcsbiGQHtVUTprm61a8Hu3h3ANHdgfOoY5SzU=
Received: by mx.zohomail.com with SMTPS id 1756983568388359.0808765853875;
	Thu, 4 Sep 2025 03:59:28 -0700 (PDT)
Message-ID: <5b626062-d2c2-4811-bb0f-2e4276ad28c0@yukuai.org.cn>
Date: Thu, 4 Sep 2025 18:59:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
To: Han Guangjiang <gj.han@foxmail.com>, yukuai1@huaweicloud.com
Cc: axboe@kernel.dk, fanggeng@lixiang.com, hanguangjiang@lixiang.com,
 liangjie@lixiang.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangchen11@lixiang.com, yukuai3@huawei.com
References: <1f9c674a-9f5b-6c89-0504-1f6985095fa0@huaweicloud.com>
 <tencent_4D98FA22B5856469AC62088A7AC6D67CB009@qq.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <tencent_4D98FA22B5856469AC62088A7AC6D67CB009@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/4 18:05, Han Guangjiang 写道:
> Hi,
>
>>>    static inline bool blk_throtl_activated(struct request_queue *q)
>>>    {
>>> -        return q->td != NULL;
>>> +        return q->td != NULL && test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
>>>    }
>> You can just remove the fist checking, p->td must be set if policy is
>> enabled. And please make blkcg_policy_enabled() inline function in
>> blk-cgroup.h and use it here.
> We intentionally kept the q->td != NULL check because we cannot guarantee
> that the policy module is fully loaded when this function is called.
> If the policy module is not loaded yet, blkcg_policy_throtl.plid might not be
> assigned, which could cause the test_bit() check to be incorrect.
>
> By keeping this check, we ensure that we have at least reached the cgroup
> configuration flow, indicating that the policy loading is complete.
>
> I'm wondering if there are any risks here and whether we should remove
> the q->td != NULL check?

I think there is none. blk-throttle can't be build as module, if config is n,
blk_throtl_bio() is a non-function, if config is y, policy is registered during
init. And throtl_init() failure will panic, noted blkcg_policy_register() will
never fail for blk-throttle. BTW, policy pid is not a dynamic value at runtime.

Perhaps remove the checking and add some comments?

Thanks,
Kuai

>
> Thanks,
> Han Guangjiang
>
>
