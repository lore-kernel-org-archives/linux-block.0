Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1D1CEAAA;
	Tue, 19 Nov 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035290; cv=none; b=g4FJ7n1/cmWpu18RBGa/hlXSzJrzNzlQ4OsZjtTyRS7h6DI1G4u7hIav2Z16ulUGIKWVII4wDKkk7ndorp/45WvRcR5q83nq881AakspPZ0tFbDLDWx5QLGpM+Y+BOVYHqhKkv6ziu3xB9Q3+izRfzixMLVMXTu7eMXMi2YuzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035290; c=relaxed/simple;
	bh=Mluv7aBfcA1cyuAWxONnyoaNZ+6ghqbtWSuSeFSkhfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrOHIbrGUmQZhWFGMWjMVoG8amrYEdYflOs3mu/R5YMpDDufXI5MZV+MpHjc7Op6J0AkQ5osHQmX0FgFZDsg1TSBfTvs9XTJu5bFqSIFEACiKI1IU0mDqllKvNHwaXFO455BOx2xvAnXPowOD3YbeJFV30piz11a8zkaG4SBRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX6kUEgM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX6kUEgM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724455f40a0so910538b3a.0;
        Tue, 19 Nov 2024 08:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732035288; x=1732640088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7bNrpPNJJoTezdIAKIpa0vYI7kndoH7VAYyN95+PYM=;
        b=EX6kUEgMO8Tiii0YbfVj+OSaw5c7zJmljijR94PyuAUuEB79PgoYwmt1huf7oN9FVn
         ZZNjUT7wnMkeKVT82Q4ZWB3/bz51xrgrS7kchTYGhCDsnakVBAidFvRIgKuymqaAfY3g
         4ap3OTvg2amsHVR5VX/j0OA09VbNDixhXct4C8re8+aH5aCq7R3SZkSU6Um6kyASwbG8
         SnqtoRY0dszllacXm21bO8UDaRrdg+dBGJTkfPOVTBzwAoaK/unbNw4hxAJdPgA8FRmQ
         JvRK+W7umt/AplJr74fYrQPr7BcN5wFKfRo2HSIO2UgcZBFPDRD5kRuOsCYUEJsQqmYF
         goyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035288; x=1732640088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7bNrpPNJJoTezdIAKIpa0vYI7kndoH7VAYyN95+PYM=;
        b=gujzYXE6zzQWneUsCF7mM5wA8FWVpT5N+TXk5wpYggmnrqzOmmHjmBAywENZpYVFuy
         t6m03iV/PsewaFcx6etTMxmJ/HA4ALlyBFYi0uFdP0L0TKkB8oWBDS0b1a3eAB6egRZ6
         p15kJepuJKXAViECVN0+BHaakCgw1xwAfVyF0f2LecJJuV0ALEzvgdKyaNlTiGxyRVQD
         PBGZDqHwUgCUhT4U6q83tQr5XEvm4SwzSRY977Kax7MN9Mx4QXhZf7peqBpRD86mZGba
         sTc5ACaASEdhFVvkVCoi+a5EOXGoEqgrveA2exKKRo91+W8vc1FRWic5phcklFsVFxCV
         ZESw==
X-Forwarded-Encrypted: i=1; AJvYcCWEs4tOLSsMHHMn+rzGTilwVHAiMjLjxt/Q9dbx+aI/Nbp3Mbea98DpViPoGRIDU/XQHPSlLb/30sJLGw==@vger.kernel.org, AJvYcCXqKnmHT81XVXmcq6DlnQmStsJoy+lLrd+taTL10Qw4epjPMbhD3w3vqxvn/dQyvKQAf2ayLXkipUwXxOZZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61YLGpwgXgsR3xLm8ZscyqA1jUkE+Mo/C3n/GqPyhZZGZxTBv
	AAbxDkDsk5k5rx1hDGUT1EB2iBeSr6gCxpIqo5IILnMDNJz4ew/i
X-Google-Smtp-Source: AGHT+IH2t0ugd98LmfJyU8kosbhs/AWCvSicwXcbXuZ3ZcMnNY497VYpTyLS5wYkBKQSE3+pGr8VVQ==
X-Received: by 2002:a05:6a00:a1f:b0:724:59f9:491e with SMTP id d2e1a72fcca58-72476cdc786mr21989486b3a.26.1732035287817;
        Tue, 19 Nov 2024 08:54:47 -0800 (PST)
Received: from ?IPV6:2409:40c0:11a2:6510:4555:ca08:e78d:a9df? ([2409:40c0:11a2:6510:4555:ca08:e78d:a9df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d29sm8596918b3a.122.2024.11.19.08.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:54:47 -0800 (PST)
Message-ID: <2c06f5eb-aa54-4b87-8ae1-c07270715bcd@gmail.com>
Date: Tue, 19 Nov 2024 22:24:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: blk-mq: fix uninit-value in blk_rq_prep_clone
 and refactor
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, hare@suse.de, kbusch@kernel.org
References: <20241119164412.37609-1-surajsonawane0215@gmail.com>
 <ZzzB3fErIdy0OHXQ@infradead.org>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <ZzzB3fErIdy0OHXQ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/11/24 22:20, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
Thank you for reviewing the patch.
