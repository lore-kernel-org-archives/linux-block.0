Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790932DD60E
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185729; cv=none; b=rWjSLv64/DqL+bBDgj1n+D2Cv4xQ7toLCawQeHdIOpolgwAo2ZIQb7IfhLObHnHzbyHnLWjkhvqLFmwYvS35ouYip/ixvKs60eQ4Y0ExNWBshREwOAOBev7kzpugWw9WVJRdLNQWxc12eqf+zFEXr5XygghetnGgOnJ+t834j2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185729; c=relaxed/simple;
	bh=vBhvrSw5+YylOgvENz/OkuT1k3Y3B00LmnpIa0vMyDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShvcNRoLr6mYF3kOJKfB3WcULqfCWuxioHiGE8HwLVK1cn/mzDCTZ2CWnzBGUvFA2EjZX351bD52G25WwfI/1WCxWmS8ZnaNho2Jwrz4md+JrRC4HrFeurgySW4CgMY/Pf95SuNwf0e4PA/uuqk0REFyHMK2TEh1D8AC0Mvt9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m0fqvCSa; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m0fqvCSa"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-87c0166df31so372288739f.3
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753185725; x=1753790525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSqpM47wyvSC10koIm/+nx4eRHlMZO0HLyUbFiugfCs=;
        b=m0fqvCSahn8IKRydpXB13ZnXi6Ch2ix1LLIhcbA+PZ6CFfFMoToBK0Ku6v7zi6tROn
         g1vzb6L6rNUFlfaTfRYmDkLxrumodnRGeQEHfwAXNXhWKc2q1zDz/pU+BwZj7ll7vPX2
         cQDo4LB1fSSpCtcOfGZ3ERFmQFLw/8bFmQwVS2p86E0n3Z2ijz01gUrxoOdNWCUxFZgj
         bBhTP92PQlBmEfBwdr+Upuuz5Z493ICWH7lsGB//t5VVhoAXJvQvoeGNgr4OEj1Il9ud
         eJlY3clx4ExIvk5Eel7Q7x68yXcey/TGd3DC4eemdn6YFmuv1zL3D/kAK0EhVyjmf+T2
         zq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185725; x=1753790525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSqpM47wyvSC10koIm/+nx4eRHlMZO0HLyUbFiugfCs=;
        b=j3jS4VIeBIYpiGVne7i/wopO87N9K2aYb+2Fc9AMXS+rSJPbD1rgvbqgWgCovrIn2T
         rcmY0mVz5ymGmvCLsCYTW4uUHmf+hYeG0IQOAbogZRFHGSMqfD8v5mSlTfIih0Jo0ugg
         4moibzqlVBiPHRYPyxTnjgC0dFOPC8+pdZguRlGA84guhaCqanb9CsWms5aWq8CGGhGr
         3/EO3QVDqvmfJfQvJlV0QxkrBXuxsB5HEI8Z9xNt7sOOT1FjaNTafNyLOo+a6U19u9XQ
         OD9x9+I7EorlFB6Ltsfr4MCtLc+IuvlPw+bLHnhcvGCbIlqCHZ/tweR7z+BIcOC0oVaL
         iBIg==
X-Forwarded-Encrypted: i=1; AJvYcCXIfjAZzSBByO/GKHr/Qb10tCiOgj9uAWDoRtx2y2LS8Q8qqYooZn10TY3MmabA7HKZgtg9iFj912NzzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0OK+COrZSSeVDrw4FfzVbxLbwhyULs5RayCHKw2jFtgqBRBBx
	ysyEO4YpL4wDaEXXXiyoT3o/dpyM02hBppbYxdm+68DzhRTrP2UwzwHAdGDtTOmVH+g=
X-Gm-Gg: ASbGncsbTzqHGuO7lHVL1PCz/pkb3Pgape3sR4EZxqHXpUOc+lwTrnjkXxk3GBOlc82
	YwYWhworB8mC8l7NJk0jk1LRBVWf5s/fiXYnDg7fQoKzzKLlmEJQPkHEkzRsPyZDXu4IV7qF+4W
	vd15XJsH452bwoL2TrkWjOsZerOviwUwqssnRDBAyfYV8iyEPFp1Zrn4diRqc/eyyOW0oJCuE+C
	lNG4I2/YcPpZ7dYrsBK1Paoonao6gZAO3Tu8W7u6SMysZO6vV9U5Ihw23hkK89GTBeH4RRKhYsT
	pxb8xNt+4cVFnKtHHHP47DKYG19OE5FaWsiRhN+6AvyYelLOPVesjQ5VF4X0H2m+0fQkyN44KRT
	CUgo61JUKfoGDGF6gR2nJ6WiJmFXEnQ==
X-Google-Smtp-Source: AGHT+IHqn+pMTWXI9ZPKKZaWd0BLYEVrzKBLt/3DYdcMc3xzk8K5EjDhO9cXHBLNe4/CutAbvBhafA==
X-Received: by 2002:a05:6602:6933:b0:86c:f603:8907 with SMTP id ca18e2360f4ac-879c286e1fbmr2463402539f.5.1753185723927;
        Tue, 22 Jul 2025 05:02:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c0e4c0b99sm310468339f.19.2025.07.22.05.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:02:03 -0700 (PDT)
Message-ID: <33dc4507-d1e0-483a-ae89-e916c52356b8@kernel.dk>
Date: Tue, 22 Jul 2025 06:02:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com,
 hch@infradead.org, martin.petersen@oracle.com, linux-block@vger.kernel.org,
 joshi.k@samsung.com
References: <CGME20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e@epcas5p4.samsung.com>
 <20250722091303.80564-1-anuj20.g@samsung.com>
 <e4bc2fa4-5137-43b5-b11b-4a9ca6519b54@kernel.dk>
 <CACzX3Av=CdrHfchof+LXpAS9=0eTAMxjh0Zs_Cu3O3e8nxYDEQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACzX3Av=CdrHfchof+LXpAS9=0eTAMxjh0Zs_Cu3O3e8nxYDEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 5:57 AM, Anuj gupta wrote:
>>
>> Where is this sha? It's not in the block or upstream tree, presumably
>> it's in the vfs tree due to it being an fs commit? In which case
>> you should probably CC that side, as this cannot be picked up on
>> the block side.
>>
> Thanks Jens, you're right ? the original patch went through the VFS
> tree. I'll resend the patch and CC Christian and fsdevel accordingly so
> that it can be routed through the correct tree.

Sounds good, otherwise I don't think it's going anywhere. You can add

Reviewed-by: Jens Axboe <axboe@kernel.dk>

as well.

-- 
Jens Axboe
