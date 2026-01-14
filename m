Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700923184F
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419375; cv=none; b=ies6JLuR9LMOtrfWfZ+Jk3V5R15gaTQAmGaEHZ4U2BgRo/dyD8ODBNDS54rnDci5DGjb3WgbUeRgVzdRvdBuenEIf1Z+XOepkqfifEgouekzp8B5PEkC+CHY9rDDQwa46Anu+jSBuRLZxavsH1EAPlpAs8RL7fdKfEbBrPFjKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419375; c=relaxed/simple;
	bh=+uSO4y7Gg1H8HilK/2dWsamVw4u4INQzYQZSrKKx3Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STiGlEoSlPBUPGZd1Tr16CZ10++yhRaMd/Ous9xVtieae27QeKNTz9h+x79ML8aVxLL3nZH52TQiBcbHsi6EdIqPahsAof8s47u314w7HqWQNoR8JrKtu8PxpMTtYq/7KQsp9Bo4IjLsqrpVE0OYaf6tJnPGEUvhfwtlZWVIjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kd/qh9Nh; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kd/qh9Nh"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c798c92edso92923b6e.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768419371; x=1769024171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0teKoFJhNTQo64s382zvN9Vkvtlc93XKoD9YKexQVJw=;
        b=kd/qh9NhUhAbzj5Bd84ABNE9lxIMnYKJhxA3MnpaEvjLMVDM06/bgh9PcA8jo+Nak8
         FX/XgQuhNiMIVy2R7Sip1L2wN5+5NZV6ShaZcif9sk1MtmiDMXxF2fb9rlXgNhkgLwuz
         LPhwINeGdx7UQXupbUOTAgacNtzCnU2Ff8Yxo3gYMmLdtkBfVNoMFbyOpnmW2KE6etBN
         AQ7W+ZkPYKRz8MF3O1oeX5Aq6S/Df5yL409pSIDf3dKjUzJN1r8QBs52rbjWOColRjKv
         sszsRyUM3HorPl801WK/BpUMfp1cXFC+804JDrnstYWJsB4cux/7U10zzF/kRBUnJYAl
         2jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768419371; x=1769024171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0teKoFJhNTQo64s382zvN9Vkvtlc93XKoD9YKexQVJw=;
        b=rJ6xzlkKHqS5dXfH4/rWO3ieksVh2Nd83Xnx8EJ/NPwixpuoot714w8WMKcT4S0PxB
         P7rseYww6v1v/OV5VE22OJxVhxdOF/EMyIrXoSn6IdoNW9uR2vH0iwOrzcMcspjzU9/S
         pGOpUcff+xYNkb0TGmPiwalKedlvwrzzZlbmjAzYoa2C8ZLE3hraQElnKCfNqXA/Paam
         l9WzWZi4gulxBoHabNmkrElIWvynJ6HxaWtxvrag0+G0FzJFkyoRz3gHCFfFSn/g98cR
         CJe5KXKGailN3SK7cFK6Y8xxEW8C2PYmYRnmy23pIb9womyWamiK71wJ0AVCuRMshqY5
         sdlw==
X-Forwarded-Encrypted: i=1; AJvYcCWbYE1yBbeUWq9I46VXr8YBg4uAccl9fYeP0jxNY7o+tfyKMUVp9lAMLS1htVskUyffd4D5qFCMu5AKeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvuZr/pGlN4hokYD2TTaLc7ThrNXh8vZrofIRQFHWX0Bs0Pko
	pCQ6rtfUVHzgURH1Gv8Bq2PixkvkZ4MpQhpLRLAzeBApxBWFlfz/wYEU/2DzGLQkspo=
X-Gm-Gg: AY/fxX4QUh5NzyFar5tpWw2imquUTLgH6r3gaCY/AthdhpIQNQ71DRbjd6J2jUceQPW
	jx/G3BUbs5WB45vLtodzHakysrikw5rKfINrI6T2nVZ/Xve0RsPvi5q0v76rO11Kk4hb6NvMx2F
	Ckr9+M+6tXuUQTiu2elFr/dVCSJFd624reGvWILZih5Or0t7UE8w3dJsdLAKf5+c1LvF8hVE3rF
	ZW9pZs8vABWPSjeYHO8VeB/MdR9sQiSJ0YBiHQ68VdSM1nhQBOe/f6jhDi+SA0IrNf3PiDNPcWr
	wxhHvtHIsTpNWY2xrG0snEspJla0cPKhNWRK0BZW4phBGPtmaX2InJDO06kEe1da2R18KFBMFCM
	nze32moQg4sw65vYKwspCCCYuqdV9X8qIYHCfj4cU38dvhygS9e0EPmNGim5XUdEyP59q+PeKIa
	vU+Lg8frs=
X-Received: by 2002:a05:6808:318d:b0:450:c877:fd98 with SMTP id 5614622812f47-45c714936f6mr2557042b6e.21.1768419371526;
        Wed, 14 Jan 2026 11:36:11 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5dfb6256sm11842467b6e.0.2026.01.14.11.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 11:36:11 -0800 (PST)
Message-ID: <602e772f-b3e9-4bba-8cea-8ab94bb64b65@kernel.dk>
Date: Wed, 14 Jan 2026 12:36:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.19
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
References: <aWfiu2Twr5_lT9zq@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aWfiu2Twr5_lT9zq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 11:38 AM, Keith Busch wrote:
> The following changes since commit 9869d3a6fed381f3b98404e26e1afc75d680cbf9:
> 
>   block: fix race between wbt_enable_default and IO submission (2025-12-12 12:51:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-01-14
> 
> for you to fetch changes up to 0edb475ac0a7d153318a24d4dca175a270a5cc4f:
> 
>   nvme: fix PCIe subsystem reset controller state transition (2026-01-14 07:21:31 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.19
> 
>  - Device quirk to disable faulty temperature (Ilikara)
>  - TCP target null pointer fix from bad host protocol usage (Shivam)
>  - Add compatible apple controller (Janne)
>  - FC tagset leak fix (Chaitanya)
>  - TCP socket deadlock fix (Hannes)
>  - Target name buffer overrun fix (Shin'ichiro)

Pulled, thanks.

-- 
Jens Axboe

