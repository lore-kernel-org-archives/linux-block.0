Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDA3FB074
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899920; cv=none; b=Ex63ow8inN1tJ7Aijdp9KdF+S/WDM3cqx5ju9GaPKZLczJh121e5wEY5+GGvyIpmABLyChgaD/DjK3dSXBXqlGyKXqKwz6oC0Oeejm+8TPY7/ObxN22DUlRfRScPOWWjxtoQdWTLqPsNYuLKJ/MY5N/JGHRMrb+hO8+psHNi6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899920; c=relaxed/simple;
	bh=ydO8Ft5Urm5M09KG8cScRhJ3iye6Vu29eRTcwv+lefo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GM7ZW1BPqDocduqCDm4kW9QIEdmbnSrABhwuQvRFPrpsC5A2qmHoLb1uNiOq2pohYMWH8ps1mgTsWvCPox1c+vBpnbXCqpW15qiiPziywpCsooXZmaMQkrXtW06W44tMtSxUXj9rWTkzLGqYBa1C8NQ37Pfhj2xTIcSpOTwEa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrM0LwU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrM0LwU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42111F00A3A
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899918;
	bh=ydO8Ft5Urm5M09KG8cScRhJ3iye6Vu29eRTcwv+lefo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=WrM0LwU7aQ7eK/i3qz3jLQ88NeSKZvBDksm5vPkUFxBB7cHeLdlOSYu8caUF8FM22
	 3F5ajDRZOzK47NI4K04DcGMzkVWHDPlTNnCyFxjfpWUbGGDtiRwxOMrCHlwGpFs+gt
	 mI6kzxiWq4QZukIKuKg6nc3EA+MCDGSsWs3ZqOIMMmF5U02abZt9RA+nLZ7MeYPqU/
	 ehndiMqQz8Bxoqr0E8AyMY4t8F0XzkY+Y5SHynteYsA/J5omqAzgdK18F0wEozboUv
	 M37LY03jWdBg/oJbTDycdJuU5qAUuKbcGOaGKk/LpJ3IfoxbFuNvtT1WYnesGz+M2z
	 UdUSRNbwXhJzg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aebbeba529so414368e87.0
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 02:58:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrnm8CSpM8Hr1UJY7TiW22M1LQDz/ETpUjG/aSMPK7d6ZhWpmYECD51tZsVAO0FmLn8kgZvHmD+mhn8OA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxueg4Ag9sy6zK36zLSOKkRCwIdQ/vUriKdvOU3OFFc8HvfvQfl
	aIfqChGafSP2hfVbY+9LxwtOL5CgUOnmmfaCR+9bzAUGc2LlDbsGWoOEMDrpYR6u8nnlIConpSS
	mo6UJvXI2GoFyACByTeOp1iyfoQp/K8+wAJkG3xbPqg==
X-Received: by 2002:a05:6512:a34d:b0:5ae:b952:6c with SMTP id
 2adb3069b0e04-5aec6797747mr213198e87.13.1782899917728; Wed, 01 Jul 2026
 02:58:37 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 05:58:36 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 05:58:36 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com> <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Date: Wed, 1 Jul 2026 05:58:36 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfTh4-RM7R-Ku=MFjo2EQLoe9dt5-AFBtrMx+zZJRHKLQ@mail.gmail.com>
X-Gm-Features: AVVi8CcMVsM_VtMs4RD3avK1gS-7SxkMAq-P9mHbEgm5Sdw31SbqOo7iHTS4Zj8
Message-ID: <CAMRc=MfTh4-RM7R-Ku=MFjo2EQLoe9dt5-AFBtrMx+zZJRHKLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: george.moussalem@outlook.com
Cc: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
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
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 15:01:46 +0200, George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> said:
> From: George Moussalem <george.moussalem@outlook.com>
>
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
