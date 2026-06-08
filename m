Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E889355055
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917441; cv=none; b=AdM5OFHkoCO/kzHMOlYlTLKh4yZGVPtdLzfSnXMzs5HQQiYebDzLYD38aMFiUUvHK+960H6ARe0nvrB4tCsiOZCYzZA740bSyAtVw65//NYUohBU0dvN72g3kWF/HwzPzKjOhylN1f6XLv9yhev0hJCBHsDYHn8naS5dFa2W8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917441; c=relaxed/simple;
	bh=COGUDabHVcqXHpcJkYlZm/XV5Ldx2uNyBygMmkWnTdE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZU9EaUP3gNmdGYTThf88bHYv4EusIvL+s6Vr5aIcmq2HDqJZSIR5ra5UK8sOnixwZ2VY0lK7o5pjVotA6oEctXQciPe/wNkinYVnkX3/ImbedV3ctbWbdKyJcRXCEVedFnC+r6Gt48EIOaD34tMqcP5PGaK20n3ZXd04taC/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY2Om5IK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY2Om5IK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90771F0089D
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917439;
	bh=ad7d5mr4CwYQO8iltfUUgJ+AAb4ROP3d+z77mZ0aNzU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=AY2Om5IK5gipoEig2easoFt8/UhpBIoevqBRMTQmKwnCXTp98FzOpZta9Io8wFcKs
	 clThijr2JcaW0qOdLaOW2TC5bAiLpGPhmntGr9n5pWR7Twme9ZkYWI5HavU39ZWn+M
	 O27hyjfcxpu2/ljU6D35LFUE3MnUoGmumhDjHGmaFQIyRc0aSQeqhdyw7GBFwQIQUH
	 u31gv4+PGcBqFth8etH1Was6x5bJbSiA9O/lo7vXxPIVKFsu4QHM8ew4LEmD601fRv
	 6eeaGLK2N+9rWNurNHbzneWueRuhXjYnY5lm2ZoOJ+q3IPwdhNmU1G2RV7eGpHhrOK
	 9E/3Gb+Hl09dg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa68e66128so4223558e87.2
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 04:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/wTWTz8GCnZtl5EkeTvcpYg46Ebjh9rlYb13Gob8/RP4P7By0rs0TxZMIGR2JVwytplWJK73L10Aj9Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0zR/pbv6T6xQCQMawd57O7hhJrklyjkpc3V/UFBaONZuPqDW
	ZRZ2GV6wF7HwrhX521rkV141+TwHJudJJ//uTxla0Td8gsThZJwLQKYxLkZIkebHDU0aS9kcVBH
	TUx8FpZ4szYNCwFjNapoz5KkMTv8b2pkuXt3TMXgrXw==
X-Received: by 2002:a05:6512:6482:b0:5aa:7078:49ee with SMTP id
 2adb3069b0e04-5aa87bf444cmr3733378e87.43.1780917438653; Mon, 08 Jun 2026
 04:17:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:17:17 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:17:17 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com> <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 04:17:17 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc46R=VqCp-eQcy8DP1yvyco=E43eup6NpkZjAR+rY=OQ@mail.gmail.com>
X-Gm-Features: AVVi8CdkJtXpApBPRw2hv_xTVbemR0DzCSGvL77XwK4W0RDjW4XvcGcsiQ8sLHk
Message-ID: <CAMRc=Mc46R=VqCp-eQcy8DP1yvyco=E43eup6NpkZjAR+rY=OQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 12:50:40 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Add support for an NVMEM cell provider for "local-bd-address",
> allowing the Bluetooth stack to retrieve controller's BD address
> from non-volatile storage such as an EEPROM or an eMMC partition.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> @@ -22,4 +22,13 @@ properties:
>      description:
>        boot firmware is incorrectly passing the address in big-endian order
>
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Nvmem data cell that contains a 6 byte BD address with the most
> +      significant byte first (big-endian).
> +
> +  nvmem-cell-names:
> +    const: local-bd-address
> +
>  additionalProperties: true
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
