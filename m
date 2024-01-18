Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D512E64E
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610813; cv=none; b=dwb+7b/2btAx47oPJNgrIpmMKPA56cQf0lE1eoG+uja1DdsfoyPl2GwMgcnExcRy9501cvJPXmEA7PUHDlmS3Q3JAkggCPwtseLXANEzxmjFv5jSIJpVIlwWcTbeiDSdi0KNV73gpHSvETIecBl3yxdFxqxvvfuieX6gi6QGO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610813; c=relaxed/simple;
	bh=cpAWyyc0f20RuzB1/NmP3Pu0hXm/zDrrJjtOnvi5lt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WVQS+7KjAjWOUOVwri2LjKJZjlEFjn4toaAqxy0XWpLXE8kpOh0PvvXZh77GSdgpYsEPJyO0pit7xKDi7eZt44sg6K0IuKgHAhgHfmx/WaozZARsITYAgREE/WhRZUuSSmhi0Pfat3GBG7+qdcn1y/9MkjXyUAclmjgrfDJLAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d54b765414so325055ad.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 12:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610812; x=1706215612;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpAWyyc0f20RuzB1/NmP3Pu0hXm/zDrrJjtOnvi5lt0=;
        b=WQYzki6sYLSJhNWKyFD+9Tb4TuPyux/QpLXbsncej7cHcbSjQaoJHl9f/B653TEEzi
         56KdoA/GEqJorbGX9JhQS1mcIqdd8DraPT/PjX1xu3lcNG405RL+2pvNrILm2fqZKZxl
         hEOWPvv62rrhVbWXCWPN0vXAtzJlg9MA1M9+rY+Rjsd3FiKTterQPFomdiy1Ur/fYLtY
         IFh38/E2oU01jr563bXXh+QNVU/1pUel0ZBgnlwORGq19HK+Sj0g4d3JM5Y8QO+WtCBr
         42YBY7XOn9D4Fd7pjRtrpmsYeTL0nm8TCXs2IVOneMkVQBqWBQ+AN1yfxOU34CT0Z/Hp
         O6Tw==
X-Gm-Message-State: AOJu0YzpaYIOz2DmjpT1UZHzA+FLWDgEUweA22KU8EyCgkbsvVSpVCWU
	UxdckiAHOpkYXMsE9wU8Al1L7rcTvbSHnyyiZkbMWjSjGKCDLGHty/EjyRO3
X-Google-Smtp-Source: AGHT+IHxHjpsiFJ0VJy3Vv1/0DkER+UnafV0HrLAZO0OkXo67qucG6+scOnXk+8IJPL2ZDt7DfjBdA==
X-Received: by 2002:a17:903:228c:b0:1d7:c27:2d32 with SMTP id b12-20020a170903228c00b001d70c272d32mr1347823plh.12.1705610811815;
        Thu, 18 Jan 2024 12:46:51 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:9b18:ff93:819c:47b? ([2620:0:1000:8411:9b18:ff93:819c:47b])
        by smtp.gmail.com with ESMTPSA id s17-20020a170903321100b001d5f4eb642esm1785150plh.216.2024.01.18.12.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 12:46:51 -0800 (PST)
Message-ID: <239455a4-7e58-449d-9450-8297473cb441@acm.org>
Date: Thu, 18 Jan 2024 12:46:50 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
 <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
 <c9f1b580-2241-4415-aa48-e4b7e1bacdea@kernel.dk>
 <e4892064-cdf2-4cd9-8033-901d8db07cbf@acm.org>
 <248b7070-a7c6-456d-99be-c3fff6f94f5e@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <248b7070-a7c6-456d-99be-c3fff6f94f5e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 10:56, Jens Axboe wrote:
> Do you need me to link the cover letter that you were CC'ed on?

There is no reason to use such an aggressive tone in your emails.

In the cover letter I see performance numbers for the patch series in
its entirety but not for the individual patches. I'd like to know by
how much this patch by itself improves performance because whether or
not I will review this patch will depend on that data.

Thanks,

Bart.


