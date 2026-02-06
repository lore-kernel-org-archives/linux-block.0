Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47629BDB5
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392147; cv=none; b=d5VORu8euB5/hxH3xFuxqbL99MjbTueb/G/L8c+icybIl0hkm6+dRjYtCB4g506iAwDSsbcmkBdya77cXUX8N2GI4QTTM56aAP8e8g6z5EFPUCxGchB8eTJ4gZ0sR0yZnA3AbEMGho8YJoCKFHVNTAtV97MKPaKEczJUVWa4o5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392147; c=relaxed/simple;
	bh=sQ7wAZYUcHHCEYn8/pfsFZZv86VU2C+1lCPHDxCs+3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfeDcxXLgoy+eUd0nUGnIKgr/FWC9JTWegDW1aLQYVWAddJe9dEvidYMSqRWklggHB97zqUDHArvdKdcrZLqX0EGO4712z6X3UDk7NUkBlhZRHsdsNkz5sh88Qx5Zsx+oGzNJTm0+KrrF6ImT07Ip4ztI4sAhBbfTvDoqzo6dO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgLjk/9I; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgLjk/9I"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1405921f8f.2
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392146; x=1770996946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=saEDIuvUXcRNpAj1CtsFCVNh0KBlM0A0VxQPIcS8evo=;
        b=AgLjk/9IQOqZ+KJGKMjPCYmAud3eICg1neta+UKNZxRwvyJpBPTmxbls9IwMjV+KUl
         m2u3rikTpda7pevhtx//kt3OeYEPzZ8mKevrvMc8U61KSBkcfAv1cslWy2NdNa2Lhlpz
         Ua+xT9GwE1zC/2oYpcG8was3HISzQoYq3zOuytkERryw8oA+MR6zKPpV0EW09pKEqSNz
         ZKY530w1bVYRvVKoE43nA09DxpjZlKewIw8/bM9OEHQdoNlQJ54Yh7izGX3nnrk7lqfc
         25CXKw6fxf+fSj+69fRnVimcNas8u4H1nODupU6IO3Bz9WPhpjm6QBF1NYI6ADMMw3iL
         lhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392146; x=1770996946;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saEDIuvUXcRNpAj1CtsFCVNh0KBlM0A0VxQPIcS8evo=;
        b=Ffbtg3a/z/wiRtaIgPLx31zQLusKjrZNEahOEEup92qbqwfWehT4r2GH9hZuZIpYa0
         L7WoUZBdSLP03EtpcQMJXcOJYMpyoP7xXHkGRs8vuaQwlNAdbam6j8svUWqZ+Nde2Yez
         IuG2kAurwXJcmaGevTqDO850etUMWUwtOqUhksiHe0r08GkbLL4aVL3YPTN+WNo6+ADa
         5W5R6srGmGyEBFGdq/zs5p3TirKdJUCa64nzzIIIROQfnv74OmN0EO2uUGpBFVIx1OIm
         B2Umpq9ZSGmMx6z+YuKDy50hpGsNWw/Zwpuz+3CVcltT+dlP/hsuIdrV8yYZNxcqOMjo
         iIag==
X-Forwarded-Encrypted: i=1; AJvYcCW68c/OlGYmXaF48YGp56dFYyBSQLkL++oSa6VSMOD+SdHRwAvNOzc48Pg5Iey4NYW7apQVPbJzVnt8Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGViMXzdatMl8VcW9MarAW+6nq7PhdvJZWmsdcJPIxR2BYAt75
	CtFkOuQzrrcveQn4npzaFZ/hizID2yiHjZYZpjKhEvdwOd4ZZ5EgtGg2
X-Gm-Gg: AZuq6aJ1dX05jTqWWdiZT0ye0Mpw358W2/7v8XUEFyqMMoQYuNoNyTseulmCmOMzwz+
	9kk6j+Raw+dsqAL553Is7RzHVou+jmCDYgQm0Vlw50hzB6H/WImMdWKDok09ihXZ3pj5K+IZvHA
	9dK3koZjpsJmKCq/fOO7V1FUic9iYCQ/1VggzUnl2SN6pVew6pRRKqzArVPdOV2SrgKDuFTTgNL
	E8yEwEYk6DuM5pYnS9LiVFDH+qu9JUsstmrmxiw0PbzBywIARs5mXvI0Kd0idM5DwutB8LPKgyW
	K7/fK3LuHO3ZODWqK6PBOZ3/BF76T3HFvnGYPUdOOUUZ1DZEixZ6Fqkd1r44bajnF4C613LF5tw
	2ibjeRepKrm17ScZKOXPGWv5TnrvdIVMh47pWk1ZkDqCHvSJxGZDVQHuMDblHcwCqqBdqNZk8e7
	BScv5RcVBBXKGsQFrBvoPIl/c5HKns/kiRhDhB
X-Received: by 2002:a05:6000:40ca:b0:436:192d:76f8 with SMTP id ffacd0b85a97d-4362933c7f4mr4168012f8f.2.1770392145611;
        Fri, 06 Feb 2026 07:35:45 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa4csm6188750f8f.26.2026.02.06.07.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:35:45 -0800 (PST)
Message-ID: <b887f3d6-28d1-4b90-9466-ae2d0886e027@gmail.com>
Date: Fri, 6 Feb 2026 16:35:44 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] sed-opal: increase column attribute type size to
 64 bits.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-9-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-9-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:18 PM, Ondrej Kozina wrote:
> Change the column parameter in response_get_column() from u8 to u64
> to support the full range of column identifiers.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/sed-opal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

