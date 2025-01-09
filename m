Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB9A35
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430743; cv=none; b=FxAQM0HzAVIZVel+1deuARRMmricMpSmTFtENKvsn1qf2Ws3lTrfHZi7/7dCOdp2c6+Q2agUrhs5zqjAQ6ARGtd2AZXNeELpPoYXMPDyZnhzvHftuFOzIK4HQx6Nndg/lMZ4HTJWeODs3+0dgZ94ZTvS1VKVCIj65RRpnTf0kdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430743; c=relaxed/simple;
	bh=vJEWTB1+EZZjDYmSpItqMEBTLhhMZBkDvxVvhsQPPio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO2KX44OwLnCmXESP4KRNFil5fBMysmJDduVp1nqgACJ82uBa6g4IQGbG9E0dZ2v16v3cjRhhfUfBdWfjtfS+0mz/JMVJ7Gl2iUWIk9AR5Xg6BAbMly5R9Mbyt5lhC+d/MW1B88kdxQ2+aOtSlbDSUFtTPSF4gJeDBe8BXPkYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ij75ITBO; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ij75ITBO"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ee166150so28495039f.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2025 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736430741; x=1737035541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lq1DFjqIwAfO5pylU4M+ORRtpviizlgmxklm3SmoyUE=;
        b=ij75ITBOI0KfwWjTtAe50GVj8afQeEdxBPScty7WUnxmRcUSIrKl9+r3Rv5GU9/gKS
         f6DAFo5XxO8NlxvdlRxDDIJhgcFb7UuXiqEHX2YKZZQCAEGtgCp56i7oaKyUjLpgn0dP
         Ekdl5w5k1mUViN3y4hPpKcPVDp3FKkiH552eoxXoOamzH6SFqUMJj6R2xp0d3J6f45ga
         8xQLhuB3A6D9EVYCBzA7wuCXKBxo8gtJCvRUPuJXitEExYv9YkGGFxz5V6yywui90SSU
         2u4/hNYFkH463tTV3ytDlFNpR9SkQy+/55fs0dbzhCpLbBPcsH1ccZW6RsLjiZjD+PXe
         a/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430741; x=1737035541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq1DFjqIwAfO5pylU4M+ORRtpviizlgmxklm3SmoyUE=;
        b=MkNvrhrXdr/kc/nVZT/4ElEWuoBv6a/TJuFSDmcok1Q+8kp7TI5tmViCkRttgbbTWE
         Uj1tvkZtXrczUxbtF1J7ZuCLF3hTZDWMpy7cKHv42Az73/rMpiKz7kmx3H0c3gDFl4Gy
         NYwPPi3wMxUD0E7Pqq5wr7jOLS6JZGRcTd++gis5gUFHcDJq+/K64ZYNxXIVqVvQjakW
         jVEvFghyAw/eLBqeyDocX0NX2z7AP/L8t2S5sHK33CsvJXR53OndQuulNTOaGa7RyF8x
         fopNifdoxHNDKMmnzQ/zeLqLz4RFTIJV72vl6kGqUAcu3pMhCMGszXkRn4wL7UlzZvgs
         EUcQ==
X-Gm-Message-State: AOJu0YyOaWYIK5QIZjOZPUjywx1L5QryZgVz0UCxmTX08fh4t9brzTj+
	IDsicFloDLGYX7fYmTGX3ePqn/+ey+HApqgRbs+9PJkM9BNm8e/Mjf+iU6pWWxA=
X-Gm-Gg: ASbGncswLCoF89/rziUzXH+zbO1p4o5SUyJKIdy2R60mVHQXDhCg8GGmmQNegwf07UB
	HnpbdSL6GEKVgsona2IzVIdcbge02SvpZq1HVMUr9C8mmOgBw0/Ny55YaLBd3FvP9Z3tDAma9AD
	ZJMb2dq+c8ei05Uwi+5g6n4Q08PnKvQHRQOeGFdPlEyqlHHJMR4NZzUigPoKmG2zWVZA8nqhCQt
	7qYYGzZ0FmabZHkSSrmkUI3udHRtwOPCE9mD1aIuC2CtacIz/lbuw==
X-Google-Smtp-Source: AGHT+IEM8tk74VfLplBGsRxJ8ZqPpDWsUS022H5w9VjhpwnJBHLvmHAu99yrEAyTAct+QPK2R4wAfw==
X-Received: by 2002:a05:6602:3787:b0:843:ea9a:acc4 with SMTP id ca18e2360f4ac-84ce01254c3mr667578039f.8.1736430740780;
        Thu, 09 Jan 2025 05:52:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d4fb5c075sm32143839f.30.2025.01.09.05.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:52:20 -0800 (PST)
Message-ID: <89f3fc0e-ea04-4b29-a79e-5d2f2ef7af6a@kernel.dk>
Date: Thu, 9 Jan 2025 06:52:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250108084148.1549973-1-yukuai1@huaweicloud.com>
 <odhd37amhss2kfhniix2jzy4crg4fb2d7u6qdwplevyiegb6rm@f4fqrg4vebls>
 <db7c26e0-c6b3-c4cf-afa9-557b2841cb69@huaweicloud.com>
 <syxzk4eauh3zzs37y6eirzlblp5lin6wyrpanw2mleliyj6cnr@2y3a7hrnet2o>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <syxzk4eauh3zzs37y6eirzlblp5lin6wyrpanw2mleliyj6cnr@2y3a7hrnet2o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 1:50 AM, Jan Kara wrote:
> On Thu 09-01-25 09:32:08, Yu Kuai wrote:
>> Hi,
>>
>> ? 2025/01/08 22:42, Jan Kara ??:
>>>
>>>
>>>>   			 */
>>>>   			if (bfqq_process_refs(waker_bfqq) == 1)
>>>>   				return NULL;
>>>> -			break;
>>>> +
>>>> +			return waker_bfqq;
>>>
>>> So how do you know bfqq_process_refs(waker_bfqq) is not 0 in this case?
>>
>> Because in this case, waker_bfqq is in the merge chain of bfqq, and bfqq
>> is obtained frm the current process, which means waker_bfqq should have
>> at least one process reference that is from current thread.
> 
> Ah, right. Thanks for explanation. The except for the typo the patch looks
> good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> (although I can see Jens has already picked up the patch so probably this
> is immaterial).

Still useful! The patch has a link to this thread, so it's still
connected even if the commit itself isn't updated. Though with the typo
in process, I'm kind of pondering just amending the commit and then I'll
add your reviewed-by as well. But usually I don't, but still appreciate
reviews after it's been queued.

-- 
Jens Axboe
