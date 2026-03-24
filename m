Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF31A9FA0
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379799; cv=none; b=XNuXTaexTGsppktaP6qnbL6/YzRmr5c2Pzid25HP1ET8ncYmolzxKy27fXBT+gEETK6s9GlUrkjLy7YRtm7uwnp99EWwu46C+u/NW/hVNrDZjzbY+VY44ID4VP0kjvZ3hpPj0M7Xwce9emd5JY2iVafJA2oUh5fmFUdAtoICka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379799; c=relaxed/simple;
	bh=zhgElkjcxB5zpjl1gZsgfOowRG1l2aMmZleL2SelQ+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+7Debxyh13CIaTn2TDAx/518iRAXsCqm64DZXVqd0C0UjKT3YBASKzWw2Low2QD59U71H6Rx2ywWHwviP1dJINfwH6ZDrHhaHMFs4uiYYn0Sdt9a6cHsAEu6lZdxQRs0RPfhmBhIV5c3Za5bhlIOxpQOLPfTZ+ayfoA5d9X1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h1bMN+dW; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h1bMN+dW"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d75371d873so4877515a34.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774379797; x=1774984597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaWWWaT7cKjlOatG8KKZZf30KN34367WduFSnjs+olA=;
        b=h1bMN+dWatqykg6dRWSsE8J6Dr76nEPglm/ME+0JVAMyCrS2ZgwvKPoCDq7ITM6nZT
         PrjNAGudEdQYWuiPUasOlPjdNHKcx5dxaqJQq+ZMOpwx0pwDWUGA48AoYD8VinBhHO68
         JoengoFp3zQ/R95At7Ggn04r8f/CxFS4zzJFE2cYLvG9LvEve7uOoR9mOq1gHPKZvKgp
         gn04LNMNvtORmdgi2o3J3kXCEVHyYoOefnNhDfFOLRECQSr506HkY1QKnzyh64C78xKf
         8CpCdMKpFjsMaldgp0T7LxrgpjTkbgO0XUu/BZuv2LVshWGsbxR+Qo5m1A4O47g7z08n
         jnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379797; x=1774984597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaWWWaT7cKjlOatG8KKZZf30KN34367WduFSnjs+olA=;
        b=XF8DRi9S0GAQ+lKI5J5NvKbvJG0g80OSKkVvohlqw1giXX37uahyn9n/hdOHzb1ADJ
         TODC5dD24s1Yl6Y8/gf8Nq/iKzLx4ynxtmyUDTimknFidOMmRrSxkvkuRy3Ok70cc6GE
         6QzI4JpPWRyKpPfIvtVPRaSEWb5pHaclcfBYHkUXFhyCfeCTmnTbISKlyOBZU5TU/IIk
         AXaksZ9vj8O4nOPjeUrcytUds3Yutog5gNST9j3p/v6sCgOHdIODCLzoEmciGns7fy1X
         DIl0pvJXhWyUd6fWe8wHFVtyd424wod7vYUpeQ/6oW7yDeEWm/0FpzGBZz/n5s26p5TH
         SzAw==
X-Gm-Message-State: AOJu0YwhTvnktAEkvCTqabFJFkp7Hf6RHF5UcWovzRRgmVaUW0JBn7rR
	GN9lrIntCTFa2qp4+z9zeyVjIyHYuTlDkxYv3ltDvFlyWxZ7CYxl0ispa6JiHzY8HMk=
X-Gm-Gg: ATEYQzxIEIeyo6kqN3AhLMHSTfYq3Bwr21l70FCp3AXo+cpyzfeh+BlDMbt3bzoi72+
	AXhh6oEloKdhfzhMLf2jidcjEqCDAOpvnkYIoCf8yaIPJXyi/mhvMMM86kIKdlWlS8LB1MSGD1W
	QHqnvvbkp2Up0n7r3N9X4cgiMWSpqXDjfTpOvaT9v12TclIH3Ub+Ntd91pCzsqvSPBDZlwvgzC3
	SNpHRV6zDBiEfWqEqlsHj+JblTsIr+W4cRn4DAz0NcXUf7MeA/lOrwoonCu7+4SLrz96rhaW/sR
	oVU9l2Ze67WWLAP6Cp7Yp38SSBJV8qi3gEgsEnxWq5gz7gIP4pPdFjmpQXbFe0JiZNpioo9DewZ
	ChB8fRmpdUyd4Z2bHEtadXZNElsDoiN5DJMC3C4AIBMLq6aDcixdp59NA5/KAxIUjWRYX3r4jqB
	C8YFjYXwUKr2+j72pyOQCBzkG/1GbAoOiDqheLixZ17/oUSy0bRAR7/xNNn9tE9ioBmdaVDQth+
	+MZ
X-Received: by 2002:a05:6830:6739:b0:7d7:49bf:48cf with SMTP id 46e09a7af769-7d9d672cbb5mr340492a34.4.1774379796326;
        Tue, 24 Mar 2026 12:16:36 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9c7656e82sm2778829a34.24.2026.03.24.12.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 12:16:35 -0700 (PDT)
Message-ID: <33177597-8df5-4494-830e-6e287bb8188a@kernel.dk>
Date: Tue, 24 Mar 2026 13:16:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: define new rqf_flags RQF_XFER_SINGLE_BLK
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <20260324143448.2631888-2-b-liu@ti.com>
 <5c12f6f8-5962-4d66-8414-8f5185438ecb@kernel.dk>
 <20260324191126.kfhwuw4njinh2vrw@iaqt7>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260324191126.kfhwuw4njinh2vrw@iaqt7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 1:11 PM, Bin Liu wrote:
> Hi Jens,
> 
> On Tue, Mar 24, 2026 at 12:48:11PM -0600, Jens Axboe wrote:
>> On 3/24/26 8:34 AM, Bin Liu wrote:
>>> This new flag will be used to handle multi-block transfer failure, in
>>> which case single-block transfer will be used.
>>
>> Maybe I missed this in previous discussions, but why can't this flag go
>> into struct mmc_queue_req?
> 
> You didn't miss anything. We didn't discuss about it until now.
> 
> I added the flag in struct request because it already has rq_flags to
> host all the flag bits. But I don't see struct mmc_queue_req has any
> member for this flag purpose. Do you mean we should add a new flag
> member into struct mmc_queue_req?

It's a bad idea to add driver specific flag to the core flags,
particularly when you already have per-rq data associated with the
driver. Then it should surely go there. The block layer doesn't care
about RQF_XFER_SINGLE_BLK, that's strictly a device property. Hence it
should go in the driver, NOT in the block layer.

So yes, add a bool or flags or whatever you need on the driver side.

-- 
Jens Axboe
