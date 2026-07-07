Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C93280A58;
	Tue,  7 Jul 2026 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398300; cv=none; b=kW0o3fm8bcLvwDkEnU9AUiY10ml0iBA/L8luDQjH+1+AZWtnJ4cFZSy0hsXBrMSLhHAo+ZRDe4bas9lR5/Etlz0YkD/YK7kyWyh0k3sp/CqfnfQGGTz8E7tYWUo2g9XpH/v1A73A4kZLeNf50iECR3jgacO3Dt1a7yNlHov/8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398300; c=relaxed/simple;
	bh=o65Hihd/sftTGkTLL1oaJj5JaTe1ojJwzKyuz8kOTFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6KmKZrMcEpfnB+YG1RMD79XwJkFmt2iOFgLe+f3qlnvCzrJUtdGEfX4ktMlfve4EDHaDyC+KYtpnw0iWkpejokgTgfcoollOjgEdvE4vMtvKPcFvESGUcMGdbrgrKV0Rvg/3+ypDvYbDwuOegSkivkLjoLTr+tku+EffwHaXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnjjbeCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnjjbeCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7C21F000E9;
	Tue,  7 Jul 2026 04:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783398298;
	bh=UgNoG5cQdJTQqqfICKulj8e/eCsejZr8QV3lueCa9lY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mnjjbeCQgjOpB9Zl049xh4DpMOxDeh856SHDXyMhzMYCbHsxVi2UYfRu/JNVixHCq
	 Vcb7n772LMFqsq+Iq7oOdMxMqflpf0C6WlyPTvOO9L1h3781b4irJhh6JoKcCNTjrE
	 u47J6RDOO6yhSLrRodfWkQxlkCgw/pIW9b/Jogo6lkpz+fYH2T7IGAuBCjQzBsjNhV
	 vv0CMdknBMd+IuIdZT1j4RX/uWMSG5V76H15PQuSMnFpHvEcjDSW4bbEkhu+Az22Yn
	 fBb2tQhFlvpLPKto/bgVp7ShmA7LQG6mJ+yhMktmtckRKLYbpjPQhkPOBx0nAGUVEz
	 plm9TPTVQGeSw==
Message-ID: <45b8c838-4d32-48d0-bb07-b2833ee4d15a@kernel.org>
Date: Tue, 7 Jul 2026 13:24:55 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/6] null_blk: free global tag_set on init error path
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-7-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260707025542.1299859-7-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 11:55, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> If shared_tags is enabled, null_setup_tagset() allocates the global tag_set
> via null_init_global_tag_set(). If device creation later fails, err_dev
> destroys the default devices and calls unregister_blkdev(), but never frees
> the global tag_set. Since module init failed, null_exit() is never invoked,
> so the global tag_set's tags and maps are permanently leaked.
> 
> Free the global tag_set in err_dev, matching null_exit() which does
> if (tag_set.ops) blk_mq_free_tag_set(&tag_set).
> 
> Fixes: 82f402fefa50 ("null_blk: add support for shared tags")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
