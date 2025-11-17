Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1D27FB32
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403893; cv=none; b=GF1REe6Tzbc4vNyaOKA3F/TToQcML5IjcFV0Pm710on5MsTXsgnXV47Yf800H+OX3ds1++KAjucU8/EYzb8e4o4Xk21A9HfvKh9iYKsnViu7yAEHdqcCgeHZktCrdnVbEER22a6MtCGVdXH51son2nNseWJfhlVoZGKNUImralU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403893; c=relaxed/simple;
	bh=nWCu/trDXxW3B6/TdLhIV+Uz0Gi8HCcBzS/dDDfVyo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4hfMQSlPxfjUy6tb1b9uadeedIiSNPDHIEX3KOVKrnmwBoTIWgjjR6l6gh7j4CAN7DB/CIIv99ECfC1r3Gyv9JLOgvMa1doqCr3VIdrsml2za7JTVgQm0B49S/xcwvGJKke2TEL4+HjTpgrStQbnHzVa4Dbi66Q9PZwc8FGytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcqNt+Q2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcqNt+Q2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29586626fbeso48461675ad.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403889; x=1764008689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWCu/trDXxW3B6/TdLhIV+Uz0Gi8HCcBzS/dDDfVyo4=;
        b=FcqNt+Q2idck+DBtgoZ3TB/pzPAaL4UGOMJ3lgqtOFvxL1WY5//093nMGUnZLiTPAD
         CaEV/A2LVZ9+7i2otVJ4CqHzj+Oo22ZNVIPc67J9VnV9esQJKaNNXcm73eHkTdNrxET3
         aFWsyEbf7/ontf2C43x+IjyLYVg29n+kSB2j4X8MBMflLsfxPzmHoJyvxIZPlpDVmj/B
         yaG3Ls7W2JZ/XHKoDaEvDzuJP+0LeLxGkxlZgoszVw+SOH/I1rCgMZOXeasRnjvos9vX
         UXQPy33ZWZ4UT7a3buRjwdPOdT8AiC+Y1o6JB3Rp2x/xukOWMPvoHfgTLcW7f17ZYOw/
         tP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403889; x=1764008689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWCu/trDXxW3B6/TdLhIV+Uz0Gi8HCcBzS/dDDfVyo4=;
        b=PWVoElMcoEz+dEmxTYKmijH1zQFVgezSB2JEZzzMnbRyJTeLWVUICHlQmODrfgbXvm
         PFrUcHW8Zu5wCmvr5fneSzYnYOKTeIn8gFBXTosg+LA5rVrjBrc4t6HFvqvJ3+BOz2FL
         tyF2BZWlf3FfkYdGCZHYMopq/pQwv6iOo6AgJWyr/zzPPjSUWP1YRiGKE24YYpow1M2h
         ERYxzCDZVzlH1aNwvRPgBjI4QxRPaayncQpMtkjk898zv3Hs13pR2yIC6qTSYAKc5M/C
         Wh3hPBtScF1AtE5U9EtWe8SuikMjuHtdhrRL+Amcz56dLkd+QwbdUE52e/vuToN14oMo
         D0jw==
X-Forwarded-Encrypted: i=1; AJvYcCX2uXvKl6c3o7F4Cp251PgX9MNIF3KEVGOSHc03puJ/jAvskvyb3h84aBG6s5yp5f7LlRGYOMnyyo2EmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2F6QapRFTWTfP26KswBsOhizOHFRVOIntEWhdAw3IwcDcmCmp
	jfUMWAee0cJt5YQq2aIJg0npr2kG107Ggpue6enSX3YzNyokyL7hStb2
X-Gm-Gg: ASbGncumRqrefC7pv4z+5DlccO6pTriGItONVJ1jrN7WmfHr6CDsg8pxLii/cUGvaDP
	lmNE9BRxboKGXtzMB55vCJlUUvC6rbRgL3qGdlgzGiDFhHizzu17gAZgQeAX9WSH7JkYqLQr2wU
	o2LMX6HhRjjEmF8ZnXDX2UCoHNPw+5zKG0XAhAKm7C6xFU+/7W/ONprRrfiM59mxY2JPspIa1hN
	Xjtpbc4c3BProOYZbQJCTrYlAX3rllcxIRecJZ+dKbAsdJIIO+wIX/4xe9pbE3cAzK6GwKz28Ui
	VU0TA3v6cqofn6fmywbORFEDlIMbcpBVOtNlNlvOS+SHCG5ZnTFDGvukjRpkwAOvkmmzOfZJAK1
	1YlftI4q6KLd53Vnu2zoOv1J8ZkhpT9mT4uKQbesGm33MV02GChz9Jt0vFseX6BhOEhjkS50YCD
	ug2A4GLrFLrz+5nVCGG0Vn1xySzBGIZeIieaRCzx2rfwhPIjjcaGkf5eDanp8BHoe+
X-Google-Smtp-Source: AGHT+IEK8q3p5oP4pfUxQfOukfrlZoR2lHYhz+NqEC4HfhChKVyfgw4XYylOJ904KNqTUysQtBRSdw==
X-Received: by 2002:a17:902:f550:b0:28e:aacb:e702 with SMTP id d9443c01a7336-2986a6bad57mr154027305ad.2.1763403889484;
        Mon, 17 Nov 2025 10:24:49 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:9e41:3032:2fa3:743a? ([2600:8802:b00:9ce0:9e41:3032:2fa3:743a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c24a5fdsm147730555ad.43.2025.11.17.10.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 10:24:49 -0800 (PST)
Message-ID: <62086c8d-ca48-4d97-bb73-e991ecb3523c@gmail.com>
Date: Mon, 17 Nov 2025 10:24:48 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rate-limit capacity change info log
To: Li Chen <me@linux.beauty>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251117053407.70618-1-me@linux.beauty>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251117053407.70618-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/25 21:34, Li Chen wrote:
> From: Li Chen<chenl311@chinatelecom.cn>
>
> loop devices under heavy stress-ng loop streessor can trigger many
> capacity change events in a short time. Each event prints an info
> message from set_capacity_and_notify(), flooding the console and
> contributing to soft lockups on slow consoles.
>
> Switch the printk in set_capacity_and_notify() to
> pr_info_ratelimited() so frequent capacity changes do not spam
> the log while still reporting occasional changes.
>
> Cc:stable@vger.kernel.org
> Signed-off-by: Li Chen<chenl311@chinatelecom.cn>



Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


