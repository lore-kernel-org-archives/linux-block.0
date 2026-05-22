Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02D407575
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458415; cv=none; b=rrlR74v9HcVpEfzcr5UJdkgI97FWyknBk95L7RQBl3A01OWPc1yb1I+o/5zLu5j9qHw4zAWpilbifTxzmhSo1R5FM6pu8yDwf+I/Bn/G4EDLspTnsHG6UjAg4k9OaQ7QJRogATz8j4DCYApudyDchGTZm8GmRFsz7cQzv2U4klg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458415; c=relaxed/simple;
	bh=SVSeh0WtbiLfmNIaz76M4SuD93elHicyms9C1xrpiVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8akHmkY8lp2MbsSv/lzXpF7YEgS87yjdk30o+6u7rP0XP7qZILVj82AQwetYpAg2g8PkVo6329Ji9Yw84/3zAoq3Sk3QEIeDmN0wqrruCUKZPnjiC7zBhGMxO8a8NpfpAW+fJWq9EeqrdSEnOWqxs5OxQ31THgOOmLJ268mZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ispeognI; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ispeognI"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43b7987a9d1so197522fac.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779458409; x=1780063209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Duo5QNbnu48RMs5TWYd9pNItgsjRBgd5VchjQlpi0vQ=;
        b=ispeognIpQBoqeVvfvDxcvqzYFAxk/i/tnBXGiTSf1689AbY8usl7xFnqjOK6WbIWX
         VKgkLBFYHcjizZZ46pILFkY3617jbQ6N/hv1nSZR+uJlAa34FuqDUlI6MhWUS6I0hf/i
         QmPT3X93nH4vq2Heemv4LtmxHKp82fCdN97TBZHd2eEtFWRdm7UqNhsGsUrCeHF0FwSO
         89x5OmgJFfUpdffwUiOQBFE/2wHozwhyLY5oCEZGpsWf8YHvm4hqwowTHlpuXz6w94Vf
         1oEGb9BaQx2N9QYl+Lr8e3IeLlgHK+KxHu5Ifmr6lvXOSxdWgCwk+AP5KfCvGkogtp/n
         RIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458409; x=1780063209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Duo5QNbnu48RMs5TWYd9pNItgsjRBgd5VchjQlpi0vQ=;
        b=c1+vb3Yf/wajh2eqSoQ60c1ohJ68yDm0jDVK3ST8926NIPSAHrBjawh50wiuO1uEsz
         qb5SlOU997CbLyb6j+gVL0hDCsoVnC2IMui910/2KDp8tlYA/fJy94YXYvgtlY7i4MTc
         yIqeHD9w6grXJnXcCjAKPtROYyt9FkgL38XGPihBgclUij6T3cvjqHcph2c99FIJt/yO
         nYtqWJsX5YgOxZygDd4847K6Si4gjL0lsB/bzZEjQIG/lrIE0t1uCYce7jFrgbtE0nU4
         Of6c9NHJfPOzQkphk+fgBQ0whbNvvbaFqznaW5PmSkZs1BzIUcJ4NoKiw9j/R3OTY7BF
         ql6g==
X-Forwarded-Encrypted: i=1; AFNElJ8eaGr7Yjo3ukB+J7sMybX1NmQXXZgRLKr9LLEpPCWDRoPHcbjcu9H7pIe956Yc+kUo/65nvRTBr1EfbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbg7OW6FQ4JKXmCjlkfw5PAJzCHKXHXZPCXxWJ4J4BguUCUd2
	lT3IzpOBz1jASpYVfQEyLu5PKIXYRpvPTgy4TGrX1sbZLIgJsnkLEtYyQR2tX7Q2TQQ=
X-Gm-Gg: Acq92OF5L1acs6mXwmnX/m0Ykd1x6F5yVQ5h7sWnpxkt5EyhUcxBMkofknwEPRubyS8
	vNKE75RfsAOzWWexamN0gKPVn/Zr8ZD8UxeiEnSxra8bWgXN4QlGZ4D868FgNnGX+46MDelnvVf
	PEbJKttJoRTHgulxVKlGWQ2HNMGzl1XmMQt5QJccdFThl4UA5atBKVc96vP+5intRqUwIXFH9rv
	DuE6HzMDRcXjOWgJUNLtn25pb+pHoDvUm+ORR16ACpfB21jkMYzyG16rj9klDfm+ZTfHfkRyi85
	b8pmDuALrgLoTgkoU9KA+mnITVZpDdIN4OXB/iLqHb7ViI8L4oPvfRGgo7JbK6HnoIqnSdAoVci
	4NyGzXXYaQe1vUIR6wEPvNSuqVTGibRNKCLiVWYfR4fvVgyJVUbdXJLYab3NUeFm+OUYcaclMYq
	l8mFyuV57U/ZGgKGl3JmHFEK91VyqNARQJ3XK0pDcIBcDuhpqjWa1J7EG07h+xwKeJoPQExOOFj
	DgiZy5me0+VSSQtwlo=
X-Received: by 2002:a05:6870:31b0:b0:417:2b13:f2cd with SMTP id 586e51a60fabf-43b5ac7afbbmr2158095fac.10.1779458408591;
        Fri, 22 May 2026 07:00:08 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd705sm1924724fac.15.2026.05.22.07.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 07:00:07 -0700 (PDT)
Message-ID: <669e0818-4a21-406c-82ab-71c55c1a993a@kernel.dk>
Date: Fri, 22 May 2026 08:00:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: propagate in_flight to whole disk on partition
 I/O
To: Tang Yizhou <yizhou.tang@shopee.com>, hch@lst.de
Cc: yukuai@fnnas.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leon Hwang <leon.huangfu@shopee.com>
References: <20260522131409.261259-1-yizhou.tang@shopee.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260522131409.261259-1-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 7:14 AM, Tang Yizhou wrote:
> Fixes: e016b78201a2 ("block: return just one value from part_in_flight")
> 
> v2: Update commit message.
> v3: Take Christoph's advice and factor the common code into two helpers.
> 
> Suggested-by: Leon Hwang <leon.huangfu@shopee.com>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---

Changelog goes _below_ this line, we don't want it in the git commit
message. And Fixes goes with the other tags.

-- 
Jens Axboe
