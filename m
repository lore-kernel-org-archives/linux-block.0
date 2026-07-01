Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6A40B373
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899959; cv=none; b=gjZaug0ANz93kOZ6bqHE7aUjzj7AM1albXQHASWYmwiv6o7eV3PuFoD6E6CF5feP5eZ6vZBuSnEu78mSQIpsArBZeJSVkaxo7QkcHb/XJWIpBlDTG0DF9GZsohRl2QkpoJfBT2eTiBY4RA57QJ1mAuhQOunCSVuPHwht+Vu9F/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899959; c=relaxed/simple;
	bh=KW9lh2K1hAahuirGr9kTW9/S1N/x4cAospR02gArHJ0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HchdGJweimpaJKamBrOhMVA3R1iRAeNw9/ALIZY0zQeThYCz9zAuWSyuzz6KmLeotm6Fu14krhHyq+QTZkNxe2+Mv0jxdzqBfgp/Yt9PhigQJXnd+T41sKj23Q3vET94DrT3n2l02vPLs/NWrjMCkEbAg+OppdAeKEDVPtyApAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcxMOZy9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcxMOZy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB33B1F01564
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899957;
	bh=KW9lh2K1hAahuirGr9kTW9/S1N/x4cAospR02gArHJ0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=bcxMOZy9+wUR0cIUa+U1DVQq23msK1GibupFls02SsSVec7WdoW+TaetCQmXuipta
	 75k/2KwNSJr7otVAL4jymBh8anWy6sHRyFNjlIDfZmbmDfCTNsStAcOhv31x0ivjQf
	 ooL1jlEQVfHJR53vjnmqNJ9OthmUgRGXccG1cosaT90q7Jh7xUooxf99keLu2hIfL8
	 f81yxjgpJIHT0GXG1uSI+WmPQIl4G0Kieunbvsnd2Yy6HVPRSLyxlMOrRUjvg+fVAl
	 DUAWcbtn/H6ycrJNXoKzsP8lYflD/0GOP+hByBLl57HhPfnuqXzEXLvtq/Y6fM2GAv
	 eqFtVbdgNSa4w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b3027009fso3891611fa.0
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 02:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp4bTnoG8ccQqZ5JXpWOgTWpFz9iVAlv3fEgxmHwlAb/fW2wXU5YggdNZXkpdTCZdEJqNPXz5qyd7BXaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyl3jpAW19YAsYPUzJRyC2LGh3iXLHD0BTYt+0yYhJvIIfBfbX
	YTLLmGcVAsUlb5zM8bPpVesEaJNujISLQOGM0laoTfLfUrdDjCMh2s7MwR6h/XSbeqtdO6VFymP
	I2exepe+Y8CESSM8uay1jHYMCj2v3WZ8UNrmfJ+IeWQ==
X-Received: by 2002:a05:6512:2585:b0:5ae:bcf7:a741 with SMTP id
 2adb3069b0e04-5aec67a5104mr254124e87.18.1782899956542; Wed, 01 Jul 2026
 02:59:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:59:14 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:59:14 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-2-02770f03b6bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com> <20260629-ipq5018-bluetooth-v2-2-02770f03b6bb@outlook.com>
Date: Wed, 1 Jul 2026 04:59:14 -0500
X-Gmail-Original-Message-ID: <CAMRc=MejBiWKB74bz9ZD8HWgm+ZGG1ed7rRJsoaPFZcRWzC-kA@mail.gmail.com>
X-Gm-Features: AVVi8CeyT1GrSjfr-2uV0qlk0nwk3b4g-mFQbPvHBLEEqLDXk1SdAU72dFgl0qQ
Message-ID: <CAMRc=MejBiWKB74bz9ZD8HWgm+ZGG1ed7rRJsoaPFZcRWzC-kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] Bluetooth: btqca: Add IPQ5018 support
To: george.moussalem@outlook.com
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan <saravanak@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 15:01:45 +0200, George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> said:
> From: George Moussalem <george.moussalem@outlook.com>
>
> Add the IPQ5018 SoC type and support for loading its firmware.
>
> The firmware tested has been taken from GPL sources of various router
> boards. Firmware files needed are:
> - qca/bt_fw_patch.mbn
> - qca/mpnv10.bin
>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
