Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858D54DAC0
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083084; cv=none; b=YlYrHgblbnfK3k1+fNUq6ntpQGDKvhac1XKHJi56KRzmNkSF9DJNCRG90qDxsw0B0glbpsIHI5l7juFkxTPhfTgOdhKI/gBr8e7rBuVMuWGFq9m81FuC2fYLk1Of4GoSej1NIW8//ePzLL/q3dC1OtivoYKsmi9ycAldJItSBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083084; c=relaxed/simple;
	bh=4pfzmO/hwWCixkUYL+9BkgmWlmDGjMCDcNSgG5Tt31w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CAKpDxyl5IdMG5XzyX2MMPnp1zqTUHcphnL4hDTV3MgxlIVVNaBinEzBBY2qY/IOV+b/bya5hd0rfZrL8LFtM//YgPkFyx4VoKxXO2dJaXOZTPPc8af8k1WcPq2vyiOCt5pGjMj844M0K40e8VerdSjl5tc+AX2GtFYM61F5g1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NdUYEgec; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NdUYEgec"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4pfzmO/hwWCixkUYL+9BkgmWlmDGjMCDcNSgG5Tt31w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790083080; v=1; x=1790687880;
 b=NdUYEgecqHccCywkar7DtDVmls+dip8NSfSCn/QPe1z2Iv8SgEf833AzLV9MY4yPF3KXMUYd
 Q4pOqSiWKQ8IvVyrXbh7jCGZGPXmXLXaw52lbvUOQ2R7z4NuRETAQmN6LkcbX3faB0xbRjs/owB
 CsDWQtYZ7dfPz+8mFkVYXpmE=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 702c86f6eda1fa1b;
	Tue, 22 Sep 2026 13:18:00 +0000
X-Mizu-Trace-ID: 702c86f6eda1fa1b
X-Migadu-Flow: FLOW_OUT
Message-ID: <e415b04b-468a-4831-9e0c-55b1b7ccceff@linux.dev>
Date: Tue, 22 Sep 2026 21:17:53 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 ameryhung@gmail.com, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [RFC PATCH v6 1/5] blk-iocost: add BPF struct_ops cost model
 support
To: Tejun Heo <tj@kernel.org>
References: <20260918055001.1273840-1-cui.tao@linux.dev>
 <20260918055001.1273840-2-cui.tao@linux.dev>
 <e95fad14874587df6ca17c5cf767d24e@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <e95fad14874587df6ca17c5cf767d24e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Tejun.

在 2026/9/22 03:37, Tejun Heo 写道:
> Hello, Tao.
> 
> On Fri, 18 Sep 2026 13:49:57 +0800, Tao Cui wrote:
> 
>> +	mutex_lock(&iocost_bpf_reg_lock);
>> +	{
>> +		struct iocost_bpf_model *other;
>> +
>> +		list_for_each_entry(other, &iocost_bpf_models, list) {
> 
> No need for a block to scope a variable. Declare it at the top of the
> function, or in the body if it has to sit inside an #ifdef block. Same for
> the other blocks in this patch and the cursor block in the 2x example
> model.
> 

Thanks, fixed.  The scopes used only to declare local variables are
removed and the declarations moved up, including the cursor block in
the 2x example model.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

