Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDB1B7F4
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285636; cv=none; b=KFKMh028g7su7iJFNM1aa7LKvvDORU9SiLxxAfhcx9BWY2WwmUirmH4cvkUvYaERNFig8xbLDrg+jUICK5/B5zZA/IRWx6eMya/ANyRqEPBmzA/e9ZHEwPcPV/L8OGFvrUfO5o2pmWCrfDh3LJNKhjciS+0jYW0HUPI8kHHusLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285636; c=relaxed/simple;
	bh=uzLFSAFtoaqYt4qKlJdghnAueSiTe1iEVYtNChPk7mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqa1Q+GifHciVnwg43LVBrKQUE+pv16qL8v0/ZI3bGbadD/pIPWragywpBRrt3CTnvZSFPqsGtDEmw9I7aHm3BjFVnWmmgn5FMB0VGIIS0dte4zRs1h8psWFbtxDf52+3EvC4jq0agk43uJ9FexqlgZWu+4HgUCjIeuwHcFKUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ccxu29Dt; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ccxu29Dt"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4330eb0f232so849775ab.0
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 11:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762285631; x=1762890431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKRAQuqoax81Pv7uca8UK+pqJYsXqiySO+8521Beqbk=;
        b=ccxu29DtfLmjNcL2l0CaA9GA0BqRzi/KlL1X/gXHumufb8kZOTxCons+9KZQqOmgd9
         rnA6LPbRZwRgH+n56Kfjv4an6K1YhcRU0NoOrXbDHvIrgcd1DU4I+eoIPS2XUMbkrtdg
         XACoJlOLd2ZoI9RHnmmcarA3g6x/1L1dvkBXUcUCrPnwxrBsy+hFYlLqUVx71sNJHlkk
         qHwr2f0YLx0rN3Mk3ZhlhVZXTUcgKSf6z4Nf/xsxYjoFt2IfYgdIAFL1gNM1AGfZF7EB
         jsV6nYaieTzqlVdGFeSlw2s7pSA5mGKtGqF5z2hzbYSg0fryXszq2ikhde9btz6KmHpW
         6aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762285631; x=1762890431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKRAQuqoax81Pv7uca8UK+pqJYsXqiySO+8521Beqbk=;
        b=qfqvxSHhhcc2f7SOXxCbgHMlyr60RXEyuYKjakvjavWkHVk6HvaDNKg71hngl5JMaA
         j2grEIimHcyzh+a74we8kT3jf5zYWNv4cmCt8NtyoxscoJXmNKYxf+qqpX8HhoR36dr7
         lGZsv5OF/wGnwOMWbbSfEKlxxgeCKw74Nn0TvsqeDgehBTDSDk5E/IXVWc9JOruvhjyv
         GCsjw7boBW2kFiiZGQQRp3MxrA0ce2Gw0jDu4Wf1My7RlvIZ+Gz0J+BA7dRceZm381oc
         uvghYlk3k41Afy14SPTfsnh/qyVdv16RCslFcT4RLcMb2lUmRe8AtftIZycUVDLsprNM
         eRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW56v6c7bx8Nnv4ITltVj1x3B2tKxdaHAQe3NChrixyprpMClTf9NPUbYBH3oT7bbzArCzQ5mxVJM02Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYTZtN7me3g4X5fZwfmP/q0EMVEacfbyS/lCI29d4EQbr0DHK
	7XZeATHd7Zug3Mo9L2YgxF0c6c4wQ5sbYLIGOadiW13GNZ5XgXowjrj4tbpwyLZzd/c=
X-Gm-Gg: ASbGncsk4eRsOoHZxz4y65YSccsyrcSAs8qbfSGzlMFsNHVlotAA7wGWJyZZETKR/8E
	q46VLlcajN/t1EBbveQcOnTZMMmuSf9hukQhvkgXnkBs8jB2LHIIz4dQJ32lVWtpPnFccx3nOkc
	DtkFh+sbY3NZAQcxh20JKQyAnNy1/UVmn0jPE+h761jZD0P08ou422oWT2CSvR7HWnCXF+EAjrQ
	F8KdRyM4sjN8uYO4bh/xNOx2G9zDOm1VyfZedTJIZP4XA1kG4n643KZVP43WLNKsV4JTYwJ6YlA
	vjb0CcDjo1WB37SqGhI0XTcNzI5qq0guuhafTSruMM5ItmtDV4Emlb/Oqp9DuX+h+LC1uRN+BFo
	ppMoMLadMdsfJVAB25uAdnywHcKOKWUSg1aDaMqIA6yhM2HtU2Lf158a3ASB+oM8pUfd+GWJ2
X-Google-Smtp-Source: AGHT+IE0WbdJ7Csn5G1aeZNBQJZljKZdfhOIN6zZEuCeCH4z1Yeo0uHog6L1nj217+OD/ojOIMkn7g==
X-Received: by 2002:a05:6e02:480a:b0:430:af6a:de13 with SMTP id e9e14a558f8ab-433377fbdebmr61885145ab.2.1762285631299;
        Tue, 04 Nov 2025 11:47:11 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d881sm1583654173.7.2025.11.04.11.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:47:10 -0800 (PST)
Message-ID: <afe10b17-245b-4b21-81ee-ff5589a7ca47@kernel.dk>
Date: Tue, 4 Nov 2025 12:47:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make block layer auto-PI deadlock safe v3
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org
References: <20251103101653.2083310-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251103101653.2083310-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 3:16 AM, Christoph Hellwig wrote:
> Hi all,
> 
> currently the automatic block layer PI generation allocates the integrity
> buffer using kmalloc, and thus could deadlock, or fail I/O request due
> to memory pressure.
> 
> Fix this by adding a mempool, and capping the maximum I/O size on PI
> capable devices to not exceed the allocation size of the mempool.
> 
> This is against the block-6.18 branch as it has a contextual dependency
> on the PI fix merged there yesterday.

Yesterday? Guessing this got copy/pasted from the v1 posting, as it must
be this one:

commit 4c8cf6bd28d6fea23819f082ddc8063fd6fa963a (tag: block-6.18-20251023)
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Oct 22 10:33:31 2025 +0200

    block: require LBA dma_alignment when using PI

which is a bit longer ago.

But why? Surely this is 6.19 material?

-- 
Jens Axboe

