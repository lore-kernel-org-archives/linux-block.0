Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812E2E9722
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255936; cv=none; b=bKZIMNt/968CJRLvk2ljNmIv/Ed+17PCoDfB6sYvWTRR+VPHLAI5VP56zbXuiYvmLymhy1FhIAH2sVH/qE9Dh7zl1lR/cagRdxau0jrSfXLA1VEs9cf9JT9/u2Zgc/WAYeylN8UZFMy3cn2GucGHbP/sKYCueitrmu2/CxrywIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255936; c=relaxed/simple;
	bh=Sw7bSqlGqr5IT9Xat5i0E71Exlf9sKUY61iDbp4a4t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2iPavC3hlrT+u0lYFSGZ6fhaqeJ/rTy2QYhb6vOOzBUCWZAJ/0KzGq9O9h7nFweTSYdpZc7l0xqgCxTSvGbc2KGbcpfQ2B8BvN+aLvQh5ESKqcJTDFgL0kgs32rY9nQUur0JRpk+syZdcBDVeD2agb3U/TgnBAy562lRlxjKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPdGemG0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPdGemG0"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so2021311b3a.0
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255934; x=1762860734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoSxDhxS90f6BeCfm1xZZ+x6pE+INoKbsN0wsldLLGc=;
        b=kPdGemG0DCN+yk6LnPqF6SDXZwGjacksJbxEPAQ6EyolxXjOUZpfBzAn/Pl7k+Q4TT
         jKVEBkLxw0PAc81bkRAnFi7ee4QAsf067QCz8f4AcbEorBk2zLOwDQS/8dwQU0Geg6pr
         ZjL74Jy2o36rugOgpMQCs06r3+pDmoD0haJCSdRVtFNQnJgwSWivGxp/ojPt+9lo9+Po
         8HgJJPsnLuQVKAzQReWRwAWcOfa64v9ZQqY24Ow1BfmfHgW0kDuAyNbF+DpehP0D0Gda
         bArD5/LML6RZnxojefkB1q2i6FFih35tYVKmZYVfC6OOp5h4MgwabhkVxfOGHagJIMHS
         zUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255934; x=1762860734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoSxDhxS90f6BeCfm1xZZ+x6pE+INoKbsN0wsldLLGc=;
        b=kdKEfd7gz1AQUGYreNOZZllq3GpSvXECTbIdOCCRz5a8/9ji7zZKtbxYs2qpNNHhNB
         LrL5s60kRakaUA/E97hRKSPyo2X3JQqdNOeud6BW6g9brW3nQI880b1oDvfeuooTSY4I
         itzPQv8tJh1l9SD1kCDGnoJZNwQHRqqOWznGxgfdHlEAySswUpWwk197dNnstJZ2Pgpk
         /S+hoC6IwQfwl/F5FoOJ5mtAUPrK4n2Fwp84zCdmqxJabgwGSyMmDkuxzDyYc9rULRbs
         rFDGTujlVIs3reVhZH4+8G/Zi20YT1Folf/GXcgnV6ZOiPZUz4o1mLMdOFs1MMyufDUm
         AVKw==
X-Forwarded-Encrypted: i=1; AJvYcCXLnoZkEPq1Y5ahAQaWQaUfsx5Mhwu5PxNAZnF+aZVem8OSYMyUni1bRbTnn00z1Rn6fJWhPGtPWPZhYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgBunOGtcBwFUo4GbNHKvjiC1lSiVX3uwPj7+snmPKo427C6Q
	y8n9v2S/YC1btC+WIOr9wycBXRa2c4IxcjI29bClM3LLteEuRy55iUVy
X-Gm-Gg: ASbGncsCKlYv8uxiSrsAoN2ipgW3bF9DpvO6xqmws2OwicymOE3/XNl65MnVjeQebg1
	aEraiyWED0NZwGbpNopfsFsWiQ0BCB9PiJHVTFLq6/7NMNUQoYZ/TacrqoAFRh6Z2yajEeY+bfg
	evs0tJLrBVUo5byuGaVtd/GNSouQB/3XjD2ci5+alcVnqSHwWt2fkdwa4lfYRz+CP75VhS7AOzo
	zcNIWDBGogWlRNUI3lRr1VWpOHkyRyF6xcrautAtiK+4wv5JInGcWDAV+G4VvxVl/gpFLEYWrHL
	VdTAcuqWU5zFNdp956JJNrM70/4jk643x9+A745PCY9x5X3sIqQTwych854QHo7h6kujhPsVjJP
	rx5tX3hZzBWjLFy46qWp1BQTI+hLF+6jwYEa9xyfDRVptchF/IwFAFbOhstf4mLjdm5gf1InKwq
	sthXZf2PSXfSitvB9sd4A=
X-Google-Smtp-Source: AGHT+IFQi4sy7Pt+iNRc3yBEyf08yF9LpgtHzOpvhx7vFHjqpeB38ssLGuLoFfNxgUkcZVwLEr9mCA==
X-Received: by 2002:a05:6300:8a03:b0:34e:865e:8a65 with SMTP id adf61e73a8af0-34e866de6cbmr2005737637.52.1762255934090;
        Tue, 04 Nov 2025 03:32:14 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6919401sm2618951b3a.65.2025.11.04.03.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:32:13 -0800 (PST)
Message-ID: <8031227a-8a27-4aa0-8ca2-c44f494e9ad2@gmail.com>
Date: Tue, 4 Nov 2025 19:32:09 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] isofs: check the return value of
 sb_min_blocksize() in isofs_fill_super
To: Christoph Hellwig <hch@infradead.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-4-yangyongpeng.storage@gmail.com>
 <aQndM_Bq1HPRNyds@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQndM_Bq1HPRNyds@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 19:02, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 12:47:21AM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> sb_min_blocksize() may return 0. Check its return value to avoid
>> opt->blocksize and sb->s_blocksize is 0.
>>
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>>   fs/isofs/inode.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
>> index 6f0e6b19383c..ad3143d4066b 100644
>> --- a/fs/isofs/inode.c
>> +++ b/fs/isofs/inode.c
>> @@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>>   		goto out_freesbi;
>>   	}
>>   	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
>> +	if (!opt->blocksize) {
>> +		printk(KERN_ERR
> 
> This should probably use pr_err instead.
> 

Thanks for the review. The other functions in fs/isofs/inode.c use 
"printk(KERN_ERR|KERN_DEBUG|KERN_WARNING ...)", so I used 
"printk(KERN_ERR ...)" for consistency.

Yongpeng,
