Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26E17F4F6
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445445; cv=none; b=R4wCzAnERPo+Ra0tHGXw3BdMbwuTsvZQqriRjpmtV7ZjmXfZoWj9jxMWvxHuuR0Dey7JFTchB92DMaTYox6joKiez4LfLVi6ahwy3yrdkN3usa7A2BUUF8fDhz3sVlfSOmw4DVGwXfZN279uvZLGu11OA8Lt9NbhgETj+Y/wNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445445; c=relaxed/simple;
	bh=mR1HZMubzuDo88qoDWRxX2DiK7pQX51amaHggzE4Up8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKCANMe59w3sPqboZdDKcn1QnXJNid5lUhFDULzUGYtvNdOBjXJZp4qv0yVJrLpLdZNuD5e9N9d5yqtvTYgiBx3KaUDCQnH06EDkDErLcC82I3eqMRuZPhX2edb0ZmWEtHm3rITs/rZtYDoyvX7gLGTJAuNkE0NdSfl6BiUdru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NQT9MmNx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NQT9MmNx"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso2043316a91.0
        for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753445442; x=1754050242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BB2oK4kVlFMA8R70kPOxJrlj1emQHcqQrUadj6so5I=;
        b=NQT9MmNxZOh1fzaKu+kGG7jvbsJUqIDqcjBLcGxKVl0ectlkqP2U4MMEgdQeHVBhf2
         Q+WBexLUgMHbUwzlpLImRAyGcWSajzXVNes48Oil40Cy19AUw9uky5S8F8hOIBuXGZTz
         05lW/XnesurxlCkgur0l6LB2dlHyrT7sGXTETuL2BCRnlYu3suByB/wpIj3WJmGI4usA
         thF+2zc2Erg8S6+DL0BvpevqIh9iug6TReWjQa+ZPDo4rRGoyz39mDsWRcWoIpM/Pddr
         Y8WRd6xOMLRgp/O9pzxg+BSFYRzouZOrQKwhFe4t+11DJwaufj8FBWl5j5f0JkWlz02g
         X9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445442; x=1754050242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BB2oK4kVlFMA8R70kPOxJrlj1emQHcqQrUadj6so5I=;
        b=LK0aNOwGUdkRBS0Y0qdXbKIyiUv0MqnutRNIA6qCwZYe0p6/lOyTwyZ3Owvq4nF/CF
         CpnD5pECKA1mPnONSOHWfKOQcWEK1UKtoNPUi2yB5JyObWYRBydXxoIqB7y+qNCL+m+a
         hNAfEk1jMR9hKsaEXwo5xSjqi6xa+tetB/2xfb+5FcxWI6yZOS1BMLshe0Wj9bqaAuDl
         Ifq/tFV8Wx0l7CyhZvBVteBwshMfk6WK/4Vnmt1NPGzF4SBsCzRGe1k2eYdSAz26g8TG
         6ALClbUAf3TBgi+SVwW8Z7g3nuMjYuAqgjXaj6YF2Y5GLBeAGWftZ2SgJYSRMCrkBupg
         UP/Q==
X-Gm-Message-State: AOJu0Yx8DvXqH8pPok9xo1No9yC0sL0vrHi5SKL5HBQJJl0ViuqqfW7i
	K9L9lSyrFXqg7SrL3hDSKQIwYIQmewCMVtISkyyst/ceJh76+EjsFN2Y4Zq6pVqQx7U=
X-Gm-Gg: ASbGnctp8TI4V1GL44RFDLr5f3oThBPc+Zz3FRdk2M6HV/Tqwv01coHDQMk6PCPy7D0
	tezOVwBYP2fSM/Yek+mkipoDzfRP5MC9KHjjDvYyTiHJrNUJhLWu9G/qmBGrFp3VusrcW+1ADAQ
	nGNVdnJcPVIA1XGmnuCIEldoNSXgHGDNSeYGtd2aM0p0X3gteqAurac5ka0FD0aOr6dukqvVOCh
	x4xMJusL9DQdPdMzP3rqJC+UzEJXjWFVJb/keOV2b47Oxi7P2a0asI9L7QvmfrR/dkhpxE7yeWB
	U1DbLdQu8rXauqJYkuYV9nKaJu/XtUhozWVFgRQQLDkBLeybD5nI7ZFTeZmLldeG2Ouv1BLD69V
	7nUr53QmXqxrbdoMdLzI=
X-Google-Smtp-Source: AGHT+IFevLnjs8vNfTzc8Bky8ffMZ/QArwnsNrHPcQoA35FdKYhdd/g0uxmZ5R0tMqrKafUOSc9h3A==
X-Received: by 2002:a17:90b:33d0:b0:313:d6ce:6c6e with SMTP id 98e67ed59e1d1-31e77858116mr2556706a91.8.1753445442209;
        Fri, 25 Jul 2025 05:10:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09bd9fsm3299292a12.26.2025.07.25.05.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:10:41 -0700 (PDT)
Message-ID: <67bfc411-d944-4d1a-94e5-610122ac6976@kernel.dk>
Date: Fri, 25 Jul 2025 06:10:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix typo 'prefered' -> 'preferred'
To: =?UTF-8?Q?Ignacio_Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725040939.73175-1-ignacio.pena87@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250725040939.73175-1-ignacio.pena87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/24/25 10:09 PM, Ignacio Peña wrote:
> Fix spelling mistake.
> 
> No functional change.

I don't take just spelling patches, it just causes pain in terms
of backports.

-- 
Jens Axboe

