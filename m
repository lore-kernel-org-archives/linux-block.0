Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21C1E4AB
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725814993; cv=none; b=NhliycO0PBn70L/sJVOZy6m8a7Ozun/GZhP/V80bzTXBqir7gSnWNqFpeNYEDBg7FXzjXkkom7yPlLDKn8LzBNxMWh1LvhBS2v3Vl5qXVdOTN9o6/rN4j1THP+/nccWgekLgFBkP0FqUf7/ZLh12gwb0dzs/A5Z+VbhkLNK4sRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725814993; c=relaxed/simple;
	bh=M6hOX6d67g/sHrbUEKNZOlyXGlA5MldEKz/S1CCvNOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY5waUmbNiqC6KRjuUyWr/V5FRVMKGvHL+Gg1vYoc8d6/tLsgQduxzo85tm+yGoR4ORdZd/oxF+8b2MhF4oEsZNKzTwLfRgEZHKDQv+uObQjyLxkaNMTSlfpH6LIuNSzpiSf4Uwmp8A2lPHScTs3s3XtUp4UX5+NfT8oszkMEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RSeJHGM4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RSeJHGM4"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e5edf270so807107b3a.1
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2024 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725814990; x=1726419790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfYf9qgMs/s/Cf29/MVQd3LQ6tknsxRcEwEDS7AwwRE=;
        b=RSeJHGM4VQttQCzEtYoOZ+PxnycBpCobU63tLfQZ6tDDj9Fju0LAWJaoXIR8mG0f0k
         xqYCcrAMiWuetW5hPtUJNdJTLaZ9OJFsZwiYN933cEkVQdFdW4Ho8kin7i2F5Mzpk7BQ
         zvpJbvtMIVQughZqU+bo+cjCAuZJC7eUiqQT9e6LcfYhmj5CC7JcRHR4sCoLyxSQ3Aav
         HhjWcyja5/wKBA9fFlSkltoazPXaINk5Qserl3EQfA8ee54WyvM+KDR3V1lIqnRWfXZ8
         We9TEaPprF6jWLRE/xjDqNEFq1lz1NbtYwjs0WMUQyqy9k3b5VJnh+BSqmSG4xSVzWDe
         67oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725814990; x=1726419790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfYf9qgMs/s/Cf29/MVQd3LQ6tknsxRcEwEDS7AwwRE=;
        b=P/TlXpwBS7QZ2aAUu/euGRXdtN+NxBzu5qMlfqd8FKlK071/HjHMvlIX4mkAV6seqq
         rj401JwHn3Ia/XZdaDUWN+yyGw3BYJ/DHXUzClcCyZ59zv5bLy/q7rxzhUxNv3m3AXcn
         v9yxNFDpedYqJa0gYO0ox18GJ3PQHk0uR6vHYkMDedmhGgcmn70cU/5wr6zQRVZs+yZz
         wySuyXIR57P1Jnj0AbPtVDDT6nmoD5k3FA8NzCt0TgL+PdgAeI3qnali50VS5IoPxHAq
         aqaiBhX/7GTuVaYM97bLMLZXKnr5mXOQnSHo4CD9SYL+6jFxQetgCXDIm8FnaCd3aB5U
         1bYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe3cLIPtrB+WXNSEyNry8eInpcECCfXMmU9xmG7399KC+tGWL5RQfszkO4G53teH+ROMHOGDoD063Dpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyprHXwFEVhTaQKZC75sgMLNihDJLchkd13WCFsg3z+VvHvpv+
	9oWo+Ge2Ix+lyE0EaNk95dzVBMTh8lalCJu1/DxkN9cWoiH8V82igbrB6+R2va0=
X-Google-Smtp-Source: AGHT+IEboSXi6Gg5AQgJ6R2dG81rS4lvAyKMHkl5m3fSbPs9p/sQnX3Y4+or6QEHsu48LyxGweVUzQ==
X-Received: by 2002:a05:6a00:a29:b0:717:85d4:939c with SMTP id d2e1a72fcca58-718d5f52c04mr12201175b3a.23.1725814990529;
        Sun, 08 Sep 2024 10:03:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c1f15sm2240605b3a.76.2024.09.08.10.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 10:03:09 -0700 (PDT)
Message-ID: <fa31473a-39ab-4605-9966-90800ddd84a9@kernel.dk>
Date: Sun, 8 Sep 2024 11:03:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block and io_uring: typo fixes
To: CPestka <constantin.pestka@c-pestka.de>
Cc: asml.silence@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20240908164723.36468-1-constantin.pestka@c-pestka.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240908164723.36468-1-constantin.pestka@c-pestka.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

1) Don't combine patches for separate trees into one patch
2) Both cancellation and cancelation are correct spellings, io_uring has
used the latter since the start.

-- 
Jens Axboe

