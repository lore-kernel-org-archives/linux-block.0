Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36137266F19
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743954; cv=none; b=gtmYXIynaq4Dh2A/8pGKWR8ktMl+rLB0jHfNU4BbtDIORDc9Cw0vQwLt4N6xepPGlOshuhDh81EqXvkY+XwFfLkC87xcBAdCCOxCt1/KdE9H3MXcM0IPF+M2tKaccx/MSUokj3ZMyFLN+spW/s19OmBp1w4mZrvtjtCCQAaoKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743954; c=relaxed/simple;
	bh=VQbQx9Tb/ylyfB9fXhvn72VbZpr6LY7NbCp0MA1QlIk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qoyxoJ98vKGaDkCpljKttVd2O1MpNt0SGE632Fh8e1MWqJfQm2kWzOffEhEpGlybTxrjUxyz5yh29TG8G9DS3Og+iBbFObqJSTvOOD5jtozPjlq90IHw2tQB4evsB+7gmps8Zw1GgQZPCjGsqdiVpD93K91R9k9qcWfwUtpDdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhMtP0RE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhMtP0RE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740743949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wWpOhsnDYuLDB7qcQwdEr5LnVDJuu5aDQkc1qn24s7M=;
	b=dhMtP0REfJCb+4fLU3alJRZO6ZHJEDQpNP8tikZbVAQZ+3uwuHVkZSfW/1DCY6WK0em/t9
	ZhraQ0yKw1lt2Y9TCoYyjIZsbcdPxGq5cnu/DRxVJCjepMrRQyS5PaZDTIPj6L5HNiwg1t
	nrF9azp2dZloDrRjD1Fl1fMV32CF2Mc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-NGuS0NZZOwS17guou4B6dA-1; Fri, 28 Feb 2025 06:59:08 -0500
X-MC-Unique: NGuS0NZZOwS17guou4B6dA-1
X-Mimecast-MFC-AGG-ID: NGuS0NZZOwS17guou4B6dA_1740743947
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-439a0e28cfaso11655155e9.2
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 03:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740743947; x=1741348747;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWpOhsnDYuLDB7qcQwdEr5LnVDJuu5aDQkc1qn24s7M=;
        b=Hsk7iPBw1NpFYTzH7zQ3r7IEbB/o8tm2077GCsALVbe0GJ0ZzmNcaYBb0Ak6uONlOS
         lpHg31TEpL7920YM5+k5TuG2oE1x96DWD/HjeM0cEKhDMYFu4fv298VsUDi8UDefrhtL
         rQWWYOgumWtbUgBHn869tUyxrMnpwsvbjP9ljmcOqzI6W/Req0fu/JqjyUYGYIBsb4OC
         WV+Uc9V+m+1uLT79+AWEaJrcGUgnhSnlwVyZoLrPMNNj0DfZA1iXZkc+G7kuRNNtYYUu
         epILG/fMM8jebSUza2nO0Wn9g/cCP3ZuPnPW12SfQIIDCqjQcFg9gtPXzTMzEwkbmzea
         ffPQ==
X-Gm-Message-State: AOJu0Yy8g+cG1SeVPG1MlLM1y8yhFbFN0MKNhcK5/sBI66lwr24ud/7y
	+qGDU5sr1HBuBI3L427LFSjsxqsNpIGJbZf0mAo7Zn7JDtZn1sbnnzOd1JZZA7QxSUsA12Bk2zi
	vHPPluTziKqfDqtYzJY7aOS3D/XLsTiYDDdGYmpL7k1AOQd1uHI2mEKBzbgi4UX9I+bPiQKFc3w
	lPsQeJuAdMMlrofE4Py7a5frZYXAsVQb7kW2xSuwSNeQ==
X-Gm-Gg: ASbGncufJpsWIO5Y3iQfjN4M/3ccW+2gPxSbEGicVAEYPhoHFMmccGr1YySiGCo0/K2
	J6Ro96dn+hR8ssF1g5AMHsd3LCC7OSTGlw0Bg1/dyBF8UFXN+1+5W6C5djxKeavyibT5ruIMsI4
	++nR3a4FT31Y4rAl1c6sSAiClh3xgKUjbsftOJaE5jxVmojzwVY77rip6VnBX0NX7oc+kwZ6EZ+
	9Id0CSbrnX4Wis/OIEWQ9I2XITOwHUkgAIz0u1vt3uD8mkfRoUKQ67bfb9rBYiPQDwUPkx+svN2
	PPhgetAg6WlwUn8vASuGobarFXBj4yXV/OidEOI=
X-Received: by 2002:a05:600c:a48:b0:439:99ab:6178 with SMTP id 5b1f17b1804b1-43ba66da248mr24474555e9.6.1740743946954;
        Fri, 28 Feb 2025 03:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB0UrvqyMu/fSpDRZaZiAa/32E38lbMFhM89jeBgbV4iK2c0lfb+kgt5fZFUgEb5hDKw36fA==
X-Received: by 2002:a05:600c:a48:b0:439:99ab:6178 with SMTP id 5b1f17b1804b1-43ba66da248mr24474255e9.6.1740743946574;
        Fri, 28 Feb 2025 03:59:06 -0800 (PST)
Received: from [10.43.17.94] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b8dsm84815995e9.14.2025.02.28.03.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 03:59:05 -0800 (PST)
Message-ID: <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
Date: Fri, 28 Feb 2025 12:59:05 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ondrej Kozina <okozina@redhat.com>
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, gmazyland@gmail.com, regressions@lists.linux.dev
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
Content-Language: en-US
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jens,

this patch introduced regression to locked SED OPAL2 devices. The locked 
region no longer returns -EIO upon IO. On read the caller receives block 
of zeroes, on write it does not report any error either. In both cases, 
previous to this patch, the caller would get IO error (expected) with 
locked device.

It was discovered by cryptsetup testsuite specifically 
https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/tests/compat-test-opal

I've attached a simple patch that changes the ioerror condition and it 
fixed the problem with SED OPAL2 devices for me.

#regzbot introduced: 1f47ed294a2bd577d5ae43e6e28e1c9a3be4a833

With kind regards
O.

------

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fa2a76cc2f73..b891ed113306 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -874,7 +874,7 @@ static inline bool blk_mq_add_to_batch(struct 
request *req,
   	if (!blk_rq_is_passthrough(req)) {
   		if (req->end_io)
   			return false;
-		if (ioerror < 0)
+		if (ioerror)
   			return false;
   	}


