Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1834041D
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001112; cv=none; b=VcxPTNQ1d3Li5Fs2eGmFyJmmn70ViOBHvM3xQ9gAcKDEZ82rlUpSQrxEJUadBgLvUtAV2FaXmNNIq5DUVzVg3xk+4jAD/1sGeY1aenAK8K4avaniAYv6ZJ3fkiecCUtvxdAK+vjvIq87MoGoDui8WiKTk0ottA6L8EcK/u7UtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001112; c=relaxed/simple;
	bh=WCRjE7WHRkFro0JCIsNd1W7TNugW+KjsoPfkadQQcWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThbFovSO5p7PYdoSCjenhYCfOvV01krIsms1kHYLXKZulhdCdfbXsPM44cH5JJ6l8nVFrf4warp5Pv2xcL6udzIooNsYGosPSYsajCtzFs01MvbA26IpLF3sTzOPpaMzAl5DNnTixgaf7c+lYNWUUrMKLrJxGn5zuGtrwr/cjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=MlciJuoV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="MlciJuoV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-911501a99feso1547042785a.2
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780001109; x=1780605909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=forDyt6db+I9z32GZdeZGHTlTQE/tr87Pw4gHRWCrZI=;
        b=MlciJuoVqkCCKqDdYozfGXsNjKdUeD5iKgd8aolzm4imkKtqe0fKfyEtdMRIagnLvm
         aGso+IXX6KNMogIqokHlxI8U/F0uoZ4YqpqIdXB9Mmt1B8b0fpo7G+T97aY8QObsHOxz
         eWdD+j6ON87Zxq9YjsONwxaJSsxlTSHRKli4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001109; x=1780605909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=forDyt6db+I9z32GZdeZGHTlTQE/tr87Pw4gHRWCrZI=;
        b=OF9yZI6NfqdUOzXefE9H47iu3z+wZ5wPp1O+wOe6tGpdM+Uz1OZ370PaPqKLHmo9tL
         CNtZX9KJSv7TeIetc7NwZw1qRWC5Am8sRCEMcjGVQkOOmwv2t0vbaegLZJYfhgUqBl7p
         OPRv2GkA1xmFMoo2CFe5wTydgW56+v+ii1LpoEqvjtFcLcI6VsFTfob+WYsyBH1qtFFx
         M6GjtnGaqNcy+Lqz8tAZwx2y5Ut0DXlv8+s6Ell+n30pOHMM/TBW40UfwpDcA86hwDDw
         5yj7GSNb6WpcVNVKm3DQ+KZC9IMZlPoh9jA6Rf0Dw4mTLgb/2g1WlxKdHlutQT6Uyn3H
         O4bQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cUj+09qlfRigg+HFyK0CqhA/s8+uWLrj2g511r9sCodCzKHUfCggJ3Y49yXu91Tr7kce1idzDqFXCpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9T48SCbvkx42G8A9JkmaKphB7aDH6qVZTGf/RDYyVQfRwtm18
	YyZtOlJ+oYSzhzpePc9HU4APrUJGHP3eLhMIEL9MQRdpiq+Ov4gcU1JthMOGAtcOTQ==
X-Gm-Gg: Acq92OFM8wlMypV14szhD4lqAM+OjcIIHPmf/stSLTYLPQhYN6nHdi1Zcvr7CaaKPr9
	2OdO/bpppGRhPr9xwU60saRYAtvt35GMALgVVLMA2fLv9d7ZbDTzfLFIjAQBHXYtHElITYm/eIb
	4aleUUWSm0QZXK7X6MDDWIRDaWd6Dt0ELBISudQfhq4uZoddRj9mlfR2imX20HQyCLNvZZtSj2K
	ik+E1xL4fqMaJ9MgPlm7KGcPkdqEiXFSLxQl15kMSiPcThihwYn3k2uQNwXO52WprztVaewqA1o
	HcB/QVYHsx25I3uTSOioIjkz/f1wnHDKzpt2No5zVvDOhRrMI254pbV+GaTvOcb86RJJBMrqLD7
	lic2ryHFXVUO+1uEdHDPldYZgJVHGx8YT2lPC4RdRMTZV0qwGaN62FK1d2nc84EVvnKSzbFFjGj
	7HE5ZbJ/3EyctDzWlWqXXyQ3f+pytVJWvV8tyVd0g=
X-Received: by 2002:a05:620a:8012:b0:8fc:5ae9:7743 with SMTP id af79cd13be357-9152cf55ce4mr101633785a.43.1780001109080;
        Thu, 28 May 2026 13:45:09 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-914f870c37dsm933031285a.19.2026.05.28.13.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 13:45:08 -0700 (PDT)
Message-ID: <703f52e1-f31b-4683-95ad-14694797c2c9@ieee.org>
Date: Thu, 28 May 2026 15:45:06 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rbd: cast snap_count to size_t to avoid tautological
 comparison warning
To: Rosen Penev <rosenp@gmail.com>, linux-block@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "open list:RADOS BLOCK DEVICE (RBD)" <ceph-devel@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260528202151.136274-1-rosenp@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260528202151.136274-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 3:21 PM, Rosen Penev wrote:
> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
> (~2^61 on 64-bit), which clang flags as always false with
> -Wtautological-constant-out-of-range-compare. Cast to size_t so the
> comparison is done in the correct width.
> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This is a simple fix.

You might consider doing something similar for this code in
rbd_dev_ondisk_valid():

         snap_count = le32_to_cpu(ondisk->snap_count);
         size = SIZE_MAX - sizeof (struct ceph_snap_context);
         if (snap_count > size / sizeof (__le64))
                 return false;

Reviewed-by: Alex Elder <elder@riscstar.com>


> ---
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 94709466ad19..b4ba51db9a28 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>   	 * make sure the computed size of the snapshot context we
>   	 * allocate is representable in a size_t.
>   	 */
> -	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
> +	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>   				 / sizeof (u64)) {
>   		ret = -EINVAL;
>   		goto out;

