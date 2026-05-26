Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C1277029
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779756210; cv=none; b=J2mITgUwb0hUUo9c1LXf7X4sX8p2EbMDOGeao4pYFJwQ8ym63Nv1iE0E6an9qEI0ZhMydZ0yQ281X4F9hjunuTg8Rerf3f5NfSriRa2Dj+wQEaZGDaMKvBxCGwJLgVeHR9gQLbEuKM6MDb1LzNxps0lRoxkpn5AHaVF+TSKweWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779756210; c=relaxed/simple;
	bh=OeBdW8w+K/E4rAqV47MIXje5WFc1I6FcWdJRjvTURBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYNap5cedtB7Bw9kOVg2odw6m7mmMAuAohzxbWvnE/l/9cwFLRO2w0F9uwKQ7DBVhWxaqql2YU6TtusLSs4dcpeUwA/zxhPsTlPr44RTYEcjMoagauPbBhLirtUnCGmTVhtnMX8jAzOdJh3czqpRITIkUaG7idY7xPRS+5qvWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+MeQm9a; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+MeQm9a"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bd266f6fc0so49319505ad.2
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779756208; x=1780361008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZSBKRaBI53J0bLo/1yi0NM1Rx2AWnXxdKiQgfUvj7w=;
        b=j+MeQm9azVO4TPM2KU1U8hZ9OF+E2RSuCdDT7wJR+/h/GBKVaH2cYkqV7Ue8sIKNOQ
         YpLvinZhHYPnjEmV57Ir+20L+0Ej4wdszdZZ3e9g0m4/taoDPEEPcdtiUlKZmdf1gn5E
         sCUrPwX92VVw0xy1Ecbekfz4n9b/oGYRRGKgIXs1nyFK1RzeutofLIZJb3FO5fztbpo/
         8zwymWq3BmcHRhxMg8gzrC33ZLmgA8q5HKTtBRcpFRbognjSytYMXx0+E/YAkQR9dyyd
         ZlIuvt5by5pZ6Ubo4Q7gpUMmexDPFiSeqhvolvq25SuhZ05ArAbyAnSC+8LbpbOeJykH
         1Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779756208; x=1780361008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZSBKRaBI53J0bLo/1yi0NM1Rx2AWnXxdKiQgfUvj7w=;
        b=TAfPoq1CDaObb/sTkPwUbXZhGlxFPtZkfvfkh48l03/CjG9Qp/iAlKzCehcI1xsnev
         v7+2fxboalUzt2LbAzdlxaUbOmG+QdfeILZ7jpf8BIdAWbNveV39WCK956+yB0WiAFb2
         ZvvakRoy6AGz/c96QtGuElEa7PhV+rPDSwZ6c583s42f7ex6kcFb3/zwxXOGRYz1h++u
         svBUfXMwgQjQ/neM4R5toiDAElfUM0eEZV0oVNbYXSA/cqncwkvvKvQNoAJ4ZerMCJ87
         ifLDh1unKOWuw7x3BleOnOSxcQF0H2k0RJxtHAZbpr1LoToBq2VgQ4ZMbg/zsyFLQo0/
         L2lA==
X-Forwarded-Encrypted: i=1; AFNElJ9jTGclIEp3/lTAVsBFnJNCwr5odDtM/u0uJLEZSJSTIq+eJP5mL4k2Z8jYZjfaJc+FR1YqV7EVo54Vpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNx8n3TGnPJgAzQAznbT4M/vvmjjn50i1WLil5I+iGD/Q1HasM
	YJYNbTKG0W7oUV+CdkFuWITT6Ar1sTHzg8Qt87D1bZV+rh+3HncWOyB0nGhjoz1b4SzPQA==
X-Gm-Gg: Acq92OFY8wbNPl6n/xTF3XgWDX4gAjYw8TqETqJAyObo0ZZv8EPA3GtEX+/O4GCRsjb
	IFOuD/GEAuxKtHNNLDxP9xHC1fBIoZw2JEZ3PwLiJb8wLFGYFVb75f+0Bg8uqRGGcANDvDage1l
	bqyqS4rlUSCu2HwYRhwBXbLMT71c/GwnGrO2DXDpCycOz71QSO7j05LT3boycMl+JLZoJ0DBcUO
	MVrafDXfdsjX8hV8MASDSluy3JZ3oE8lh5VfO8I1PqOKzSM25Fi4UcZJwTflVdm1bY66demT3Of
	4ouVOfHfercWnr7Tn6C4dIibgk7S5AAldE8ylfWzDgu0BnO0a3GhbH98e7P7zDqMT4v9VvHZsnA
	POGca06mwlKsx//AIpliB8dW2ZVuarAwhqA9PuX9MIpTHqTfIVX6CzssT6PGEmk5UzW1ZQ2hK7r
	GwuJ70Uvg=
X-Received: by 2002:a17:903:3850:b0:2ba:3e2f:6874 with SMTP id d9443c01a7336-2beb06994aemr181148545ad.26.1779756207944;
        Mon, 25 May 2026 17:43:27 -0700 (PDT)
Received: from [0.0.0.0] ([64.118.136.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b9fabsm133811225ad.23.2026.05.25.17.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 17:43:27 -0700 (PDT)
Message-ID: <8b988694-789b-4a2d-9e7c-0206ac427860@gmail.com>
Date: Tue, 26 May 2026 08:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rust: block: fix GenDiskBuilder failure cleanup
To: Andreas Hindborg <a.hindborg@kernel.org>, Ren Wei <n05ec@lzu.edu.cn>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 axboe@kernel.dk, sunke@kylinos.cn, tamird@kernel.org, yuantan098@gmail.com,
 bird@lzu.edu.cn
References: <cover.1779596478.git.royenheart@gmail.com>
 <vDiE0u5yWwpR73QOOL97_K5xky-jGckDYtTjHAJH_7uGK6V1W8OKtcgrAIK2mC6I0Kfkd6lhbSYgjk2IRbvORw==@protonmail.internalid>
 <b6411cc055080c984a67bfad72fd683aa84b8e13.1779596478.git.royenheart@gmail.com>
 <87qzmz75d9.fsf@t14s.mail-host-address-is-not-set>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <87qzmz75d9.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/2026 1:42 AM, Andreas Hindborg wrote:
> "Ren Wei" <n05ec@lzu.edu.cn> writes:
> 
>> From: Haoze Xie <royenheart@gmail.com>
>>
>> If GenDiskBuilder::build() fails after __blk_mq_alloc_disk(), the
>> allocated gendisk is left behind until the caller drops the last
>> tagset reference.
>>
>> Handle the failure path by releasing the temporary gendisk first,
>> then converting the foreign queue data back, so probe failures clean
>> up both resources before returning an error.
>>
>> Fixes: 3253aba3408aa ("rust: block: introduce `kernel::block::mq` module")
>> Cc: stable@kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Signed-off-by: Haoze Xie <royenheart@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> 
> Thanks for reporting and fixing!
> 
> I see we also lack a `put_disk` in `GenDisk::drop` after `del_gendisk`.
> Do you want to patch that as well?
> 
> Best regards,
> Andreas Hindborg
> 
> 

Hi Andreas,

Thanks for the review and for pointing this out.

We will run some additional experiments around the `GenDisk::drop()`
teardown path first. If it does turn out to be a real issue, we will
send a follow-up patch.

Best regards,
Haoze
