Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5F44236A
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161858; cv=none; b=hmhgerwJEBKR2rT+1rHG/5y+Z8lbu7agteiOUWc2uZgY3JqADLkpjEYzvGWtWSVGaWs7CGpalA1nwxMXdNWcHU4NTDJk2zs8AGGDJ3VafR3lwqIXbSXmS9t/saY68BHxdBQf3AkhWbFXH1qwX2bqKN3bF8ewVywLnNJnCG5993A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161858; c=relaxed/simple;
	bh=AW9LSuLXBmvDFvTLuvr6NVWRcGwXysboVp/gCUhoC7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mutD29dguYbGYTUzUnLz5KU41FBHGrdpDv/70HPbhOP1QPgNUZNL/CzqmlDwmQS4OhV8bSAiu78pmWVY0uq3AXm8CIFNfwdjau+sd3z8sKjUAZbJcbaHTBoXgRvL4S1Ps2KLk7d8v5C2WOTeM5ZZIEZwtPIV/GzUGy4sp3uRvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=F5CTm1sd; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="F5CTm1sd"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451a49abd8aso51744fac.3
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792161855; x=1792766655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoQnNQRpIUotDt89h6XztLJn3WuY/wM/r91HTjvltFA=;
        b=F5CTm1sd6AAZBiguwvKD5nMxBT3pda3vAJx1o96n383GUlTrItJRxey2q5fogNTW+Q
         VtLePtAtkHhTZcbxRmiwkc+XWD/v6Kc2J67SKn4GKTiNqbc2e/XPopZOtP09cEqQGM1b
         xb29MJi5wq0carQ0bh5OMQv/2DHLIqn0ppdl+z+Q9c95YN16GR2LIh2rAchpqJSq5AEr
         X2gcf3mkPkQHl2mrnFyWz2hSAeypKtwQhoxxdroe8+8hXdgmfDgPN5htz65ZbXLNJdI1
         8dvARhT+2gi9H5qDWlFuxYykZbCop8SqOYxVU5xaqRB3HQyjuf1yWMhuTKlbhxotAGn6
         19ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161855; x=1792766655;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoQnNQRpIUotDt89h6XztLJn3WuY/wM/r91HTjvltFA=;
        b=v8h1ex63vJXU+ORwsR72TgG+8Lyk+1uPumIUxmFWhvl75odv3MmhfkDKxFC+BGe04q
         Tec59/VY3ip7XbFqrbxqfU1Ac54epsUdiXhcYV5pq7z4PRllhxRpStgvNtmsl/rPPJNy
         fKEBlZJZurV6o2GHo3T4n1ir9vbf4OnCkRsv21juvT5dVDlnvPaTUfIGIWgS2mO/4FOW
         K9WUfAU+poENxJuoNpX3SfyBwZBsu3bsNJbybIKTAwc9/UgGqtYZPOQD/6vOTt28j/Re
         n8wn51joAMCGanek8GZ0o3LHjSkadP3dQTLFYCUuNujEjJ7xnYa1wuPCFR9DgyJSJDc6
         JLPQ==
X-Gm-Message-State: AFq9FYJwTrXlq3DSGv3PZj4w79xZr7lwrQnrfA/mQUAUnj2gZ+bIY7NA
	Vd+web5Xt2K3GgHe5Rot2KKxL0dZ94mok373s1OfJYsIxdeJl9T+PwJesPaO00TbA+XNifRgiAh
	CXXAJ8dY=
X-Gm-Gg: AYBFou1Hw3oAzvA/g61m5K3v70CrH97b1nxupLqONow27M7fIYrVGXzf5LreemYVtBQ
	rlOY0b4pjkXPYpJCc3QTkyMkpKaHKeEju2ZVS3VCMqS92cOVpdpB7AFydctZFCSMunyLgi/cPFG
	U9waaRgI6mTh1NW9rRZKMvszVoHwj5INP7d8rPSEeFuG+S1H27Viarzzuyn2NKrZMxSRhV5sOZs
	fjySO0h5KvnfwMtaGyVcrK1llCQ5qBlEgaCtOf7ecaGdFMwrckAxoILctHmM4Q6jlU7+CGrSis4
	rS1hR9mRVTeSwPzFmHBeTCUsPSHFbkXuecAW0EyxmFeGOTSHdxnJni0egrJdNup6b7mDmCDyNer
	DLz0d0EHths8WGpyObGuSakZq2axso3rw35Bt9fAoryYIfkMLc9lXLbeDdvVREE82N2HJ2TsYkr
	V7CcIl2iMR+Mlyd20ReWDd9oyK1msrFDGKCuz75vyyq9Da3VeC+qdRayhVKc2KsLYHbkeNh54a/
	rJXjQTP+8Pt6sRf96GMJW2ZYhd10nTnYWrI3GT+PSVITiqArR3d2fWQWQ==
X-Received: by 2002:a05:6870:d38d:b0:4a2:4239:bfea with SMTP id 586e51a60fabf-4a75796a765mr195645fac.34.1792161855077;
        Fri, 16 Oct 2026 07:44:15 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73adff016sm1923518fac.0.2026.10.16.07.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 07:44:14 -0700 (PDT)
Message-ID: <5ce34052-c18b-4e3a-ab3e-f689218f6208@kernel.dk>
Date: Fri, 16 Oct 2026 08:44:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: print device that had errors
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
 <4104c9c7-2df4-4008-ac2d-0c999bba98d6@kernel.dk>
 <237f8537-79cc-4ac0-83ae-31ea0d51e0b9@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <237f8537-79cc-4ac0-83ae-31ea0d51e0b9@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 8:40 AM, Johannes Thumshirn wrote:
> On 16.10.26 16:23, Jens Axboe wrote:
>> On 10/16/26 1:30 AM, Johannes Thumshirn wrote:
>>> When testing zoned filesystems that span multiple zloop drives it can be
>>> difficult to figure out which devices access caused an error.
>>>
>>> Prefix the error messages where we have the disk available with the disk
>>> name.
>>
>> I don't know what this is against (doesn't say), and it doesn't apply to
>> the next branch...
>>
> 
> Strange, it applied on 34fbfb9d8d1f ("Merge branch 'for-7.4/block' into for-next") in your tree.

Does it apply to for-7.4/block? That's what I used. Doing other git work
right now and will re-check later.

-- 
Jens Axboe
