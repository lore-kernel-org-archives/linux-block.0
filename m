Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22843019B3;
	Thu,  4 Sep 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980727; cv=none; b=KWqWSkVKSEPjPSd4Ani/WPcgFadYl/lQAh0Tc0AGRYGQLPl1fa+Ng24bkgKWrICFigZhPcUFdOJNJVB2+HuzcnZyeeIEsumR2cHAt0tZIOy+Y0o/0a9GpPPH1Ak2/pkQ+3Zx3+oRmw83d36OxYVlAh26/4WPAooHhynx8tzEhdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980727; c=relaxed/simple;
	bh=SVzrlG6EiqurtcYJS6e3s4CsW++ZWmmqsKqR3pT6waA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uepbIA72c+N9ZSrqY7SpDNhEvCGJAk8siiLM2amDLGvvhTpyHmjmNcg4Q/KBrY9rdHM2JcNd7590eOGbQqqgtprzlhJroZh/o0OtGQtB1Jyrbqw2pTLDV2uVKmEXluDc4Wt4i8+OtZIsuVNsxEZ8/9WK8b1xqm0sHk+QW2UAfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Wi/KJwDe; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Wi/KJwDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756980721;
	bh=SmrgEE1d/4hfg8XYik2jCXkw+t8AuBI4gpU0IEWiY1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wi/KJwDelfnfVCQI9GmRZvZLq6ERIqinTPq+f9THbaL2Srebmj550miVR/1HvPiQa
	 z5VwUQ0kim5J5GIT+1INx0X8+6Wod2PXPxg9du1a4d/DkX+53wl84aEdqdd5qc/Pto
	 pmfiEkxs3sCuYvLkuWiHWHWuoZXJXZLnjBIAKMpA=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 150B5428; Thu, 04 Sep 2025 18:05:16 +0800
X-QQ-mid: xmsmtpt1756980316t3kaej8v2
Message-ID: <tencent_4D98FA22B5856469AC62088A7AC6D67CB009@qq.com>
X-QQ-XMAILINFO: M+DG/l9YxNXYhGG6xTZvAHoCs6fLNiYGPXsqjT7cDZEE2lTAJAvjOTlJAc/mQh
	 9yzgVcYfyODOaZtU2mEqApQ6o9zfL3/i4cJvdXpu2/LpCsXqkULThC6EZ4mw/m3ikwySUg3e49/t
	 28LEphxSJlY7sDzhx4NoSBEm48D1lE5gwBKDXXY/8uwp5IYSsSQ1ov6Xk1ro1aFF5LWYRw9HIaKE
	 x4N3AdfNUPUP2cMQeatgJNu/Thus7ME4RVKPs0QVKS6qK1p1ADqT+Vrh7sAbgYAbEaa3tqPU7Bi6
	 QEocdHwyKyJULrcRttl7/Kpz82gR0mzpcCdpJyDwpTFNx+r3ce7eA/z2mQLLsQN1XL1WJZT7P1w8
	 wZsIpBdk/fTldu4KwMyaSl4k9cyk8iWgQUMVMC2BIMi1znjjVzKNpCcqlB3h6RmoIsYczZKiXc5q
	 luZQmOPkeuuQyI5L4yDrgDRW9mFMNKflT4l02ce/48Yni04ZKU78jziYPj3GVM8KX0voAo9WY1nM
	 EbV2GFqMzmUY92mlx94aGanuj+oLSs4z5NnqM7Mxzlez/5k/i5B9EtxMgIHXeeBfxpgSdLyd56JV
	 a+Lz5jddEVfB3Wk4Rnc2EtO3uFLJsrM7bPHl0/Dp2C0vNbcB/Ta34Z0/IWnTBZNYEjsVEpq3HmcR
	 dJYAa1q+wzdHyKsdH+WnS8JBqVE5ok7cfrprXsnvNdV44kQ93ziIECeVMZV43Cn5NazXKj5vRAa/
	 b0ftCVoOvc94gOmigGnqV0E8BdMsVCieJH8e8JOYr7a4eeA24XXcVxTtJTN6tD4lqHbFQreADxI3
	 N7p/0f/gqOlaUcslIyia/iaSgXOf9FD/p8ZvvlmloD6PtgeUt6V8go5xY+LU84INMeDx23I9e+WR
	 UFM0ocPf46iuuscgHpLZ4XV9g3hnUsd2flr3YFwO33IuccNxFuBIhAIcFnguk6EXNAIAP8d/YbsL
	 xP47q/CtISOVAP/vXF85tnKk6NChwZN/IhJELKzn4hUl/+YP7frAWvhK0xVVQ3JJbM5IU+3t5264
	 1Wf/JzpndK3Sh6HA9Z
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Han Guangjiang <gj.han@foxmail.com>
To: yukuai1@huaweicloud.com
Cc: axboe@kernel.dk,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hanguangjiang@lixiang.com,
	liangjie@lixiang.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com,
	yukuai3@huawei.com
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Thu,  4 Sep 2025 18:05:16 +0800
X-OQ-MSGID: <20250904100516.250579-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1f9c674a-9f5b-6c89-0504-1f6985095fa0@huaweicloud.com>
References: <1f9c674a-9f5b-6c89-0504-1f6985095fa0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

>>   static inline bool blk_throtl_activated(struct request_queue *q)
>>   {
>> -        return q->td != NULL;
>> +        return q->td != NULL && test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
>>   }
> 
> You can just remove the fist checking, p->td must be set if policy is
> enabled. And please make blkcg_policy_enabled() inline function in
> blk-cgroup.h and use it here.

We intentionally kept the q->td != NULL check because we cannot guarantee 
that the policy module is fully loaded when this function is called. 
If the policy module is not loaded yet, blkcg_policy_throtl.plid might not be 
assigned, which could cause the test_bit() check to be incorrect.

By keeping this check, we ensure that we have at least reached the cgroup 
configuration flow, indicating that the policy loading is complete.

I'm wondering if there are any risks here and whether we should remove 
the q->td != NULL check?

Thanks,
Han Guangjiang

