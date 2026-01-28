Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE51F9ECB
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602676; cv=none; b=D3hxfMexjbkkof+qr2X9w9usZd/4EhdrZWVa9w46yoKeFsP2wbnCXPabDoLoN418IHdUt3kI0mlL/7aWA94cfF9h2+/n7dYhRxRwgHKixudgmKOLD/9wEvxLoUgsIe90VDpCstGlrD7zfp86ZA/ih/nW4ndjhdN3m7tfq9BfWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602676; c=relaxed/simple;
	bh=vFWdb3PBX2zBDqdrtWvluSHxOAFMa8qzzSmnhwckFpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhPDXsdpWZs0ZGVOM0aFhNLoKUsVs/fQKAtSg5lWp+pWCHrYCD69GH/k954b5EHKIVgIrluN+hiBIKnO4zOmV0VC2FAfQjnwTmD6Qu4DL+XVKokU6YKP03qEtFAC65593Pt4uou4B0BVnziT+lbJETBPAn8+XQxWBU0cSQ40wDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GYSpmv+b; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GYSpmv+b"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502acd495feso77136241cf.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 04:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769602674; x=1770207474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUdr6DX+iZadrtnG4gSybF93zfd1qmcT/Pp5WRh3xdg=;
        b=GYSpmv+bzR9piAMErSx0mrN+RyeOdPkAoA92oW3lGX3DEzLKoSsOtDUSBHVEFOr4fi
         L3bZZ4sigZSxVR4xVHYnqLUazJDz9UeCFAEkn0RSL9MoPVA83XPIydnn5elD3FlwkTeo
         Zp263OUdzduHpNsudNlOoSbZrbmcZWf28AMFe1mOSnIe9H4VAAyIduZW42hrKLGzo5U7
         T6m65V+E+qiVCxEYrkrTstYe5NiK5lzqwmBSMDFmpnjiy8e9x62+Zg0lC4+I3n547A0x
         KxPopf+KKO4RcwfaGvItNGM2zAFoTUdOF1WpONLPW3s/DYDxGitko2swKwm+7Uxxq0qQ
         MGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602674; x=1770207474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUdr6DX+iZadrtnG4gSybF93zfd1qmcT/Pp5WRh3xdg=;
        b=R1oFUW7psIna7kHBFqCSb5Fsp2lVsiOTwdkXKJGVoqHA8uX22PaB4TN1f9lX/NL+Cw
         O9UddBAisXZgQVb2ODsN/wK4efduvC1qSKkFN5pM2i7736PyWN3pSUVol93GY19JHN1E
         qxTYZT7QjdvOxE+iNiuvLa8rny/tqQ3f4GJf7zvDl1l7HKy9f2bZVu1DIu+X8Oxh93H3
         EGBCvW70ALDCxJEQct1rJvwSRe/KMk5Lahk4DHcF0/HJV4+JZbpsh8zcbHQs0jkyTIc4
         fUBRxcvA8zIsCPQbPyWI+RoWafK2a23v/3ZZcz7WCCiJq7FavMxtSDf7gfSa/DuuM8cv
         /PFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhMxzwQN93veNNd/7WDURgeJH6a8MZKChhX8VFXbSKmAyUn4Aj+Gr8TOse0LVaIguAZ2uobT50zcTfjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6pg8hD2fbAtotjDImtvSnDcH5rh9IUELxgrlMBKMYPx2zniE
	NOzXoUl6bYvSzS4MrxHuUeAk1l3HBUmyHm2GJyXJ9/zf9PR56JPjQhehlj/cdPZoAEw=
X-Gm-Gg: AZuq6aLbzDnO2i2Oj3P9CJPEjGZkwlX37mVw3ZwuFbBkfVQTTAt5KHHz2Ei+vpKV+7R
	OvWR7UWPwWJR4Zu1YRtiqgqZndXHhNAh8H+BfwN2fbdKlRdU13YLYm53TZQpLLFGNbPNNN7/cK9
	bQ0A29sCLzTBJAMNsI847JV5P5jI6Vki0Jc5fFM6/xl483yHKhRNm18F3rgVnnTP6T1nhkc7fSr
	3Brd8puL9y6/J1NtEbpvZDYqrkKp6uoA2RR32AJfkZqtDGhKw+1apmRdN7CSptvL9YiwVW2+gyJ
	B++oYIzdFY+irTVvcdSAEDnXodnZVg5rovhz8Ai40yJSN1Vn5ouGTFW6yqMRyN67qoKrDFguFpe
	jtkPct5Kk2oj19AYkNn5zfezTdUuUdlEqx+Ti/f5BYooyJmo2fqYXbNFz5LZ13Eq4JS2yxVkXBF
	gKbZ1/jb+Se38w/q4ej8hdrSdmdzmTJMIHeDSVKBYT4Ugmc1SL/PX/ejcoTkGmvOej3xHmAZE=
X-Received: by 2002:a05:622a:2d5:b0:502:6ed5:7b0d with SMTP id d75a77b69052e-5032f8f0e01mr63543941cf.48.1769602665322;
        Wed, 28 Jan 2026 04:17:45 -0800 (PST)
Received: from [192.168.201.17] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4e3sm14749451cf.6.2026.01.28.04.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 04:17:44 -0800 (PST)
Message-ID: <16e41d3d-401f-4600-a304-08f1d2ba6892@kernel.dk>
Date: Wed, 28 Jan 2026 05:17:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bounce buffer direct I/O when stable pages are required v3
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260126055406.1421026-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 10:53 PM, Christoph Hellwig wrote:
> Hi all,
> 
> [note to maintainers:  we're ready to merge I think, and Christian
> already said he'd do on Friday.  If acceptable to everyone I'd like
> to merge it through the block tree, or topic branch in it due to
> pending work on top of this]

Queued up in a fork off for-7.0/block, for-7.0/block-stable-pages.

-- 
Jens Axboe

