Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EA3769ED
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083206; cv=none; b=Qi8u8LKm4R89H/QYuqz2jxBUHqsH371doc4tw7rWQpINcFWIcP8adnvdkEJ1Y2QLxoqa6Ch43F72JHbUMAre3mHIUudI9Bq1BXim8MlJ40ZEOzMgVZlD+npItRumMoQfPEdbDfKFSO6lk5t0LdhRExbx2ukS9ae91ah8x4cFXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083206; c=relaxed/simple;
	bh=i4dpGhW5T68WIUwlYd5eofVckO/HNmKTiF1m0nQ3GBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nucmML04D1chWLEWxugCeSYNDOHj3XtUeqccCC/qq2CLsSp+//JsPkGauw09jQ/flpaF9+Xw2lp2IykCAwipRIfvpHW740Fz6gWEe8zjK4cs2cOpWf5o5M6fpYTltYt9YggemT96AKAacG0dMFJoIGNm+gOUOTJfHC1yz3BYr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plo+rzPQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plo+rzPQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e614fdb42so112098771cf.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780083204; x=1780688004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiSJ4bH8ZMtUfZ/nsfhYHWoJ7VZh5Xb+WRKRtalot4w=;
        b=Plo+rzPQ8APGmXHSRReRTxsANWyZ01v//fUpXP6xV9Zb5h2GgGoiAR4M2iqfd5261b
         1wpP1tGZecU09fZaJhixWc967LZsIrv9B0PCA1PK5OFZyetebA1VnfsWQeC5r/Li01G3
         dtXiqK+EA52yZWX11cHsr0KqQoTHf1u3Y5jmxxeVw7e8k/vKA/ABgR46AtjlO4ano9f3
         yK+3BomiPPRHVSjyjhveCfE/PJDzIxtoDCqkz3KIJNDTtq4mljnp19chaDt01MRoOeNa
         GQBP91kA4lirxRPB9pUoDnX0tBUhQSp/utQ88VNKmisvW3B+hXivECU4lg1LXQTffefF
         YEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083204; x=1780688004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiSJ4bH8ZMtUfZ/nsfhYHWoJ7VZh5Xb+WRKRtalot4w=;
        b=Ddog6i6K4prmwtOLCk4btF3pp0zVHt4OGgNMWkTvcSt/52sLNH4ZDA/8LCoTd0U8YF
         zaYrIjkJS8sKih2IsJrFb/mI9oQz+ivaAh1gkSZpDjFFsK83yOUFDu+h+zIB/e2v9fTx
         K0ErFjf0QlaBcq/9zvIwIfR7uZNjvGQITe7HJMUtGfxovh2gAChAg9aeQ8IL9illQYaq
         3yVBp1ugKHsNtnV/sJxwc4+g4m6hMTSV+yoRxC19kETsX3O522GbOrW6J5ExAH81DeVu
         3bfdNsAUZxNS4sFDNC2KKd4xKWjn17wQbrmh1/9KUTqg6QawChbwy3HoR+qmIOtmKP0R
         ut1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ViZTUQspAWKRLJReBnGLfejow+NZJZzCSTBya/hDDHKGvx5eAGVyqwcznhvnGCM760qdyfzHhco749A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBqeS8T+9UINZz9DGVMavPtsO5SZE7auWiJOlniU59YU2KmR8
	7XuzooaPIMU8pt/XDmv0BfnggCCKIaxR+pYasRwkwhK7VQgr7zuuCgFI
X-Gm-Gg: Acq92OHIz2OxDnOq4mdysTP3aw9CCVHJd8YPaPPzh0C5fd6nbv5OZld0CQSJvs8JoNU
	C2e30dAQb5LqqQX7FPwM9cxlUuTRM8kXzcWz72wGCxvEehYQby8rYRDqmL290BB4h8SoFgdFOED
	V7N8DlA+QVTtBHgtpt1BP9tetkj/SbjjK/bLF5A9NnoR3nETbJffq4uS2lupJlyveHcPU/mxtY/
	ergiCfgOIo2Zy0vKOZg4vVLYHlNoRJRc474QsyXXFCMiotI+LmczK4ni9K5aA66uPyB+A9aMxRB
	khxdfn/RUYlx2aq87jG2/Z4TAjOEQTcKPZoiwQIn5KRoN/uUh9HDnKz7UXL/tXYrNTS3w0FXpoC
	RPE9QG1zMYpbDyK2Y597CfKScWfzoCVWoKRHuFFzDzFDy/Jn57lozFjbVaIGCC28Pwkv86O3Gpp
	18dlUnJWccPZ+cGiSzng35boXEPxepA9ZMjEXK5LJ6BMEFro9ClePeieKw7Qig
X-Received: by 2002:a05:622a:5912:b0:50d:e471:2d1e with SMTP id d75a77b69052e-5173a7a33c9mr14237631cf.35.1780083204572;
        Fri, 29 May 2026 12:33:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517397eeec2sm8684571cf.19.2026.05.29.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:33:23 -0700 (PDT)
Message-ID: <56735228-63c4-49a6-a25f-08d37f604aef@gmail.com>
Date: Fri, 29 May 2026 12:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/272] 6.12.92-rc1 review
To: Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org,
 broonie@kernel.org, conor@kernel.org, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260528194629.379955525@linuxfoundation.org>
 <20260529060918.123155-1-ojeda@kernel.org> <ahlN6TPTgMwBT9_d@duo.ucw.cz>
 <20260529122623.bio-integrity-rc-prereq@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260529122623.bio-integrity-rc-prereq@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 05:44, Sasha Levin wrote:
> On Fri, May 29, 2026 at 10:27:21AM +0200, Pavel Machek wrote:
>>> I am seeing:
>>>
>>>      ./include/linux/bio-integrity.h:101:12: error: unused function 'bio_integrity_map_user' [-Werror,-Wunused-function]
>>>
>>> This looks like it needs:
>>>
>>>    546d191427cf ("block: make bio_integrity_map_user() static inline")
>>>
>> We see that, too:
>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/14592368004
>> We don't see the problem on 6.6, 6.18 or 7.0-stable.
> 
> Thanks! I've queued up 546d191427cf ("block: make bio_integrity_map_user()
> static inline").

Thanks, also seen here, FWIW.
-- 
Florian
