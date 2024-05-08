Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC762C856
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154094; cv=none; b=mI/VyC8OsfuZGyXP46xLgVDAMqn+Ayu0N2gJCJGcyljEmmJJkO5J8wBxRO4BK9V22WwoiXZuu9DGpug1FxEkcdz0sIrr2LEcpuigYGT31Cg4rMxk/OBYzfli/hsE2qbGCLIEOHFg9/2ssxP1eOHl3V9cUOb9+thtN+Y64WzEhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154094; c=relaxed/simple;
	bh=gbESP1QETSXIHhn8KYELBw6pMRCJ9N4ypoUb0Pxk4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUG8uKMboLbvk1TyUR+PM/4SYurc0LqovayQe8KapbsjFJ59m0JUiMdS2S2Qt0ZglXNy6qYSrwIGbgzx7+Vby5NH11ALlw+NFyAqrv310Z3uflSv4dPURYeWk+xcGCexcyXB1P/Wy0GGsib5u0RqmopAflC/avslf6hyZZQRlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jXEgbqkf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jXEgbqkf"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f457853950so410742b3a.0
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154092; x=1715758892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0r3IrBqTHQaJKbAMA6Mm9iZI63fDx9y82yERkqABZI=;
        b=jXEgbqkfltTRwy8AQ7Sd8GC0jxl8g9vpCIuxCSgL/hWeNEKmSQxyfwi/GgmNzGWWBU
         hddxQ8eolzUqemwOgD9To4sTqSp7EH4wbvClYh2bZzEdtN3QfYdyH5wpCiyfPfm7QJXi
         6CZsXKovyLuTEJRNL5W08ZVbZWI+FVamsgLIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154092; x=1715758892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0r3IrBqTHQaJKbAMA6Mm9iZI63fDx9y82yERkqABZI=;
        b=lMJorlo3jO6cvBUAGQ/QpL+EJMC//uD4UR43FSbFcrdbzZ6RPQMsu2FVxUBm2dKeE3
         U/DsPTG6vW5/TAnX9ByEjVJPlYpZZ7Cw/qI1/CigXE0trCw5Lwuj+BxRSoo8wI1NpM+F
         PUN6rhOcF+xe19YqC6BxUAzhnbAJzifdShk/zJGOpocaZ6ZnjUNSDi4TpFCpVcsR2O2z
         UowqkU2FViRnrGmp7e+bLSz61ao3rw1NxH5Nx76zUoYD6NqUt42Fk6VpIfz+dSD4hjn8
         XEvXvz6zUV75KyxaU7/kwF+Q7C0ZfZsBlIkeG3ndXyvzkkL4ytWNVMy9zd6BZDsEPelJ
         GH4A==
X-Forwarded-Encrypted: i=1; AJvYcCWR503q4NYUiaqEncJd9K7jNXF75WmIrDD3RyR+JT3jUyMRQG2XJsrcQ2EEHs/MD+mShvEtPNpY9KnWbho+TEf8dRIS1g9bO+pkR+I=
X-Gm-Message-State: AOJu0YxVDYevir3sDYshD8KywUB5Q0pzjJymuZqrUeixQ7Ks5ZeXIRe7
	wGP3ElNJCM01+k1MIUGS08cfQY0uCrAF0AX6KfsESTuk2a0wgcBf0djyaXbZHnORhgmEqtHWcR4
	=
X-Google-Smtp-Source: AGHT+IGGJTY/PIGzQdtKKuV5fOUdLeYQsPqQYivASH6U4VOoA/T0QIDsMdiekFLUtNsr9TSBWXVJ8A==
X-Received: by 2002:a17:902:d4c2:b0:1ea:657f:318f with SMTP id d9443c01a7336-1ee6235c6f3mr77503315ad.0.1715154092630;
        Wed, 08 May 2024 00:41:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090311c900b001e944fc9248sm11130369plh.194.2024.05.08.00.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:41:31 -0700 (PDT)
Date: Wed, 8 May 2024 16:41:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 00/17] zram: convert to custom comp API and allow
 algorithms configuration
Message-ID: <20240508074128.GG8623@google.com>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>

On (24/05/06 16:58), Sergey Senozhatsky wrote:
> 	This patch set moves zram from crypto API to a custom compression
> API which allows us to tune and configure compression algorithms,
> something that crypto API, unfortunately, doesn't support. Basically,
> this seroes brings back the bits of comp "backend" code that we had
> many years ago. This means that if we want zram to support new
> compression algorithms we need to implement corresponding backends.
> 
>         Currently, zram supports a pretty decent number of comp backends:
> lzo, lzorle, lz4, lz4hc, 842, deflate, zstd
> 
>         At this point we handle 2 parameters: a compression level and
> a pre-trained compression dictionary. Which seems like a good enough
> start. The list will be extended in the future.
> 
> Examples:
> 
> - changes default compression level
>         echo "algo=zstd level=11" > /sys/block/zram0/comp_algorithm
> 
> - passes path to a pre-trained dictionary
>         echo "algo=zstd dict=/etc/dictionary" > /sys/block/zram0/comp_algorithm

I'll send v3 shortly, which adds pre-trained dictionary support to
lz4 and lz4hc compression backends. Apparently lz4/lz4hc can use
dictionaries pre-trained with zstd --init, just like zstd.
