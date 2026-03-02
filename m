Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEBE1A680A
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485447; cv=none; b=DvUwbTfkH3WUrlV8r4WZw9oE6CI9DAuQi8GfNt7Jy8x+gySAFonwYmOwhfRAVxsUG2Y9pk58YubjyrvgBrgHlkzt+UMqgDxDC7DnFrLloT+ALmSf4RpsHuMgwZCiVR2my4ryMBx02/10uuscwWKuwGbhGITRAduhbCq9PKWpVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485447; c=relaxed/simple;
	bh=UwKN828bpYjsATwe/PFNfBBgDEwwJJjZ3GciXwnOP1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4CI/dRwgsGF7x056EeFixNJwbk9oty0C5VE5I1OnlM3vIT0y9FSy96Vbbx12Hci7ggHkUpQf9MdTjgR+smyeQrXcDDY6rV4/20Atvwym0BGYh4p0I5Nm0AW8q/RKADtkVL4dXT4ON8wG0nYeibyZtjPZ3XLkVCRVhdNTPtGCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z4Bzo0Wf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z4Bzo0Wf"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46392972257so4014365b6e.2
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772485445; x=1773090245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvIDDVWC3amChzTdZaAU+7HRWfu0rMD4zIP/5WJSg4Y=;
        b=Z4Bzo0Wf3G+d2z5kyswDxW3jW+NPZDiVyYZwCcqN83Y49dvLqgm1fj0D+2nh2e/7HK
         y8XgjjOFWG50GRCh2srXXbYtnH1gxt5oudR0awiokKqFJBqFV+75vqF0fXZcb9O37PzB
         ssP/XV05YlZsYh2QLF+rBPyBu9kralV3P1u67TnrC4Gq176kdbtB+q+Yzk7rNrtA2DyL
         JNxO+m04ssNNgDdJS5SdTjn5rlUQGzbyEPyhUWsMrh4R0eemKB2xMgXYGgCtad/ThjyD
         pZvO5pkjXBF07tjJWmuzdzaOoLCD/n7CQeuwzhnCm1zeTQbegrjQte7JAmiotc4r7I1y
         akRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485445; x=1773090245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvIDDVWC3amChzTdZaAU+7HRWfu0rMD4zIP/5WJSg4Y=;
        b=HGkfKSoqrXn8mn9Gl9JkUEFFNObZQrR2DoPKlYlJYApe6Em89gUNFYnQZhUVyBb9ki
         S9UF14Kk07GGf1PjbBf9/bt/LPApAFM2PdH/bcPjBEE/1p+a5wyDcNKV8zRXbFNfi/90
         sa/UxmWITPMy1XDed1N3bCu9CfAwoo1hy53k67g7R8kJJDZz34NDGRrROOL+Z4gjJUt3
         gCJRez5vImWpf6ULJWchIyuHkhnLtPSU8+N/UexxkrJhZt8rsznFV9vxEsN5OwNHnOIc
         KMv4JvwN/ntdCFxZERXRT+DpYHfobRgjUZdxLhTy6qyQSUW1z1Twfg4lbFfk8vgPJXFL
         CYjQ==
X-Gm-Message-State: AOJu0Yxr9cQcLijn8h7rhO72/GN7WJl8a2uOyaIDAan6hefXJdPNqyVd
	dIlFQaaLaMimmOizeOvMWZvu9tjQ7fhylQSvyeZjuERblVj+FF9bQVJ5wAaVnyjYkRE=
X-Gm-Gg: ATEYQzzv3Qp4odsB9zWKEnP0GBbA0Nv7MHuiE9OG/1y2/A/wxtKbBnZ+/xSChsPUUwE
	mB5BIsMQXLc6bPaYsp6polDdFJDeQNTFb6wKtzpmnT4Lz7j5gqQPqeRj8Op/wFnjkwKrc5La4UY
	iBgVQZZhOn3DB4PHEwmmeqA871rX/Z6tEL+oSkooomvThlrE04WtC8kPamXuesVz5nktWaEirXC
	wSZ/413C0oXUNu0Fcf68ABrGsg9Juxcdh76Hhs3fVsfz4px2UVqQA4lqRsnjDIf2/qt3cn9rdcM
	p77P2YK/Eb2psB9u0bkn/C9pzb62OUThdyaZhCd0uBHz2MnAaADZ4qUL7gM9slVgajbGwVNGpjt
	joKzE377/Cwwi8BN2IAfok1ZkcNNiHXz0iSNt0WYMGFfZ038htgBQvRRuy4rn1oaU6I0s22o9L9
	3R5jm1MYD6hUTd1pL/VpEzZtLBjco1+2A90iO4bfngDzdl8Ecd4MjDYS0zYZhmK72Ik45B7GDCo
	0bzU3xqXC1DXyBwv1Ft
X-Received: by 2002:a05:6808:8281:b0:463:b4bd:5287 with SMTP id 5614622812f47-464be921973mr6434178b6e.11.1772485444663;
        Mon, 02 Mar 2026 13:04:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab302sm8292175b6e.7.2026.03.02.13.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 13:04:03 -0800 (PST)
Message-ID: <40e13629-aa4c-45ba-a2da-b7614961def0@kernel.dk>
Date: Mon, 2 Mar 2026 14:04:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove bdev_nonrot()
To: Damien Le Moal <dlemoal@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai@fnnas.com>, linux-raid@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
References: <20260226075448.2229655-1-dlemoal@kernel.org>
 <5b8c1811-c9d9-469a-b8d0-992814a11b9a@molgen.mpg.de>
 <a2993605-2cdb-42b2-85fc-b071f07af4c3@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a2993605-2cdb-42b2-85fc-b071f07af4c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 5:27 AM, Damien Le Moal wrote:
>   > Is it worth the change, as it looks quite subjective if you prefer the
>> one or the other way?
> 
> I think it is a nice cleanup, but I will let Jens and other
> maintainers decide on the worth of this patch.

It's a bit of pointless churn, but I kind of suspected this was coming
when we added the bdev_rot() helper and now had both of them. So I guess
we may as well finish it, as we're half-way there anyway.

-- 
Jens Axboe
