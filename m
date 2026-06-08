Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE783655C3
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917540; cv=none; b=ccBgXAV7f7GXpx9VXCmmzzNmFkW+HbRNv7WvcKahljSeJkJursHskRO9EloglHECm4xJxy7VCS1lHDMMVrdswjpcAKcsnd6i+RsXO72owvabrV2h9sZ9Hbr8mH9I3BTbQoVMPErX5RHXFKVnvjHG6xFUMoIkDZWYWg6R5kSekSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917540; c=relaxed/simple;
	bh=DPpaot2Svx2MSbq7KY9ZMt5/x26NfewXAR6zENf8kbQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjWUJYuVInkzAoRiA20XsDF6oIfyb1Jc5ezTvrcpzK3uWO8mGbGOSTL0Hp7chr2Hd94b2ZYCokiyRAC1Cg94hbxoEei2Rd9R0QtOhFFCRU+IEf7TAZKkNlxpUGJkvw4Z+LF/VunbfmWpnpmV5KhaRmAiUtC4dvFHwcPIUEhchV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqjKgFkO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqjKgFkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FFF1F00893
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917539;
	bh=DPpaot2Svx2MSbq7KY9ZMt5/x26NfewXAR6zENf8kbQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=kqjKgFkObqfwVvcVXJkmpZpX1TkQLYU2+UZlp+tpOIg2EQzD0ciQMwI5eKqP5zNNy
	 1MnoAYN3hwHkJNojge4fY+NqquZfjcy1RFbVwG9S5vYZVoS7zIvnokjvKHsnZsatXL
	 rkNjgnxHzxM+NNcXGGfbHCf4YLS0NUpvgH2u75haXaazraTVOdDCnaGnrs9qfizMBr
	 OCXo4+GKRuOhfmzK7xphPdiBEIcJ5D7IVc10xgYL1LHgOXKW5TfbZJEfdl7/0qO9m9
	 EuWqidU/SAy83NacJkFbC1yw+bkT0wGwguF7deGgd3UfJtYIBpIQrvdTVsXuRdl+QS
	 +EgFvL7SjvVuQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa7a70c0aaso4221722e87.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 04:18:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ//1OSXZXET2CP8XD9hxEZ5tA8Bg+E8Wcf5Y7s2LpFd8o2TcFNNEjHQWxqVHnQzHgmzHi9Dh8IkgD3YtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUz06UHxdfV3ka1RImFXJjorYXQhLvI5LjpuMPfi+dWPy4SuZw
	FrhCpTINzedbcNkViDZlPKRyYFe7eTWW0MY662pDyjIvzAAjNrgBwkH/sZ4ZHcim1OMXyF0/tyP
	2Nl8Dp4y/kLhvCM4lRP7y0n1JV2yIXD7rpEIjqNDWrA==
X-Received: by 2002:a05:6512:61d3:10b0:5aa:6b85:85cf with SMTP id
 2adb3069b0e04-5aa87babf3bmr2724481e87.10.1780917538408; Mon, 08 Jun 2026
 04:18:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:18:56 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:18:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260608-block-as-nvmem-v3-2-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com> <20260608-block-as-nvmem-v3-2-82681f50aa35@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 04:18:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeyOS=ngzVcu9zHN1g2W60GXHuZgSFozCTSVb1cGxJwMw@mail.gmail.com>
X-Gm-Features: AVVi8CevzSi8FWjqPtdJGMMjRNFkh5D31R7JAhStRKSOzvhr_7JJA4oBvY-YP1c
Message-ID: <CAMRc=MeyOS=ngzVcu9zHN1g2W60GXHuZgSFozCTSVb1cGxJwMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
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

On Mon, 8 Jun 2026 12:50:39 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Document the NVMEM cells supported by the ath10k driver, the
> mac-address, pre-calibration data, and calibration data.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
