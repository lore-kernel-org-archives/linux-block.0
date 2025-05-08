Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D722A7F2
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709819; cv=none; b=ogRi5N1CGtPvDZj2iTc5Um61a98hpMURAHBXmxCDJtLshM43xoO0jL33r8txsFjBlndiNJEJYDNtSdXtnW1AKlnjUnZelbst9BQKIAmJiqAKJSC7zdhxWFRAb/mLXfLxkLKoim3yQlpqo9mKqP66yesrtZMP5aTrNqFoXcnaInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709819; c=relaxed/simple;
	bh=p3igjo1WeQ4ei3xNoOb2bq7IvOmv4IUIwEwUY8QYhsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbWcWPi1ql5J1pZANjI5TEK3vyV85zb4LxgyMRurxsy2+OOAzlNPjDZF24Efw1KM453MjGefS6iN2Q+2CD76lztiWNiN6nzOaNe/i9VyattlKPyh/igKYZ/sdNrTcyqHNrdBy688FaHO30ZJKjUJughuXF8NiabDBg169tZcj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dElkhqxu; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dElkhqxu"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f5373067b3so13513666d6.2
        for <linux-block@vger.kernel.org>; Thu, 08 May 2025 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746709816; x=1747314616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=dElkhqxu/goVLCAJe4YPugx0jIvVu3HkSV3T2iJALFlfFNIXcRGxDWSUglX0tUG3CJ
         t/MCz4ZrKPpWINAqWURuSlmJiBp0qkU8hunAqzJmdUJ0iKEsaxxQXsc+YVtTZJ15QWkS
         scX/2joh/OLf1q9NIBVPquAY6PZbbwtxsZj7mpE6I+0ASUQrpKG60HIak6CiD/6VQf+u
         aBAjzc6sGAVBkpN3DPZI7h12TNKtDSodHnHCZ6TmQe0w9y4Nh6CTiTNYng5q+V27+9Pd
         xekZUQjToRDmOKBXwBOdC6KpPugNqMHPcdqLEDgzCU5eCbIi+q/zT4p/ANvrIn59+dVU
         JvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746709816; x=1747314616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=wbKn+p43Boxl/pXDOm8H51QiQYNHzWXKEv8qcBVh0wdml08bPWM37+BJRnaeSOmj9u
         6PW7R8aqilWQsim4ZW9jjn62vwLgG9Ixeb8V5BxflWjy24kqXb7NVuZHxIcjsEh8AEGZ
         YVosQiZGw8L2eIheklhnKkKt1H8GLfOazdSjjk82eiJmniVl4eKpZfB55GxBi66GZXT1
         u3Vil1R0j6WUQceHE1/FzU89pQ61RDVjLkIigXI7e5CGijlqljTDzjuAVAQSgVthDu62
         oWxAYFXxz/cGkHdB81I/JX+GL5Y51/qVw3ggRnrs9rFpkif5nDU29mXMsEy1qjAREgUZ
         T7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ms1cgaoN5ySRlm9D7v6G/AlFilLt8hjihKThJAKWV4L1h2DWkY3zArCMt9PgVIgrPn361kOseSRA+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YykK7see5pJOec+Firx94zoIjbzGCVjsP0rUuxRk2sb4lQ4qP1j
	YiseAiJl3gvKK68sX9Y7N9ThXv+aETSPOj6z8B3t98CBwH2F3Le356XSRHAs9L3tKY5TxIv/wwr
	N
X-Gm-Gg: ASbGncvAVM7X3LqNPpPjL7qjBp6uoclmNO+a10EzlBL9xr0xYEwIv1K7LUsJK6vqnzh
	aiEf6WJ54r0VZczEvpXgPrX3GDfjjV5iCpB1G4bFIf/DGTcs8vlyuCNrkD3JqAgLc09jxHkiCxN
	Oc2EH/w62Al9FJqs5jExBoWV2QpOdZvXnLg9LSXp3B9AQQ5zBnb4Zl93tmCGTd4rCMt6s46NZJz
	+ZpyXd0+FuJ0Vx+/f3M/RH8Ebs4RaFFaa+Qb8nRCAx67vSJX/5S8qhGQJ4fjGcLR+ZZFyyWUx98
	ymgDqagHuU4xek+iCbUdG9pqbqZjb9I8lASM
X-Google-Smtp-Source: AGHT+IFc67B3rj29wLwGe5b9hNdUhbBaJDAFmOrgjOa9uQdS/eOlhjhIK4I5PRu/Z5lCJQDbW0IFWg==
X-Received: by 2002:a05:6e02:12ef:b0:3d4:6ff4:261e with SMTP id e9e14a558f8ab-3da73867d6fmr68904585ab.0.1746709805765;
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a945471sm3173148173.70.2025.05.08.06.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Message-ID: <0df727b4-c0fb-4051-9169-3bd11035d3e0@kernel.dk>
Date: Thu, 8 May 2025 07:10:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
 <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
 <aBypK_nunRy92bi5@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBypK_nunRy92bi5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 6:52 AM, Matthew Wilcox wrote:
> On Wed, May 07, 2025 at 08:01:52AM -0600, Jens Axboe wrote:
>> On 5/7/25 6:04 AM, Christoph Hellwig wrote:
>>> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
>>> +		size_t len, enum req_op op)
>>
>> I applied the series, but did notice a lot of these - I know some parts
>> like to use the 2-tab approach, but I still very much like to line these
>> up. Just a style note for future patches, let's please have it remain
>> consistent and not drift towards that.
> 
> The problem with "line it up" is that if we want to make it return
> void or add __must_check to it or ... then we either have to reindent
> (and possibly reflow) all trailing lines which makes the patch review
> harder than it needs to be.  Or the trailing arguments then don't line
> up the paren, getting to the situation we don't want.

Yeah I'm well aware of why people like the 2 tab approach, I just don't
like to look at it aesthetically. And I've been dealing that kind of
reflowing for decades, never been a big deal.

> I can't wait until we're using rust and the argument goes away because
> it's just "whatever rustfmt says".

Heh one can hope, but I suspect hoping for a generic style for the whole
kernel across sub-systems is a tad naive ;-)

-- 
Jens Axboe
