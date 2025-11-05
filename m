Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0522157B
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308496; cv=none; b=qKQRfo0W4S0X+RvZYMbxLBd55IUly1MAv49R6xD/Yzu6H40PQOt+SLxp6jCtiIDX5gFAb0O2CFoe0IAvYLLZ7YOBt3iuEI9IfANBDH/lSPychuJc8pw0w6af0rYxlOZOxd6ytUuhkyXLMs6Op9vn9LIs5VihChGmZ4KS//ILtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308496; c=relaxed/simple;
	bh=aCIePvxR6b0aME6sxxADpgHuW9tgTHqfJqmmFPqOqb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeMjJV7MWGGTZNjVTPpfMMT5g3fOGSPOtYlN1MsXSKDrbeMbVFooJv8fRwOZUe6lKNbQBuQGKyj7fmMz2rDVzUPt2s5KzzOzwnsptXsvKhz27fnvKidse6hkiO9+Fc3ax0vu+gzmST4932QJ7/sJi245vlUycpG8jqwmcD7oW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOXRdKOU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOXRdKOU"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b98a619f020so3248506a12.2
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 18:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762308493; x=1762913293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4yDBu3bQnhMe9kSGDJfDwWvTH191XsVU1fFztibKfQ=;
        b=AOXRdKOUWbvJa/YjPYbAkr6KmAf/lpgcXmUSDMlJy4DYU6lDrP6RkJyQnnU8PTt7ke
         2sY+RCUIJTIcQig8mGcG5B3Qu74NRGKT6e2gucYzRCyw68u3Pxc6r2DV2z4GhAvecxsc
         M9hVastkDwW3WAqenP+6idkb7Yif1hEeYLO9+Zf3Txax7je4fkY4p+Ch5NTCg2FNHrgx
         X1ALGtL14NAxGbczmqgoq/HBmD9874hXQHTZx3j3lXwqrycY1t3Pl2jwCZmxgN6vIaIy
         FFHgaA11QsAfEFUtoKWa/9nuuOomJepM+uB1M1KJ4mb6OKwJf8I/DpYIAOi9vYjMCcDu
         UI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762308493; x=1762913293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4yDBu3bQnhMe9kSGDJfDwWvTH191XsVU1fFztibKfQ=;
        b=I3qeZBMF6q77EJ8bd0ehV+ZPGSAdgrWVdWWPNQ3MSI1OcII4M11/Ph1qeCv37zyWRY
         3YTxdWM0C/g6PbNfj2cfCmBWogqSETGH2xaDtNxo1fUsFM7shVrgVKLxqnc6hKqsq0FQ
         MKS82O9l+qKcjmqmuPgJCgB/sbBKHJFTctkNrsi0y8WlOKqt9pl3lQ7I3iig6D5l8Oan
         N6Skp982PidFhVGvdxrBGv6+rLpJOI8APlxTlc+LCwTHGqgOMlpYRGWg5dhnFiVpzuIc
         wpp11E0k4zicQ2N7kbVGgV7jWdI61XHg84flVBwXswwyW70NRei2YC6gKZU5QMmOgc4y
         ZdrA==
X-Forwarded-Encrypted: i=1; AJvYcCWwywLNvBqIQqZHUWImcaj/599NfI39FPI1aqWpMdvNsTS5LPPgYeCqd5z8Z1cRfsbZ5AshHOWnN4u+qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzlZN3aCZkAfxN13hEEbmLhDvn8WYU96akrimHnGHP7Np6ZjV
	Xuc4IfZ4frZWjZ466NoZa/H+5Ld4YXSj4VsHB8OmauJp1K0/hmEavTzc
X-Gm-Gg: ASbGnct495MewJYGzNq1G8UbjVdDEof5pZlqy4vis/lBkIm+uXKLeRDBNuY7886IcF0
	hwSCJsi24zwWscSX6l0pLU0ddBknM495pwbHTbNgIhaVO1ieLjvTZitdg76287/I0lvtTejMquS
	sD8/G40njJD+jn+tw9bs2XzHAD1NUSQ1ysEX+1U4JIK11g0K2cr60jJuGb4YS0MI3P+0YrME3St
	Ho/77ONd2EXzjyf8ROEpj+rSmn2gpwigqbW70ccp5O6VMepNWEuJKxVjjsGQ8aiu8VX3eiDevU0
	s8zhi5GbzUuXaBwyenRPXMwo1A8jMKF/uAsdTovU4UtujO6Ors8Irfy7bm7OjBQkRr3F6tfHuty
	5Gzb95+dnwOPe811T72BHFw+LfyGMhXYCuDWPDxaRciHOhob+yNWJEytjV8RXw+DKR24xPB2C7d
	IpxmLYgzOxmcpIueBaxxaHC9k=
X-Google-Smtp-Source: AGHT+IHFEEDEwbkYMhDcYlAouSByZjRV09d05fMzqHjwPvk8mlwVG2htfWc/MvggLNSc+kqx17qoEQ==
X-Received: by 2002:a17:903:2448:b0:295:6d30:e263 with SMTP id d9443c01a7336-2962adafc02mr23971055ad.40.1762308492736;
        Tue, 04 Nov 2025 18:08:12 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601978210sm42828115ad.2.2025.11.04.18.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:08:12 -0800 (PST)
Message-ID: <221cdf62-f8aa-421b-9d39-d540cbe7346f@gmail.com>
Date: Wed, 5 Nov 2025 10:08:07 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] xfs: check the return value of sb_min_blocksize()
 in xfs_fs_fill_super
To: "Darrick J. Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
 <20251103163617.151045-5-yangyongpeng.storage@gmail.com>
 <20251104154209.GA196362@frogsfrogsfrogs>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251104154209.GA196362@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/25 23:42, Darrick J. Wong wrote:
> On Tue, Nov 04, 2025 at 12:36:17AM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> sb_min_blocksize() may return 0. Check its return value to avoid the
>> filesystem super block when sb->s_blocksize is 0.
>>
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
>> for sb_set_blocksize()")
> 
> Odd line wrapping, does this actually work with $stablemaintainer
> scripts?
> 

Sorry for my mistake. I’ve sent v6 patch to fix this issue.

Yongpeng,

>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Otherwise looks fine to me
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
>> ---
>>   fs/xfs/xfs_super.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 1067ebb3b001..bc71aa9dcee8 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
>>   	if (error)
>>   		return error;
>>   
>> -	sb_min_blocksize(sb, BBSIZE);
>> +	if (!sb_min_blocksize(sb, BBSIZE)) {
>> +		xfs_err(mp, "unable to set blocksize");
>> +		return -EINVAL;
>> +	}
>>   	sb->s_xattr = xfs_xattr_handlers;
>>   	sb->s_export_op = &xfs_export_operations;
>>   #ifdef CONFIG_XFS_QUOTA
>> -- 
>> 2.43.0
>>
>>

