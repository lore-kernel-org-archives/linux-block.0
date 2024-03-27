Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCE12E5B
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582345; cv=none; b=gTPTzSyPEkjeOk/OJrC3Z/VvmZn83EgRNAlF6mGmuX6g2d04aDowyDXdah6YyGoTkU7eBIFFWHZEmxjIXBmetEGuPPIdaKx5/SvYQTCbpHOFHjFZsNOiN53PE93Zf3zSZm3dz5e/bFiqPEu2e80i2W91pf85HW1EYu+2zeKKe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582345; c=relaxed/simple;
	bh=VmxtqgUrzE93Q/Wz1sL1pFYQgikUHYUnYZlsNQquL8A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o7XsvYHPLunPWAwXO489cyDeKr65Hv0Qn9EJ2qx5ZuYu6CyQ5/AJjXMUL3IMxenXtpma18nHwBQcW06wKgS3KaTwvp1DIFNtNkZ4Y/kXstUYKroxP4zUGYifTYO0y+pObzmnzJ8c+BcYn8+1rcFlipnV5Zq/bHBpPw4eObhkOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=B1grv3zb; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="B1grv3zb"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-368a97b31d1so1288435ab.0
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1711582343; x=1712187143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd+bLnuIrzo5BL75P35HbQa9bf0AJcROp8J6EUCroDE=;
        b=B1grv3zbrHDFhas79oUEMfE+jABAzqxXHgZkTFxsZQFfSG1qT0Jj76d/lkCi3Dchpq
         WJ2DKxmmLCoat7rmbC004lGFGIwtEIb4a37kjFiXvXVyE/AN95Ir/RguAps4Isr12wbT
         FlM/S+41c2lRWUnz3sMidTo3+uoMn3HcrMr34uVlJTj62/ElGo/VUf9K7JJshhT/AGwY
         b4QfyD4/0LMsqA+iQPEu9MOunaxKxL40RLBaJc6Twmpy2AbJAzwsYCrJTi/LwatswPqT
         qcwzYyjpASBWwQAyHusG3vupyX/zMRb12asi/c1yEbf6GIcMPzRN0YLqzOdUfi3Wleih
         CtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711582343; x=1712187143;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd+bLnuIrzo5BL75P35HbQa9bf0AJcROp8J6EUCroDE=;
        b=XhrKogM69+qQeXARyZIFbL2xiiJ+otsyItJd15QD1SC+bQIELJTVqQlms1n3eqNauz
         4+fPZ/4KNf7+TWGO9ClfP/srW2243I0oRMefGurFWcwmcHin0OZcvfeNKrlaI8psvlif
         CP3YeIhSY61ZbQJSDxLSXaN+0Q6tXWqPvMlVpkSuZaUfy9JCNyXT5sziasvQFL4uGtfm
         qSifHHA7MGuiRQGUT3kmjTUdbGqwOREI+30EC5GE/gin6+4IuXqXOwoLuwsWq76/7n/O
         wTyrEEr3gBmbJ206ILqop3cNDWBy/uWW8qb5FOpJgOZVUfVcepnPYXBsAVB1XY1reIHe
         KeDA==
X-Forwarded-Encrypted: i=1; AJvYcCU6973pfZu5Hrj1XtNX7AlRt6JmABKqcQ0eITd/OP272+68sHWWAkqFDpNK5gR1iezIr7lNRNVGfp9BOWycllw6QEGNri1SVzPowOo=
X-Gm-Message-State: AOJu0Yy7KVJy+QduB6zKjtniF3lmUn8ahy2z8/ZVEF0H7GBdwurdT/ku
	MRSkZBXJcdME3r8c7tIwondjMBU9RpOdBYCktsaGIbUsitWPACo1qGasuPGF0cs=
X-Google-Smtp-Source: AGHT+IE03vHmTzxQG9QLpdQbmSqGVQrY7PdAbqyHjUU+tR8mWE3FVtLUmfvgcJCOs/V/EwuTnJXiBA==
X-Received: by 2002:a92:511:0:b0:366:93eb:fbaf with SMTP id q17-20020a920511000000b0036693ebfbafmr1468432ile.11.1711582343034;
        Wed, 27 Mar 2024 16:32:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::7:1d1f])
        by smtp.gmail.com with ESMTPSA id bw28-20020a056a02049c00b005dcaa45d87esm53837pgb.42.2024.03.27.16.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 16:32:22 -0700 (PDT)
Message-ID: <78e206c6-111f-4482-83ba-cbdd5ad8b61e@davidwei.uk>
Date: Wed, 27 Mar 2024 16:32:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] io_uring/rw: Get rid of flags field in struct
 io_rw
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
To: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
References: <20240322185023.131697-1-joshi.k@samsung.com>
 <CGME20240322185731epcas5p20fc525f793a537310f7b3ae5ba5bc75b@epcas5p2.samsung.com>
 <20240322185023.131697-2-joshi.k@samsung.com>
 <c31b0c71-dc6a-4481-b2d2-c41f5cf6371f@davidwei.uk>
In-Reply-To: <c31b0c71-dc6a-4481-b2d2-c41f5cf6371f@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-27 16:30, David Wei wrote:
> On 2024-03-22 11:50, Kanchan Joshi wrote:
>> From: Anuj Gupta <anuj20.g@samsung.com>
>>
>> Get rid of the flags field in io_rw. Flags can be set in kiocb->flags
>> during prep rather than doing it while issuing the I/O in io_read/io_write.
>>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>  io_uring/rw.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> This patch looks fine and is a no-op on its own, but I think there is a
> subtle semantic change. If the rw_flags is invalid (i.e.
> kiocb_set_rw_flags() returns an err) and prep() fails, then the
> remaining submissions won't be submitted unless IORING_SETUP_SUBMIT_ALL
> is set.
> 
> Currently if kiocb_set_rw_flags() fails in prep(), only the request will
> fail.

Sorry, that should say fails in _issue()_.
