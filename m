Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A13161BF
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186971; cv=none; b=dge/OGVeueO7uXtZ5FGC2mwUjISqBaBsIxg55fuauoyh6mcoMRkYl89K5j5rr7GzW5QIZkotRQn1T2uoMt7Yb86V9XzpRM8eiQfgAyKyOSMyktWEY3ioX+z4SnCK0snPPZEQvnaml57KW8qew0TI1oAi/u/pml6K6ldevl94C9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186971; c=relaxed/simple;
	bh=MAqh8a5N+ZsOAGEcWjRLDNWJ4Cf1BpHeOMi77RPjhlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XE6g4a8fZ+rlCU3uU50p6igwnP2jidxaGa3B2GQWaH25GrKIvkmg8b9o3ZluSvWIY1LXYRxi5M8ad+VKlst/sWXMUfnCVi+QXI6C1+4lOA0pbrc5Nj5hO3GzTP8UFpVxJ8ZeyvC+OIUWnMYaiMTh/e2xrFI0UEeaOVyRPMJw1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJm1QDIE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJm1QDIE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2907948c1d2so49577675ad.3
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186969; x=1762791769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfeI4do2p8OwX1bs3r/PVpU23cvBEdcK3KBLEfo+aK8=;
        b=cJm1QDIEvy6vQsHD2LLXTwJJJf4Mpe4/+xOPU31gpiXO/voaC5GoTJdUP49sLohvUe
         VIT0lc7p9a59kWz3sRDeNRIp71R+3k+NRLHa0uOyqjEfnoLkSwpEHgF3+xHG0rIW1z0d
         tFnbE6XgB1P2J/c1jChgyGO80pQHfClydnR3caIx3ckCib4P0qgDptgqoieL3rWnI4tU
         YNGBeWXsxrFna+hB5hpNmNKR4ZoFxvPEWlEKPLX1TE3XYWiz1tuqhTRQ4wwi0EtxK9hG
         a3059MRX9Km7YEESIe1OlxhdYoslcqhX0Hatum6onHcJ4RyA6vH5YOLuqMkS3voyNH4k
         PBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186969; x=1762791769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfeI4do2p8OwX1bs3r/PVpU23cvBEdcK3KBLEfo+aK8=;
        b=OD/HCRDqz7z7BaTXhszelt7GpJpbtYxUowf4LRKCvIUX2YFvcUyIxN0xBgbxBtp3O1
         6muPYq3cwvtCXRMZJqLGp0iw1w1Zuneh7mqykibIQ/YQw06Q3YgBQhKajZey40/x9994
         57nE3jOxPTcF6KFWj1EWrdgigivy4txj7dPhKjrUD/GEVh9zcpJvFOs/QqLv8DEcfhbs
         a7sSYXYRo03Zlv4mN1KJ+2r3Xd2ZruGx6jSYWDgZja5rK6QJHL5kQv1V/0fqAiuFCYPp
         Q2CA6ooguvNGMeHuZDraeV2/hvIBwwNUPTHjUa8CEp68set1mNZlublYC5kqyYAZGPIJ
         4G7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT4m6nK4z6COB//5fS3VTx97pbZOd7lOfNBqBGkHtxRhMzr8ZS86iyEi+31INy2lCS+UONlIsvBx0Lfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqoQ7Rv4FAJHLZDDcdX3bCFPei6tp1uQudEDNl6GUinyjkabKJ
	SsW2Ju7MP/jUiZf+B9z76K4sIbWhRQM6/lckEACe05R1zm3RY3W7xOFT
X-Gm-Gg: ASbGnctA9NrzT6RyypWHkydiwGQwTGhh0xjS6A7k7nb711QJniXbxm7yLkpykgevD0l
	bYa9ti6f8nRmpvlLTWpe6UpJ95dPNCIQVMUamX3xlkRQQ07qirAbvyjdLC8meci14wcR2eI23fo
	Ghu6stHt/xpmJ5K7xWAZmGwHqvmIPL8T/jRebyO6C1W8J3sRQgfS2FKg3BKuWM4LTO5OoOHU42E
	MO1An1PdmPIcS2u0JBr18Q3AjGo4g/Ma3fDzppYoWQAlW6zbS6xW9h8qoygUUqtoCpWfJLjx5ih
	e5TxrPjWii5Z72+Go3UwVychhyRMoEloWKeDZtV0dlRYcmoSxatHegxoJ2dUEqhbJIrmpcQd6RN
	Bo0GB5OjYuYFhCMed4hyga6r88zjBbW4Pf8HTLlV6Tb3L8OPYBp1iyPlhp+kG/BxH1Oa3WJsf6f
	ALTPg+so27Tsd1ZH74GknH70TQxaKwbYUJrH6JyztfI8ziPTEp8ZRzmqLR3WSZ8hRx493KazCQ0
	65BKQ7UByI=
X-Google-Smtp-Source: AGHT+IEQaEN/YRqaD9Q0fZ6GjLoywGPuwEKc41YzWo/EM8FatoGxq2+IaYk2SY8ba4sIfOPAOnQ3UA==
X-Received: by 2002:a17:902:ecd0:b0:295:9b3a:16b7 with SMTP id d9443c01a7336-2959b3a1914mr60038095ad.4.1762186969039;
        Mon, 03 Nov 2025 08:22:49 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:5d7b:82d2:2626:164a? ([2409:8a00:79b4:1a90:5d7b:82d2:2626:164a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295743772e9sm73908245ad.66.2025.11.03.08.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:22:48 -0800 (PST)
Message-ID: <a89cb9af-784d-41a6-9f1e-dfa28d09be29@gmail.com>
Date: Tue, 4 Nov 2025 00:22:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fix missing sb_min_blocksize() return value checks in
 some filesystems
To: Christoph Hellwig <hch@infradead.org>
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
References: <20251103135024.35289-1-yangyongpeng.storage@gmail.com>
 <aQi4Q536D6VviQ-6@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQi4Q536D6VviQ-6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/2025 10:12 PM, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 09:50:24PM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> When emulating an nvme device on qemu with both logical_block_size and
>> physical_block_size set to 8 KiB, but without format, a kernel panic
>> was triggered during the early boot stage while attempting to mount a
>> vfat filesystem.
> 
> Please split this into a patch per file system, with a proper commit
> log for each.
> 
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
>> for sb_set_blocksize()")
> 
> That just adds back one error case in sb_set_blocksize.
> 
> The Fixes tag should be for the commit adding the call to
> sb_set_blocksize / sb_min_blocksize in each of the file systems.
> 

Thanks for the suggestion. I'll send v3 and split the changes into 
multiple patches.

Yongpeng,
