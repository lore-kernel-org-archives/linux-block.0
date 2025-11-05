Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14E1DDC35
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309045; cv=none; b=QoB1MXQLQNm4Q91+z6nbdugcxmZ+xI0ffzHk70+fvwYIrph4oCUYSB1J0O4ZxbAFoID6oUkwfSXZ7dD8l5OL90F82Z18zCDI4nOMWd5munPUQWZIfRpdjQO58QFkKd7+qAlv6Byez33w97LKK8aIAJ0H+JA0khyi44h15h9YFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309045; c=relaxed/simple;
	bh=tIkUTPwyZxnsrTixu38fGF7ItfuUWaUD0A4ZjzU7nQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUOEx5ITOGE5IGJKevk7md3BQ+fIJagz6PJwMmzgTOOdQSyunvPKidy+3fofNNqCj9Z+iFDvCcvSCQNMPfNPpYlQhbKYf9DShoGpGQjtna8vOhVMho8707CAkwDtBwM70Jo85qcqzu94TG7AToDV7HHGAzxVvOf24lv9X36DqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWkXTJSJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWkXTJSJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29586626fbeso31573325ad.0
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762309043; x=1762913843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6BPDj3wavhdGIBE9zS61DdhM4idE+BoIHjh+Hrdzy4=;
        b=MWkXTJSJ5ZL4ErTJIoUQo/iNguMVRjHrQanPorc4eTV5Rlv8QYjCLFiGHjKmRjpRwk
         4xxxKav3v6eLPXwNtCrgTZC5Iop06bfiTf9kPSewONmGJ+UX3VxZGBJZVTEiU1924+1V
         4L51dAELkUT1pCO7iX/m427VCRuBlmTdMnmF5/ZZYx241HwHFjtO0QFEiXdqd6lUticB
         DgoAcy4oQ9r1QW+/ArBqc98iNqaLw9dNhJWssQoWMYA7q1jydTZm1+PQeJQ6i1VNs85H
         d4la/h/hbfXqIDObtkaLHY8CZwI/g8N5hzXS1dVqxS0FJhVmaN/AwwasIxuBsi37d5O3
         6EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762309043; x=1762913843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6BPDj3wavhdGIBE9zS61DdhM4idE+BoIHjh+Hrdzy4=;
        b=TVAXUyFEeVeyqg9sKQiOLFuAbItr/181hgVkicO/oweas8JfK3ZK+T8I+Tx33PpQ3v
         5wiCVpBeGB5F0MECyp2UlDuMCnywoCuawAdXIXDCwi9KKsugSFp1uUlWEaiATHAGlkwW
         9Sxp52nCnls2PoQEc4/MyVOepvON624lcyvEZpa1LJN8iLYJWTrmBDkWSCFeF27puatt
         opuvM9MN4t3C+1ImrbGQeyHc2Myokk/oJA+JKaXZsQVIFFA1QMUe993+eRXaqu6GaR2K
         A42v3kscrd5/2RJLc43P1atcj3dEWvEE8pyXjA7IfsBN3uRU29+EiB1o/ZMwADhlCqXc
         N8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVxp7NSwnQtxC0YKU+rnvcCcyuFSr4EbRt5eGfV9M83uwVTFCEj56gphe3UXbrWZARs4WonlnQSxPc2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPPpdGV0J53QEIj8DL4IehenUuZj5fSzP6nG1FDteks0Hl+Qt
	LEgPRoi8uc0CFwgAU+1syoRkj3T7H6uAeqlMcbPQ9LexSFo/K0hqdxu7
X-Gm-Gg: ASbGncsAUisPpVrB+O2i/Cbkm7NaXHZnbUnkvhKwfc2cMjaUmpIeo7zYTWKPQGvUj3P
	MIKPruhPfmMQzmLnLkSoPIg4IfM3qeseIr8jIQotEYjUmp1HbuLvx1eCNSW7tFcnIMPnDKKYl2H
	aN4hJQJMtkdpZsRvYdH3KCoxdLCnMP7l69TSJVrZT1ic7N4I/5JiLzSzJMGw/o6i1De6MyDAAlR
	MwBX4sh/pVS9bShX7cK2wwqlR3AxT5HpIMFOThU3P4gP1wkeAyKWhfRgqXuuikmri2npDSe1jAs
	xMc8D+xkK/K3FpFd0SKITnw/Gtfgs4NwSxMCcaCCzihytkkql0b4LNeSkgmwZyL5Ed5eaG9LzsB
	aDkzs6zFZByzqg9cHxEAhAISX/668VeavuAMqxXaE6o8/7JC6qbEofHuoExZwDpj9prE5YVpusn
	QGMo6wq+sMrU+InRoUJt/1MjY=
X-Google-Smtp-Source: AGHT+IEYmsytaR1mEiRZPjc6ohcI5FrMoE1+JkNMyyS9qC58igvtXBSkpPErsXNTO8SABAM2YSvmsQ==
X-Received: by 2002:a17:902:f684:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-2962acfd7e2mr27115905ad.11.1762309042615;
        Tue, 04 Nov 2025 18:17:22 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998336sm41935745ad.31.2025.11.04.18.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:17:22 -0800 (PST)
Message-ID: <ed736d06-3f91-43d9-b24f-60c54807a1c9@gmail.com>
Date: Wed, 5 Nov 2025 10:17:17 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] isofs: check the return value of
 sb_min_blocksize() in isofs_fill_super
To: Damien Le Moal <dlemoal@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Kara <jack@suse.cz>,
 Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
 <20251104125009.2111925-4-yangyongpeng.storage@gmail.com>
 <0a04e68d-5b2a-4f0b-8051-60a0b7381d17@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <0a04e68d-5b2a-4f0b-8051-60a0b7381d17@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 05:29, Damien Le Moal wrote:
> On 11/4/25 21:50, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> sb_min_blocksize() may return 0. Check its return value to avoid
>> opt->blocksize and sb->s_blocksize is 0.
>>
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
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
>> +		       "ISOFS: unable to set blocksize\n");
> 
> Nit: using pr_err() maybe better here ? Not sure what isofs prefers.
> 

Thanks for the review. I checked fs/isofs/inode.c, and other functions
seem to prefer using "printk(KERN_ERR|KERN_DEBUG|KERN_WARNING ...)"
rather than "pr_err|pr_debug|pr_warn".

Yongpeng,

>> +		goto out_freesbi;
>> +	}
>>   
>>   	sbi->s_high_sierra = 0; /* default is iso9660 */
>>   	sbi->s_session = opt->session;
> 
> 

