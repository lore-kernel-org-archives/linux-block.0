Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F8209F54
	for <linux-block@vger.kernel.org>; Mon,  3 Feb 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595530; cv=none; b=Vf0zR886FI1fGefBVgP+4l4+SADP7F79b8yMC6+MPmo1S+0UeWXXLU6eIUdCBv76D9zmGmfLv/L+gmd6xFmFPgOyJK0jEhotq0YFTOxRX9zef1ew3R+h/+84HcDqkv+2bo1lemyy/tmggaLWnjeGG7SiEbRRKE7NuZk4RVvodb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595530; c=relaxed/simple;
	bh=J4WPyu2dCpa1wg3kBbT+yTxtUfiD3S5ZdeCx/ev+Q+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA8wIl3d4PpihVTcxO9LdRpzgKErRHFOLbemTUTs8vM/cqd4n4ZB5WqESx7xWubTA77Uk5pO8bsih276/as+AAQiEsC01Iw4NUh46+CeLo0hEUaQ88KsnqAdu8IVDh49uHQ0TrUzFC7OW9Vzcwv0UxCXbmavEFrAK7oExgO9i/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NkiN9Xns; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NkiN9Xns"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso12091385ab.1
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2025 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738595526; x=1739200326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRfpPZzgAZa6Zak9GDas5XD80wl2C6NIA/57szE4cSk=;
        b=NkiN9XnsNIc9MJ9+BQBMhqCoS4s4xFw7uobCWNFiNpbWh3HQBJG8zie61VQBnwy9f1
         xtB3skXdXs6TlGnbW441ecnT+L3SoGcBa6ziPKji25fhhj/7Vmbnd2X2hyA0yGlydm7h
         GnJpR285Ab4PoaqwEcy61WQc0YWmIFWBeJVUkJtxP0QtjUK0Rwqjdktp3vBzilq9CU05
         xqNpPMNt7k7pR69S3qmCvqbS7aiaftA/pRJ9QEWU3PpdTBmNzz7kyrExM8RLzm2Xa4UV
         a9rX7wbysZIu4dlZnE8fW9cMdxQCO2k96efKhkR2cvcse6u79Omc8qPp2bhUj/I60Jru
         9RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595526; x=1739200326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRfpPZzgAZa6Zak9GDas5XD80wl2C6NIA/57szE4cSk=;
        b=KIdQLdBBhbBNutRs2LCh1RjZUvqHXNS33RrktAK9kz9f6hGpOJyZLYabVW2darsACI
         R6FyFGoYu6wfyIXTrgBiwcyhXa6DL8QX7yqbN2W/t2wz9ft6nYgsXkvUWCt/789xg9Zm
         ZMAvndaeTZsOhc8mRqjWy62cfmDDKYjn+LF3RW3l72oPXzgpLfBUCB46Iz8HPzwt/p0w
         84hh7SK35WnLw1NBzGOI5nlFMcnxEQBBx8NtO8VtbDduRwNrCyXky4YVHom32fRJwbDZ
         qzpwEBQS38LsklFKPvNmkvrH/XaJbm7ARy4NjtevTT6ZAl9AM8OlV+GCVYJsZPK1ItHM
         539Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdFUastPWMlbTEIKTTVtjzBezQGHMgV+rZbAO9vzYr/ULFa88dEZnRgTDvy6IlV7h95RvLvmPr1hiYtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPOhDYadVUDqxR1zX72nhpcWVho3wTHPc5+DxQBjCyrU1eABs
	nWXAPWLfZ0MvoxVd2XXv9fbMuMuaGJauXbJv5lSPvRkq72BRZAZUWuaibG8cdmQ=
X-Gm-Gg: ASbGncuQkDtHCHU2F6+ug2jFI8KCxjubAk5jJjqTSOPkjGFB9eaoRzMuSLV3LiLsKLI
	Sj8WBdoRmcGfEYU0DoTQILrzrrg8eZXthWq9dPgw/kLMkYoyoNeyoJ/Gt+yrgiKCGfYT/6fhh9/
	8pfCIPFT34tKXH/dPsTPnjA3VDs3+ZEPKEvDwN8gGCochupYksWoLuqpXYFn3PZEx37BdecBys3
	cGVuVHvTdg5KehuEVyTLmUXpa3RItvzAuBYItdq+6Ork3piVAUIErEsw6twD9H6RvuHrQhoWA0l
	WDVub57rfHo=
X-Google-Smtp-Source: AGHT+IExPksUoM3E6ty6LrIuS+bUTXtJbAwi3WKcho/2VPhbuSKK1HIuLb1aeN5jPmbZBIOOLKzxHw==
X-Received: by 2002:a05:6e02:2688:b0:3cf:b2ca:39b7 with SMTP id e9e14a558f8ab-3d008e71836mr145248235ab.3.1738595526174;
        Mon, 03 Feb 2025 07:12:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d01c433734sm16125455ab.14.2025.02.03.07.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:12:05 -0800 (PST)
Message-ID: <262032e2-a248-40aa-b5bd-deccc6c405ca@kernel.dk>
Date: Mon, 3 Feb 2025 08:12:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: force noio scope in blk_mq_freeze_queue
To: Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20250131120352.1315351-1-hch@lst.de>
 <20250131120352.1315351-2-hch@lst.de>
 <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 8:09 AM, Guenter Roeck wrote:
> On Fri, Jan 31, 2025 at 01:03:47PM +0100, Christoph Hellwig wrote:
>> When block drivers or the core block code perform allocations with a
>> frozen queue, this could try to recurse into the block device to
>> reclaim memory and deadlock.  Thus all allocations done by a process
>> that froze a queue need to be done without __GFP_IO and __GFP_FS.
>> Instead of tying to track all of them down, force a noio scope as
>> part of freezing the queue.
>>
>> Note that nvme is a bit of a mess here due to the non-owner freezes,
>> and they will be addressed separately.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> All sparc64 builds fail with this patch in the tree.

Yep, Stephen reported the same yesterday. The patch is queued up,
will most likely just send it out separately.

-- 
Jens Axboe

