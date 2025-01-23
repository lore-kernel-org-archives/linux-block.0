Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669A20E035
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737635100; cv=none; b=GJT2Eharixx7pfg0GsLquszOaw0K+9R1FEzO6A7NMHeWOGZHMJRRytCyef4qLKYywNCrdfJWkHBTAJgsojdJ2MP2jCTSFV9EWeqVrq6r5aRMO+PfqObmheOVzIN9Bhy3/cda8TffNlg9ZVALrrMe5J06F4Ko2MIeJ4SRlepF99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737635100; c=relaxed/simple;
	bh=IBA/LyGQVTDOCTFkchyE9NFxQXHn8vX7GPkzx1uGyOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UE+wPt5kUSDA8OhJq+F0DIo0US6nHmsVIh0oHBiSKfvVTQ0QRhrZtUv2AriQvh1C9OgM3i/m7padCaEJPX6Mwn6euSonSDMD6pW0xK/eCW3DiqWl0a31ByGDbUj8VzVtAxcBSDq1P8R3minfKEPXPyQPC+YNX9TdlfFbDaSTzzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB00bErj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB00bErj"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38637614567so391459f8f.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 04:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737635096; x=1738239896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wXt4XPaajtFHZ5c8A+G51ZW1YO0lL3hGYR9ox59vgI0=;
        b=lB00bErjPGx3L6L44N2FcAaDx9Z/cByFbduxgGgNoxi4JwK8aN9xmzFJwy0GcGJWPe
         +PFXkEzflrWfhRo5h7mEvo1ujB0u9pb3czT5MeVhUX9/CS1VeLgvzXKrOM4ZKGBVTJO/
         f6KdpTObqjzxxLdxaDT4s76/nuhVxDWmE/fyoIo4nhYDaxKwNc8yoabkKrdsXbSeYL+1
         G3MmkMxO3hrbTL7XOT0PaYjKKPAK6j8WeFvPY0bdY5Om/Zl6MHwwprbHK5RLhJ5rv2lY
         9/svCNC0+tGbsk2Se4KOVzXf96bKU2JpAiZzKYxVR+0dkX30oc6cCjGJhUrwmEzmdjDf
         YKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737635096; x=1738239896;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXt4XPaajtFHZ5c8A+G51ZW1YO0lL3hGYR9ox59vgI0=;
        b=lN06wY1g8y6vnTrakgxPoHF6r9SU/9b2Q318LUL8/hW4FE+3p7GnFfgPUheZIXHV3Q
         J7MDxfqKmAORIk30drKus2h6X1iS2D5riVcdBp9BKrrJ459BgOdKC1VI15sF01JohKgs
         y5HHcxX/eLR+MPmmIgzhtu6okKg2IPq5eBTHneb2qX/8RES05HNrQawDYvNO5tyw0kEd
         2pazeMOKyzLEyZwZfPjz1lLqdut4LcFpq/WDUK2rkSx6UUk8GhwpyKq3vRyTAufw3G9p
         CI7TkXWj6mdrluDJPWi4AmDh3Z350GnGk7y1u48PGE4P9B/6OFd+1tXzkceKqHpwcUjS
         tZZw==
X-Forwarded-Encrypted: i=1; AJvYcCXE3s/PtuLDmbJrBwHxS4x//Qhy69QVSorsYjV2mdmK2qNPJswW3T7ifiuliR1u4RKM/0lnVAmvi3xN2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZ9GxXPWEoWUzQCxRS9nfImoY70qE+fAQWCSV2nIkQOrfGwkx
	dTJoYa2pEthuArBIXM1jaHAI8VD3vVNR9N2XfxFSkQDa+Dl0Krij
X-Gm-Gg: ASbGnctIAQbdhjlBM2mcIuKtike94hX0OVz6VqGfTO2XCjlsyHLb7gldprchh0QMWhV
	0Idfl7qeCLV+Ea71yio35JKuAvJNVW+d3xmSx4yzbWICeK+Vu7wbqcZYkKTvFmVqZFG1bvPLehq
	ZrZRVh/hyu4mhv2FI7P8y/tJvWhiSTfGwQ93q8+bfPjwxv+kT1GAW5RTRhzX+XIQ2R8Cjkqboxe
	G+iRgq5/U3Q3X1RNlLqxB38ktImlbFFKmWcoE4BRdTJQLQSDUypwglcdAsXD+BVcTP0AsCEOTvN
	6/ueyoOh1pE4ytHCW59yheej3Tl5
X-Google-Smtp-Source: AGHT+IHSGqbW+bB12PQJf05MkZcfy4KspYLyFOhlUEycWtliS01I78gzBgLKLX6SrYVach6tJ8USGA==
X-Received: by 2002:a5d:58ef:0:b0:386:4277:6cf1 with SMTP id ffacd0b85a97d-38bf57b380bmr23403890f8f.39.1737635096230;
        Thu, 23 Jan 2025 04:24:56 -0800 (PST)
Received: from [147.251.42.106] (fosforos.fi.muni.cz. [147.251.42.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221b5asm18762759f8f.21.2025.01.23.04.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 04:24:55 -0800 (PST)
Message-ID: <13e4890f-25ae-4c99-96b9-db3499f3e117@gmail.com>
Date: Thu, 23 Jan 2025 13:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-settings: round down io_opt to at least 4K
To: Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Zdenek Kabelac <zkabelac@redhat.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev
References: <81b399f6-55f5-4aa2-0f31-8b4f8a44e6a4@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <81b399f6-55f5-4aa2-0f31-8b4f8a44e6a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/25 4:16 PM, Mikulas Patocka wrote:
> Some SATA SSDs and most NVMe SSDs report physical block size 512 bytes,
> but they use 4K remapping table internally and they do slow
> read-modify-write cycle for requests that are not aligned on 4K boundary.
> Therefore, io_opt should be aligned on 4K.

This also changes how various (usually broken) USB enclosures reports opt-io
(as you already found, it breaks our cryptsetup align test simulating these
resulting in much larger LUKS data alignment).

Not sure if the patch is acceptable, but if so, please add comment that
it can have side effects - it apparently affects more systems than NVMe and SSDs,
definitely some USB storage devices.

Milan


> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: a23634644afc ("block: take io_opt and io_min into account for max_sectors")
> Fixes: 9c0ba14828d6 ("blk-settings: round down io_opt to physical_block_size")
> Cc: stable@vger.kernel.org	# v6.11+
> 
> ---
>   block/blk-settings.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/block/blk-settings.c
> ===================================================================
> --- linux-2.6.orig/block/blk-settings.c	2025-01-03 21:10:56.000000000 +0100
> +++ linux-2.6/block/blk-settings.c	2025-01-20 15:59:13.000000000 +0100
> @@ -269,8 +269,12 @@ int blk_validate_limits(struct queue_lim
>   	 * The optimal I/O size may not be aligned to physical block size
>   	 * (because it may be limited by dma engines which have no clue about
>   	 * block size of the disks attached to them), so we round it down here.
> +	 *
> +	 * Note that some SSDs erroneously report physical_block_size 512
> +	 * despite the fact that they have remapping table granularity 4K and
> +	 * they perform read-modify-write for unaligned requests.
>   	 */
> -	lim->io_opt = round_down(lim->io_opt, lim->physical_block_size);
> +	lim->io_opt = round_down(lim->io_opt, max(4096, lim->physical_block_size));
>   
>   	/*
>   	 * max_hw_sectors has a somewhat weird default for historical reason,
> 

