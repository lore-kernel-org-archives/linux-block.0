Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C54168DC
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217702; cv=none; b=YPv5tZTteLO4dBvX21eXAP9voz5W8O6Aml3n6V708do+EVawz5a1FiE4NyWkgcelCp17kQgD/cbnAtAtD2qgxeMOF6zVoxysaXEPiTkiHi1v+CXogfRDbM/Os7WI0CCr6WHbTb1t3vZgBxbK36TbQS4SRNJmEm5S03cKPL2u3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217702; c=relaxed/simple;
	bh=vU/48LIHdzatnXaFk6tIUtMI9cD5TMpV3hQrTpJeqbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsRMGCKe9MtvtKrwdrFcV3OBT6j2U0fAlT8QbGuZnpNVbk1agLUxiZwIW7KIvCSHB78n74J00B7yyM8l5cSnhE3KltTkZtdaLTrpEP06/1tmRUDm/azRx0l2GaekuioOZkdkViyZT8mDUai2VRIVMAdvu0vodg0WzJnQbqdew0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kessrLd8; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kessrLd8"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3989f6acc90so1117315ab.3
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2024 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723217697; x=1723822497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oId9STgLfdIGQ+LhZbW6hxg3skZFfi+5Ez0mg+R4Joc=;
        b=kessrLd8YrFFikw1IFW7wJMou3wAUtuzxio2HpNQCwFgFea/Ulo4ujDqY6aAI9Z5/w
         h5T3UlZaPpYL/5EtkqTT4k/lUa4cYOVA/v10pvIPpHbQF++BMc/FxJSfy6Eu3JzDVmH+
         97xoI6ogorufHHA2pj6UEuo+8ADXQzBpDPHu0VPTVt7OxpldrzRi/FsIarXg5cjOMxhk
         LdKr4tzfgmzDhAo9Dc8KEbrasX20KtiIIsgRqJAzcq82wV9vUcGuRGhSamqdkhVnKyax
         vc73c54o0ZJwZ3qWSAVlGeit5G+AY46OT8EAiswK1FhkggzWDxViYpCXwb+8mHCuF5qV
         jj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217697; x=1723822497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oId9STgLfdIGQ+LhZbW6hxg3skZFfi+5Ez0mg+R4Joc=;
        b=cSKjNwFquZnUIkkdwgyfoljR1eEfy66jlzllDC6eEbZrtYUlQI1/owmA8pJ6okZCJf
         X5JeZe+jJqILxfP6QsOZC/N64WHdAntFiRAyzpH6Ahc1w3mRszK872gg3m2OM9aTmqNf
         Z3yQYfghYntS69YdQGNNC7cZwlUVyiY9gCI+Bt8kjRq/RVSB1PKnOPWqEp6cAWllZ9Mq
         phLDslWpe3njbWgPe+hWS+rymTqABLyhDwAykDTdy9zffzeE2u+j7F61ucQeAMYEzKsZ
         eYDWj2kyl4Z7e6m5G64QwhGSpTOBONMmDuEBwaMJTnglQDoNxS4EX/Ogbx18V7orU5kG
         +2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWuELJj6EQp7BfljZq9nMP1igxGjUHZ2K7uSjEQdkrEBjCE9N6WwM3vLONhScexkzmuFrXQm5b4iprhyl17YsmEQ8JhKl+439vveH0=
X-Gm-Message-State: AOJu0YwLELwlhBIM9XbBn3EOu1WMaX4oR8zFqB5C9BgKgo25RicFaolE
	ZCek3ZIZcsUYuCj7gYR/pR4d2s4VCgH3SlmcIp4TvHbGIIqTAckZkcf3kDqgZ4M=
X-Google-Smtp-Source: AGHT+IFLRZmDl+ZxbjcJJ8qEWSq27UMzqEjFndcG5q43EFzp3g4B7kGjU8tgMo9TiYr31X2+hClk/A==
X-Received: by 2002:a05:6e02:1d0b:b0:39a:ef62:4eb2 with SMTP id e9e14a558f8ab-39b8134a5eamr16121925ab.4.1723217696883;
        Fri, 09 Aug 2024 08:34:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69878d2sm4188811173.26.2024.08.09.08.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:34:56 -0700 (PDT)
Message-ID: <584a1774-0268-4b3c-9a78-0f00073b9d74@kernel.dk>
Date: Fri, 9 Aug 2024 09:34:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nbd: correct the maximum value for discard sectors
To: Wouter Verhelst <w@uter.be>, Josef Bacik <josef@toxicpanda.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 nbd@other.debian.org, linux-kernel@vger.kernel.org
References: <20240803130432.5952-1-w@uter.be>
 <20240808070604.179799-1-w@uter.be> <20240808070604.179799-3-w@uter.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240808070604.179799-3-w@uter.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/24 1:06 AM, Wouter Verhelst wrote:
> The version of the NBD protocol implemented by the kernel driver
> currently has a 32 bit field for length values. As the NBD protocol uses
> bytes as a unit of length, length values larger than 2^32 bytes cannot
> be expressed.
> 
> Update the max_hw_discard_sectors field to match that.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46

This isn't the correct way to have a fixes line.

In general, please don't nest next versions under the previous posting,
and it's strongly recommended to have a cover letter that includes that
changed from version N to N+1. Otherwise we have to guess... So please
include that when posting v4.

-- 
Jens Axboe

