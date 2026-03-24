Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921582E2F1F
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379828; cv=none; b=grQ0hYCknLznfq6CsGzlHR8OhCwQ0XH/9VAmX49asbwu30fOOIU9bmQcrAEnWW78b8Aql9ULThl+0As8WDTLm0bUzOyFLAiih8z/A9c9xDs28tbvHuLSUezNjhmTbQ6C9J3TH7v0bHHCoFubXjwUDufPPOBctjycQ85lQCnJd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379828; c=relaxed/simple;
	bh=+TQM65BJY+ZSQkcGOKw5PuDnu4eV14pMO10FTP7QC+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRMZiw+HjAFjBXyk4HzSRDDWZeAjAIZmTCy9OL9FO9iK0YcGTC0bvU0giRwnit8Nc6shHWnpBxiBbLAR3RegRX0iM/RfU3OVVXSEvr24AZiKEAR3lr103QnGOwDtmMoTRX6EKTMKkk9cWAonVu5rAqR5aNWWkwZkp6lC2ib2QWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Jlcrw8+8; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Jlcrw8+8"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-41c096fab64so179901fac.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774379826; x=1774984626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZaGIAvsrvd38uW9A1YrhlXJ/4ABVVpctfYZycfo2o0=;
        b=Jlcrw8+8Q1A8srGeszFbTlnG1P1tZ+cqzjU/S8b4BpATKK1XuyzBEhZG6tsTRj8vql
         LbBF8skV0crL8LJMFVDZKEo/lWAaDMpGW/BzeRace4Flw+z5J0A8vXdIMUOVE5+vXIzT
         YD4fHM+l1paD8gamfgH2EhYg0RESLrOIx63Rgb339FeyLepemsOf0IJZ2qPb6c1P6t3Y
         zy/0a9CYt0UzLsX11LZ/2AOr6vBdOu/CuQnJq8nwMwZblsOAQAlpMHyoQPvDDj3fJf3G
         L6WzlUzezoBKeNndikG6JPASDEQggI8Clb4r6KXV+n6JV8ZIflc834kjqHbgFZgok45v
         wznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379826; x=1774984626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZaGIAvsrvd38uW9A1YrhlXJ/4ABVVpctfYZycfo2o0=;
        b=nOi4dcnczJz22qn5ZO5Fy96yJsAUni0DxA4L0ycHn7RNiyE95mN8tUUQ24xVgs4I+G
         GQdtlRwN6eT8eXWe8ervsP11oimklVPtJNUq+XhuvzMp+QbbSP6PpZoPa0FNp84EswI/
         CcipZlwLdjxYfOv1jlGe8H7taLl5/tx4A/uxJ7NadWNmW3zt4rXbusFiseJRbIIrEVkm
         HvwwRIv0+KVMTc15rZFED+sLICdMKTG4SKXYGz8SJF3RSQf/wky7pajIf3Ttazc2T1ht
         2jpof/ebi1Hsj7E8yZ1QUSqs1vS9jolQksQm5yliSPVMRpgCfaP1TSBeWH+aw5SwzUBj
         Vcyg==
X-Forwarded-Encrypted: i=1; AJvYcCUZQLt26LIwsJI3NdnaaGlQpUnX8cAI9vMT7gI2gY27lhiM4iIsuqCP/pJAEhI1+9vJxPBQwWebb92ZTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZmV3qwgafGcsz76lfZjSFLjrgbbdfC3GXOnXBodFz//QpjYT
	uGXo/ssgqXeHg2//ZTPOQPOCikqb8lB/Cm1PqTjCGXxTNAqN6vPMX2V+UxNcTxIdzPI=
X-Gm-Gg: ATEYQzzmPuu90QUgIu4XI7n+f0mBftyifLJB/jpJWbKzJbvK7/qsprS20lCPQR+pOn2
	TG85h48s2lpwD6p4euaLhldVK+7Fabcz+jzKaQMTVbtPd49DfL3qiizrN1GkIY7O69e+wsoSJi/
	//BjhPP+xT4m8rvh+SiXVU1fdWLXwo8Qs/H8IpHmrDaTG8jVG7rwvSYO8IpgX0bCl2J0yzYddaC
	KqTsm47T2UDst7oDN8e33g0C6SJPQOhHjNSQ4BkxlvbkBwHnqgus3D7to2DqUzZqm8vB0e4BgQx
	hMWM3iWg7CcQ2FeJHMvjeF39btB+oK0uqBHeELVzkfpV2ZKqJX3X9gqhijz1QaEtacxEsaXfCjK
	E1MSBtu5Z935ODEhWLy6rbeBrmX6Oc4NIRIC7t16W/FxGG9Ht/TyyfJrBgIy9PqQG/5zVSzPn2m
	AsIMjnJTH1EkkXjsR+S4U6E2XOdBhd5W4Bx0bu1QDv+OMsGmOm7vKncB3ud4hn+Op2BRE/ixCEA
	EECED45
X-Received: by 2002:a05:6871:e717:b0:40a:5870:98bb with SMTP id 586e51a60fabf-41c878610c6mr2712252fac.21.1774379826490;
        Tue, 24 Mar 2026 12:17:06 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a5ca4sm13928550fac.3.2026.03.24.12.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 12:17:05 -0700 (PDT)
Message-ID: <0c11f560-f796-4ba6-a515-3a6d613f27dd@kernel.dk>
Date: Tue, 24 Mar 2026 13:17:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mmc: block: use single block write in retry
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org,
 linux-mmc@vger.kernel.org, shawn.lin@linux.dev
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <CAPDyKFo5h57uiym=WuKBLji-VwcDtCiCBu434RpmZdYTWzSm_w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFo5h57uiym=WuKBLji-VwcDtCiCBu434RpmZdYTWzSm_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 8:57 AM, Ulf Hansson wrote:
> Jens, if you think this approach is okay, feel free to take the series
> via your tree. Or if you prefer me to handle it, please let me know.

See comments on patch 1, I think that needs a rework. And then you won't
have any block related changes either.

-- 
Jens Axboe
