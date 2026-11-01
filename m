Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793547280;
	b=D2sLs19POXoXMLr/YSdW+iqtntqzCsVsMFOSgpbDkc1965oN+NWXs+TlmtKExLHBLhTl
	 iEJA6F5SVi8ZxybqKuguY5v7BGIRmo41Khtzrj7si1F+P5umgrHKallC47s/r2BLw8yWp
	 966F+FSCitVIcNs6WDmjkqWbiDBLt3zdzXFsqqAW7CLu4qeJIDmQgqzk1Pbr081HhKOZE
	 lnghNMDRwTDrY4UHw3xfwiGPNG7scVVjqANlClOI+i+jDZY6m9Yp0g4Ficcm3pcd8CS27
	 VP7QSICdkKX/CviPEkA3RV5/69FhXpYuxQJ25bnagYvIndL98oAeVsAtAf3VWeM91VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=psGHhOsIoIp6B+XTiXsNSE0GhyZPqC7AReMe33kXerM=;
	b=GYTihEYuhAmA8a6i8pwTpGAju31SwiyN71GqqrwkWISMsfS9wBYrfiNOhkavZCurPqIS
	 DaXvbUL8Qb83oKb6+IoV+4QxNf8hpg4nOkZgA6PY8CXaRYFY4/MkTI9GQCZlPjlInDCv9
	 Dka1otCbLYxdAbg9bc1bkcSTPp15EKRXhQ4ssLBnc8XgVAyCeKU+XrKMGoW1sJIViDO3E
	 46zFVtpNqVASN6FqSRDqHN+f8hbs0zZRsO2zPEFZUu9h3ZTIR5lWpCWAJ7J9zWCAfHv8o
	 ysXXnk0DURITo91O2YlP0QRxee+dnQHGwraiCSBxCuVfZBpW0g6FiI44Albk737+VBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYprsY36;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDF606A32F
	for <linux-block@vger.kernel.org>; Sun,  1 Nov 2026 15:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFFDF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYprsY36
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35159e0092aso242079eec.2
        for <linux-block@vger.kernel.org>; Sun, 01 Nov 2026 07:34:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793547279; cv=none;
        d=google.com; s=arc-20260327;
        b=sVTJKTlmiQL5SeiZtWLfIV7RrRaewWJ1dFIxHgTYFBaXq/kQnziem8jx3dONL2iLZA
         YNEEwOBj4KauXwQgmo041I70KM+7YtnrMbnPzmq23rj2zzTH9Hic6mPJwlkWEXMKuhcz
         ZZnomkvirQVkcrLibyRLuPjf/TTI6G/TCAvofJC0t+Nyi6muE3RVBDyN+VXiLQEOxAaH
         RoxcNtFuO9TL7gEPSGbucRUckwJe1KY5/m5MFcZNXEZ0SIrFGkjqhZ2QxUSsldEszQPt
         J64mDfMXJ/q/0UNd/vFDYSuFBCs5DZoOck9d0zyhhVTXZerOCTxSOXQ0CGfS3mAVvokj
         2IIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=psGHhOsIoIp6B+XTiXsNSE0GhyZPqC7AReMe33kXerM=;
        fh=PMojCFQWQNcyfGzdIWFHOXQnxryvS5DATShEn4h8WHc=;
        b=M6hSrvDl1bQLS5DifFLDtqc0nqq7mAkdIAmX+El5H1IfvF9sSAhsqjtz8iqsOka3pm
         7MqYRQC6piA0b+IA+v8b74CC/CtDC8lBrx/64zZCXFYkjq23d25ZAGJTni1+uk9KEa4d
         X6wwtaArUqv/bD4UfH9dgNpg3ujV/NOPAfBAbrkRV4fvQZoqiigDrcWrU4p2Q6cnOfCm
         oZgYBpZmX/MbcNBZe9xP1FrV0VSQYEXRgYxzDw/qeAzFn2TgomMDUTdEdKWE7FcnZhFe
         Nx3fUjMQRS4LcUQN2Qg1/uDliWB75xW5EdKxUP8qx/6/aEyR56nZwp190mpWoVVTRIJe
         bELA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793547279; x=1794152079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=psGHhOsIoIp6B+XTiXsNSE0GhyZPqC7AReMe33kXerM=;
        b=eYprsY36nXzookYULLHmEke8H5GI5P3RmtqXHxJ1MQ1DResE4YG+f97CLR94tUL66h
         AS7XKPPrNS4wmAtiXLg2oRuR1zRuz3w4vCmGa538IkalFwBWlxeh0y0ie8btlDREU4qp
         N2G4QWT/XGiVxK6bXGk9UJdEt49SaZ35Ael3n5eBzasN/u3WfF44pv8IN8iFIHgC8u8H
         ko+ZjD/B/9wLJnd9F0NjfUm72KWWANIO1r8yMaDMTeWHjA8lALh10/UocLtMR/r4c2f2
         ZLCRPbVaLwo2KBblST2c97RQqYh8L/GYy3q29EOYvLaLhwdwEXF8KlINH0nmtEprlkqD
         uU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547279; x=1794152079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=psGHhOsIoIp6B+XTiXsNSE0GhyZPqC7AReMe33kXerM=;
        b=va7V31pFyAspjXiFLc02wWVUvHk3wGXBRwE1LOH18ukEHWTam8WUG7CYcRr0lOR8xK
         kDsMzucHGOsT0jnrGUs5fxeubiZp0XvBRDuwDHH1U3rQ6wpWcgarW0cc9f1joy0cLgk7
         4Nuv3kvwJyy4DziurngQTXWg4iEMmigHOoY/obCDN1caStRncoHWz/RM6S7mtriceZbF
         iB4baC9l0O3ClcH20hGyXjMLYczqIqWS/G4+B8c0/nD39fmwr8kOR6324gdBD8Xfclu9
         o+xQrwxXMtbeoag3JiSYqPdsrj67WYS7bPrhQOb1DQ3zLzpXEXpUOdmKEOlCx9O9S8en
         mNUA==
X-Forwarded-Encrypted: i=1; AKwUvBxTPGG1krpbYbNLlXG4no7kovOLEXn/AEm0CJFBWm2CvW34hr2XeytXX9w8p5b9P1Hjak2BKZ2t2DSK+Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKWL7e1xlMhLPCKYwjcyPwibzNlz1sIynZzfZE0eM3rnSdNaogt
	Sm3CpWpQ6C11j9Zm+B3ymK1V6ArQ6ujQDD7eg/8S9//hmv6Ds6kryqx0LW3x/nwR3ll62sfPt56
	HHxOEcmeNtnn09WTB54oAgSXH+TxNj5cYOtz49tw=
X-Gm-Gg: AYBFou1FqfJnntrCsJfdMpaWtfYN9OncHkGKWhiJByw06sgD/BRI+pwqUdHE4uxmcJf
	m+P8OkKkfEEzPZMz7EcSNMgrE5IWQno7XzEiWf54sFuGReyPfTq6rWulKK3DQqObTAjw2ZM/n3+
	rhnpcC678XMjRXaQT75GUHHAft6nTpaNShYGl+UT2xH3vJKRFKHFh/fOodlGHZw5wGc5jrOVPGc
	cDsQfGHrhPpeD7OluDdbsJ8F78ynKx7OLUmZoJy0S0SyLh189lX/wx4p4WEV6x1jEUsWgE3YVqi
	Up2Ncdaz/6B+/o2tHRLgr956uIpNSsanHGOuJ1yG0WjiLMnLifx11UH69Qmb8Tv88pTPabNyGZ2
	TVvBjf6/vTnA/N09Yqyd7C52o1BHyeTD2AqPmbckw/LASXYIlMvs07Nid77jLwd+P+J5Zn0AG7g
	95ZBsPix1mzMfNziWidtvDwG5CMBtrWwnmXKWpPDUIc/5zsKBisKWkTSesIz2VNkmVNhfVcb+UX
	kYLHuBjFutsEGdVLQBjoVytOdP0K8QsN1GG4c+ukVWGDUEFJZ1zMhNs0A==
X-Received: by 2002:a05:7300:e9d7:10b0:36a:1452:8da9 with SMTP id
 5a478bee46e88-36a4231f759mr20462458eec.1.1793547278227; Sun, 01 Nov 2026
 07:34:38 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk> <20261031152846.746656-1-sashal@kernel.org>
In-Reply-To: <20261031152846.746656-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Nov 2026 16:34:25 +0100
X-Gm-Features: AclHuK9CG-B0tjlQR-Ajve19cMS08Wyi0a0Q-isF9a0uhX3oTI1dOa50vKFtVEI
Message-ID: <CANiq72kK9p_eUwa9BY1pYoidRqsORXhd-YDu3SVpnAmrMQm5gw@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque
 array wrappers
To: Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 4:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
>   error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]=
>: pin_init::Zeroable` is not satisfied
>     --> rust/kernel/block/mq/tag_set.rs:41:49

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/rust-for-linux/20261030223702.GA1673281@ax1=
62/

Cheers,
Miguel
