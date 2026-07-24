Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B7377EA2;
	Fri, 24 Jul 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927635; cv=none; b=CstNIWVoDfVMSxh8roPnlrI7sgizKFloP1YHklwL9I/ldZfBanwHU8ZnKPSHyHcdcupgIS1lefjrbKJ4Ne5Q+MHuwdyzu9O4ulLJJ0NmN801qMmFdMA5o9slGv9sQU5kZTGD0FC5UpUJ9xoHZQnqA7eKyB7tk5NtFmzZ/LK0xyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927635; c=relaxed/simple;
	bh=nTaKOd535PJcoOnV1znW0MA3jQ10BcQBIk8LtDbDrE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmsEECzKGFCFqkhm4lu/hgSvTOJjh3uT9TcIGCX//aglAUm1Lko27OvbcYvnkeEWfAJ1VBMc/YRtkPgIIjZ/WENKEPe+IhU4EvovQ3OnDWy1L8rAkkEqFzOYGM0JksxxHGQ9tJDTAyUnoLHV7KKaOeRlpX7INFJ4lEmc7ggZSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pMtnDak+; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pMtnDak+"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h6LMP1szPzlfvpc;
	Fri, 24 Jul 2026 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784927628; x=1787519629; bh=8PLf9ZsWVBg3tn9827RFvtPO
	gek9cfg5KLsxXKhqr78=; b=pMtnDak+WztFnPr083YKeCzn0vV8lvUiHspsmCRH
	btNz1mLIBHpHMjm58WkmzOsMJ926e0lh6yJJ7PdoU6F7V+9UBio6awaf7gUfTSc6
	2Veq2pJGeqhFE9B5tY3ioRMpSCMbUe0WZhkGOLGAPACh/xR9Q+T4ueAc/e0JpHpg
	oyBVqEmrQ819N9lKmeexijCoRrw/aCUX9LdNFg6it3GbqQA+aAgYMB8pNl1ppaDj
	Tb2FUMs6yTb9k4PuOah6yoK5wahTXlnwhbWmdnjPibGJzg9EE4Le5mxcCUhOVhG/
	JryxP3FQfpXomP210BOm5JKTejcw8MpYBwEL3EKzCwKR8Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Hgk92lAw6XL1; Fri, 24 Jul 2026 21:13:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h6LMD5FflzlfvpW;
	Fri, 24 Jul 2026 21:13:44 +0000 (UTC)
Message-ID: <75009f4e-7f03-4911-bf51-27377c1ee11a@acm.org>
Date: Fri, 24 Jul 2026 14:13:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 8/9] null_blk: serialize configfs attribute stores with
 device setup
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-9-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260714041805.1088702-9-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/26 9:18 PM, Zizhi Wo wrote:
>   	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
>   	if (ret < 0)							\
>   		return ret;						\
> +	ret = 0;							\
> +	mutex_lock(&lock);						\
>   	if (apply_fn)							\
>   		ret = apply_fn(dev, new_value);				\
>   	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
>   		ret = -EBUSY;						\
> +	if (!ret)							\
> +		dev->NAME = new_value;					\
> +	mutex_unlock(&lock);						\
>   	if (ret < 0)							\
>   		return ret;						\
> -	dev->NAME = new_value;						\
>   	return count;							\
>   }									\

If guard()() would be used instead of explicit mutex_lock() and
mutex_unlock() calls, the if (ret) test wouldn't have to be duplicated,
isn't it?

Additionally, the above changes modify the behavior if apply_fn()
returns a strictly positive value (> 0).

Bart.
