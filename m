Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9D1F948
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934200; cv=none; b=m29+LxH2yVHQLdyuZ/dX00C7zOy6/tQalgPMt5noWsweTtXp7+hSc0bpjUQ3tvFa+OS4OmzuNjo+FOvdmao1RPPx8YvSnl/riEcK8t9bS5Nefy8Z/8KsYu+DrwfTyj/q9Ltt6UmAmJyTlFod4Mi3hFZ+raB8OXK+HIhQCXIm3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934200; c=relaxed/simple;
	bh=boYJdd6+m6SDd5soL9SlVlvXVINBf0zXpA6Ppmi0JYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhC9BBHbN5Jn47V2EXpmQ8LXZtDW778qVOAZ+NLO4axQm2z45HaKewB+aHq13KCzhGblu9VL8n7bEQ4D/C0JRtizL7cZS2ObUVOwbwWVctzkP7fSvXbI01vSKR4J94vx/Jt1AklCuFU/OeHQq4KVvXHbvCC9SoPnYA4VJScmumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DEN33cGj; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DEN33cGj"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3f664c47ad2so3819185ab.2
        for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756934195; x=1757538995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfMkix/+P7HPOllFv/98pzVj5tLiMyFcmqj1emmBcTU=;
        b=DEN33cGjzGOkDmmsZXq8JrM0BIg3VPJYNxDv91oH/NHiZYziEqGoc6DNwyIfZfzSLb
         Sb1MdC3L5N6Mcc16AiHyftBG7V4rfelUli8AkVDRCGDFojIKdal1ja6q0MQZqLzbzoZg
         00L2Pe7n1DXFxPYgT2R8hDnO9sENKqF1Ftme0mS97xn7OtxV7WClkcpIKSGOwXM/qw/G
         wSUu2qD00PwEbnDyO/lTLMmEhtfHbiiVgTFq4p5BLXlyTNGd4F+USHZu7X68d7bkAVVE
         /Ltf/3hYjhpsCWRafualhzKh0EDxNvvURWersRO/yNtPLOgDLBD2/G9449WuG8HR69J2
         IuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934195; x=1757538995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfMkix/+P7HPOllFv/98pzVj5tLiMyFcmqj1emmBcTU=;
        b=CAOiUk4cPG2U1CVE70tKgwmemdshGQbmQXhaHzhIMY73dezI1jzlpiDf5TjvdCoCa2
         r3Z7YAfQWQyY67PpxOw58BkU2apUyW1vnw0bTxrd1gUT9NYJg0yxTOHq85Dq+uvG5ukw
         euAsTLpUVANpoETA5JMSd3PbU8PFN9wCzCTkzdoBoajp43vGbakESaTsQyl8/hOXxlJP
         GM86w+HizwPR0PPcd0kdbaGWGktybH2OhmfPgyFvu6d/jU89j81caVwKtZgcYIs/4OA/
         kB4a5ziNx8K4A/avkIl5ORu3GtLl34t4E3SjgoO91PB8EpDlFckLe7yAMQ08WTuwOsKm
         f9dA==
X-Gm-Message-State: AOJu0YzNokvf5FA7F1Nu4YQxcj7jdBJMEnepNII7mmx6G8bkNH2cDbDg
	gP8als9Iojo/BW79bQ5pEJerT0Gp4T4FfHAcxFMkhrBXw20EVyoIaa3K5xfud+2UdXdlk+AVc4w
	YKTGv
X-Gm-Gg: ASbGncuYzcToX5maT8fVncBintiNBwTloFjiRLqlw7DO4LWfipOby7qskyGAWqwie/G
	5nadF9FBTf1Dmap/4pON1Bm9R3zvcpyogzY4F1en3DXngFnP3e7yxi+nu+gZw7yVZqayJqebVBF
	v7wu5uN0eiTFO0OCL8MSu6+0ZtcLudBwxovQ5hqxdMyrWGc5gcapF3OVxplGeAtgvyLJOkNxrzd
	qmpdA9/f2GbHG/UAFpAI686lCLdiwiRFcK2Lpd0itiMu0fSNcDwSCW3NbGhb6WOaj+9JISx/bO2
	BD3dW9wyhXUmuftRlbjT2aE8bwpvdg22kBmO2dvAw9i4E/nRmu2RCFyJzoZ/Tq6nMqnKAuaV+g8
	M7bQzHLYuoMxi6UTyPDQvgGUgfaxa
X-Google-Smtp-Source: AGHT+IGAI5PYiOc4mSX4TsLwMr03tflvKBB2/cmBnp60pV+ZE8OYhK0BoEcxY6nArod9vPJz82porw==
X-Received: by 2002:a05:6e02:2169:b0:3f6:60d5:ba0b with SMTP id e9e14a558f8ab-3f660d5bcf2mr53655355ab.24.1756934194776;
        Wed, 03 Sep 2025 14:16:34 -0700 (PDT)
Received: from [172.20.0.68] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f35c1f8sm4503611173.55.2025.09.03.14.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 14:16:34 -0700 (PDT)
Message-ID: <630bd7a9-ca86-41e9-8bfe-6b3660878581@kernel.dk>
Date: Wed, 3 Sep 2025 15:16:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCHES] convert ->getgeo() from block_device of partition
 to gendisk
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20250718192642.GE2580412@ZenIV>
 <c821c881-76c4-4dde-a208-bb9e8f3ea63f@kernel.dk>
 <20250903140936.GK39973@ZenIV>
 <b0de8c00-050f-45ee-9a77-72d12159fed5@kernel.dk>
 <20250903200737.GM39973@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250903200737.GM39973@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 2:07 PM, Al Viro wrote:
> On Wed, Sep 03, 2025 at 12:58:32PM -0600, Jens Axboe wrote:
> 
>>> Which tree would you prefer it to go through?  Currently it's in viro/vfs.git
>>> #work.getgeo (rebased to 6.17-rc1, no changes since the last posting);
>>> I can merge it into vfs/viro #for-next and push it to Linus in the next
>>> window, unless you prefer it to go through the block tree...
>>
>> Assuming it merges cleanly with my for-6.18/block tree, which I believe
>> it should as there's not that much in there, I'm fine with it going in
>> via your vfs tree. Which is also why I provided my acked-by. It probably
>> _should_ go in via the block tree, but little risk of complications
>> here, so...
> 
> I can send a pull request to you just as easily as to Linus, so if you would
> prefer it in your tree - not a problem:
> 
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-getgeo

Pulled, thanks!

-- 
Jens Axboe

