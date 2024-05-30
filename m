Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860E1C6A7
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103009; cv=none; b=HdFOxQIYd88x+y32Hggsx5/zgk+oauuQcv7POVnKtLEWjt2EwbiS0BwvaNIga1BQw/zvr56BXZfYc5ke/pdWJa97WYb8CE9j+U4t5f1UPTOJitd1DDgpeNboPd+FDf+znOtTz5BSUGJ/MrX7x2kMZBRVLWTkXmWtN3vxNCQNHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103009; c=relaxed/simple;
	bh=z1QkV/oN4PrtxkXkowk2WXG5mwwAmpepcbaxRHSK50k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R3Oeu2KvuhrmjeMN0OPWOZyzAqchdrZ/N1YRDg8rEyROtPSeG+uL38ykR7XHLlDJog0DqjzIYd3ZNDAek2jWelCgfIl8dDukaJqZzAj9sMJLcBhCpJWOeE980P+m8Kz7Y1MHfpKzgu2GQgoBdTEi60Sio6cx8CHebA0VChyy/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z4ZIneD2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z4ZIneD2"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8e60db1abso22000a34.2
        for <linux-block@vger.kernel.org>; Thu, 30 May 2024 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717103006; x=1717707806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ADwps8sC0bvy2KrBBRv+blQLWKGCsgQXNcwl/1TWNo=;
        b=z4ZIneD2+bNx1nZ2vfxwdYAfA0UyQ6xFJGEYP1IhNHTdaiexv4bs/n7AVcvf2MbE7B
         dOG1tCXkpm1hvHP+OPDbMb6G7/okLR2/WWG+bxFBCoFzq+s9MbJ2UnYQNnP8YDFR/8zo
         eegQiiO7oqi0WGXMS0ub3cAPLTitEiSTte4FZBhHtKAhAHAmpFv87LSsRPjmbn40hlPK
         H9+TsbHrMMM29yLTwjgAc1WPM5G+DP6uHSpiVY3CzjGoG1aj1FCrIz3HyRqx2Lz+vY4f
         Y/8NfVvchzKZVBIuZcNQXvtgqQX3HpOQrxJxAYWHJyTxjnw24nxvEfvoSjAb89J53Bvd
         n8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103006; x=1717707806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ADwps8sC0bvy2KrBBRv+blQLWKGCsgQXNcwl/1TWNo=;
        b=PRTS1EG1vy26t8+qngcIdCwcCfca+iCXxfeiES+VsgSapdLKPiQ/6cQ+9GbKpoNvs0
         FAGjLkI+j61vYnIOiPVZ6ImzIvRvapofj216Hpg2xcAd7igOBya6uzB5rk29R0Gluqqc
         St9Ox6PdFXsFKJ/e/x63c9YPPh+ZFjcn+f2Mbs5FkdnZWhTWmp55fDj/aJU16d4CSJZO
         xXRS7q7rZCSV7OKftTYKD1eVnNJjCBmJ235JQHa8Q0LObd2mBZBeaCE5caN0LBwm0hA7
         lr+rxPIBhn+h2wpclhdBfAtMrqW428Te8h8YIkdy6Pn3C3sVQei2R87hbVDbkDG9YnP2
         YXJA==
X-Forwarded-Encrypted: i=1; AJvYcCV/RaVHH+T1OmTvldsESdwQcgqnEyrwwzb4PoR1tjfXgRekz1RwnsTLV9wIQI/ItsQRD9S5RkQjauDtluk7UX8V74BfeLA4eaobokw=
X-Gm-Message-State: AOJu0Yyx1ufd3xhEBj8krYAoZF4xS2QsXujZqtEqKtPoQiGzJVFiR9Xu
	EahtBni/wNU2/36KD/FnHG83JR0hvSdBRarY3TcU7NKYL5AO/wjkPLtttI38P16hKZVptkmvzQA
	M
X-Google-Smtp-Source: AGHT+IF59a24algYsdHIAtCu4zdmdj/N+NLGFiVkQN1zMHhH16wEcxkPdyBROz5FEWzkyW5od0gN8g==
X-Received: by 2002:a05:6830:7203:b0:6f0:3cf3:fb35 with SMTP id 46e09a7af769-6f90aee6d10mr3391090a34.1.1717103006452;
        Thu, 30 May 2024 14:03:26 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f9105239d5sm100984a34.6.2024.05.30.14.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 14:03:25 -0700 (PDT)
Message-ID: <1599ad1c-4395-46eb-9b9b-7439850a8300@kernel.dk>
Date: Thu, 30 May 2024 15:03:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Zone write plugging and DM zone fixes
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>
References: <20240530054035.491497-1-dlemoal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240530054035.491497-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/24 11:40 PM, Damien Le Moal wrote:
> The first patch of this series fixes null_blk to avoid weird zone
> configurations, namely, a zoned device with a last smaller zone with a
> zone capacity smaller than the zone size. Related to this, the next 2
> patches fix the handling by zone write plugging of zoned devices with a
> last smaller zone. That was completely botched in the initial series.
> 
> Finally, the last patch addresses a long standing issue with zoned
> device-mapper devices: no zone resource limits (max open and max active
> zones limits) are not exposed to the user. This patch fixes that,
> allowing for the limits of the underlying target devices to be exposed
> with a warning for setups that lead to unreliable limits.

Would be nice to get the dm part acked, but I guess I can queue up 1-3
for now for 6.10?

-- 
Jens Axboe

